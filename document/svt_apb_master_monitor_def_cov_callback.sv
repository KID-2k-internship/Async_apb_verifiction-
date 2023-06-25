
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV

`include "svt_apb_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(amba_svt,apb_master_monitor_svt,S-2021.06,svt_apb_master_monitor_def_cov_util)

// =============================================================================
/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_apb_master_configuration handle as an argument, which is used for shaping
 * the coverage.
 */

class svt_apb_master_monitor_def_cov_callback extends svt_apb_master_monitor_def_cov_data_callback;

 `ifndef __SVDOC__
// SVDOC doesn't seem to like covergroups with arguments
  
    /**
    * Crosses WRITE transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_8bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 16 bit . This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_16bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 32 bit . This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_32bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses WRITE transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_write_address_64bit(int upper_bound) @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_write_address : cross write_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and address when pdata_width is 8 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_8bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_8
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 16 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_16bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_16
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 32 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_32bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_32
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
/**
    * Crosses READ transaction type and address when pdata_width is 64 bit. This cover group
    * belongs to MASTER monitor.
    */
  covergroup trans_cross_read_address_64bit(int upper_bound) @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_ADDR_64
    apb_read_address : cross read_xact_type, address {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup
`endif


  /**
    * Coverage that Master works fine when PSLVERR is low  by  default and only goes
    * high when PREADY and PENABLE are 1. This cover group belongs to MASTER monitor.
    */
  covergroup trans_pslverr_signal_transition @(cov_pslverr_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR_TRANSITION
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pstrb. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pstrb @(cov_write_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSTRB
    apb_write_pstrb : cross write_xact_type, pstrb {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pprot. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pprot @(cov_write_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    apb_write_pprot : cross write_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pprot. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_pprot @(cov_read_sample_apb4_signals_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    apb_read_pprot : cross read_xact_type, pprot0, pprot1, pprot2 {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and number of wait states. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_wait @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    apb_write_wait : cross write_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and number of wait states. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_wait @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    apb_read_wait : cross read_xact_type, cov_wait {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses WRITE transaction type and pslverr. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_write_pslverr @(cov_write_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_write_pslverr : cross write_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses READ transaction type and pslverr. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_read_pslverr @(cov_read_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR
    apb_read_pslverr : cross read_xact_type, pslverr {
      option.weight = 1;
    }
    option.per_instance = 1;
  endgroup

  /**
    * Crosses transaction type and coverpoints. This cover group belongs to MASTER monitor.
    */
  covergroup trans_cross_master_to_slave_path_access (int upper_bound) @(cov_master_to_slave_access_event); 
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WRITE_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_XACT_TYPE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_IDLE
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSTRB
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT0
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT1
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PPROT2
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_WAIT
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_PSLVERR

    all_slaves : coverpoint path_cov_dest_names {
`ifdef VCS
    bins slvs_b[] = {[path_cov_dest_names_first : path_cov_dest_names_last]}with (ignore_slave_func(svt_amba_addr_mapper::path_cov_dest_names_enum'(item))) ;
`endif 
`ifndef VCS
    bins slvs_b[] = { [path_cov_dest_names_first:path_cov_dest_names_last] };
    ignore_bins ig_bins[]  = ignore_slaves_list;
`endif
            }

    slaves_excluding_register_space : coverpoint path_cov_dest_names {
`ifdef VCS
      bins slvs_excluding_register_space[] = { [path_cov_dest_names_first:path_cov_dest_names_last]} with (ignore_slave_no_cfg_func(svt_amba_addr_mapper::path_cov_dest_names_enum'(item)));
`endif 
`ifndef VCS
      bins slvs_no_cfg_b[] = { [path_cov_dest_names_first:path_cov_dest_names_last] };
      ignore_bins ig_bins[]  = ignore_cfg_slaves_list;
`endif 
      }

    address_8 : coverpoint cov_xact.address iff (cfg.pdata_width == 8){ 
    option.weight = 0; 
      bins addr_range_min = {0}; 
      bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
      bins addr_range_max_8 = {(('d2**(upper_bound))-1)} ; 
    }

    address_16 : coverpoint cov_xact.address iff (cfg.pdata_width == 16) { 
    option.weight = 0; 
     bins addr_range_min = {0}; 
     bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
     bins addr_range_max_16 = {(('d2**(upper_bound))-2)}; 
    }

     address_32 : coverpoint cov_xact.address iff (cfg.pdata_width == 32){ 
    option.weight = 0; 
      bins addr_range_min = {0}; 
      bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
      bins addr_range_max_32 = {(('d2**(upper_bound))-4)}; 
    }

    address_64 : coverpoint cov_xact.address iff (cfg.pdata_width == 64){ 
    option.weight = 0; 
     bins addr_range_min = {0}; 
     bins addr_range_mid = {[1:('d2**(upper_bound)-2)]}; 
     bins addr_range_max_64 = {(('d2**(upper_bound))-8)}; 
    }

    four_state_rd_wr_sequence: coverpoint this.four_state_rd_wr_sequence {
      bins bin_RD_RD_RD_RD_SEQ =  {`SVT_APB_RD_RD_RD_RD_SEQ};
      bins bin_RD_RD_RD_WR_SEQ =  {`SVT_APB_RD_RD_RD_WR_SEQ};
      bins bin_RD_RD_WR_RD_SEQ =  {`SVT_APB_RD_RD_WR_RD_SEQ};
      bins bin_RD_RD_WR_WR_SEQ =  {`SVT_APB_RD_RD_WR_WR_SEQ};
      bins bin_RD_WR_RD_RD_SEQ =  {`SVT_APB_RD_WR_RD_RD_SEQ};
      bins bin_RD_WR_RD_WR_SEQ =  {`SVT_APB_RD_WR_RD_WR_SEQ};
      bins bin_RD_WR_WR_RD_SEQ =  {`SVT_APB_RD_WR_WR_RD_SEQ};
      bins bin_RD_WR_WR_WR_SEQ =  {`SVT_APB_RD_WR_WR_WR_SEQ};
      bins bin_WR_RD_RD_RD_SEQ =  {`SVT_APB_WR_RD_RD_RD_SEQ};
      bins bin_WR_RD_RD_WR_SEQ =  {`SVT_APB_WR_RD_RD_WR_SEQ};                            
      bins bin_WR_RD_WR_RD_SEQ =  {`SVT_APB_WR_RD_WR_RD_SEQ};
      bins bin_WR_RD_WR_WR_SEQ =  {`SVT_APB_WR_RD_WR_WR_SEQ};
      bins bin_WR_WR_RD_RD_SEQ =  {`SVT_APB_WR_WR_RD_RD_SEQ};
      bins bin_WR_WR_RD_WR_SEQ =  {`SVT_APB_WR_WR_RD_WR_SEQ};
      bins bin_WR_WR_WR_RD_SEQ =  {`SVT_APB_WR_WR_WR_RD_SEQ};
      bins bin_WR_WR_WR_WR_SEQ =  {`SVT_APB_WR_WR_WR_WR_SEQ};
    }

    four_state_err_resp_sequence: coverpoint this.four_state_err_resp_sequence {
      bins bin_OK_OK_OK_ERR_SEQ =    {`SVT_APB_OK_OK_OK_ERR_SEQ};
      bins bin_OK_OK_ERR_OK_SEQ =    {`SVT_APB_OK_OK_ERR_OK_SEQ};
      bins bin_OK_OK_ERR_ERR_SEQ =   {`SVT_APB_OK_OK_ERR_ERR_SEQ};
      bins bin_OK_ERR_OK_OK_SEQ =    {`SVT_APB_OK_ERR_OK_OK_SEQ};
      bins bin_OK_ERR_OK_ERR_SEQ =   {`SVT_APB_OK_ERR_OK_ERR_SEQ};
      bins bin_OK_ERR_ERR_OK_SEQ =   {`SVT_APB_OK_ERR_ERR_OK_SEQ };
      bins bin_OK_ERR_ERR_ERR_SEQ =  {`SVT_APB_OK_ERR_ERR_ERR_SEQ};
      bins bin_ERR_OK_OK_OK_SEQ =    {`SVT_APB_ERR_OK_OK_OK_SEQ};
      bins bin_ERR_OK_OK_ERR_SEQ =   {`SVT_APB_ERR_OK_OK_ERR_SEQ};
      bins bin_ERR_OK_ERR_OK_SEQ =   {`SVT_APB_ERR_OK_ERR_OK_SEQ};
      bins bin_ERR_OK_ERR_ERR_SEQ =  {`SVT_APB_ERR_OK_ERR_ERR_SEQ};
      bins bin_ERR_ERR_OK_OK_SEQ =   {`SVT_APB_ERR_ERR_OK_OK_SEQ};
      bins bin_ERR_ERR_OK_ERR_SEQ =  {`SVT_APB_ERR_ERR_OK_ERR_SEQ};
      bins bin_ERR_ERR_ERR_OK_SEQ =  {`SVT_APB_ERR_ERR_ERR_OK_SEQ};
      bins bin_ERR_ERR_ERR_ERR_SEQ = {`SVT_APB_ERR_ERR_ERR_ERR_SEQ};
    }

    pstrb_addr_aligned_unaligned16_coverpoint: coverpoint this.addr_aligned_unaligned16_coverpoint {
       bins  wr_addr_unalign16   = {`SVT_APB_WR_ADDR_UNALIGNED16};
       bins  wr_addr_align16     = {`SVT_APB_WR_ADDR_ALIGNED16};
       bins  rd_addr_unalign16   = {`SVT_APB_RD_ADDR_UNALIGNED16};
       bins  rd_addr_align16     = {`SVT_APB_RD_ADDR_ALIGNED16};
    }

    pstrb_addr_aligned_unaligned32_coverpoint: coverpoint this.addr_aligned_unaligned32_coverpoint {
       bins  wr_addr_unalign32   = {`SVT_APB_WR_ADDR_UNALIGNED32};
       bins  wr_addr_align32     = {`SVT_APB_WR_ADDR_ALIGNED32};
       bins  rd_addr_unalign32   = {`SVT_APB_RD_ADDR_UNALIGNED32};
       bins  rd_addr_align32     = {`SVT_APB_RD_ADDR_ALIGNED32};
    }

    pstrb_addr_aligned_unaligned64_coverpoint: coverpoint this.addr_aligned_unaligned64_coverpoint {
       bins  wr_addr_unalign64   = {`SVT_APB_WR_ADDR_UNALIGNED64};
       bins  wr_addr_align64     = {`SVT_APB_WR_ADDR_ALIGNED64};
       bins  rd_addr_unalign64   = {`SVT_APB_RD_ADDR_UNALIGNED64};
       bins  rd_addr_align64     = {`SVT_APB_RD_ADDR_ALIGNED64};
    } 

    cross_apb_to_slave_write_address_8_pslverr: cross all_slaves,write_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_8_pslverr: cross slaves_excluding_register_space,write_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_write_address_16_pslverr: cross all_slaves,write_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_16_pslverr: cross slaves_excluding_register_space,write_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_write_address_32_pslverr: cross all_slaves,write_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_32_pslverr: cross slaves_excluding_register_space,write_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_pslverr: cross slaves_excluding_register_space,write_xact_type,pslverr {
    }

    cross_apb_to_slave_no_cfg_write_address_64_pslverr: cross slaves_excluding_register_space,write_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_write_pstrb_pprot: cross all_slaves,write_xact_type,pstrb,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_no_cfg_write_pstrb_pprot: cross slaves_excluding_register_space,write_xact_type,pstrb,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_write_pslverr:cross all_slaves,write_xact_type,pslverr {
    } 

    cross_apb_to_slave_write_wait : cross all_slaves,write_xact_type, cov_wait {
    }

    cross_apb_to_slave_no_cfg_write_wait : cross slaves_excluding_register_space,write_xact_type, cov_wait {
    }

    cross_apb_to_slave_read_address_8_pslverr: cross all_slaves,read_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_8_pslverr: cross slaves_excluding_register_space,read_xact_type,address_8,pslverr {
    }

    cross_apb_to_slave_read_address_16_pslverr: cross all_slaves,read_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_16_pslverr: cross slaves_excluding_register_space,read_xact_type,address_16,pslverr {
    }

    cross_apb_to_slave_read_address_32_pslverr: cross all_slaves,read_xact_type,address_32,pslverr {
    }

    cross_apb_to_slave_no_cfg_read_address_64_pslverr: cross slaves_excluding_register_space,read_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_read_address_64_pslverr: cross all_slaves,read_xact_type,address_64,pslverr {
    }

    cross_apb_to_slave_read_pprot: cross all_slaves,read_xact_type,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_no_cfg_read_pprot: cross slaves_excluding_register_space,read_xact_type,pprot0,pprot1,pprot2 {
    } 

    cross_apb_to_slave_read_pslverr:cross all_slaves,read_xact_type,pslverr {
    } 

    cross_apb_to_slave_no_cfg_read_pslverr:cross slaves_excluding_register_space,read_xact_type,pslverr {
    } 

    cross_apb_to_slave_read_wait : cross all_slaves,read_xact_type, cov_wait {
    }

    cross_apb_to_slave_no_cfg_read_wait : cross slaves_excluding_register_space,read_xact_type, cov_wait {
    }


    option.per_instance = 1;
  endgroup

  function bit ignore_slave_func (svt_amba_addr_mapper::path_cov_dest_names_enum myitem) ;
    ignore_slave_func = 1;
    for (int k=0 ; k < ignore_slaves_list.size(); k++) begin
      if (myitem == ignore_slaves_list [k]) begin
        ignore_slave_func = 0;
        break;
      end
    end
  endfunction
   
  function bit ignore_slave_no_cfg_func (svt_amba_addr_mapper::path_cov_dest_names_enum myitem) ;
    ignore_slave_no_cfg_func = 1;
    for (int k=0 ; k < ignore_cfg_slaves_list.size(); k++) begin
      if (myitem == ignore_cfg_slaves_list [k]) begin
        ignore_slave_no_cfg_func = 0;
        break;
      end
    end
  endfunction

  /** 
   * Covergroup:  trans_four_state_rd_wr_sequence
   *
   * This cover group covers specific combinations of read and write
   * transactions, for a sequence of four transactions. For eg.
   * Write-Write-Write-Write or Write-Read-Write-Read, etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_rd_wr_sequence @(four_state_rd_wr_event);
    type_option.comment = "Coverage for Four State READ/WRITE for Ex:WR-WR-RD-RD, RD-WR-RD-WR, RD-RD-RD-WR etc";
    option.per_instance = 1;
     four_state_rd_wr_sequence: coverpoint this.four_state_rd_wr_sequence {
      bins bin_RD_RD_RD_RD_SEQ =  {`SVT_APB_RD_RD_RD_RD_SEQ};
      bins bin_RD_RD_RD_WR_SEQ =  {`SVT_APB_RD_RD_RD_WR_SEQ};
      bins bin_RD_RD_WR_RD_SEQ =  {`SVT_APB_RD_RD_WR_RD_SEQ};
      bins bin_RD_RD_WR_WR_SEQ =  {`SVT_APB_RD_RD_WR_WR_SEQ};
      bins bin_RD_WR_RD_RD_SEQ =  {`SVT_APB_RD_WR_RD_RD_SEQ};
      bins bin_RD_WR_RD_WR_SEQ =  {`SVT_APB_RD_WR_RD_WR_SEQ};
      bins bin_RD_WR_WR_RD_SEQ =  {`SVT_APB_RD_WR_WR_RD_SEQ};
      bins bin_RD_WR_WR_WR_SEQ =  {`SVT_APB_RD_WR_WR_WR_SEQ};
      bins bin_WR_RD_RD_RD_SEQ =  {`SVT_APB_WR_RD_RD_RD_SEQ};
      bins bin_WR_RD_RD_WR_SEQ =  {`SVT_APB_WR_RD_RD_WR_SEQ};                            
      bins bin_WR_RD_WR_RD_SEQ =  {`SVT_APB_WR_RD_WR_RD_SEQ};
      bins bin_WR_RD_WR_WR_SEQ =  {`SVT_APB_WR_RD_WR_WR_SEQ};
      bins bin_WR_WR_RD_RD_SEQ =  {`SVT_APB_WR_WR_RD_RD_SEQ};
      bins bin_WR_WR_RD_WR_SEQ =  {`SVT_APB_WR_WR_RD_WR_SEQ};
      bins bin_WR_WR_WR_RD_SEQ =  {`SVT_APB_WR_WR_WR_RD_SEQ};
      bins bin_WR_WR_WR_WR_SEQ =  {`SVT_APB_WR_WR_WR_WR_SEQ};
    }
  endgroup
  
 /** 
   * Covergroup:  trans_four_state_err_resp_sequence
   *
   * This cover group covers specific combinations of ERROR response
   * for a sequence of four transactions. For eg.
   * ERROR-ERROR-ERROR-ERROR or ERROR-OK-ERROR-OK etc. This covergroup is
   * hit when completion of four transactions are observed in a
   * specific combination as described above.
   * <br>
   *   .
   */ 

  covergroup trans_four_state_err_resp_sequence @(four_state_err_resp_event);
    type_option.comment = "Coverage for ERR RESPONSE for a sequence of four transactions";
    option.per_instance = 1;
     four_state_err_resp_sequence: coverpoint this.four_state_err_resp_sequence {
      bins bin_OK_OK_OK_ERR_SEQ =    {`SVT_APB_OK_OK_OK_ERR_SEQ};
      bins bin_OK_OK_ERR_OK_SEQ =    {`SVT_APB_OK_OK_ERR_OK_SEQ};
      bins bin_OK_OK_ERR_ERR_SEQ =   {`SVT_APB_OK_OK_ERR_ERR_SEQ};
      bins bin_OK_ERR_OK_OK_SEQ =    {`SVT_APB_OK_ERR_OK_OK_SEQ};
      bins bin_OK_ERR_OK_ERR_SEQ =   {`SVT_APB_OK_ERR_OK_ERR_SEQ};
      bins bin_OK_ERR_ERR_OK_SEQ =   {`SVT_APB_OK_ERR_ERR_OK_SEQ };
      bins bin_OK_ERR_ERR_ERR_SEQ =  {`SVT_APB_OK_ERR_ERR_ERR_SEQ};
      bins bin_ERR_OK_OK_OK_SEQ =    {`SVT_APB_ERR_OK_OK_OK_SEQ};
      bins bin_ERR_OK_OK_ERR_SEQ =   {`SVT_APB_ERR_OK_OK_ERR_SEQ};
      bins bin_ERR_OK_ERR_OK_SEQ =   {`SVT_APB_ERR_OK_ERR_OK_SEQ};
      bins bin_ERR_OK_ERR_ERR_SEQ =  {`SVT_APB_ERR_OK_ERR_ERR_SEQ};
      bins bin_ERR_ERR_OK_OK_SEQ =   {`SVT_APB_ERR_ERR_OK_OK_SEQ};
      bins bin_ERR_ERR_OK_ERR_SEQ =  {`SVT_APB_ERR_ERR_OK_ERR_SEQ};
      bins bin_ERR_ERR_ERR_OK_SEQ =  {`SVT_APB_ERR_ERR_ERR_OK_SEQ};
      bins bin_ERR_ERR_ERR_ERR_SEQ = {`SVT_APB_ERR_ERR_ERR_ERR_SEQ};
    }
  endgroup

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned16
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 16 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned16 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned16_coverpoint: coverpoint this.addr_aligned_unaligned16_coverpoint {
       bins  wr_addr_unalign16   = {`SVT_APB_WR_ADDR_UNALIGNED16};
       bins  wr_addr_align16     = {`SVT_APB_WR_ADDR_ALIGNED16};
       bins  rd_addr_unalign16   = {`SVT_APB_RD_ADDR_UNALIGNED16};
       bins  rd_addr_align16     = {`SVT_APB_RD_ADDR_ALIGNED16};
    }
  endgroup

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned32
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 32 bits.
   * .
   */
  covergroup trans_pstrb_addr_aligned_unaligned32 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned32_coverpoint: coverpoint this.addr_aligned_unaligned32_coverpoint {
       bins  wr_addr_unalign32   = {`SVT_APB_WR_ADDR_UNALIGNED32};
       bins  wr_addr_align32     = {`SVT_APB_WR_ADDR_ALIGNED32};
       bins  rd_addr_unalign32   = {`SVT_APB_RD_ADDR_UNALIGNED32};
       bins  rd_addr_align32     = {`SVT_APB_RD_ADDR_ALIGNED32};
    }
  endgroup 

  /**
   * Covergroup:  trans_pstrb_addr_aligned_unaligned64
   *
   * This covergroup covers if the RD/WR transfer is Aligned/Unaligned based on address and pstrb
   * when the pdata_width is 64 bits.
   * . 
   */
  covergroup trans_pstrb_addr_aligned_unaligned64 @(cov_apb4_align_unalign_addr_event);
     option.per_instance = 1;
      addr_aligned_unaligned64_coverpoint: coverpoint this.addr_aligned_unaligned64_coverpoint {
       bins  wr_addr_unalign64   = {`SVT_APB_WR_ADDR_UNALIGNED64};
       bins  wr_addr_align64     = {`SVT_APB_WR_ADDR_ALIGNED64};
       bins  rd_addr_unalign64   = {`SVT_APB_RD_ADDR_UNALIGNED64};
       bins  rd_addr_align64     = {`SVT_APB_RD_ADDR_ALIGNED64};
    } 
  endgroup
  
   /**
    * Covergroup trans_read_x_on_prdata_when_pslverr to check if x on prdata when pslverrr = 1, pready = 1 and penable = 1 for read xact
    * applicable for apb3/apb4 only.
    */
  covergroup  trans_read_x_on_prdata_when_pslverr @(cov_read_x_on_prdata_when_pslverr_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_READ_X_ON_PRDATA_WHEN_PSLVERR
  endgroup
   /**
    * Covergroup trans_apb_state_after_reset_deasserted to check IDLE and
    * SETUP state during reset deassertion (just after reset is de_asserted)
    */
  covergroup  trans_apb_state_after_reset_deasserted @(cov_reset_deasserted_sample_event);
    `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_APB_STATE_AFTER_RESET_DEASSERTED
  endgroup

   /**
    * Covergroup trans_apb_states_covered to check IDLE, SETUP and ACESS state
    * during the transaction
    */
  covergroup trans_apb_states_covered @(cov_state_sample_event);
   `SVT_APB_MASTER_MONITOR_DEF_COV_UTIL_APB_STATES_COVERED
  endgroup

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTUCTOR: Create a new default coverage class instance
   *
   * @param cfg A refernce to the APB System Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg);
`else
  extern function new(svt_apb_system_configuration cfg, string name = "svt_apb_master_monitor_def_cov_callback");
`endif

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QVmOkXY7oaw3IUoTkzw/ALK3gv7FHnQQUTmFWl/ydh3gAjrh5X5mcNjQyrkYEeWY
wFGc+/3GA8Y6JhjCmRdDbKkUfVgT3P3bF43Jf57cZbZvwT2LuAl2C7DqBQdTDxFl
SI/H+P0Q6naTHm97gaCs1O94m9CR7nwKqaxORUR80UY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7084      )
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
`pragma protect end_protected

`endif // GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JPcyWVTymQotsbsWHbnqtSPXSa6OjIw2+xs277+njXxR+PUSn00YDhZ2e6o3pzyr
7rGCoBrZHhSLSfkvlzHIia+tZvFUQvSZG4KlvDC8hGAX2dmfclVLGeyPpDNcF+L6
XLj9o9bEfH8vAVNRZlavs1IuV5LxKuKiB7nojGKWKLs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7167      )
Ng9eQseaMRxsg9j6CHuTWVPNBOLJBZYWTYivbnMz2tgkB7tr+sov3l2DROoloLA2
ekqYupT9aUZmSdsk2ufANrli6hCFBGXVzuzZDeqMAcny45EG3juAkJ1PtijxvNUM
`pragma protect end_protected
