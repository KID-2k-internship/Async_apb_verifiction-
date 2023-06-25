
`ifndef GUARD_SVT_APB_TRANSACTION_SV
`define GUARD_SVT_APB_TRANSACTION_SV

/**
 * This is the transaction class which contains all the physical attributes of the
 * transaction like address and data. It also provides the wait state information of the
 * transaction. 
 */
class svt_apb_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Enum to represent transaction type
   */
  typedef enum bit [1:0]{
    READ  = `SVT_APB_TRANSACTION_TYPE_READ,
    WRITE = `SVT_APB_TRANSACTION_TYPE_WRITE,
    IDLE  = `SVT_APB_TRANSACTION_TYPE_IDLE
  } xact_type_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    NORMAL = `SVT_APB_TRANSACTION_PPROT0_NORMAL,
    PRIVILEGED = `SVT_APB_TRANSACTION_PPROT0_PRIVILEGED
  } pprot0_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    SECURE = `SVT_APB_TRANSACTION_PPROT1_SECURE,
    NON_SECURE = `SVT_APB_TRANSACTION_PPROT1_NON_SECURE
  } pprot1_enum;
 
  /** Enum to represent prot[0]
   */
  typedef enum bit {
    DATA = `SVT_APB_TRANSACTION_PPROT2_DATA,
    INSTRUCTION = `SVT_APB_TRANSACTION_PPROT2_INSTRUCTION
  } pprot2_enum;
 
  /** Enum to represent FSM State
   */
  typedef enum bit [2:0]{
    IDLE_STATE  = `SVT_APB_TRANSACTION_STATE_IDLE,
    SETUP_STATE = `SVT_APB_TRANSACTION_STATE_SETUP,
    ACCESS_STATE  = `SVT_APB_TRANSACTION_STATE_ENABLE,
    UNKNOWN_STATE = `SVT_APB_TRANSACTION_STATE_UNKNOWN,
    ABORT_STATE  = `SVT_APB_TRANSACTION_STATE_ABORTED
  } xact_state_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Value identifies which slave index this transaction was received on */
  int slave_id;
   
  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------
  /** Defines whether this is a write or read transaction, or an idle transaction.
   *
   *  This property is rand for master transactions, and non-rand for slave transactions.
   */
  rand xact_type_enum xact_type = IDLE;

  /** Payload data.
   *
   *  This property is rand for both master and slave transactions.
   */
  rand bit [`SVT_APB_MAX_DATA_WIDTH -1:0] data = 0;

  /** This property allows user to send sideband information on APB interface signal control_puser
   */
  rand bit [`SVT_APB_MAX_CONTROL_PUSER_WIDTH -1:0] control_puser = 0;

  /** Payload address.
   *
   *  This property is non-rand for slave transactions.
   */
  rand bit [`SVT_APB_MAX_ADDR_WIDTH -1:0] address = 0;

  /** If this is an idle transaction, define the number of cycles idle.
   *
   *  This property is non-rand for slave transactions.
   */
  rand int num_idle_cycles = 1;

  /** Number of wait cycles that the slave injects
   *
   * This property is non-rand for master transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand int num_wait_cycles = 0;

  /** On Slave side, this member is used to inject slave error response. 
   * 
   * APB Slave VIP drives error response when this member is set to 1 in APB Slave transaction.
   *
   * On Master side, this member is used to report whether master received error response. 
   * If APB Master VIP receives error response from slave, this member is set to 1 in APB Master transaction. 
   *
   * This property is non-rand in APB Master transaction.
   *
   * Only applicable when svt_apb_system_configuration::apb3_enable or    
   * svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit pslverr_enable = 0;

  /** Write strobe values
   *
   * This property controls which bytes are written to memory.
   * 
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand bit[`SVT_APB_MAX_DATA_WIDTH/8 -1:0] pstrb = 'hf;

  /** prot[0] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot0_enum pprot0 = NORMAL;

  /** prot[1] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot1_enum pprot1 = SECURE;

  /** prot[2] value
   *
   * This property is non-rand for slave transactions.
   *
   * Only applicable when svt_apb_system_configuration::apb4_enable is set.
   */
  rand pprot2_enum pprot2 = DATA;

  /** This member reflects the current state of the transaction. This member is
   * updated by the VIP. After user gets access to the transaction object
   * handle, user can track the transaction progress using this member. This
   * member reflects whether transaction is in IDLE state, SETUP state, 
   * ACCESS state or ABORTED state.*/
  xact_state_enum curr_state;

/** @cond PRIVATE */
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the addr. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int addr_width = `SVT_APB_MAX_ADDR_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the data. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int data_width = `SVT_APB_MAX_DATA_WIDTH;
  /** This attribute is only used during do_compare to restrict compare to only 
    * the used width of the pstrb. They are being copied from the configuration
    * in the extended classes prior to calling super.do_compare. */
  protected int pstrb_width = (`SVT_APB_MAX_DATA_WIDTH/8);
  /**sideband signal width
   */
  protected int control_puser_width = `SVT_APB_MAX_CONTROL_PUSER_WIDTH;
   
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

//vcs_vip_protect
`protected
MN=[96dC==ULP/JgPEgS58.\VN=/I]9A0Yd;a3IGOE07eIV@4O-e3(848WV3SAe8
B:]>6FQ.BfX_@N?@#F(F3G.E&>4<W]ec&a84/ZKC)+:-2.6//ZHc9;ZFgDGV7^0=
PS>HHPPe/E<J<Q[NC)F-Nd+M_bX+(Z3H2N,KZ(<_6/3=.<c\O6^1>9Y4)01Z?N1W
E_^.).>YJB5EN=1gV?-]_Q/H<d?N[(\G2dDX9WX4aE5/-3)7Y_VeXHZGc2J7T1,Y
HUP4fd9:O>e\\8c#OVR#7,)@&>6Odg&RP:3O,&U(>VfF&U0aI#8]7DAY8XATEB[9
Z8GDG=(g;3bGB(R-4Q8[Jg=;2S]dB&da?$
`endprotected


`ifdef SVT_VMM_TECHNOLOGY
`svt_vmm_data_new(svt_apb_transaction);
  extern function new (vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   */
  extern function new (string name = "svt_apb_transaction");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

  `svt_data_member_begin(svt_apb_transaction)
    `svt_field_enum(xact_type_enum, xact_type, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_int(data, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(control_puser, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(address, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_int(slave_id, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_idle_cycles, `SVT_ALL_ON| `SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(num_wait_cycles, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_DEC)
    `svt_field_int(pslverr_enable, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_BIN)
    `svt_field_int(pstrb, `SVT_ALL_ON|`SVT_NOCOMPARE |`SVT_HEX)
    `svt_field_enum(pprot0_enum, pprot0, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot1_enum, pprot1, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(pprot2_enum, pprot2, `SVT_ALL_ON | `SVT_NOCOMPARE)
    `svt_field_enum(xact_state_enum, curr_state, `SVT_ALL_ON | `SVT_NOCOMPARE)
  `svt_data_member_end(svt_apb_transaction)


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
 `else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif
 
`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern virtual function svt_pattern allocate_pattern ();
`else
  extern virtual function svt_pattern do_allocate_pattern ();
`endif
 // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the filelds to get only the fileds to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();

  //--------------------------------------------------------------------------------
  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );
  
  //--------------------------------------------------------------------------------
  /** This method returns a string indication unique identification value
   * for object .
   */
  extern virtual function string get_uid();

  //--------------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the packet generally necessary to uniquely identify that packet.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which packet data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  /** Does a basic validation of this transaction object */
  extern virtual function bit do_is_valid (bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_apb_transaction)
  `vmm_class_factory(svt_apb_transaction)
`endif
endclass


`protected
2b@60g4IANJY@f;;BEX[K&?=_gKF1Q;WZ\&E;gBA?77@/J=cL=[5()JX/TfG9G)]
S,F53]_@W[MC@3A]D#a17MI4E2>B+Ta])dJ/LXL&F>Pa=?]-\aD6a/\.eQ+R8YZ?
g2G4W9SRM-UCEaC?]-g-3?3_?0cJ#_Re6aDB9d&\1<N.OU8VMPc34I,R@K<[Q;TR
BEQb2ZT/]W5L:EGN)@McFaQ4#ZUO.TB>b3Jg;SY;X2DD7VLKY=42FHMNRX#W;V@5
#FgMIbMIDJb<Wa/@Rec5&4?V[dPL?dWfVW5_N4_<LN\FL&Q^)>4eVOK)?A^4I1VP
Te0b]JCCc_?<YC17Y#_<^L+L[=--L?+1f#55a:APZ(QW-/;]W:JG#P^C]c>(3fXW
&?d#;a>+EDG\G?#dgcZUB3^,N&a#F12LeRQHV9SKgBd5]8YLG#3d+K.S3Q\<PYSP
I+XT]Q_:g@]e[<4GH>,2aLH@DJVJ+95R6/CYFVb^eWI/PQP;13Z:YMD/5@]W]<EO
^\J>BfaR_&E&9DBW;/Z6-_Zd&WgS9<CEP3>N;S6YVQ9+HI(:(K4BV.eOVP)QV1FL
8PH,WRE_(##&@N[PL=f8C;VG6RL/IZ17N7KZWOb6Fc^+70M@Y+.R7?:C/]YdB2(0
LU0N/fBM9]@&9TRN9^,M?@gY,6Ye[AWVU_5#:H:\44>SF>JVYA3\fI^D.IR9Y1_&
SWTTS]ZH>=9SRI(,P0#XKJa=I.L9RA9A(OW^IC-eU9c9;^M)PWVgB<>aGZf-DJM=
NKEX9bC&2MNfGMY6+_,a)cP8?KG\-2(IZ>1TQ>Jbb&14f#5^+6G9->U7P2+27\Sf
2N94XBO6_(d3H&29Nd\.5+7Z?@g@8AgF>$
`endprotected

  
//vcs_vip_protect
`protected
Fb)5>BE]3<bT2GC-^_RRO[EJ00..0LHO<<4LRZSL4P?Y96KXY:OT((;&9D3S1.f/
D@SLJ[8SO0+RgOff5;9,?7]PNYf<0Ef1Xe5e^0?+4N\4X?BW#@H7a@C8K.D;Pd(3
OR[;6FH:4UCM-Z@ZQF5;A/2X0A#Mce84)Z4I?J&:F]aOV71GcbZQ/X\(O:dC)ZN+
KZ?V@2@CdOJWWg0=GdK/R[W?@WU]WV\U89U<PJDH.\11E+[Y&b&GUMdQJ=1O-?@X
gZ(N)3K.TGNC>>_.E[WGY;CV1S&5KU9EP/DDJ<T?F?U;WcH+O;dN0(WU-7W-]^_]
5-3=1MSH@a>=M+Yb99VKNA-J,K=/ad@b,Y7]/(_MBYH1d&7GO[T((HLMQG,SP+8B
0[^<AS9c9SSX(B1:7B([Y)&O;FfK&-HQN&N9U_^/)-]-::_D_fCc.=.77&cg4E1f
DLT69?/Za:6U5PXP9[Z5P-]XY(gU9N<QRFc]Kg2;<e/IZI-M]CgOE2[b#ab.87Og
fR\8bbA+GMPU6]YL[(YZ^)Ha[>)c,+_JHS:GZEK]U>bY&8EPWBaDZWG=)#MUWe+J
RbL?efQXc1\PJVF8Ae?4C[XdE)GN7Yg[g>6-)1)7G97eSQ>=0BDOBEf7[#]ID=U4
4G]UD;03?M-P+$
`endprotected


`protected
H]IEd#ITR,f#5#VKYC?&#f>\@0(PVW>a3XZ+PB#&9IWKbPeIZ=UZ5)?B3][WX]Y.
5D:ST,OebgA#,$
`endprotected

//vcs_vip_protect
`protected
PD102O\Of5L5e4X-_59L5<gZX&B:MUTQ(0ID9^>4@cCRM?cJ14e].(KY0UW+4:&&
cYX42B4I48,CCWd=]->bU_D?+V@SM<2Ee(_W/RA^>Bbg_2G.(6:]>VHK[]^P8N+?
[RZY5;6fK<&=dHT)(NBC[LD()]G,=IBH/0[+3_)a5Yc970JeBJ:5WMS1f-8OdYdc
(NdTceUSc;BJ)X@d1\E?7#30[VCTBY2,Z,9?9@XN+^_X@\>CP&>aLO3M<=>XgDYZ
&KZLMg=-)afZa5K@/.^M^<ObNI?b.N5d])gI(L[)a6EXBgL-]@O)1Z4A(K>9V<HT
?J4a3b<^\<gb4cGCdN0cAR,#/(;QeBSA]5@OF2YLe=2CN)I<e?5;bWRR]cRN/#7M
SAG)RebEPCT6\C21c.AOD@S>RR_8?XERdZG-^,/B8PC^:9BM@;A27SOGWeg1U)QP
\T1KC^gB5aS#48UB-acE+HdQE@GOWR\;=R1\/OWN\3_]+Z[;6J/N+G6;\?+V;BHU
BH<51PIQ:AKVGR7T6\W9XB&513A[a(cB35V;<4#IX;H.g+1Y5X9F)@-&O,bXJ:]I
>Pg[0c1PPC^M9T4;XG^G9CA4O]F,+e09_2Y@SKb=GOPTgP=POcU=6[;OE>(?N]8.
PR&6&(??ASJf<22&-CS<0PEV4ZXFfBY87_ZIIKd/.#H;eG5^#K3[9X=CAAeU+\E^
MEF@4P3RE/Y17P7TB=?)645]a7T/_JBbN45f(9Y<e0M\;[g:BAJ2eH;TB_b8L:f2
:6GJdEPf]1dZcG(\4+6<Nc7RK.91b?/R2KEL=FN=BN]WX>>-RF/D[a?5U-R]M]7>
_&[9#0#/W@6Qe:[U#.V1&J>)X6,&I4I^?Va&YN^d97?3VKQGA;HMOX?I]A@V,XAV
\D#+U\bB]W,;0]PGA5)BF;G,@SES&_6P=e=3?S45S-2@IGd,B+<IMZH0ZSV[?.b2
;.F,O@fY4#V?f52;3_3=f;-Sac^1Ya[9\U\2Nb,23gO-Z=LC@b+8\7c+LQ>JFaVR
9=7U8\gE.<=801\CXCUEL?TQ/SGN;?dNgTWcDNYJA:;cY0\=^FK3>YMI(VX;aLM/
?A0^<a-?=F>[,O)eC9[eW^ac/58)V]IENZ91EVB]FV)?PKDA\A?<(+Mb+W)&Z4eE
-4dLg-7)_7)?4B\eNJB71bOc=SB40-S:?dSI7U->(6OG+I+=P[.WDD4bSUEFf;D/
G1)RM\TdUfR(dH2?KBN]D^,.^;:H8J#FI/e4&I_KT&0J1E9dRcJ)LeG637FAR&\d
dE4;/g3gV7_2DdS3GZMYMc<#A_@9V,F85K-+P8IGP>RIZJKIFVU+gMKAEJR0XF5/
G25Yg4^B@J9[-<B?F[;O^S33]2T7b,U@C3_T7U-.UR)<]7[[9O/L6]W[&I-OCEbY
-YJV/]:M2&U+^5gbJ:QA:e\;IddU?^STMZBE59Fg3]I&]dTX@_8;#e5HZ5D)/7db
X0fOFBQ-R4N0S;6+>A46Z57Rd9Vb;G3c-RBa@/>]OS\G(W-a)eBR[]3DPfI9F=@a
53.LJJI:/?>4W8L5>S@JN40^&WNWJR?[+eZ\+V)L(<R6&@_f5X9:#JR];e:IfW9]
Tafc^Z3B=NdBB81488g[J=N&^Q[97E,-_M&dJ17^2T;UaO/E5F[8MS_E&?3c+Eab
^0\_H?ACbJ5Ya7^23[/^?+XMD60F@[^I]05MC_aXL99N=_\]\O>MgC2B:^HU]M_a
_Q=Ka.X^PU^G#7cXKM\HG<<(UR7?S^P#7(>fO:PH6.J9G;+a8S_9X.85F=PC/cgC
HNY/A?_1<2_eCV_?7-G/S7.3S97d;-<8&<A;ae,1]]HP7O-MH;;-9/7(KP3.8B;F
0f+B&E6Qa1>YW1OUXdA58F,/3f8#dNKWga_R+@Q9WbDY+R+VQH]Q9CJC+4D+=g1@
)KY1;;SP>S<(,EE/;-?c@<=.K\E+=:91M,N8SWQ/?K1V,;S;3QM?a[O(d4B=YBBA
2A=8FF9eD@G5_>6]8P?)2X<;7(SZ^VPHV]ecP.C@Pg0=0R#N;7P?/DETAA=NAL9c
AFb3^^,64PQ&LLgZ/d2)AQA:Q,,G]:)JBQ]_CAJ4M0(F@<DID5@Z&7M(^F87RXO[
L1C#X[4WCC24[6/&>YSKf9a)ZZ/f4E8)75XLTLQ.8VB7RG#:1[TULY0T#HO]34Gb
F_#TVO[b]WOE]7E^Qg8K#R6^7g&3@9=V-?+5WFVT>=;8<aZ9]=eZU2X>@T6:OA3(
TC<:C+YeS1&F)5fYJ=a8N/-W5bf((6V#UCA:?NO6[dGVTK?6fPN2:<-/FARL+;Z1
-4adL]KW(OXe6O+&DOWGHGfd1IHbB70,[PS+ZJ_WOR.I7:8bM1g1YMY?&I=9HBY&
]X3+IZRPeAIa;cT_09;]:-PT,EcV7#>PNKa>FGD^GWL8[N92_.^7G0R.]Y8)J\A/
JNR8\)C^CUF:0/@D+)_?cIeV=KFW2Lb1&?Q@P,ND5E8gA0:GSFU3KHJXNH6g1EFg
3LR>Q60f/_gCWCf=#EURZYL7UK^7IfGNg\.,.1JNIK@:#=/;J>Y3].WPEb+1KH[E
QAGQ/X-LaI;[Vg[FU.b&eVCOV,J0M5+ZRU7++87\eeU6/.I2.B8R=9O:dd0bE/-g
9g\M#6aaN3X@d@6#\EU&Y[b9IHXaN3.:ZZc;?OYJ2bdTX9EPgO?,&(3SPUX3X-43
]G]ec0cN-.+59D_?8)<GgI9Y5?NO0]\A=)OW5A^SfO2gFMGX3U:BL)214\O4\=,-
R59\;&TSSW(DQ8]X44<RTOaB^a,GOcNAYP@\P90N_0a0]H]XA5IAfU&.&+:f95:M
9FdD)+-:\4.FSBL\4/eI^IC/JCK+DDT1.b+g,.+E.(:,Md/J1N70aNbMe_E;P>]5
Q9[B,21KILORA(I>CR5YGeEd;:;DMB@NLW1#F]G69BTJ&F>f[>WTd/]g3P:>;1V#
<@O9[,LH=3B0B)):06XK>DFY0^T5aCba>e3Q\((5+P<)+/_BcY]W\6C973(/2dFP
W;&(R_&a,P/a.&AC^J1_#W0#F-UYE[A=2efXP8Z(AH4;_)5VdO^@][K,C@bNZ<,S
:dJD@aV1Y0#ODT&#R<)AdL2YKGW\DB-_LdWN@Z)>B;8:cZ5gg#NO?)^:3V<G1<]g
=2[X5+000eH?Q01-?N<C#)a,C_-Af;,[:?/fU&L+5\TES,JE(-U1+M3@ZJE^Hdf?
7(-_\-ZeN791L4MM^(AbeH4UOX\>T\9KBL=2XZ(?/T4[\YXR^[7]<@K4U-\;\X]e
8,ODGYe+Q>[Sf_ODE7:],S7J@&AS(T9#9#7DJbN0^Y51(;R2QB\;NdR_SLVNI=bH
;ZL_I^?(IgQAB2e[.a2UgIOB^IUNUC;._VC61482ca/1]/WQ4T,:<\+U\]Le6Z(_
MK[N,ZY&SH&K0Z>Q#a.4B^a5T<B>Wc^X&A6-Q@4.-@(<N#+;^Z)<&+,PgRYbcE8-
;Z.RX;#8TE9gV>OC340ZP,WYJPTKKU[K0K:.+a#.N#8d3Xb3g8aT(8[I]SYNMa<G
+?,F-,@VLCHT?_F)M.SD]X4-MSL:RgG(NLPIaaH?2,+?H]HGI&)e6b_+#OJT.2N)
Z9?XC(#KgdB;,BVH=-BWCYMN[P2H4gQMYc<-YA633]f=S^T?KBeefBe/KYYOP.PQ
U)^8/RE@5>Q0F-<CJe=<D3?\[+N^9gFP6ADbIec)QXd[b>:;F[7FJ,NQGd&8(+Pe
5,?d)8d8>1_]ZN2=/]V]XcI_@5f&f5<&;\Z_/a&U)55UP5P2\LC[]fTAC\<RC4YJ
;1U_QBd:XX+]=a,&ReBD@e#H//ZCN74F.eX0JCZ#.@0QKWOGLLQ,8CbbD(DM)>JJ
]I:QP/e?gU[9,eO8C)C#c?daCVSLQ9FJAB[.&1^ZFIW[Y.N#Q1SG0<+??f2;g6\a
V(c9&A1PRf[8DKDMbA8KIH^X(f(KVB?TOFYC?0X=A]:5dX3R-L&SJOX;AH]Y?7I1
LIRbEE>,T,,OT=RB61WWSW[=LE(H&KUW<>Eb;D^g7@<]D1RFSD6e</C/TDd4P.Le
Pg/(Mg-LH0EKPdO4Q?7RP<-1J>.N+@KZLQO_2ZccEO4aJG+KK9N)75K?A?_QX11Q
1a3LAZ0C_V?-VI^8QAcN&#X)++7P353L,GLLQ+NRb#fe=e-,[]+S-D4ZB01JTV3C
41Xd0NE/2BfY:Q4MR@;?I)dAS^gQ47WSbQg;eM\H1:fM=Y];O(5+C&_e;3@\4:6;
&aHZ-Z-RL_U)2-TfC)5S)MVA&<7,SQ-71bWG..,O<;WaAAMY<X3DXPQ6P(J6&LIf
Ld8&g>#BBB>fF_/Kb+5>K90+]=;L;K1bJXB=KGL^58O6fX^,_/?1<TMBM8EgJ4U@
_\Pg2.4Q;QECfTJ2@[AfQML9DZ.X/15d/^_7=#B?L:3:Q4W,3N=W(?,Z/b4b:L2L
.PE7SX,NHcGF613<^]6W+_&KH,-5<O=XaDL&<,dT6_YU9S;B7]IO+)=,GP2Y_^JU
4McGT<PE@_GUZ:K;^W6M(#ZQcf8:3)9Sa,B1)8;G0\aX&)NDW;36#P:L5OOE]1f;
P56>(4fVa-T&IWFP3>Y1TCT21M9)\e181TP05-A@,X+PNgQ4O+;:UJA-D3PJI>LB
a@g1gb8:6X>.PaR=3a2be6g>R:VNA33aU;UUd>5@=7#1FXUK0L/WY]MRQ7YYBAg^
I7O95d#0C&D(GZ0K?TO07OZe:(agQ@AZ,RH]]MPdX59D@gZTe<R>UQ_d/D3<FX/A
E>[]P)F/8\MQ#^BHV<DK#<75E(c:<YD9ag;IJ6a_g\16UfN[fYNb3M>9Lb>LXdg=
^AaOY9(<9LUS:eB/3<=J]XK.e]^A#9?:XQ]=g/6d__Q+IL2c>9GAVEB5\eAQ.@+8
#4O<=WV7dAPUB+T-Na8G7B47<#WKMXNW:1D43eQIZb=#[P:54F?7c)D7(O70&:XT
;dX&?Wg4+W]EaCMY)I2.JFH^#R86V#Q52+ZY57f&L:Q_#SH3.JSA7MTP&GJ(#1J0
Gc=B=87=M@?-aCX5FWVAQ[dMb.L2,82-^IKD7+a,US+?,F9^[<[75WN?c.bV._:&
b7S1CH7O:II^:6WJ;00)6F=@3P\US&.b6BYccHaY1)7H5?TR_ZHF\L?M1O:Q-K/M
QBL\^RV3)#>H)^6,8LQQ>/bBW-SBKf1+##/.>.0Ua=>X&Y-(#+Y+5B2CHcTUS/;1
3T)4&<a\Eeg^2V\Yb??/ZdIBUN9,QGaD#+c&J(K)fWH3YCO:&F:Q0dGY^=15O\M(
^Je\Va(L^PII?YMOd3:JJ#QJ8MIXN(fQGILX4O<\JN9)XB4_[A+GC:Q;R[?)b<X-
G5?^C-S8[CCf/)39&,@E.QbI_5.[YdaL1R1L^cZc@aM/Q,cW+MP8(_R6cDQYg<b<
TECMR2.,5.4=8G2VJ6?\]4(NB>Q-J7aCXaR.S(B=LFbFL&&[?WRWQUXYMf=)(A)J
_@QgLQg(WFK=OVO2X,?K=5[ASR68#V=;eR^8-B^T?AZT0@=&+ddJ7Vf3P+1#ecHc
b@a6]R]gL>VVbNcA^9C39WCO&0A)5&@KO^+Da,M.U1?2)7ULYM\2a>adC(_Q-/e8
NV;M2LeSM(QJ>;2fUT31RP8Q]>I(A(#dZ/VSCb#JUM_J&X4/@1.fe3WF2+]IA)fG
;G>:T9;g-0D-/]cdVeC,cNQ-E#gI&)SV0HVE/KM#,_499TUF+II-#KJ+L43OT_]K
/\>dPg+5QDSUdRCZ;&;S#NG[VFAF860RQ.XT<:aY[)M7^X.^GeB91EVG;4V+.O95
,/H<]XYJ-,RNf69c5.SB&+-7B,JGf-[U=d./G@3SaZfFfW)P@XfV>Q)<@53cCB77
2NDSKJ8WCDKM-4^WY/J@OeUQ#(29_RZMLX(f4YQ:S_Fcb?FFcQ3](_>5Vd-PDbF?
ADfX27S7[_=.=]/;Fe?ZDLGeYZA[P4>a\QTM9:T\D0R(:UJD10U&WP^[f6ICS5TI
0eYa+LU6e-3:X\OdJUeF[><A>DR:@@=(7ARPWCHGc0-RM-&.Q1Wb-U_TP25X,MPY
f9]RSU1fPK(ef_A#U)YB?=2;-L@02#->QD<>f,eMR9Z0F48dZ>6Oe^ZX,RBSSZ-<
f5WJ+FL=-85@;&?@/8_d<:WY/J9:HO&e^DO0b4MO>,KLM=:64IWUTN=c4d)OO6gZ
Je)<\:e#=/U>/^<F<MeK1^O17>4A&,86.gc>L)PL#f5T;bP>K?RUFY@@52BG;dCF
Z\GFOF,.6@9-4c_g^#B^NfI5T/AC^)A[BFIU4[?]d\V82]@2<#O9fYPT1TMB3WW9
D^Xe:H/[JY0NEE97B64>RNHUC++/fI6VRVRY18WVOXX\ONS,6R(/b,MVCO<=7d83
9+1GKQRbQYDcMV-DWT_N5O&&9E)NF+K98\MY1gc0bU@&(1VW34:2BeWTMFYT?WNa
KPKZ4W[a&Z\X7XaAED5-D37L^,XSKOfRBM_NQ.4N;b#-RM]],g+HGD>e/.&T;JSQ
U?QA>U4BXWKH<S[.]Y-@>QXFXffT:-E1ZMf.1[M<<<SRX1/W:DU3Q?XBf/T+^[A_
?C?SB2BTFKIRa&c3Q;\:3K\UZ5K7@]gR7X8Y:6U7Jg01Q],ILL(JRWVYL?g3HgM]
-F;^KW5UL#JXL=H)W1.:^f)MTdO1/UfT&G[F7&8&4:Y8gX[Y]edCQ(=RE9Q3BX44
>gbANHeZfeY#NeNKQ/BgA8aRE,1NX1H+9+1Ab[O1I6WUeU[>XK6=fFPDHE-bR.@:
TT(8;.=8WeR^@dd-S\4R;eZd+@</9K(YL:aVM]f1N6PG)VK.<#^T0Y/0P+cEf4FK
3d,Y(K45BQ5a&Va8;&(b<HM4H)<-G.XEd(F1/O-9K<64bYQHLNJYaI\Eaa9[3BAS
T^U-Y;/OKR1P.93bXAD#D,Q6C0JbW(49#OW.5E>S0?cb:fAaP4_J0Igea,CWF),\
NA+7&4b)[;DdI?0EccZTZ:#K:cdff05S@GA6(O3R^H0_37+J^bbNZD]DQB2e2QP&
g@6]03XgLR_+1\?U1@-DH4R9<\PQS#,;?Z4(e2M/)N<LP^La:\>?+OVAYC6e&\1R
^JBYNAMa(>JHLWcLdd[Z]DXaU&B:L4B^A]@/;D;aXeP,D9QVL\9FYGc::3dg;NY+
]_6e4HD9Z1()^O_5GO2A5VDFS15d:g#F)Cc/&+]F_#<TI&;_.,6@5^,Q8VC/5E+)
c,UZGEge_\W[4.NSSc+C&cgSBLQ>C_WgOLWe)TWbb6K1PdJeDA8@2edY9c=707g7
.Hf1aHIGYMa9?7JFC5,AGX@A=O\]W3gG[)6HH]^D:[P(D+RJTP\<P-QAH.)?-]+Z
@0]LTfMFRg,4BWKK;>)Z&DU^B6^6F5<=dEEV,;/]g(Je9fSL;TB47X)Ze1?D_D^\
U77<M4(A8[F0IQ81TF52+Z_N/>_&_,LH_+D&@HII0bEFHJDI4:]T]+]=QU#I7LU1
#][811W?H_]3@K.#<a(KJ1A)bbe4Z>gL(aQe^CD)+e>Nf#)R6RKbOCX)>Y@?E29B
O6UL5Lc\-9fNJ?=]SDZ(BHbTD#fJ_>\#-S],A,#YNPFab-cLHH9P(3^UP>#[D(b5
Z#Fg1-dARF+54:^@91;_?<-gT1ZRZ&9>RYF96N_cP8>(^,)fMZ0ZHRf_T+3ec;^9
P+<D-AN5g_;[J&gBLL_SO0UF3(fH9#IR?;HN2CT<<F4UFNF(WM01E8/H^Zc<)F@\
:LVABN3FA_^25RK5^aE\YH^,QW7d1.2fT#?UD0]UgI-HM[Og/b^JefZFTg_dgeKZ
KD9KZg62E-?JC.ML9(QQM2PZ(+2J6AJG2AI^MHF0CbUf&QBOf#;MIPJbbHYCI#V6
6/aEV?]N&QRKNZ]MDX1&6<<S,/?RE^,(EP+I88\7?S.8ZQ=2>X^&QIQ=O)1R8-3f
_g2,1+E1(IN#=eVMd:1>bg&LRIG:1])G?]T1;S/6b,>/W;Ec(_TKL?+d@5KB;HCF
g.T95]D6HGM\B,^[aTA9U;5]SDQ9Z#-1-C&L5W?fE0FKQ++a<L)1)S>@>L:>CR7K
YY#g;4XJ/WNc0R>>=(5aEE6:Ac7J^cO3/bH2S9#4?.@;0T.Z+6^3[FKFKaK8Yg/g
AHfPTPHB>0MWE8#6dLN+a,1Y76,_?b<2[#PE5:NN6\NB(A5\g-a<,\aO<Q]aZ)=N
]7_D^TW4__5\7e.9FEb+/OZJf00Pb.=3fX8ed<@EI>Q_7T/8C+_aJ&]]-_LcJ,H:
C#W?OR&U1cSa;g1WB5]G9QLRgWA[734JJ.5_IE[\,NL7JL.DYQ)I^ZHIXa]TE_T.
7abdLCY4)I)[2?8L.ePB^g)IT.0#d\&LbNXF(fIgN(&bd5:FC20;&3GcK&7K0\be
Ab[;R:R[V]gfB09dIFSP)@^bBP8N).AZZ0:V>8G#S7X_f,\gfR4=8B)3PQE^[(@I
H@eL>QdT)?,e\\bXa0VcAZB6OQ^QW:+aSO;a<,YfC<J^,_JF&#ea,@&c#)<A7Y.5
F7+e]I.\RQfR6-BS)V(c]\OC^OC8P&?HI?/@@SaT@@Wc28:D2@0X^-e3DJGR<@)3
Ie#>>H]^a?^LJS<[E97S-.#()JY1TcKB1aUSPJD4W[IQ1.<d4VQS:X_4S-][GM6I
XS-IX_#[#3OXFeR3X(dM72TGSIbeRM4K7a22LgLIF^Hb1XG9[,]XZ8<+>P9T9,J<
_Bb,7;X+>YadLSXL(b)8,AH7PDGeR)<2f372K5e]f?R#^AJKS<VTQSLTV+PeEFIY
4SZ2:6;9,e4NZUbW6B/5\-D#37#@JV>Z?O/bI&62UI9XSL6O[Ee)?>N=OB7FdeDU
cGXB3JZRWB+UC@8TT\[V_EOSbJCMO@;E+F9\HBU.[7LX6RF]LL=BgAR:>^H&8=\I
T8MDGSLAR7Q\>[-K^B^9BN6Q&0JB^_#)_0^MQ5]:E>)UVN4A/]\b3;+17UE\_07F
A=:P+-caL=HY2@\>Z6LL@K4A>7:.C.?dS/O\+C0)e//#4Y]4AN;QWYC51L4[98XP
@;8.C6bbKO7.K3_LG?f@R(gb=0#5@[<F]K9&c,P\BBLULbf-ZMD#8M1+[19bUR/E
NBL>,.\&D7f46f82>YFI3#6(TN(DYe3:E@d8D3&?&)Q/ITZ<##7B=#-^AS6>4L/F
.JZMSC7-2F:#TM4ae0c+-R+Z1[=+ab,98E#Va3QGJB00gKAH@JSV)SS34O7ZF-N#
?Ld/LLV[IB3@NZ<37_4eDO]DA/TXaS<[A(8FI@YOO[?dZeP?)eb7c>=d3Q(582=3
54Z;KDb]HfT(I-@g878@gPd\c^eSd6F8MI4G?#Q)IMb,IA2T.Qfg3P[J#U=3V;d;
5>(c/cMLBJ3U2,?UDJ?d;UQR/a_3F/0E6Y36.\Ge/MH/<BbCc4Q(HA+e@WTLXS<g
YNdba?a\=)>EbM1[JbFJW+(@3F4AEFD?):Jd2=HV+<g=08.AZ&bIdI:Z&d&7fIJO
Cab4A18Q:C6@=>/9Fb?M6=R[YWLW2aC;,3:;:3ZN4#bKZ4ZQP1Hd@])2[S.2#7]/
B\(&ZN.8(P2WM&dVH51ULPOcTHWG7P/,YWB:)TJNOQC6>+Q]J7N.Nd<a&-\+F+ZD
0\&S8>9=I&&ea=a@B8ER.HcKPCZO7bH/+;NQfR78\&&OQcA8G;9NC[aUAI7O2UFg
+F+F&QGZ=#1bK\0:)4b[X\\eEZ>B#KVU/3a>4)#f963E\8DTA&Xf8J8:;025U7Y/
7>O-SfEXO631-^+(#&/1\SO=DO1P6FEd<\:KR3T2CW4M2)W\L/ObZS/?Y=<b-5/^
7LRB;F;#>OXOWJBJ^=FMgFHV@,3UR:<>IO&e-6QLT\N751A@>@A7HcFX^+d5T#SU
F;H<a[5VI0M<X7J7&EJ83Z(BL/N&XOE5X]\g>0ZC0g1SA=JI5g&TSFC8?5/PO0R.
E&=BA>aY8]_/=Cd&R_NI136ZE.0/-])+B71QQ/Q/>+A^=eSX:gI-UTE(C:?b,cbF
KXD(;^W1g>C9b(J]Y4+Z.@_;:5Y#&U^>.827DKZY#[e7=QTOKf?>PGD<9=#&Z6W)
gV_LPHY85#b5\DRFGa(E>.^DIK:YgTPZ=OD<XWJQ^,9)g_@2Jag(S\gfGC_-L/()
<0fER)X#95@bWWP7.#bc>;;ZX:)8P,Vc/BN[JH?\T3R#K(f\B,(ROL]Z\WT=A;D/
C&?<87e0LBOgK1IS#<SC;J8(FZK^_Y&6UeAe)2MRgIV-P9>E[#9BcK]C\N9KJEOY
]34I=7TKcc::^OP7KC)ae?VJ=<7+f^bA5-0:aD4,GH3e&7K)aaNe2Nd#B^.4&1<b
1_fB=Mg\#3T9B<4@)GF43ZbHCPEY:Fgee,T]\:/e^SGPT.@Q-aR1?b4e[Tf)bP2R
Ef]BH50HeL&=I1WZ,VOYY\\@CHC]c-U0XScFX=J#1UAUc<L<7d=YZ)>YNTW^[-DF
Z_&7Kb@EFX[[6;B4_4_0BFC&F/F^4;,<5EO@>Q2P7_Y0>KX/H#f.H&@SB\#(8c>_
1]-/OEd[71[P4Z&Q::3^@)T?bPSG@L&?\+[B#1N-^c/I_O(c8(P7QL\TR2JSGCC0
0===0K_4eK&6^H4B3879G\8,66A_<KZA3PWK:K1K=;d=3BF6eB0U)S.bT2EFQN9X
F#F&=-7GNc5<VPcW?\CM:]@aA>Y#ZJ3UL+KT=,N?70OP8PUD8@L=F8ZB[eW9L35(
acWO2@F#d=D^gg4>Z3&97=MTOZ=#B)@d2=>Q_4RXYB\1aH;7dW#DALPd,36fZ#EU
1C3A@,E3AVIdYN9(,#;<-IAI/&]T2R_>?0=T^(.PW&dYL.:CE>CJ@b3_)Y<WJ]RF
BeTXW/M/[H,XQTcWZYa,9<9b;BS7,GJJ.R_J?5.IaUD6X[8Yd-I87=#/Y:]V/=&@
V#4.#)6?I\f(-1NUbC&)MTU#.\PE>J-[8)PB:LcLcbD5.YR6cYMZNY9TV/>UJZ/8
Qa)#:L]SH\cbF-MCObJGV_9J@T6\Z\CO@Kc8WRf=8Y-A/,)]R7g/]3;ed)]LU3A@
1?]?=:G<a2[Z\6.7JK&RN=aMd/;;?Zc>16Ce[aS/J^]AB[Q-=YE/:?/PVV,B2XP-
9+21(FL8=W?ga6e>),MS?>GgBc)eS2HRePIMfGYSU(a?I[Gcg?@Rd<d_8R=YS&L.
Q/4B8OLZGXV=c+;@2-2N&@e?FW=c&[;<U/7AOb^2IL3GaB+[0V2W]HQ(cH+ZD_T/
4/6HDB3GEVCb>a3#TeAP@O49)(,=c^9VVRU53b=&VaK-0)&TWY@_G\2XO32bd0^O
B2\XT^U8<?e00]R+0B/+ZK=UPW=,-a5>[HHLH3eK6NbZLdFL.Y[TdJ#:G-J=H^HJ
X,A=d(4=A\8b.:Y7=-gUR)XZg8bR8,F&FcO7:ZQ)5O4IVE4(IQ95)3.8G+W(4T_.
cc;ELY>:(3_Q7geO22.3(7U1\YT;N=U<70JRX3;U_I_OfKCbJ.;TaEFRS&UNQZ]S
R;+E8^\:QGI+)E63(VXacTf+Db<<P(fU+XG-Y)(AV.;gg/FJGPcL<DB?XPe_cN8c
6J<[HfII]V]:g@8?Q&A;DX\/YXPS[G@]K[NKAP)OHM&WUZ-;e1eV/1e=_b=_OM8L
G)HG3B2Q6>b@AS8?CeYcC\BB=21#72+bM#8O&<fT[d6,Q(Eeb?SO>BA#K38([Cda
Y?KOgS#.IS1HTeMR&4IS)6FbXBR3O1F9b],.0(C6?A(RKJV>0_Rde,V@F:fJ@.Y+
@&HYJ+GRPRJ1-9,#_Ub46;<Y^cFXW_DF<KX>V1(BeC2P[TB#ae4dgTISdDOA2eD@
6E&O22P03-]K^.,bZ)G0g+KBS,B#)>61V1#,\BI9EI\;c088P]CT+a9O3A2^VDC>
;?fgW_cd+\5YWb,G_)FX8Lfd0P2GN?Q#_.La@4C\IZ9f8_aJ_<_G.eR7\+a3/M=K
5dY<5MKQ-Z6)FO#^Q6/JC0(@]?6\\&C[XT.O];G)AT97C<ba)Rg0N^I5dWRZ-J1F
K?&Zd>Cd8CU_.?-J[ag1-+fbN(RB]F,V#VCG/5d[-+XI-\QF2BYbYAMG6S=AK3IN
A>>/N7e>c103O[TYeZfK&-:XaQ=#+>3.K;V\J@VH)\E?Nf1J]?=LfK[>?Z]H\c<P
a&TPdfKXB,1G&cNf66L1bO.3#)8?LHS(>.G]@abS7Y.JOb48UO:2Z?b.BCMSb_:_
/:&IIJ.D^R936O^Y+UZYFGQ/J>9IUAU3QddY/W6LF;QJCYFSVOb&8\F4)/N#CLY7
5TT<WX0H5QR.ZB1&NcSV/EQ9KS@(R.5UZNHT2dg24]M&-2EK+TVAPQ#V17M4PcFa
&ACQW+UeeZ])UX,KC?MH4fXE-@<ge)a7AL8?]ecN(e/O>.=9f5AJ.]URJ5.:OWN)
d/8QPL_>8URV^;/gg(6f1RUN&/1;Ob[<:Ke@>SQ.^^;gBFE&I,:G4Tg_H^GRW4M=
++T(K;9)(JWP,LN4U&:/GS2/)9TFVOB87d&aM0SFEV-22#+W^;;S=YSb>2d0>1Hg
09,SP.EG>](eQ2-\TQNZbFYDLA3)XDT01Zg<NTWGRbS)bQNb#>SOYI+U-/LXZMZa
JY4;Ie/T2:4O)U&N-;eVY+77_aUWLY0b:=#.;VH&egYL/+&.L\Yac(J8fO@+eL@Q
#0STaS?3EI>^:Z&b)ECLHVW-ELNR6c&PSXS)R6^LCGfNQ/F_>1\.<J0<FgZ1]-\=
eaB9T96G(W6GaMN3f1eG?H4O;<6N?9_R@(0Ygc5BJXGN.===M-FUV-#\CJTJT=US
/YV31C_P14&BL[>3XINV>O85Y:[&be+B3@L[/2DH,bf+WBB/6YDN:W<<AT(-GSK7
4#a+U:F:>cf.V;@G_-RH6,Q>2R=2/0+G1./LNVVFI^cRWQM_8>NLc#B=UX_2\-;=
5Q=\aPR<)5NIJUf[b=O.DBLSgOQG/_30]g<ce7?N-5=DWa=g?_I6LG.R,+Bb7WMA
B-A]G,\LGWPWG8JUJU>0O\e)ET9<:]]+d9(U0g5VME^V.#U4=^_HMXPO6=:dXZ;I
@c\)=?(>J/WV90Z>Hgb_PJJSUcGW#He7S[\d/4ge_,&BV3b&L=+D7P2dR&,LC_AW
()Q-1G&?KA/X4O3P]8)JMR1Y#3NR[(&Sd&b#)+-1e[FX&3IC89Xa/Q-PA671GDA2
7?JbN1^,CL=)ZUHKJX)RQae8Ad;BSOK>4]N7P\d<][6V@WQR9BY0UQM1@dF?N&0;
=/;GW,8:,eQ9)8+T^XA=XF,27&,bUY<6_GHO:A#QI03U7#eV9>:5TW/L)5]0cPN,
7THMI;V9/BDegA6)ZLg-&_)_#KTL9.RDCUZ,9,0[2MM)-JeS\I9X8K\Jaf-]CJ?e
d:/:<72(=?NdWI91/Vc^/8)DFI=.J_1FQ637N;L0]dH^a^9(dSF=AO@FXAA5?_-4
(#@0Kc@ILF0^.6TC4=UJf/(V]9@)JWIV52>,.TXKB9WT4]B\O:Q@W80TdVW@)TJP
U4VZ;P^A4HJT5-aF5/O=79_TfE@c1_cE8ef]00F:X0,&d:@DT2G]P--beGIC6(S0
\\5?JdBL1>4Pca]\>OWHWC3GTg8W,5[&eF2+R8<I:;SM#&0L[PRJcaL9(A)c+YAf
PG7DaGR2A?1M(I24;:PN]]gdJaCDJLU=@,F>X>SQC&LZ&FJ(1;Y6eQ^HaEQ-(2C2
[gT4eEH7IIZN8<K_6ZTOFQC>1-N&A-dB2\S;cNZ&?/-.X(UV8C/bAcKN0.)ML6?;
dE2NG\ab4/7Y</[AG+MJQ(/BM0^:_QIOda<E-He?F:=XK8LGHgYS6V>@7-QJTVM6
F+.KUU0d?b=GFP;dALE.#=@PJ>F.aRMM9&O-Q@;XPM?YIQR04XC4Z[\\Ff<V@N+5
.G#ZT)(NDGCIBaCPHD5b/;OW;+8a1Y\a,P(W[7gUPe?0QWa\UIf43[6]R#7#c#]#
4<[fFHFgB(P<7GZ@9S5?LJgIP]#aH.K:C2&7DG@=3AN+HgA0:U)#fG=eQY#8(1K3
0C.AG+7+KH:?#5VF6W\Zb]KT8TBadV=9c:f);bR_18a0?EP-f(IeGEeY9YA5T]<]
X5)/,]aVX@(9]8/#6:,&2YKW-_cFWGX^V0bGHARaO)KDZ?P>IS.YO,NI)=^2I\BE
P?3-OPcZa;^bKOPE1d;X:85@&95<G=_885UYW?1&NceNa+.?8\+4W:WF[e/GK17e
213)b#M1Ve@4ULP-Wa<0BfO^&Bf[6c61+(?G:J93Wa96X1-;<ZbfV9PN;XW4DX_K
5(,17c)[/=Y5C24dMW18YI?43;^9CS(N/L;b?+6/^2d.4Z8L).J&&W><(b-YI;B<
:daM59=BMF1+fFK-,VNOc^.XB,T-#;GT:D=:@.B2PdLA;>WJ<1\VLQ5;ERL1gPUd
+TRc+2U,-5OP1W<4Kd&-,GB5T77DU)6d?FP5\6aGJ(UA0R#-ZXab<YV[Y3UR_=]<
UG;AJb.?\/15fc(,Y&0=BD@Og+&=7T>5J/cd&61G#W<e#K;.ZQe^(/4U3<Id=fg/
0&[Q1PB2BWfc)UI-^I)<9O@gd36ZP)aUMQ9[3:QFXLZK6gK+.V^7CR:P?=)-_9T;
G0=^H3R4(QIX.Bd1CfD5T75QE[L)6/.(_K<-8db:PD<UXFC;eZ,DM#I.(\;+cB,1
,D9@bCfOVZ9ZM7Q,^e[T0.9NC-6_72H&TA_f#DOgAMbY-L^(]dQ_O1gI\ZaGHdZV
U8S7RbVC-8PHQ=DfBOKY<aD#0^EQ1&VE(R@8:#&Z]UN(bGfH25B6?J;2-(519C,(
>f61JXCRQdH^JK>6E&XNGL23@D7O-D@MBYHLB^&NGgc=JLJ)R#&aSb[S0TN(9=>b
&X)0Bb295_S<PT=TTS<+,FKU\MY=ND^Xc<46(.#H<=1,Yb(<2EOKSCHYJOeD)?D(
P:PKgDEZY(.IJ-W<UKX86]=K91XEDd\#e>g5d_&\=]O21\?L@MI]R2ed<1YQGWBP
eB(ZOM[,bfd,BQ7cE+5@g^a7;8e@G6U>4V5Pe@YOeaefQS3+X8L3@)KcIZ4WM\a?
@a:6eMVNdc>dB<U)R+)Q-&_D799Q^Re4;8_c4@46?I3=WFZbJ;K_V:;)B;DdA4g,
.4)P+KK(LK1S[3R1-:L@&)TA#\_I#)W(c>28fTU2eeYO45d9BE9<]/BSPeD?D4d,
P#H36]E#QJD>SB>K.AP]A1#6@KW^?LD?7&TNYc4BM27Ff2(SG]f?#R]0N7(?0#Ye
D&JJEgVK-#P+8<?K>ZX>.L#YM0DIK2&Y8)46FGJKAB;-@CQ7JUZ<)]aVEST#^9PA
S7^=N6RG2-N+fZeFYI+Xa7X()&G@PNJd8SSJJ-VeVf>YNVOe=>69/7df@URY=.f[
L5TZ,[6D[F&@#cSf-G3CaJR;0L=,O#J_/X1;Hdg-0&,cCZdIM8:3FUPNTY87>#(9
-2<(-f)FR-+R^gH0+e.YP?.P8\KSW,_P^5]IX3O<Ff+dJ(cU)E_V=Q&M-XM0[A<R
gOE-H0E1-F0,WV\HZG5#07G=e1[0\0@QBaA&;B:N3a9aE<eDC_Z\3BH41MKH\#Md
IP\>BeAJ)BA_/M@=1>3>,(QaPd120#XC6F^X7S.HEAa+ZEd&?aSI>VNBIF:(NSc:
R.dHRI\g_?OXRA5-:#g?7=P-Mf)=M1?-=LX>Wf9?M-:Yf+1PD<5)QH^0V)QS3^@a
PeC:8^(]&A2Y6c=<-d9<GG06=8/Z=596eP.ZVW,KM,ZUaAWCd8#BU]XMVJ:#O3#G
>UJ&M)M#(X(GbO[R#5#Y<:bH3V<,.N;K2EN,O[N/VJWPeRO9H;9Q<Zb\C_@SC4F#
_LgERG#)aS/#54[=aa[W6fG,>_U;L/fd_AIE;gc..^F@E=Z7RT>Me=X[YWe)0>fL
O2IC\U]^CRT[<FRDQ7.F7)2Sa@Z51N-)-#a6c4[:+I&&L0181ZQacZ3dA@HfKM+3
#dQ3ZaZd6^XFOIR86,-F3XRAAA#DE7,9U]]1#Kg?N+_ec?-1N7<^WDSS#.,+LNE1
U:;.NY_2P1@:6g-7QY1F/O#=b;#)\bb;14:+4=I#;6JUO\K13._VA(SeQ)(fE.Vg
K].P=XP4/=-?C?^V-^dQ>,BX8cFMK7_+c,YC>XWW5G\;g3V83Q&ZD4]L?EI&#JK9
-PZ,4^@89S&L[D<_d963CLA]00X)Vc5=@T@&]8)M=cUU;0f8[-fA#-TLT=>,+]U#
c4PJ6<1Z6Z&O9H?L<f\3C5Q2(Y(NIeL50-O=HX5L6J704:]))(\DZM^5&:SL4(Z;
X7ZPJHPL\Ie<6c4dOYW&bR;I5CQ/D0X7VW_DYV#786]Tb0;QIU.O-dfW.-g+Q=d?
M>5KU>GNA74aFME>4cU+((dFE/+<ML\G_c,LU1Y9LNW,/b>AbRL2T]S9E)@@.?ZM
L5C4DPCZ370]>,e@4T\[>I+(>I_CW@:3#L?aSB;<,PP[1M&(+@-7,/3KHJ.1Z]=F
;)]VI2;57Da/=6K\K=/[70A=#R7>D2]D2)g::b_8FGEK@6a+:;],HMTg+5T+RaYP
)#,D616-C]RO9:)dH3>__6[(3)W&RV@MWYO7cQZ8<HP&R.9.+4H:I.,gg5G<O=>2
S3E/4@9AG((J/T)=1KPTA(8EWKQc:FH>RXAKVUS5<7Db3&S25:UbbFA+L6K,ac5c
BJE=0@L4acD;D:E^cRKRRcA[\RH06R0Ja/2+@Y36>,4a?<GUNd&B<N9Y(S^/(3Tb
?M)CM[X:b+Z>NQ6J[P;;cTA_Gba_MZZQ(SD7>R_OL-;IC^RT0K(]dLT_3E<_7T77
f]^]N?aLPEE?Pc?[_RAJNX^M5a#eJXIUE0NYf)3a[V;E=-W#f,2AA04Bd8V]5FJb
D@6NT7TAMe8(1S(@I]:IZW5A4])0GITce/d#g[?-_O5XU16)aWQ5LOD7EHB\HXc8
ITMVL?8>WRgI(-X:M9[AA4I?WZO_c:8XYR3J0dJUQ^b-30Vf1E:g^DG-JD\(V:9-
:#YHWMDC0eAID9MDU#K>E7^OBP_1O.V>,+I@^VEJO3L7N]2_E@(e[X8P,2c87>-U
L(c#XCc;^WbGC171Y/P1]=GRe_+XD+>/S75+&6=>=)J7N2f/5D1NU0Z:dHX:P@ac
MK;1E>ICD^e;S(Y@P7a6ZT>6HK9?He(9R6bX6cd\&9b=QGYF,eO50_2)f/SIEW,7
BVS]f/XBEH^\XdVJJcX/)=X.13bKG7eBGM--87R\DMB4+Da\S7gWcM5dC2GK(F\e
9NfNg1:20Z>B6TGEG_M.I8?H]CPJF&H&=gBG+OYVAb:N;7Y=3[a:)S;QGc=\Rcd)
C+A#b?7.9SZEJ<7WVdWb<_-+aWeU&ASBN98)=G;OZDg-3?@H+VRMY([W3][(\ad,
HA:;#PXMPE:)c&7Z&Y/Y3JFOHe]_BJ?e3?AJQ@-eeZdTUc,K-?UT-^LNL64X\.9e
X1^802g\I<LcWJ3c7>7#Qa6\Y11f;.D2<PRGA;_H/#83NRS:/]@8L:/K-(Z[SU.T
O?;Rb._\S/LW\da94#dDLFGHcSTH43\KEHg&+?f25e@]G=X1ARA5,e><OWM<N0BX
[KN@CW3MMedL8a<P7FL48U[Zg-e;G[S=NKf9NSO<W>5IIX]Qd+UeTBI)B;_80=(H
T7--SMH.df#]4\YSZ1B6O?9TY0RFMJVK)37E2DT-([SJaHXSUc\ZT5<Y+,4K5U7e
<T1;a)SfVXVd3S@^2D.UOO).GD+7+DXb<HEfUHX;B&Q(P=4agaDIU]=)CAHLBH4.
dcKX8(6c=B]Y;G1H<->;=;J,:QA8(I9CeY2?ZTJ>,6#UaDaeE1DCNNM(_f^LA:2?
LDRH,;2(:e538]=YOM&GH=HX@IS@3.;<fH-4E-Zf[VGHQY=<E[6XbZ5cEbGeA(J@
,-_(HVf?/XY2([FFE>2W=AG+OP.?;,1^dT\9)-ODDJWb4XbCHI8#Z100,KUaQ#XY
Ec#Q(<Fe]bc0aFeS]G^CXae=8MTK<:TA:X9/&DN_#H<a;Tg;3gT&TIR1,Jd-63;L
3F^(0+H65W[Z588&TBC2&Xg@4FaD^M?CK1+[4,,a6bDC1:7W8&9Z]3AEGQL[NMT.
(V):JV<a>I,D8gZZ+f0+bM0BTI^d.:Z_e4S:@<FQN\U#.^HZR90Y:ST0-)fS5(FE
5Xb3NCZ?(JGI0TNIEZE_CMD#-b<&K7/=8[8?K@13GBCT-;^HY,IN,)6V5:>SU/)C
f<KFaV^0a:b..S<Y&>Pa41eCPA88OV9-Z+P0,G#Ie#SBR0B,B+BW_IO_#Zf-QKQ-
;dT>&a#Oc[a<+cbFNbBTA\#a0^.A3<MR0EZ9VN:3]:,-9<VSUc,J4Y6]KQ8#H^4=
YfDV2:Z4[1#fD,Vb-Z\KIU1.L;#Z1acGAPT[=8Z=cS1f+WCc\0IIVN5b:.6.Hg?U
@K@/X-G-EAP82WSeED4?TJfb8@/\=-QKHDcL:=c]8e,2f-.>Z?OZe@e(3V=S,]R)
8Z4L9Ig9P@cQ8,2^d>HPC+2fM:.N38@gN0P[Y.VYO&F0EeP@IDDBMfT;K4X^Z/6[
V3+88E,-[?.A:73U?+_Db<5bSdH89:RDQ],6N;(XAV/_Y0d_>1Q;g8;eCMX?TI1]
?,ERBY_ESW[]=4:)5@_FB&<1-=4CB<:K;UcgOD_=_@#&Q,/++gQM4(+UJ=c,R4cL
763AgW9e2,UA^XAJHAX\Z8Z12HQTN@ec(QSB^>B_A1NR@f.S5)Y8EL^^Lc).V+.e
IOQDN9;O-1/EC6(IJOOD0HJ6J1,Y8Fb)ZD]GU]N)A7[5,(K.6?a?&La;R5TGb/KS
Dd+PG;J3I9\<M40#S1>MQ#B?_WHJ7O[DK\5#/BP=/1V.\1_MHBKK-\C/[KIaG#0f
JH.LgX6&N@4JRNB>Y;V>,[?U?HcJQWdYe#V&@TD4QH2UeTA)dYO@=b:.8DR>Q=83
TN7<U,K:DRZ?A[RLaW3eJS&1>9)=1<bZEYEH<0U-CB>#:8L.,b<4EKZVV9C+[\.>
;WN=:AQPOd40C7-L>XY,3[@Hd>C?T>(PMHdbaK&#.f=]ZC9^HR7SQL(Y8LGDdLI/
5]WQa0^DY[-FfX+Nb4:N#[ZEFRSCUc-&3SaJ3QAc&7:E:/?+H4]&E:B<>^9-\@b(
;(O?N,5=KG9aWcLf],_A21IIRZb6B55\ZSbVG_8^b0A;2c3>U#U7Z(7TJag/L0L.
7DG26#&CAPPMJSa;-SFeOKKMY.(R.3[8Q9aB7DP7WK;<08KBL4>5W/+H1VU<RM6Y
M=S=Q_>,WaJ+&.(M[.HJ7G\Ve[^+2b81-^SNg)0HZ_0SX<H8<U?c)2Uf>)=J^L\B
>S&6G@+J2G---1FUgH:V0T;U#LT\ATJ>MIA,[;1UOH:BGcE>HR^(VUK,@?&fZF::
G#@,2NX#BP,eXCI]A#CHFaB_;9U:^&17.(9JGCWH>-/3]AC@2:/NV@Q(9JT#G121
DGYc+Z+Q[>AFMD+^DE87?\/;(aIT+8_BFNaZ#IZa5cN@86L.dVO_EFNGdK&.()]K
NZcXC5[1+(X=/;]a(^9)F)eOEgF?+_B=5+,WWaEd#?TP6JbEC)7&960XJ9+7MUZ_
2MQ3&_V1T[8XEB?C20;]Nd,LF77U;aJ.RUXg9H94CG>;>,E6GO_GWWL#g.W#96b?
8g31NbL5I[4#_0K+ZYV@J7ge,C98?M](b&+LbA3N<M9SG\/>>?,22-0\5G[A>)7S
B(T;c-+R?RSRJFO/06NP;L<B_YQ5=_W]\8@Q:X0DE1f_P&<L2e377>-c3?)GKW=2
\Qb67g=B]d_&b@TIUK3V2@7KB)+(\XZ-WNMD-_MR1]4UN+:9=[DOW;bZ?7@BJ6+@
8cH]#Y;CcQ.eCA>QEKJDR53@/bI47#LdI8<?)<A;XgD(K;M?]f\SA)J@[^OR&P@@
^=TGO3>>S3aE6QM4[0WPS<b.945);SPI+f1<A>)YRgd:(S)&-+]HIg;6OFKeNc3-
J7Q;X7&KfMH7;Z96KXgL[dT@a2_0E:@ff@fO3K&A[1]1EgXHb0fKGRN_.^d@5WK6
6@_IReVaYI^&V7Y^F#<SM[O#6U]TN?]>RJ2\SXaf_NCWYE[(7FR-4bg]c7:3D4:4
-1DEEP@=QSH?:/W;[:W0_:O7@SVKW?Ueb;]2@21>dgU&M@7fG05D;d.BD/Pd>If0
e5\1&Y4^26d#W6FFYYZ4^4.Bg>bM0(_TIF:H)V4KO;L^A.B(<.S=@I(Z&X#&C;=f
b2QDbZ#N5TSd+f2OM&0(DR4(_-cLHB1\U+FGX8B+=YfP:V7&3V28bJ75;VBJY=F2
=G(:+3&eX03-]5:<AT82FGAG<_Nd:G^41]g)P@_0CS6S9C.eI2_9KI^M&([7UPdg
6;.=X.MYdH@BgUIN]-^ZPFV,F1Pd@_4GC/T^IG+&.MNbQBd@cB]fVeP^UfF/^C]/
O4g_+XC:HI^]XKf4QTYTC?/SNCUZ(6N)=.L.c7eV((_==<SU@Y):M1KN__T5UM3@
\_F]Ldf-Vd6&VY8<MDgR2<H>5?eOE+M<AK4G/YGWP=-@&3/aL8QYFe@#5O+\Pg8V
<;B13\.]WXW@-X-RC&=IMS[GPLA=JY.S:$
`endprotected


`endif // GUARD_SVT_APB_TRANSACTION_SV
