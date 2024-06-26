#!/bin/bash

set -e

if [ ! -f "/etc/debian_version" ]; then
    echo "E: The script can only be run on Debian based systems"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "I: The script can only be run as root, trying sudo"
    exec sudo /bin/bash "$0" "$@"
fi

echo "I: Checking for packages"

# Check if necessary packages are installed
REQUIRED_PKG="binfmt-support
debian-archive-keyring
file
mmdebstrap
qemu-user-static"
INSTALLED_PKG=$(dpkg-query -W -f='${Package}\n' $REQUIRED_PKG 2>/dev/null | sort)
MISSING_PKG=$(comm -23 <(echo "$REQUIRED_PKG") <(echo "$INSTALLED_PKG"))

# Install missing packages
if [ ! -z "$MISSING_PKG" ]; then
    echo "I: Missing packages $MISSING_PKG"
    read -p "Do you want to install them using apt? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        apt-get install -y $MISSING_PKG
    else
        exit 1
    fi
fi

# Ensure the image already exists. Creating it as root will cause ownership issue.
if [ ! -f "rootfs.img" ]; then
    echo "E: rootfs.img does not exist"
fi

# If the image is already formatted then warn before overwriting
if file -s rootfs.img | grep -q "ext4 filesystem data"; then
    read -p "Do you want to overwrite it? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "I: Reserving space for the rootfs image"
# Allocate 2GiB
fallocate -l 2G rootfs.img || truncate -s 2G rootfs.img

# Format the image with ext4
echo "I: Formatting rootfs image with ext4"
mkfs.ext4 -F rootfs.img

# Create a temporary directory and mount the image there
TMP_DIR=$(mktemp -d)
tmp_cleanup() {
    rm -rf $TMP_DIR
}
trap tmp_cleanup EXIT

echo "I: Mounting rootfs image to $TMP_DIR"
mount rootfs.img $TMP_DIR
mnt_cleanup() {
    echo "I: Unmounting rootfs image"
    umount $TMP_DIR
    tmp_cleanup
}
trap mnt_cleanup EXIT

echo "I: Bootstrapping rootfs"
mmdebstrap --architectures=riscv64 unstable $TMP_DIR http://deb.debian.org/debian/

echo "I: Updating apt sources"
chroot $TMP_DIR apt-get update

# Install additional packages
echo "I: Install additional packages"
chroot $TMP_DIR apt-get install -y $(cat data/debian_packages.txt)
