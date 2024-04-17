//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 10:18:15 AM
// Design Name: 
// Module Name: gpio
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gpio#(
  parameter AddrWidth   = 16,
  parameter SourceWidth = 1
) (
  input logic clk_i,
  input logic rst_ni,
  
  output [15:0] leds,
  input  [3:0] sw,
  
  `TL_DECLARE_DEVICE_PORT(64, AddrWidth, SourceWidth, 1, link)
);

  logic bram_en;
  logic bram_we;
  logic [7:0] bram_wmask;
  logic [7:0] bram_addr;
  logic [63:0] bram_wrdata;
  logic [63:0] bram_rddata;
  
  logic [15:0] leds_reg;
  
  assign leds = leds_reg;
  
  always_ff @(posedge clk_i or negedge rst_ni)
    if (!rst_ni) begin
        leds_reg <= '1;
        bram_rddata <= 0;
    end
    else begin
        if (bram_en) begin
            case (bram_addr)
                8'h00: begin
                    //leds
                    if (bram_we) begin
                        leds_reg <= bram_wrdata[15:0];
                    end
                    else begin
                        bram_rddata <= leds_reg;
                    end
                end
                8'h01: begin
                    //switches
                    bram_rddata <= sw;
                    leds_reg <= leds_reg;
                end
            endcase
        end
    end
  
  tl_adapter_bram #(
    .DataWidth (64),
    .AddrWidth (AddrWidth),
    .SourceWidth (SourceWidth),
    .BramAddrWidth (8)
  ) bridge (
    .clk_i,
    .rst_ni,
    `TL_FORWARD_DEVICE_PORT(host, link),
    .bram_en_o    (bram_en),
    .bram_we_o    (bram_we),
    .bram_wmask_o (bram_wmask),
    .bram_addr_o  (bram_addr),
    .bram_wdata_o (bram_wrdata),
    .bram_rdata_i (bram_rddata)
  );
endmodule
