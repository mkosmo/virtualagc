/*
File: bitsizeDemoCommon.xpl

This is a demo that the output files associated with COMMON are correct
and that COMMON, COMMON ARRAY, and COMMON BASED declarations work the same way
as DECLARE, ARRAY, and BASED declarations.  According to IR-182-1 p. 13-2, 

                1) ARRAY, COMMON, and COMMON ARRAY statements may
                   not be used to allocate data of type CHARACTER,
                   and
                2) BASED and COMMON data of any kind may not be
                   initialized via the INITIAL feature.

XCOM-I does not share restriction against CHARACTER in COMMON, nor that of 
INITIAL in COMMON and COMMON ARRAY, so this demo does test those cases.

The printed output from this program should be the same as for bitsizeDemo.xpl
*/

COMMON 
        B1 BIT(1) INITIAL("FFFFFFFF"), 
        B2 BIT(2) INITIAL("FFFFFFFF"), 
        B3 BIT(3) INITIAL("FFFFFFFF"), 
        B4 BIT(4) INITIAL("FFFFFFFF"), 
        B5 BIT(5) INITIAL("FFFFFFFF"), 
        B6 BIT(6) INITIAL("FFFFFFFF"),
        B7 BIT(7) INITIAL("FFFFFFFF"), 
        B8 BIT(8) INITIAL("FFFFFFFF"), 
        B9 BIT(9) INITIAL("FFFFFFFF"), 
        B10 BIT(10) INITIAL("FFFFFFFF"), 
        B11 BIT(11) INITIAL("FFFFFFFF"),
        B12 BIT(12) INITIAL("FFFFFFFF"), 
        B13 BIT(13) INITIAL("FFFFFFFF"), 
        B14 BIT(14) INITIAL("FFFFFFFF"), 
        B15 BIT(15) INITIAL("FFFFFFFF"), 
        B16 BIT(16) INITIAL("FFFFFFFF"),
        B17 BIT(17) INITIAL("FFFFFFFF"), 
        B18 BIT(18) INITIAL("FFFFFFFF"), 
        B19 BIT(19) INITIAL("FFFFFFFF"), 
        B20 BIT(20) INITIAL("FFFFFFFF"), 
        B21 BIT(21) INITIAL("FFFFFFFF"),
        B22 BIT(22) INITIAL("FFFFFFFF"), 
        B23 BIT(23) INITIAL("FFFFFFFF"), 
        B24 BIT(24) INITIAL("FFFFFFFF"), 
        B25 BIT(25) INITIAL("FFFFFFFF"), 
        B26 BIT(26) INITIAL("FFFFFFFF"),
        B27 BIT(27) INITIAL("FFFFFFFF"), 
        B28 BIT(28) INITIAL("FFFFFFFF"), 
        B29 BIT(29) INITIAL("FFFFFFFF"), 
        B30 BIT(30) INITIAL("FFFFFFFF"),
        B31 BIT(31) INITIAL("FFFFFFFF"),
        B32 BIT(32) INITIAL("FFFFFFFF"), 
        F FIXED INITIAL("A5A5A5A5"), 
        C CHARACTER INITIAL('When you wish upon a star');
COMMON BS6(5) BIT(6) INITIAL("F0", "F1", "F2", "F3", "F4"),
        BS13(5) BIT(13) INITIAL("FFF0", "FFF1", "FFF2", "FFF3", "FFF4"),
        BS27(5) BIT(27) INITIAL("FFFFFF0", "FFFFFF1", "FFFFFF2", "FFFFFF3",
                                "FFFFFF4"),
        FS(5) FIXED INITIAL(1, 2, 3, 4, 5),
        CS(5) CHARACTER INITIAL('Yes', 'I', 'am', 'so', 'great');
COMMON ARRAY AB1(5) BIT(1) INITIAL(1111111, 2222222, 3333333, 4444444, 5555555),
        AB8(5) BIT(8) INITIAL(1111111, 2222222, 3333333, 4444444, 5555555),
        AB16(5) BIT(16) INITIAL(1111111, 2222222, 3333333, 4444444, 5555555),
        AB32(5) BIT(32) INITIAL(1111111, 2222222, 3333333, 4444444, 5555555),
        AF(5) FIXED INITIAL(1111111, 2222222, 3333333, 4444444, 5555555);
COMMON BASED BB1 BIT(1),
        BB8 BIT(8),
        BB16 BIT(16),
        BB32 BIT(32);
COMMON BASED BF FIXED,
        BC CHARACTER;
COMMON BASED BR RECORD:
                B1 BIT(1),      /* 0 */
                B8 BIT(8),      /* 1 */
                B16 BIT(16),    /* 2 */
                B32 BIT(32),    /* 4 */
                F FIXED,        /* 8 */
                C CHARACTER,    /* 12 */
                BS1(5) BIT(1),  /* 16 */
                BS8(5) BIT(8),  /* 22 */
                BS16(5) BIT(16),/* 28 */
                BS32(5) BIT(32),/* 40 */
                FS(5) FIXED,    /* 64 */
                CS(5) CHARACTER,/* 88 */
                                /* 112 */
           END;

OUTPUT = '';
OUTPUT = 'BASED Allocations ---------------------------------------------';
OUTPUT = '';
OUTPUT = 'Allocating BB1: ' || MONITOR(6, ADDR(BB1), 16);
OUTPUT = 'Allocating BB8: ' || MONITOR(6, ADDR(BB8), 16);
OUTPUT = 'Allocating BB16: ' || MONITOR(6, ADDR(BB16), 32);
OUTPUT = 'Allocating BB32: ' || MONITOR(6, ADDR(BB32), 64);
OUTPUT = 'Allocating BF: ' || MONITOR(6, ADDR(BF), 64);
OUTPUT = 'Allocating BC: ' || MONITOR(6, ADDR(BC), 64);
OUTPUT = 'Allocating BR: ' || MONITOR(6, ADDR(BR), 
                16 *(1 + 1 + 2 + 4 + 4 + 4 + 6 * (1 + 1 + 2 + 4 + 4 + 4)));
OUTPUT = 'BB1 @' || ADDR(BB1) || ', BB1(0) @' || ADDR(BB1(0));
OUTPUT = 'BB8 @' || ADDR(BB8) || ', BB8(0) @' || ADDR(BB8(0));
OUTPUT = 'BB16 @' || ADDR(BB16) || ', BB16(0) @' || ADDR(BB16(0));
OUTPUT = 'BB32 @' || ADDR(BB32) || ', BB32(0) @' || ADDR(BB32(0));
OUTPUT = 'BF @' || ADDR(BF) || ', BF(0) @' || ADDR(BF(0));
OUTPUT = 'BC @' || ADDR(BC) || ', BC(0) @' || ADDR(BC(0));
OUTPUT = 'BR @' || ADDR(BR) || ', BR(0) @' || ADDR(BR(0));
OUTPUT = 'BR(10).BS16(3) @' || ADDR(BR(10).BS16(3));

TO_HEX:
PROCEDURE(N) CHARACTER;
        DECLARE N FIXED;
        DECLARE RETVAL CHARACTER, C CHARACTER, I FIXED, DIGIT FIXED;
        RETVAL = '';
        DO I = 1 TO 8;
                DIGIT = N & "F";
                N = SHR(N, 4);
                DO CASE DIGIT;
                        C = '0';
                        C = '1';
                        C = '2';
                        C = '3';
                        C = '4';
                        C = '5';
                        C = '6';
                        C = '7';
                        C = '8';
                        C = '9';
                        C = 'A';
                        C = 'B';
                        C = 'C';
                        C = 'D';
                        C = 'E';
                        C = 'F';
                END;
                RETVAL = C || RETVAL;
        END;
        RETURN RETVAL;
END TO_HEX;

OUTPUT = '';
OUTPUT = 'Address Allocations ---------------------------------------------';
OUTPUT = '';
OUTPUT = 'B1  @' || ADDR(B1);
OUTPUT = 'B2  @' || ADDR(B2);
OUTPUT = 'B3  @' || ADDR(B3);
OUTPUT = 'B4  @' || ADDR(B4);
OUTPUT = 'B5  @' || ADDR(B5);
OUTPUT = 'B6  @' || ADDR(B6);
OUTPUT = 'B7  @' || ADDR(B7);
OUTPUT = 'B8  @' || ADDR(B8);
OUTPUT = 'B9  @' || ADDR(B9);
OUTPUT = 'B10 @' || ADDR(B10);
OUTPUT = 'B11 @' || ADDR(B11);
OUTPUT = 'B12 @' || ADDR(B12);
OUTPUT = 'B13 @' || ADDR(B13);
OUTPUT = 'B14 @' || ADDR(B14);
OUTPUT = 'B15 @' || ADDR(B15);
OUTPUT = 'B16 @' || ADDR(B16);
OUTPUT = 'B17 @' || ADDR(B17);
OUTPUT = 'B18 @' || ADDR(B18);
OUTPUT = 'B19 @' || ADDR(B19);
OUTPUT = 'B20 @' || ADDR(B20);
OUTPUT = 'B21 @' || ADDR(B21);
OUTPUT = 'B22 @' || ADDR(B22);
OUTPUT = 'B23 @' || ADDR(B23);
OUTPUT = 'B24 @' || ADDR(B24);
OUTPUT = 'B25 @' || ADDR(B25);
OUTPUT = 'B26 @' || ADDR(B26);
OUTPUT = 'B27 @' || ADDR(B27);
OUTPUT = 'B28 @' || ADDR(B28);
OUTPUT = 'B29 @' || ADDR(B29);
OUTPUT = 'B30 @' || ADDR(B30);
OUTPUT = 'B31 @' || ADDR(B31);
OUTPUT = 'B32 @' || ADDR(B32);
OUTPUT = 'F   @' || ADDR(F);
OUTPUT = 'C   @' || ADDR(C);
OUTPUT = 'BS6 @' || ADDR(BS6);
OUTPUT = 'BS6(3) @' || ADDR(BS6(3));
OUTPUT = 'BS13 @' || ADDR(BS13);
OUTPUT = 'BS13(3) @' || ADDR(BS13(3));
OUTPUT = 'BS27 @' || ADDR(BS27);
OUTPUT = 'BS27(3) @' || ADDR(BS27(3));
OUTPUT = 'FS  @' || ADDR(FS);
OUTPUT = 'FS(3) @' || ADDR(FS(3));
OUTPUT = 'CS  @' || ADDR(CS);
OUTPUT = 'CS(3) @' || ADDR(CS(3));
OUTPUT = 'AB1  @' || ADDR(AB1);
OUTPUT = 'AB1(3) @' || ADDR(AB1(3));
OUTPUT = 'AB8  @' || ADDR(AB8);
OUTPUT = 'AB8(3) @' || ADDR(AB8(3));
OUTPUT = 'AB16  @' || ADDR(AB16);
OUTPUT = 'AB16(3) @' || ADDR(AB16(3));
OUTPUT = 'AB32  @' || ADDR(AB32);
OUTPUT = 'AB32(3) @' || ADDR(AB32(3));
OUTPUT = 'AF  @' || ADDR(AF);
OUTPUT = 'AF(3) @' || ADDR(AF(3));

OUTPUT = '';
OUTPUT = 'Initial Values --------------------------------------------------';
OUTPUT = '';
OUTPUT = 'B1  = ' || TO_HEX(B1);
OUTPUT = 'B2  = ' || TO_HEX(B2);
OUTPUT = 'B3  = ' || TO_HEX(B3);
OUTPUT = 'B4  = ' || TO_HEX(B4);
OUTPUT = 'B5  = ' || TO_HEX(B5);
OUTPUT = 'B6  = ' || TO_HEX(B6);
OUTPUT = 'B7  = ' || TO_HEX(B7);
OUTPUT = 'B8  = ' || TO_HEX(B8);
OUTPUT = 'B9  = ' || TO_HEX(B9);
OUTPUT = 'B10 = ' || TO_HEX(B10);
OUTPUT = 'B11 = ' || TO_HEX(B11);
OUTPUT = 'B12 = ' || TO_HEX(B12);
OUTPUT = 'B13 = ' || TO_HEX(B13);
OUTPUT = 'B14 = ' || TO_HEX(B14);
OUTPUT = 'B15 = ' || TO_HEX(B15);
OUTPUT = 'B16 = ' || TO_HEX(B16);
OUTPUT = 'B17 = ' || TO_HEX(B17);
OUTPUT = 'B18 = ' || TO_HEX(B18);
OUTPUT = 'B19 = ' || TO_HEX(B19);
OUTPUT = 'B20 = ' || TO_HEX(B20);
OUTPUT = 'B21 = ' || TO_HEX(B21);
OUTPUT = 'B22 = ' || TO_HEX(B22);
OUTPUT = 'B23 = ' || TO_HEX(B23);
OUTPUT = 'B24 = ' || TO_HEX(B24);
OUTPUT = 'B25 = ' || TO_HEX(B25);
OUTPUT = 'B26 = ' || TO_HEX(B26);
OUTPUT = 'B27 = ' || TO_HEX(B27);
OUTPUT = 'B28 = ' || TO_HEX(B28);
OUTPUT = 'B29 = ' || TO_HEX(B29);
OUTPUT = 'B30 = ' || TO_HEX(B30);
OUTPUT = 'B31 = ' || TO_HEX(B31);
OUTPUT = 'B32 = ' || TO_HEX(B32);
OUTPUT = 'F   = ' || TO_HEX(F);
OUTPUT = 'C   = ''' || C || '''';
OUTPUT = 'BS6 = ' || TO_HEX(BS6);
OUTPUT = 'BS6(3) = ' || TO_HEX(BS6(3));
OUTPUT = 'BS13 = ' || TO_HEX(BS13);
OUTPUT = 'BS13(3) = ' || TO_HEX(BS13(3));
OUTPUT = 'BS27 = ' || TO_HEX(BS27);
OUTPUT = 'BS27(3) = ' || TO_HEX(BS27(3));
OUTPUT = 'FS = ' || FS;
OUTPUT = 'FS(3) = ' || FS(3);
OUTPUT = 'CS = ''' || CS || '''';
OUTPUT = 'CS(3) = ''' || CS(3) || '''';
OUTPUT = 'AB1 = ' || AB1;
OUTPUT = 'AB1(3) = ' || AB1(3);
OUTPUT = 'AB8 = ' || AB8;
OUTPUT = 'AB8(3) = ' || AB8(3);
OUTPUT = 'AB16 = ' || AB16;
OUTPUT = 'AB16(3) = ' || AB16(3);
OUTPUT = 'AB32 = ' || AB32;
OUTPUT = 'AB32(3) = ' || AB32(3);
OUTPUT = 'AF = ' || AF;
OUTPUT = 'AF(3) = ' || AF(3);
OUTPUT = '';
OUTPUT = 'Assignments --------------------------------------------------';
OUTPUT = '';
BR(10).CS(3) = 'Goodbye';
BR(10).FS(3) = "59595959";
BR(10).BS32(3) = "95959595";
BR(10).BS16(3) = "36363636";
BR(10).BS8(3) = "63636363";
BR(10).BS1(3) = "71717171";
BR(10).C = '"Bruce" Willis';
BR(10).F = "99";
BR(10).B32 = "12345678";
BR(10).B16 = "23456789";
BR(10).B8 = "34567890";
BR(10).B1 = "11111111";
BC(10) = 'Dormant mice are sleeping';
BF(10) = "82828282";
BB32(10) = "98765432";
BB16(10) = "87654321";
BB8(10) = "76543210";
BB1(10) = "1";
AF(3) = "12345678";
AF = "23456789";
AB32(3) = "34567890";
AB32 = "45678901";
AB16(3) = "56789012";
AB16 = "67890123";
AB8(3) = "78901234";
AB8 = "89012345";
AB1(3) = "90123456";
AB1 = "01234567";
CS(3) = 'Pumpernickel is delicious';
CS = 'I suppose.';
FS(3) = "83453910";
FS = "23459108";
BS27(3) = "52525250";
BS27 = "52525251";
BS13(3) = "43434340";
BS13 = "43434341";
BS6(3) = "67676760";
BS6 = "67676761";
C = 'Glorcknab in the prissyfritz';
F = "65434567";
B32 = "FFFFFFE0";
B31 = "FFFFFFE1";
B30 = "FFFFFFE2";
B29 = "FFFFFFE3";
B28 = "FFFFFFE4";
B27 = "FFFFFFE5";
B26 = "FFFFFFE6";
B25 = "FFFFFFE7";
B24 = "FFFFFFE8";
B23 = "FFFFFFE9";
B22 = "FFFFFFEA";
B21 = "FFFFFFEB";
B20 = "FFFFFFEC";
B19 = "FFFFFFED";
B18 = "FFFFFFEE";
B17 = "FFFFFFEF";
B16 = "FFFFFFF0";
B15 = "FFFFFFF1";
B14 = "FFFFFFF2";
B13 = "FFFFFFF3";
B12 = "FFFFFFF4";
B11 = "FFFFFFF5";
B10 = "FFFFFFF6";
B9 = "FFFFFFF7";
B8 = "FFFFFFF8";
B7 = "FFFFFFF9";
B6 = "FFFFFFFA";
B5 = "FFFFFFFB";
B4 = "FFFFFFFC";
B3 = "FFFFFFFD";
B2 = "FFFFFFFE";
B1 = "FFFFFFFF";
OUTPUT = 'B1  = ' || TO_HEX(B1);
OUTPUT = 'B2  = ' || TO_HEX(B2);
OUTPUT = 'B3  = ' || TO_HEX(B3);
OUTPUT = 'B4  = ' || TO_HEX(B4);
OUTPUT = 'B5  = ' || TO_HEX(B5);
OUTPUT = 'B6  = ' || TO_HEX(B6);
OUTPUT = 'B7  = ' || TO_HEX(B7);
OUTPUT = 'B8  = ' || TO_HEX(B8);
OUTPUT = 'B9  = ' || TO_HEX(B9);
OUTPUT = 'B10 = ' || TO_HEX(B10);
OUTPUT = 'B11 = ' || TO_HEX(B11);
OUTPUT = 'B12 = ' || TO_HEX(B12);
OUTPUT = 'B13 = ' || TO_HEX(B13);
OUTPUT = 'B14 = ' || TO_HEX(B14);
OUTPUT = 'B15 = ' || TO_HEX(B15);
OUTPUT = 'B16 = ' || TO_HEX(B16);
OUTPUT = 'B17 = ' || TO_HEX(B17);
OUTPUT = 'B18 = ' || TO_HEX(B18);
OUTPUT = 'B19 = ' || TO_HEX(B19);
OUTPUT = 'B20 = ' || TO_HEX(B20);
OUTPUT = 'B21 = ' || TO_HEX(B21);
OUTPUT = 'B22 = ' || TO_HEX(B22);
OUTPUT = 'B23 = ' || TO_HEX(B23);
OUTPUT = 'B24 = ' || TO_HEX(B24);
OUTPUT = 'B25 = ' || TO_HEX(B25);
OUTPUT = 'B26 = ' || TO_HEX(B26);
OUTPUT = 'B27 = ' || TO_HEX(B27);
OUTPUT = 'B28 = ' || TO_HEX(B28);
OUTPUT = 'B29 = ' || TO_HEX(B29);
OUTPUT = 'B30 = ' || TO_HEX(B30);
OUTPUT = 'B31 = ' || TO_HEX(B31);
OUTPUT = 'B32 = ' || TO_HEX(B32);
OUTPUT = 'F   = ' || TO_HEX(F);
OUTPUT = 'C   = ''' || C || '''';
OUTPUT = 'BS6 = ' || TO_HEX(BS6);
OUTPUT = 'BS6(3) = ' || TO_HEX(BS6(3));
OUTPUT = 'BS13 = ' || TO_HEX(BS13);
OUTPUT = 'BS13(3) = ' || TO_HEX(BS13(3));
OUTPUT = 'BS27 = ' || TO_HEX(BS27);
OUTPUT = 'BS27(3) = ' || TO_HEX(BS27(3));

OUTPUT = 'FS = ' || TO_HEX(FS);
OUTPUT = 'FS(3) = ' || TO_HEX(FS(3));
OUTPUT = 'CS = ''' || CS || '''';
OUTPUT = 'CS(3) = ''' || CS(3) || '''';
OUTPUT = 'AB1 = ' || TO_HEX(AB1);
OUTPUT = 'AB1(3) = ' || TO_HEX(AB1(3));
OUTPUT = 'AB8 = ' || TO_HEX(AB8);
OUTPUT = 'AB8(3) = ' || TO_HEX(AB8(3));
OUTPUT = 'AB16 = ' || TO_HEX(AB16);
OUTPUT = 'AB16(3) = ' || TO_HEX(AB16(3));
OUTPUT = 'AB32 = ' || TO_HEX(AB32);
OUTPUT = 'AB32(3) = ' || TO_HEX(AB32(3));
OUTPUT = 'AF = ' || TO_HEX(AF);
OUTPUT = 'AF(3) = ' || TO_HEX(AF(3));
OUTPUT = 'BB1(10) = ' || TO_HEX(BB1(10));
OUTPUT = 'BB8(10) = ' || TO_HEX(BB8(10));
OUTPUT = 'BB16(10) = ' || TO_HEX(BB16(10));
OUTPUT = 'BB32(10) = ' || TO_HEX(BB32(10));
OUTPUT = 'BF(10) = ' || TO_HEX(BF(10));
OUTPUT = 'BC(10) = ''' || BC(10) || '''';
OUTPUT = 'BR(10).B1 = ' || TO_HEX(BR(10).B1);
OUTPUT = 'BR(10).B8 = ' || TO_HEX(BR(10).B8);
OUTPUT = 'BR(10).B16 = ' || TO_HEX(BR(10).B16);
OUTPUT = 'BR(10).B32 = ' || TO_HEX(BR(10).B32);
OUTPUT = 'BR(10).F = ' || TO_HEX(BR(10).F);
OUTPUT = 'BR(10).C = ''' || BR(10).C || '''';
OUTPUT = 'BR(10).BS1(3) = ' || TO_HEX(BR(10).BS1(3));
OUTPUT = 'BR(10).BS8(3) = ' || TO_HEX(BR(10).BS8(3));
OUTPUT = 'BR(10).BS16(3) = ' || TO_HEX(BR(10).BS16(3));
OUTPUT = 'BR(10).BS32(3) = ' || TO_HEX(BR(10).BS32(3));
OUTPUT = 'BR(10).FS(3) = ' || TO_HEX(BR(10).FS(3));
OUTPUT = 'BR(10).CS(3) = ''' || BR(10).CS(3) || '''';

EOF