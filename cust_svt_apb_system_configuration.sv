`ifndef __CUST_SVT_APB_SYSTEM_CONFIGURATION__
`define __CUST_SVT_APB_SYSTEM_CONFIGURATION__

// class cust_svt_apb_system_configuration extends svt_apb_system_configuration;

class cust_svt_apb_system_configuration extends svt_apb_configuration;


    /** Configuration object used by the master VIP */
    svt_apb_system_configuration master_cfg;
    svt_apb_system_configuration master_passive_cfg;

    /** Configuration object used by the slave VIP */
    svt_apb_system_configuration slave_cfg;
    svt_apb_system_configuration slave_passive_cfg;

    `uvm_object_utils(cust_svt_apb_system_configuration)

    function new(string name = "cust_svt_apb_system_configuration");

        master_cfg = new("master_cfg");
        slave_cfg  = new("slave_cfg");

        master_passive_cfg = new("master_passive_cfg");
        slave_passive_cfg  = new("slave_passive_cfg");

        master_cfg.paddr_width = svt_apb_system_configuration::PADDR_WIDTH_32;
        master_cfg.pdata_width = svt_apb_system_configuration::PDATA_WIDTH_32;
        master_cfg.apb4_enable = 1;
        master_cfg.create_sub_cfgs(1);
        master_cfg.is_active = 1;

//      When #slave_addr_allocation_enable is set = 1, the VIP allocates the slave
//    * address ranges automatically. The address space is divided equally between
//    * all the slaves.
        slave_cfg.slave_addr_allocation_enable = 0;
        slave_cfg.paddr_width = svt_apb_system_configuration::PADDR_WIDTH_32;
        slave_cfg.pdata_width = svt_apb_system_configuration::PDATA_WIDTH_32;
        slave_cfg.apb4_enable = 1;
        slave_cfg.create_sub_cfgs(2);// num_slaves
        slave_cfg.slave_cfg[0].is_active = 1;

        master_passive_cfg.paddr_width = svt_apb_system_configuration::PADDR_WIDTH_32;
        master_passive_cfg.pdata_width = svt_apb_system_configuration::PDATA_WIDTH_32;
        master_passive_cfg.apb4_enable = 1;
        master_passive_cfg.is_active = 0;
        master_passive_cfg.create_sub_cfgs(1);
        master_passive_cfg.toggle_coverage_enable = 1;
        master_passive_cfg.state_coverage_enable  = 1;
        master_passive_cfg.transaction_coverage_enable = 1;

        slave_cfg.slave_cfg[1].is_active = 0;
        slave_cfg.slave_cfg[1].toggle_coverage_enable = 1;
        slave_cfg.slave_cfg[1].state_coverage_enable  = 1;
        slave_cfg.slave_cfg[1].transaction_coverage_enable = 1;

    endfunction


endclass


`endif
