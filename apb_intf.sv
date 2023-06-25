interface apb_intf();

    parameter APB_ADDR_WIDTH = 32;
    parameter APB_DATA_WIDTH = 32;
    parameter APB_STRB_WIDTH = APB_DATA_WIDTH / 8;
    parameter APB_SLVERR_WIDTH = 1;
    parameter APB_PWRITE_WIDTH = 1;
    parameter APB_PROT_WIDTH = 3;

    logic                          PCLKS;
    logic                          PRESETSn;
    logic                          PCLKM;
    logic                          PRESETMn;
    // slave APB interface
    logic                          PSELS;
    logic                          PENABLES;
    logic   [APB_ADDR_WIDTH -1:0]  PADDRS;
    logic                          PWRITES;
    logic   [APB_DATA_WIDTH-1:0 ]  PWDATAS;
    logic   [APB_PROT_WIDTH-1:0 ]  PPROTS;
    logic   [APB_STRB_WIDTH-1:0 ]  PSTRBS;
    logic   [APB_DATA_WIDTH-1:0 ]  PRDATAS;
    logic                          PREADYS;
    logic                          PSLVERRS;
    // master APB interface
    logic                         PSELM;
    logic                         PENABLEM;
    logic  [APB_ADDR_WIDTH-1:0]   PADDRM;
    logic                         PWRITEM;
    logic  [APB_DATA_WIDTH-1:0]   PWDATAM;
    logic  [APB_PROT_WIDTH-1:0]   PPROTM;
    logic  [APB_STRB_WIDTH-1:0]   PSTRBM;
    logic   [APB_DATA_WIDTH-1:0]   PRDATAM;
    logic                          PREADYM;
    logic                          PSLVERRM;


endinterface