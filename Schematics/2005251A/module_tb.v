// Test bench for 2005260A/module.v
`timescale 100ns / 1ns

module testbench;

reg rst, BR1B2B, BR2_, CGA3, CT_, DBLTST, EXT, EXTPLS, FS09, FS10,
  GOJAM, INHPLS, INKL, KRPT, MNHRPT, MTCSAI, NISQ, ODDSET_, OVNHRP, PHS2_,
  RELPLS, RT_, RUPTOR_, RXOR0, ST0_, ST1_, ST3_, STD2, T01_, T02, T07DC_,
  T12_, WL10_, WL11_, WL12_, WL13_, WL14_, WL16_, WT_, d5XP4;

wire CON1, CON2, EXST0_, INKBT1, MIIP, MINHL, MSQ10, MSQ11, MSQ12,
  MSQ13, MSQ14, MSQ16, MSQEXT, MTCSA_, NEXST0, QC0, QC0_, QC1_, QC2_, QC3_,
  RPTSET, SCAS10, SQ0_, SQ1_, SQ2_, SQ3_, SQ4_, SQ5, SQ6_, SQ7_, SQEXT, SQEXT_,
  T07, TCSAJ3, TS0;

wire AD0, ADS0, AUG0, AUG0_, BMF0, BMF0_, BZF0, BZF0_, CCS0, CCS0_,
  CSQG, DAS0, DAS0_, DAS1, DAS1_, DCA0, DCS0, DIM0, DIM0_, DXCH0, EXST1_,
  FUTEXT, GOJ1, GOJ1_, IC1, IC10, IC10_, IC11, IC12, IC12_, IC13, IC13_,
  IC14, IC15, IC15_, IC16, IC16_, IC17, IC2, IC2_, IC3, IC3_, IC4, IC4_,
  IC5, IC5_, IC6, IC7, IC8_, IC9, IC9_, IIP, IIP_, INCR0, INHINT, LXCH0,
  MASK0, MASK0_, MP0, MP0_, MP1, MP1_, MP3, MP3_, MSU0, MSU0_, NDX0, NDX0_,
  NDXX1, NDXX1_, NEXST0_, NISQL_, QXCH0, QXCH0_, RBSQ, RPTFRC, RSM3, RSM3_,
  SQ5QC0_, SQ5_, SQR10, SQR10_, SQR11, SQR12, SQR12_, SQR13, SQR14, SQR16,
  STRTFC, SU0, TC0, TC0_, TCF0, TCSAJ3_, TS0_, WSQG_;

A3 A3A ( 
  rst, BR1B2B, BR2_, CGA3, CT_, DBLTST, EXT, EXTPLS, FS09, FS10, GOJAM, INHPLS,
  INKL, KRPT, MNHRPT, MTCSAI, NISQ, ODDSET_, OVNHRP, PHS2_, RELPLS, RT_,
  RUPTOR_, RXOR0, ST0_, ST1_, ST3_, STD2, T01_, T02, T07DC_, T12_, WL10_,
  WL11_, WL12_, WL13_, WL14_, WL16_, WT_, d5XP4, CON1, CON2, EXST0_, INKBT1,
  MIIP, MINHL, MSQ10, MSQ11, MSQ12, MSQ13, MSQ14, MSQ16, MSQEXT, MTCSA_,
  NEXST0, QC0, QC0_, QC1_, QC2_, QC3_, RPTSET, SCAS10, SQ0_, SQ1_, SQ2_,
  SQ3_, SQ4_, SQ5, SQ6_, SQ7_, SQEXT, SQEXT_, T07, TCSAJ3, TS0, AD0, ADS0,
  AUG0, AUG0_, BMF0, BMF0_, BZF0, BZF0_, CCS0, CCS0_, CSQG, DAS0, DAS0_,
  DAS1, DAS1_, DCA0, DCS0, DIM0, DIM0_, DXCH0, EXST1_, FUTEXT, GOJ1, GOJ1_,
  IC1, IC10, IC10_, IC11, IC12, IC12_, IC13, IC13_, IC14, IC15, IC15_, IC16,
  IC16_, IC17, IC2, IC2_, IC3, IC3_, IC4, IC4_, IC5, IC5_, IC6, IC7, IC8_,
  IC9, IC9_, IIP, IIP_, INCR0, INHINT, LXCH0, MASK0, MASK0_, MP0, MP0_, MP1,
  MP1_, MP3, MP3_, MSU0, MSU0_, NDX0, NDX0_, NDXX1, NDXX1_, NEXST0_, NISQL_,
  QXCH0, QXCH0_, RBSQ, RPTFRC, RSM3, RSM3_, SQ5QC0_, SQ5_, SQR10, SQR10_,
  SQR11, SQR12, SQR12_, SQR13, SQR14, SQR16, STRTFC, SU0, TC0, TC0_, TCF0,
  TCSAJ3_, TS0_, WSQG_
);

endmodule