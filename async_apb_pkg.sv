`ifndef __ASYNC_APB_PKG__
`define __ASYNC_APB_PKG__

`include "uvm_pkg.sv"
`include "svt_apb.uvm.pkg"
`include "svt_apb_if.svi" //top-level APB interface
`include "apb_intf.sv"

package async_apb_pkg;
    import uvm_pkg::*;
    import vip_clkrst_pkg::*;
    import svt_uvm_pkg::*;
    import svt_apb_uvm_pkg::*;

    localparam  P_ADDR_WIDTH    = 32;
    localparam  P_DATA_WIDTH    = 32;

    `include "uvm_macros.svh"

    `include "cust_svt_apb_system_configuration.sv"
    `include "apb_to_apb_sb.sv"
    `include "async_apb_coverage.sv"
    `include "async_apb_env.sv"

    `include "apb_sequence/apb_master_random_transaction_sequence.sv"
    `include "apb_sequence/apb_master_wr_rd_sequence.sv"
    `include "apb_sequence/apb_slave_memory_sequence.sv"
    `include "apb_sequence/apb_constraint_addr_sequence.sv"
    `include "apb_sequence/apb_wr_rd_addr_max_sequence.sv"
    `include "apb_sequence/apb_slave_random_response_sequence.sv"

    `include "apb_test/async_apb_base_test.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test2.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test3.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test4.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test5.sv"
    `include "apb_test/async_apb_random_clk_and_transaction_test6.sv"
    `include "apb_test/async_apb_reset_test.sv"
    `include "apb_test/async_apb_wr_rd_random_test.sv"
    `include "apb_test/async_apb_random_response_error_test.sv"
    `include "apb_test/async_apb_constraint_prdata_test.sv"
    `include "apb_test/async_apb_cov_deasserted_reset_test.sv"

endpackage
`endif
