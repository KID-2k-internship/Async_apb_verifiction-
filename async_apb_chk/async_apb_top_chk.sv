module async_apb_top_chk
#(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32,
    parameter APB_STRB_WIDTH = APB_DATA_WIDTH / 8,
    parameter APB_SLVERR_WIDTH = 1,
    parameter APB_PWRITE_WIDTH = 1,
    parameter APB_PROT_WIDTH = 3,

    // calculated parameter, do not modify
    parameter APB_WIDTH_M2S = APB_DATA_WIDTH + APB_SLVERR_WIDTH,
    parameter APB_WIDTH_S2M = APB_ADDR_WIDTH + APB_DATA_WIDTH + APB_PWRITE_WIDTH + APB_STRB_WIDTH + APB_PROT_WIDTH
) (
    input wire                         PCLKS,
    input wire                         PRESETSn,
    input wire                         PCLKM,
    input wire                         PRESETMn,
    // slave APB interface
    input wire                         PSELS,
    input wire                         PENABLES,
    input wire  [APB_ADDR_WIDTH -1:0]  PADDRS,
    input wire                         PWRITES,
    input wire  [APB_DATA_WIDTH-1:0 ]  PWDATAS,
    input wire  [APB_PROT_WIDTH-1:0 ]  PPROTS,
    input wire  [APB_STRB_WIDTH-1:0 ]  PSTRBS,
    output wire [APB_DATA_WIDTH-1:0 ]  PRDATAS,
    output wire                        PREADYS,
    output wire                        PSLVERRS,
    // master APB interface
    output wire                        PSELM,
    output wire                        PENABLEM,
    output wire [APB_ADDR_WIDTH-1:0]   PADDRM,
    output wire                        PWRITEM,
    output wire [APB_DATA_WIDTH-1:0]   PWDATAM,
    output wire [APB_PROT_WIDTH-1:0]   PPROTM,
    output wire [APB_STRB_WIDTH-1:0]   PSTRBM,
    input wire  [APB_DATA_WIDTH-1:0]   PRDATAM,
    input wire                         PREADYM,
    input wire                         PSLVERRM
);



    // check PRESETSn
    P_APB_PRESETSn    : assert property(
        @(posedge PCLKS)
       (PRESETSn == 0)  |-> (PREADYS==0) && $stable(PRDATAS) && $stable(PSLVERRS)
    );

    // check PRESETMn
    P_APB_PRESETMn    : assert property(
        @(posedge PCLKM)
       (PRESETMn == 0) |-> (PSELM==0) && (PENABLEM==0) && $stable(PADDRM) && $stable(PWRITEM) && $stable(PWDATAM) && $stable(PSTRBM) && $stable(PPROTM));

endmodule

