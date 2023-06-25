
// `include "spi_slv_checker.sv"

`include "uvm_pkg.sv"
`include "svt_apb.uvm.pkg"
`include "svt_apb_if.svi" //top-level APB interface


//import asyn_apb_pkg::*;

module async_apb_top;


    import uvm_pkg::*;
    import svt_uvm_pkg::*;
    import svt_apb_uvm_pkg::*;

    parameter simulation_cycle = 20;

    vip_clkrst_intf     vip_clkrst_master_intf();
    vip_clkrst_intf     vip_clkrst_slave_intf();

    svt_apb_if apb_master_vip_if();
    svt_apb_if apb_slave_vip_if();

    assign apb_master_vip_if.pclk    = vip_clkrst_master_intf.clk;
    assign apb_master_vip_if.presetn = vip_clkrst_master_intf.resetn;

    assign apb_slave_vip_if.pclk    = vip_clkrst_slave_intf.clk;
    assign apb_slave_vip_if.presetn = vip_clkrst_slave_intf.resetn;


    svt_apb_if apb_master_passive_if();
    apb_intf apb_intf();

    // connect interface apb interface  and DUT
    csv_apb4_async_top #(
        .APB_ADDR_WIDTH     (32),
        .APB_DATA_WIDTH     (32),
        .APB_STRB_WIDTH     (4) ,
        .APB_SLVERR_WIDTH   (1) ,
        .APB_PWRITE_WIDTH   (1) ,
        .APB_PPROT_WIDTH    (3)
    ) dut(
        .PCLKS      (apb_intf.PCLKS),
        .PRESETSn   (apb_intf.PRESETSn),
        .PCLKM      (apb_intf.PCLKM),
        .PRESETMn   (apb_intf.PRESETMn),

        .PSELS      (apb_intf.PSELS),
        .PENABLES   (apb_intf.PENABLES),
        .PADDRS     (apb_intf.PADDRS),
        .PWRITES    (apb_intf.PWRITES),
        .PWDATAS    (apb_intf.PWDATAS),
        .PPROTS     (apb_intf.PPROTS),
        .PSTRBS     (apb_intf.PSTRBS),
        .PRDATAS    (apb_intf.PRDATAS),
        .PREADYS    (apb_intf.PREADYS),
        .PSLVERRS   (apb_intf.PSLVERRS),
        .PSELM      (apb_intf.PSELM),
        .PENABLEM   (apb_intf.PENABLEM),
        .PADDRM     (apb_intf.PADDRM),
        .PWRITEM    (apb_intf.PWRITEM),
        .PWDATAM    (apb_intf.PWDATAM),
        .PPROTM     (apb_intf.PPROTM),
        .PSTRBM     (apb_intf.PSTRBM),
        .PRDATAM    (apb_intf.PRDATAM),
        .PREADYM    (apb_intf.PREADYM),
        .PSLVERRM   (apb_intf.PSLVERRM)
    );


    // connect vip apb active intf to apb intf
    assign  apb_intf.PCLKS 		= apb_master_vip_if.pclk ;
    assign  apb_intf.PRESETSn 	= apb_master_vip_if.presetn;
    assign  apb_intf.PSELS		= apb_master_vip_if.psel;
    assign  apb_intf.PENABLES   = apb_master_vip_if.penable;
    assign  apb_intf.PWRITES    = apb_master_vip_if.pwrite;
    assign  apb_intf.PADDRS		= apb_master_vip_if.paddr;
    assign  apb_intf.PWDATAS	= apb_master_vip_if.pwdata;
    assign  apb_intf.PPROTS		= apb_master_vip_if.pprot;
    assign  apb_intf.PSTRBS		= apb_master_vip_if.pstrb;
    assign  apb_master_vip_if.slave_if[0].prdata  = apb_intf.PRDATAS;
    assign  apb_master_vip_if.slave_if[0].pready  = apb_intf.PREADYS;
    assign  apb_master_vip_if.slave_if[0].pslverr = apb_intf.PSLVERRS;

    assign  apb_intf.PCLKM           			 = vip_clkrst_slave_intf.clk ;
    assign  apb_intf.PRESETMn        			 = vip_clkrst_slave_intf.resetn;
    assign  apb_slave_vip_if.psel[0]    		 = apb_intf.PSELM;
    assign  apb_slave_vip_if.penable             = apb_intf.PENABLEM;
    assign  apb_slave_vip_if.pwrite              = apb_intf.PWRITEM;
    assign  apb_slave_vip_if.paddr               = apb_intf.PADDRM;
    assign  apb_slave_vip_if.pwdata              = apb_intf.PWDATAM;
    assign 	apb_slave_vip_if.pprot               = apb_intf.PPROTM;
    assign  apb_slave_vip_if.pstrb               = apb_intf.PSTRBM;
    assign  apb_intf.PRDATAM	     			 = apb_slave_vip_if.slave_if[0].prdata;
    assign  apb_intf.PREADYM	      			 = apb_slave_vip_if.slave_if[0].pready;
    assign  apb_intf.PSLVERRM	                 = apb_slave_vip_if.slave_if[0].pslverr;

    // connect vip apb passive to apb intf
    assign apb_master_passive_if.pclk    = apb_intf.PCLKS ;
    assign apb_master_passive_if.presetn = apb_intf.PRESETSn;
    assign apb_master_passive_if.psel[0] = apb_intf.PSELS;
    assign apb_master_passive_if.penable = apb_intf.PENABLES;
    assign apb_master_passive_if.pwrite  = apb_intf.PWRITES;
    assign apb_master_passive_if.paddr   = apb_intf.PADDRS;
    assign apb_master_passive_if.pwdata  = apb_intf.PWDATAS;
    assign apb_master_passive_if.pprot   = apb_intf.PPROTS;
    assign apb_master_passive_if.pstrb   = apb_intf.PSTRBS;
    assign apb_master_passive_if.slave_if[0].prdata  = apb_intf.PRDATAS;
    assign apb_master_passive_if.slave_if[0].pready  = apb_intf.PREADYS;
    assign apb_master_passive_if.slave_if[0].pslverr = apb_intf.PSLVERRS;


    assign apb_slave_vip_if.psel[1]    			= apb_intf.PSELM;
    assign apb_slave_vip_if.slave_if[1].prdata  = apb_intf.PRDATAM;
    assign apb_slave_vip_if.slave_if[1].pready  = apb_intf.PREADYM;
    assign apb_slave_vip_if.slave_if[1].pslverr = apb_intf.PSLVERRM;

    initial begin

        //Add interface VIP active to VIP system env
        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top._env.apb_master_env", "vif", apb_master_vip_if);
        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top._env.apb_slave_env", "vif", apb_slave_vip_if);

        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top", "vif", apb_master_vip_if);
        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top", "vif", apb_slave_vip_if);

        //Add interface VIP passive to VIP system env
        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top._env.apb_master_passive_env", "vif", apb_master_passive_if);
        uvm_config_db#(  svt_apb_vif)::set(uvm_root::get(), "uvm_test_top", "vif", apb_master_passive_if);

        uvm_config_db#( virtual	apb_intf)::set(null, "uvm_test_top", "apb_intf", apb_intf);
        uvm_config_db#( virtual	vip_clkrst_intf)::set(null, "uvm_test_top", "vip_clkrst_master_intf", vip_clkrst_master_intf);
        uvm_config_db#( virtual	vip_clkrst_intf)::set(null, "uvm_test_top", "vip_clkrst_slave_intf", vip_clkrst_slave_intf);


        run_test();
    end

endmodule
