bind csv_apb4_async_top async_apb_top_chk async_apb_top_chk (
    .PCLKS(PCLKS),
    .PRESETSn(PRESETSn),
    .PCLKM(PCLKM),
    .PRESETMn(PRESETMn),
   // .PCLKS_GATE_EN(PCLKS_GATE_EN),
    .PSELS(PSELS),
    .PENABLES(PENABLES),
    .PADDRS(PADDRS),
    .PWRITES(PWRITES),
    .PWDATAS(PWDATAS),
    .PPROTS(PPROTS),
    .PSTRBS(PSTRBS),
    .PRDATAS(PRDATAS),
    .PREADYS(PREADYS),
    .PSLVERRS(PSLVERRS),


    .PSELM(PSELM),
    .PENABLEM(PENABLEM),
    .PADDRM(PADDRM),
    .PWRITEM(PWRITEM),
    .PWDATAM(PWDATAM),
    .PPROTM(PPROTM),
    .PSTRBM(PSTRBM),
    .PRDATAM(PRDATAM),
    .PREADYM(PREADYM),
    .PSLVERRM(PSLVERRM)


    );

