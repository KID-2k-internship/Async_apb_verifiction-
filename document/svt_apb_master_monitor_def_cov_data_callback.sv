
`ifndef GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV

`include "svt_apb_defines.svi"

// =============================================================================
/**
 * The coverage data callback class defines default data and event information
 * that are used to implement the coverage groups. The coverage data callback
 * class is extended from callback class #svt_apb_master_monitor_callback. This
 * class itself does not contain any cover groups.  The constructor of this
 * class gets #svt_apb_system_configuration handle as an argument, which is used
 * for shaping the coverage.
 */
class svt_apb_master_monitor_def_cov_data_callback extends svt_apb_master_monitor_callback;

`ifndef __SVDOC__
  /** Virtual interface to use */
  typedef virtual svt_apb_if.svt_apb_monitor_modport APB_IF_MON_MP;

  /** Virtual interface to use */
  protected APB_IF_MON_MP apb_if_mon_mp;
`endif  

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************
  /** Configuration object for shaping the coverage. */
  svt_apb_system_configuration cfg;

  /** Event used to trigger the write transaction covergroups for sampling. */
  event cov_write_sample_event;

  /** Event used to trigger covergroups trans_cross_write_pprot and trans_cross_write_pstrb when apb4_enable = 1 */
  event cov_write_sample_apb4_signals_event;

  /** Event used to trigger covergroup trans_cross_read_pprot when apb4_enable = 1 */
  event cov_read_sample_apb4_signals_event;

  /** Event used to trigger the read transaction covergroups for sampling. */
  event cov_read_sample_event;
  
  /** Event used to trigger PSLVERR covergroups for sampling. */
  event cov_pslverr_sample_event;
  
  /** Event used to trigger Four WRITEs/READs. */
  event four_state_rd_wr_event;

  /** Event used to trigger PSLVERR of four transactions. */
  event four_state_err_resp_event;
  
  /** Event used to trigger the covergroup trans_read_x_on_prdata_when_pslverr*/
  event cov_read_x_on_prdata_when_pslverr_sample_event;

  /** Event used to trigger covergroup trans_apb_state_check_after_reset_deasserted*/
  event cov_reset_deasserted_sample_event;

  /** Event used to trigger covergroup trans_apb_states_covered*/
  event cov_state_sample_event;

  /** Event used to trigger Aligned/Unaligned transfer */
  event cov_apb4_align_unalign_addr_event;

  /** Event used to trigger master to slave covergroup */
  event cov_master_to_slave_access_event;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Coverpoint variable used to hold the received transaction through pre_output_port_put callback method. */
  protected svt_apb_master_transaction cov_xact;
  
  /** Coverpoint variable used to hold sampled values of PSLVERR when PENABLE
   * and PREADY are high */
  protected logic cov_xact_pslverr = 1'bx;
  
  /** Coverpoint variable used to hold Four State Write/Read xacts. */
  protected int four_state_rd_wr_sequence=-1;
  /** Coverpoint variable used to hold Four State PSLVERR response coverage. */
  protected int four_state_err_resp_sequence=-1;
  /* variable used to hold completed RD/WR xacts. */
  protected bit four_state_rd_wr_queue[$];
  /* variable used to hold four State PSLVERR response . */
  protected bit four_state_err_resp_queue[$];
  /* variable used to hold aligned/unaligned address when pdata_width is 16 bit . */
  protected bit [1:0] addr_aligned_unaligned16_coverpoint;
  /* variable used to hold aligned/unaligned address when pdata_width is 32 bit . */
  protected bit [1:0] addr_aligned_unaligned32_coverpoint;
  /* variable used to hold aligned/unaligned address when pdata_width is 64 bit . */
  protected bit [1:0] addr_aligned_unaligned64_coverpoint;

  /* variable used to hold the slave indexes */
  protected	int slv_num [];

  /* variable used to hold the slave indexes from configuration */
  protected	int slv_num_cfg []; 

  /* variable used to hold the ignored slaves from the slaves list*/
  svt_amba_addr_mapper::path_cov_dest_names_enum ignore_slaves_list[];

  /* variable used to hold the ignored slaves in the queue */
  svt_amba_addr_mapper::path_cov_dest_names_enum ignore_slaves_list_q[$];

  /* variable used to hold the ignored slaves from the slaves list by configuration */
  svt_amba_addr_mapper::path_cov_dest_names_enum ignore_cfg_slaves_list[];

  /* variable used to hold the ignored slaves in the queue by configuration */
  svt_amba_addr_mapper::path_cov_dest_names_enum ignore_cfg_slaves_list_q[$];

  /* variable used to hold the slave names */
  svt_amba_addr_mapper::path_cov_dest_names_enum path_cov_dest_names,t_slave;

  /* variable used to hold the number of slave configuration */
  int num_of_slave_configs;

  /** Coverpoint variable used to update if x on prdata when pslverr
    * Applicable for APB3/APB4 for read transaction
    * Called in pre_output_port_put callback method. */
  protected bit cov_read_x_on_prdata;

  /** for LRM_1800_2009 [SV-VIBV] issues */
  const int cfg_num_slaves;
  const int cfg_pdata_width;
  const svt_amba_addr_mapper::path_cov_dest_names_enum path_cov_dest_names_first;
  const svt_amba_addr_mapper::path_cov_dest_names_enum path_cov_dest_names_last;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new svt_apb_master_monitor_def_cov_data_callback instance.
   *
   * @param cfg A refernce to the APB Port Configuration instance.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(svt_apb_system_configuration cfg);
`else
  extern function new(svt_apb_system_configuration cfg, string name = "svt_apb_master_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------  
  /**
   * Callback issued when a Port Activity Transaction is ready at the monitor.
   * The coverage needs to extend this method as we want to get the details of
   * the transaction, at the end of the transaction.
   */
  extern virtual function void pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Called when four_state_rd_wr_queue is filled with four READ/WRITE transactions,to trigger
   * corresponding covergrop events
   */
  extern virtual function void trigger_four_state_rd_wr_event();
  //----------------------------------------------------------------------------
  /**
   * Called when four_state_err_resp_queue is filled with four ERR/OK responses,to trigger
   * corresponding covergrop events
   */
  extern virtual function void trigger_four_state_err_resp_event();
  
  /** @endcond */

  //----------------------------------------------------------------------------  
  /**
   * Callback issued when reset is de-asserted.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void post_reset(svt_apb_master_monitor monitor, svt_apb_transaction xact);

  /**
   * Callback issued when the transaction is in SETUP, IDLE or ACCESS state.
   * The coverage needs to extend this method and trigger the event to sample signal.
   */
  extern virtual function void sample_apb_states (svt_apb_master_monitor monitor, svt_apb_transaction xact); 

  /** Samples the apb master to slave covergroup */
  extern virtual function void sample_master_slave_cross();

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
k9NDvoUoXOCeZKJ2yWI5zhfoFOCyDSCtDMcbGCjTX+8I6ysLJf1/IJwPBXYqUfIK
smd+Zn1VtRw6SOawSGHlhTOjqgtD89Vcml7wObCBhJA/puSd1xE0v4wk0opXr0yX
sBAFlfxPb09xsObpYcdZ1zEghOyWTJvuW8E+48ROhIE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 830       )
Gz8Wrn309PpKwG2Qnw73u4C0BfF2GQnadhbYjdVHfLoR3hRGp8166IVyVg+o7lhX
pYR6Ztn/6vu5HSK+n3W+GF5zAND3FNOQuJMqaQdytaxACPH2JWh5cwkMg5l7b6vI
4tP8PsvY7bHMosIBaBhESZ7IuWC7vbhmEWLqCtXAQFtj7WOjKY4/uSQTG8bW9iqr
kNoQnYSgNGAXpE6DW6IsVKf2nSxpqy/bG7xEm0lFyhdfA4xV50vdKiU3iUJGwG36
mfE/wfItat8JaMIfQtDN8B3Bd8iyNqbjIEpX+y7wyKV8i+fCB1iq4ChjcfxMmbuY
sPG1N2eD9IFtOFwbScbqCYXI7PaBM8mwuCjdlpc/vdNo9xJ2Dc4rcbgoP2SlztPT
ndvdiVH4QeGUcXdqD64Kav5Es4G277xpCbGcn/83ZlHu1UNV2SWHEiNPha8j1sMb
W57CG1VXZD+Y5UrQBqumPInVDsOFV0RDMLmymPv5FKpdukyBGvCURXDL7NW/JNRw
RDBgsOEVnhCtYYBhQNtbA0xV4gp71C3a14leDKhyjNE33gdnST0l+z2fp2ISbjYR
w96qn8FJd56YIblwmni6+pjRA66HxvZhggKb3HvJCmoDLkoEy7Yl8G/KHSP0p8ZT
pz/Sv+tfIym83lKto7Ec1BVDkVq4kYD/k8W0ZZDm144Q9caRJAeGW+jRqFPe9XHe
hJI6M+Uctxo+vW0rCwlApQLVUGyWY/1BSOdZdPuJIjHqH/EdLuAY8WNtL1rXv6U5
YK8i3xlOiqyqafSIG/QHXTjxoJpUWze6VGOu51/0ir610yGsYLPnT03X9/czRd3A
I+++ZfzrbauQOCcbszgGXACvEKOIYD77YoHhXw/mTew0wrZUlwbaaJcyBp2AEmfx
guInxPHxhDSVoa7WSzGvkkNHmznfkl5xXWOSq4OJGKzd/SnqEFL9umnb3E/69YLp
l0Y7NXqYXj5G/+HFyT/C3Szo1u8r5Bx8G/gR3Xz1+SZ3ywV2XD9deJZV0t2Z/xEe
HlpguY/BqrzwrkWEscoqKnh2IxbwqdkOAwj2WK8VaneL42xAdem0KNJwp7vyy0Nh
0vl57KodDuVy7dEu9g2KpA==
`pragma protect end_protected

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_cov_data_callback::pre_output_port_put(svt_apb_master_monitor monitor, svt_apb_transaction xact, ref bit drop);
  
  $cast(this.cov_xact, xact);

  if (xact.xact_type == svt_apb_transaction::WRITE) begin
    ->cov_write_sample_event;
    if(cfg.apb4_enable)
      ->cov_write_sample_apb4_signals_event;
  end
  else begin
    ->cov_read_sample_event;
    if(cfg.apb4_enable)
      ->cov_read_sample_apb4_signals_event;
  end

  // Only applicable when svt_apb_system_configuration::apb3_enable or
  // svt_apb_system_configuration::apb4_enable is set
  if (cfg.apb3_enable || cfg.apb4_enable) begin
    if (this.apb_if_mon_mp.apb_monitor_cb.pready[xact.slave_id] && this.apb_if_mon_mp.apb_monitor_cb.penable) begin
      cov_xact_pslverr = this.apb_if_mon_mp.apb_monitor_cb.pslverr[xact.slave_id];
      -> cov_pslverr_sample_event;
    end
  end

  if(cfg.trans_four_state_rd_wr_sequence_cov_enable)
    begin
      if(xact.xact_type == svt_apb_transaction::READ)
        four_state_rd_wr_queue.push_back(svt_apb_transaction::READ);
      else if(xact.xact_type == svt_apb_transaction::WRITE)
        four_state_rd_wr_queue.push_back(svt_apb_transaction::WRITE);
      if(four_state_rd_wr_queue.size() >=4)
        trigger_four_state_rd_wr_event();
    end
 if(cfg.trans_four_state_err_resp_sequence_cov_enable)
   begin
     if(xact.pslverr_enable == 1'b0)
       four_state_err_resp_queue.push_back(1'b0);
     else if(xact.pslverr_enable == 1'b1) 
       four_state_err_resp_queue.push_back(1'b1);
     if(four_state_err_resp_queue.size() >=4)
       trigger_four_state_err_resp_event();
   end
 
 if(cfg.apb4_enable) begin  
   if(cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_16 ) begin
     if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin
       if(cov_xact.address[0] != 0 || cov_xact.pstrb[0] == 0  )
         addr_aligned_unaligned16_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED16 ;
       else 
         addr_aligned_unaligned16_coverpoint = `SVT_APB_WR_ADDR_ALIGNED16;
       end 
     if(cov_xact.xact_type == svt_apb_transaction::READ) begin
       if(cov_xact.address[0] != 0)
         addr_aligned_unaligned16_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED16 ;
       else 
         addr_aligned_unaligned16_coverpoint = `SVT_APB_RD_ADDR_ALIGNED16;
       end 
     ->cov_apb4_align_unalign_addr_event;
   end
   else if(cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_32) begin
     if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin  
       if(cov_xact.address[1:0] != 0 || cov_xact.pstrb[0] == 0)
         addr_aligned_unaligned32_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED32;
       else 
         addr_aligned_unaligned32_coverpoint = `SVT_APB_WR_ADDR_ALIGNED32;
     end
     if(cov_xact.xact_type == svt_apb_transaction::READ) begin  
       if(cov_xact.address[1:0] != 0)
         addr_aligned_unaligned32_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED32;
       else 
         addr_aligned_unaligned32_coverpoint = `SVT_APB_RD_ADDR_ALIGNED32;
     end
     ->cov_apb4_align_unalign_addr_event;
   end  
  else if(cfg.pdata_width == svt_apb_system_configuration::PDATA_WIDTH_64) begin
    if(cov_xact.xact_type == svt_apb_transaction::WRITE) begin
     if(cov_xact.address[2:0] != 0 || cov_xact.pstrb[0] == 0 )
       addr_aligned_unaligned64_coverpoint = `SVT_APB_WR_ADDR_UNALIGNED64;
     else 
       addr_aligned_unaligned64_coverpoint = `SVT_APB_WR_ADDR_ALIGNED64;
   end
   if(cov_xact.xact_type == svt_apb_transaction::READ) begin
     if(cov_xact.address[2:0] != 0)
       addr_aligned_unaligned64_coverpoint = `SVT_APB_RD_ADDR_UNALIGNED64;
     else 
       addr_aligned_unaligned64_coverpoint = `SVT_APB_RD_ADDR_ALIGNED64;
   end
   ->cov_apb4_align_unalign_addr_event;
  end 
 end 
  
  // Implementation for trans_read_x_on_prdata_when_pslverr cg
  if (xact.xact_type == svt_apb_transaction::READ && (cfg.apb3_enable == 1'b1 || cfg.apb4_enable == 1'b1)) begin
     if (apb_if_mon_mp.apb_monitor_cb.pslverr[xact.slave_id] == 1'b1 && apb_if_mon_mp.apb_monitor_cb.pready[xact.slave_id] == 1'b1 && apb_if_mon_mp.apb_monitor_cb.penable == 1'b1) begin
       // check if prdata has x
       if ($isunknown(apb_if_mon_mp.apb_monitor_cb.prdata[xact.slave_id])) begin
          cov_read_x_on_prdata = 1;
          -> cov_read_x_on_prdata_when_pslverr_sample_event;
       end
     end  
  end
  if (cfg.trans_cross_master_to_slave_path_access_cov_enable)
    sample_master_slave_cross();
endfunction

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_cov_data_callback::post_reset(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  
  // trigger the event to update the trans_apb_state_after_reset_deasserted cg
  -> cov_reset_deasserted_sample_event;
endfunction

//--------------------------------------------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_cov_data_callback::sample_apb_states(svt_apb_master_monitor monitor, svt_apb_transaction xact);
  
  // trigger the event to update the trans_apb_states_covered covergroup
  -> cov_state_sample_event;
endfunction

//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_cov_data_callback::trigger_four_state_rd_wr_event();
  bit [3:0] four_state_rd_wr_var;
  for(int i = 0 ;i < 4; i++)
  four_state_rd_wr_var[i] = four_state_rd_wr_queue[i]; 
  case(four_state_rd_wr_var[3:0])
      `SVT_APB_RD_RD_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_RD_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_RD_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_RD_WR_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_RD_WR_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
      `SVT_APB_WR_RD_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_WR_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_RD_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_RD_WR_WR_SEQ ;
         ->four_state_rd_wr_event;
         end 
       `SVT_APB_WR_WR_RD_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_RD_RD_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_WR_RD_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_RD_WR_SEQ ;
         ->four_state_rd_wr_event;
         end
       `SVT_APB_WR_WR_WR_RD_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_WR_RD_SEQ;
         ->four_state_rd_wr_event;
         end  
       `SVT_APB_WR_WR_WR_WR_SEQ:
         begin
         four_state_rd_wr_sequence = `SVT_APB_WR_WR_WR_WR_SEQ;
         ->four_state_rd_wr_event;
         end  
  endcase
         void'(four_state_rd_wr_queue.pop_front());
endfunction //trigger_four_state_rd_wr_event
//------------------------------------------------------------------------------
function void svt_apb_master_monitor_def_cov_data_callback::trigger_four_state_err_resp_event();
  bit [3:0] four_state_err_resp_var;
  for(int i = 0 ;i < 4; i++)
  four_state_err_resp_var[i] = four_state_err_resp_queue[i]; 
  case(four_state_err_resp_var[3:0])
      `SVT_APB_OK_OK_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_OK_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_OK_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_OK_ERR_ERR_SEQ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence =  `SVT_APB_OK_ERR_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_OK_ERR_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_OK_ERR_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_OK_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_OK_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence =  `SVT_APB_ERR_OK_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_OK_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_OK_OK_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_OK_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_OK_ERR_SEQ ;
         ->four_state_err_resp_event;
         end
      `SVT_APB_ERR_ERR_ERR_OK_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_ERR_OK_SEQ ;
         ->four_state_err_resp_event;
         end  
      `SVT_APB_ERR_ERR_ERR_ERR_SEQ:
         begin
         four_state_err_resp_sequence = `SVT_APB_ERR_ERR_ERR_ERR_SEQ ;
         ->four_state_err_resp_event;
         end  
  endcase
         void'(four_state_err_resp_queue.pop_front());
endfunction //trigger_four_state_err_resp_event

function void svt_apb_master_monitor_def_cov_data_callback::sample_master_slave_cross();
  bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] start_addr;
  bit[`SVT_APB_MAX_ADDR_WIDTH-1:0] end_addr;
  bit is_register_addr_space;
  int slave_port_ids[$];
  svt_mem_addr_t slave_addr;
  svt_amba_addr_mapper::path_cov_dest_names_enum dest_addr_mappers[$];
  svt_amba_addr_mapper::path_cov_dest_names_enum ext_dest_addr_mappers[$];
  bit[`SVT_AMBA_MEM_MODE_WIDTH-1:0] mem_mode = 0;
  string requester_name = ""; 
  bit ignore_unmapped_addr = 0;
  svt_mem_addr_t global_addr;
  bit status;

  fork
  begin
    path_cov_dest_names = svt_amba_addr_mapper::path_cov_dest_names_enum'(-1);
    status = cfg.get_dest_global_addr_from_master_addr(0,cov_xact.address,mem_mode,requester_name,ignore_unmapped_addr,is_register_addr_space,global_addr);
    if(cfg.get_dest_slave_addr_name_from_global_addr(global_addr, mem_mode, requester_name, ignore_unmapped_addr, slave_port_ids,dest_addr_mappers))begin
      path_cov_dest_names = dest_addr_mappers[0];
    end
    else if(cfg.get_ext_dest_slave_addr_from_global_addr(global_addr, mem_mode, requester_name, ignore_unmapped_addr, is_register_addr_space, slave_port_ids, ext_dest_addr_mappers, slave_addr))begin
        path_cov_dest_names = ext_dest_addr_mappers[0];
    end
  end 
  join_none
  ->cov_master_to_slave_access_event;
endfunction


`endif // GUARD_SVT_APB_MASTER_MONITOR_DEF_COV_DATA_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bQcU/XIYdyDuluSsx2AThAf7iTw36xKQqe9uA9ZOI67QSO0fGfLsfQjYUbzpsDbV
A0RPjB207wqwRC5+zXr/qW0NuL7HRN0/pS9bhvdLUkTj5YGMuDellwn50FocslA+
EWDa0pFlpr4em/zUxezg4Mqi7OTxJEy24YRp2vR5BVA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 913       )
eUUpx1/qsobE200wq4vGQftC0/TcNkRJWHJP1of1GGNJk752GrWaMgfVVTn7pdcD
p4Ef3os5lXnoOrteDK22cH7drqbVyIvGeMb1NVZrVAoZBhsVxq3jCRRQuntUtk4o
`pragma protect end_protected
