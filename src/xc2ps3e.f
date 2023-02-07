      MODULE XC2PS3E
      CONTAINS
*     
* ..File: xc2ps3e.f    F2_PS
*
*
* ..The exact 3-loop MS(bar) pure-singlet coefficient functions for the 
*    structure function F_2 in electromagnetic DIS at mu_r = mu_f = Q. 
*    Expansion parameter: alpha_s/(4 pi).
* 
* ..The distributions (in the mathematical sense) are given as in eq.
*    (B.26) of Floratos, Kounnas, Lacaze: Nucl. Phys. B192 (1981) 417.
*    The name-endings A, B, and C of the functions below correspond to 
*    the kernel superscripts [2], [3], and [1] in that equation.
*
* ..The code uses the package of Gehrmann and Remiddi for the harmonic
*    polylogarithms published in hep-ph/0107173 = CPC 141 (2001) 296,
*    upgraded to weight 5 (T. Gehrmann, private communication).
*
* ..Reference: J. Vermaseren, A. Vogt and S. Moch
*              hep-ph/0504242 = Nucl. Phys. B724 (2005) 3
*
* =====================================================================
*
*
* ..This is the regular piece. 
*
       FUNCTION X2S3A (X, NF, CC)
*
       IMPLICIT REAL*8 (A - Z)
       COMPLEX*16 HC1, HC2, HC3, HC4, HC5
       INTEGER NF, NF2, N1, N2, NW, CC
       PARAMETER ( N1 = -1, N2 = 1, NW = 5 )
       DIMENSION HC1(N1:N2),HC2(N1:N2,N1:N2),HC3(N1:N2,N1:N2,N1:N2),
     ,           HC4(N1:N2,N1:N2,N1:N2,N1:N2),
     ,           HC5(N1:N2,N1:N2,N1:N2,N1:N2,N1:N2)
       DIMENSION HR1(N1:N2),HR2(N1:N2,N1:N2),HR3(N1:N2,N1:N2,N1:N2),
     ,           HR4(N1:N2,N1:N2,N1:N2,N1:N2),
     ,           HR5(N1:N2,N1:N2,N1:N2,N1:N2,N1:N2)
       DIMENSION HI1(N1:N2),HI2(N1:N2,N1:N2),HI3(N1:N2,N1:N2,N1:N2),
     ,           HI4(N1:N2,N1:N2,N1:N2,N1:N2),
     ,           HI5(N1:N2,N1:N2,N1:N2,N1:N2,N1:N2)
       PARAMETER ( Z2 = 1.6449 34066 84822 64365 D0,
     ,             Z3 = 1.2020 56903 15959 42854 D0,
     ,             Z4 = 1.0823 23233 71113 81916 D0,
     ,             Z5 = 1.0369 27755 14336 99263 D0 )
       DIMENSION FL(6), FLS(6)
       DATA FL  / -1.d0, 0.5d0, 0.d0, 0.5d0, 0.2d0, 0.5d0 /
       DATA FLS /  1.d0, 0.1d0, 0.d0, 0.1d0, 0.018181818d0, 0.1d0 /
*
* ...Colour factors 
*
       CF  = 4./3.D0
       CA  = 3.D0
       NF2 = NF*NF
       DABC2N = 5./18.D0 * NF
*
       FL11 = FLS(NF) - FL(NF)
*
* ..Some abbreviations
*
       DM = 1.D0/(1.D0-X)
       DP = 1.D0/(1.D0+X)
       DX = 1.D0/X
       DL = LOG (X)
*
* ...Harmonic polylogs (HPLs) up to weight 5 by Gehrmann and Remiddi
*
       CALL HPLOG5 (X, NW, HC1,HC2,HC3,HC4,HC5, HR1,HR2,HR3,HR4,HR5,
     ,             HI1,HI2,HI3,HI4,HI5, N1, N2)
*
* ...The coefficient function in terms of the HPLs, fl11 part
*    (same in non-singlet and pure singlet - with different fl11)
*
       if(CC.eq.0) then
      c2qq3 =
     &  + fl11*dabc2n * (  - 192.D0/5.D0 - 1728.D0/5.D0*x + 1152.D0/5.D0
     &    *x**2 + 5120.D0*z5*x + 1312.D0*z4*x + 1536.D0*z4*x**2 - 2304.D
     &    0/5.D0*z4*x**3 + 128.D0/5.D0*dx - 3136.D0/15.D0*z3 - 51712.D0/
     &    15.D0*z3*x + 1344.D0/5.D0*z3*x**2 - 1920.D0*z3*x**3 + 1024.D0/
     &    15.D0*z3*dx + 192.D0*z3*dm - 7552.D0/15.D0*z2 + 11648.D0/15.D0
     &    *z2*x - 768.D0*z2*x**2 - 4992.D0/5.D0*z2*x**3 + 512.D0/3.D0*
     &    z2*dx + 512.D0*z2*dp + 512.D0*z2*z3*x - 1024.D0*Hr1(-1)*z4 - 
     &    2048.D0*Hr1(-1)*z4*x - 512.D0*Hr1(-1)*z3*x + 2304.D0/5.D0*
     &    Hr1(-1)*z3*x**3 - 256.D0/5.D0*Hr1(-1)*z3*dx**2 + 11072.D0/15.D
     &    0*Hr1(-1)*z2 + 8064.D0/5.D0*Hr1(-1)*z2*x + 192.D0/5.D0*Hr1(-1
     &    )*z2*x**2 + 1152.D0*Hr1(-1)*z2*x**3 - 1024.D0/15.D0*Hr1(-1)*
     &    z2*dx - 128.D0*Hr1(-1)*z2*dx**2 + 4672.D0/15.D0*Hr1(0) - 384.D
     &    0/5.D0*Hr1(0)*x + 4992.D0/5.D0*Hr1(0)*x**2 - 128.D0/5.D0*Hr1(
     &    0)*dx - 320.D0*Hr1(0)*dp + 2048.D0/3.D0*Hr1(0)*z3*x + 768.D0*
     &    Hr1(0)*z3*x**2 - 3072.D0/5.D0*Hr1(0)*z3*x**3 - 512.D0/15.D0*
     &    Hr1(0)*z2 )
      c2qq3 = c2qq3 + fl11*dabc2n * (  - 2944.D0/3.D0*Hr1(0)*z2*x + 
     &    2688.D0/5.D0*Hr1(0)*z2*x**2 - 1536.D0*Hr1(0)*z2*x**3 - 64.D0*
     &    Hr1(0)*z2*dp + 64.D0*Hr1(0)*z2*dm - 10496.D0/15.D0*Hr1(1) - 
     &    768.D0/5.D0*Hr1(1)*x + 768.D0*Hr1(1)*x**2 + 256.D0/3.D0*Hr1(1
     &    )*dx - 1024.D0*Hr1(1)*z3 + 2432.D0/3.D0*Hr1(1)*z3*x + 768.D0*
     &    Hr1(1)*z3*x**2 - 768.D0/5.D0*Hr1(1)*z3*x**3 - 256.D0/15.D0*
     &    Hr1(1)*z3*dx**2 + 64.D0*Hr1(1)*z2 - 640.D0/3.D0*Hr1(1)*z2*x
     &     + 576.D0*Hr1(1)*z2*x**2 - 384.D0*Hr1(1)*z2*x**3 - 128.D0/3.D0
     &    *Hr1(1)*z2*dx**2 + 2048.D0/3.D0*Hr2(-1,-1)*z2*x - 3072.D0/5.D0
     &    *Hr2(-1,-1)*z2*x**3 + 1024.D0/15.D0*Hr2(-1,-1)*z2*dx**2 - 
     &    1280.D0/3.D0*Hr2(-1,0) - 3200.D0/3.D0*Hr2(-1,0)*x - 768.D0*
     &    Hr2(-1,0)*x**2 - 4992.D0/5.D0*Hr2(-1,0)*x**3 + 256.D0/3.D0*
     &    Hr2(-1,0)*dx + 1664.D0/15.D0*Hr2(-1,0)*dx**2 - 512.D0*Hr2(-1,
     &    0)*z3 - 1024.D0*Hr2(-1,0)*z3*x - 1408.D0/3.D0*Hr2(-1,0)*z2*x
     &     + 1536.D0/5.D0*Hr2(-1,0)*z2*x**3 - 512.D0/15.D0*Hr2(-1,0)*z2
     &    *dx**2 )
      c2qq3 = c2qq3 + fl11*dabc2n * (  - 896.D0/3.D0*Hr2(0,-1)*z2*x + 
     &    3072.D0/5.D0*Hr2(0,-1)*z2*x**3 + 512.D0/3.D0*Hr2(0,0) - 5888.D
     &    0/15.D0*Hr2(0,0)*x + 768.D0*Hr2(0,0)*x**2 + 4992.D0/5.D0*Hr2(
     &    0,0)*x**3 - 256.D0/3.D0*Hr2(0,0)*dx - 256.D0*Hr2(0,0)*dp + 
     &    128.D0*Hr2(0,0)*dm - 512.D0*Hr2(0,0)*z2*x - 768.D0*Hr2(0,0)*
     &    z2*x**2 + 7552.D0/15.D0*Hr2(0,1) - 9216.D0/5.D0*Hr2(0,1)*x + 
     &    768.D0*Hr2(0,1)*x**2 - 256.D0/3.D0*Hr2(0,1)*dx - 512.D0*Hr2(0
     &    ,1)*dp - 512.D0*Hr2(0,1)*z3 - 1024.D0*Hr2(0,1)*z3*x - 128.D0*
     &    Hr2(0,1)*z2*x + 1024.D0*Hr2(1,0)*z2 - 1408.D0/3.D0*Hr2(1,0)*
     &    z2*x - 768.D0*Hr2(1,0)*z2*x**2 + 1536.D0/5.D0*Hr2(1,0)*z2*
     &    x**3 + 512.D0/15.D0*Hr2(1,0)*z2*dx**2 + 128.D0*Hr3(-1,-1,0)
     &     + 1280.D0/3.D0*Hr3(-1,-1,0)*x + 1152.D0*Hr3(-1,-1,0)*x**2 + 
     &    768.D0*Hr3(-1,-1,0)*x**3 - 256.D0/3.D0*Hr3(-1,-1,0)*dx**2 - 
     &    6016.D0/15.D0*Hr3(-1,0,0) - 13696.D0/15.D0*Hr3(-1,0,0)*x - 
     &    1536.D0/5.D0*Hr3(-1,0,0)*x**2 - 768.D0*Hr3(-1,0,0)*x**3 + 512.
     &    D0/15.D0*Hr3(-1,0,0)*dx )
      c2qq3 = c2qq3 + fl11*dabc2n * ( 256.D0/3.D0*Hr3(-1,0,0)*dx**2 + 
     &    512.D0*Hr3(-1,0,0)*z2 + 1024.D0*Hr3(-1,0,0)*z2*x - 10112.D0/
     &    15.D0*Hr3(-1,0,1) - 20992.D0/15.D0*Hr3(-1,0,1)*x + 2688.D0/5.D
     &    0*Hr3(-1,0,1)*x**2 - 768.D0*Hr3(-1,0,1)*x**3 + 1024.D0/15.D0*
     &    Hr3(-1,0,1)*dx + 256.D0/3.D0*Hr3(-1,0,1)*dx**2 - 384.D0*Hr3(0
     &    ,-1,0) - 128.D0/3.D0*Hr3(0,-1,0)*x - 1152.D0*Hr3(0,-1,0)*x**2
     &     - 768.D0*Hr3(0,-1,0)*x**3 + 128.D0*Hr3(0,-1,0)*dm + 128.D0/3.
     &    D0*Hr3(0,0,0)*x + 768.D0*Hr3(0,0,0)*x**3 + 64.D0*Hr3(0,0,0)*
     &    dp - 64.D0*Hr3(0,0,0)*dm + 512.D0/15.D0*Hr3(0,0,1) + 2816.D0/
     &    3.D0*Hr3(0,0,1)*x - 2688.D0/5.D0*Hr3(0,0,1)*x**2 + 768.D0*
     &    Hr3(0,0,1)*x**3 + 512.D0*Hr3(0,1,0)*z2 + 1024.D0*Hr3(0,1,0)*
     &    z2*x + 3584.D0/15.D0*Hr3(1,0,0) - 128.D0/5.D0*Hr3(1,0,0)*x - 
     &    1536.D0/5.D0*Hr3(1,0,0)*x**2 - 512.D0/15.D0*Hr3(1,0,0)*dx - 
     &    1024.D0/3.D0*Hr4(-1,-1,0,0)*x + 1536.D0/5.D0*Hr4(-1,-1,0,0)*
     &    x**3 - 512.D0/15.D0*Hr4(-1,-1,0,0)*dx**2 - 2048.D0/3.D0*Hr4(
     &    -1,-1,0,1)*x )
      c2qq3 = c2qq3 + fl11*dabc2n * ( 3072.D0/5.D0*Hr4(-1,-1,0,1)*x**3
     &     - 1024.D0/15.D0*Hr4(-1,-1,0,1)*dx**2 + 128.D0*Hr4(-1,0,0,0)*
     &    x + 1024.D0/3.D0*Hr4(-1,0,0,1)*x - 1536.D0/5.D0*Hr4(-1,0,0,1)
     &    *x**3 + 512.D0/15.D0*Hr4(-1,0,0,1)*dx**2 + 256.D0*Hr4(0,-1,-1
     &    ,0)*x + 256.D0/3.D0*Hr4(0,-1,0,0)*x - 1536.D0/5.D0*Hr4(0,-1,0
     &    ,0)*x**3 + 1280.D0/3.D0*Hr4(0,-1,0,1)*x - 3072.D0/5.D0*Hr4(0,
     &    -1,0,1)*x**3 + 512.D0*Hr4(0,0,0,1)*x + 768.D0*Hr4(0,0,0,1)*
     &    x**2 - 1792.D0/3.D0*Hr4(0,1,0,0)*x - 768.D0*Hr4(0,1,0,0)*x**2
     &     + 1536.D0/5.D0*Hr4(0,1,0,0)*x**3 + 256.D0*Hr4(1,0,-1,0)*x - 
     &    128.D0*Hr4(1,0,0,0)*x - 1024.D0*Hr4(1,0,0,1) + 1792.D0/3.D0*
     &    Hr4(1,0,0,1)*x + 768.D0*Hr4(1,0,0,1)*x**2 - 1536.D0/5.D0*Hr4(
     &    1,0,0,1)*x**3 - 512.D0/15.D0*Hr4(1,0,0,1)*dx**2 + 1024.D0*
     &    Hr4(1,1,0,0) - 1792.D0/3.D0*Hr4(1,1,0,0)*x - 768.D0*Hr4(1,1,0
     &    ,0)*x**2 + 1536.D0/5.D0*Hr4(1,1,0,0)*x**3 + 512.D0/15.D0*Hr4(
     &    1,1,0,0)*dx**2 - 512.D0*Hr5(-1,0,0,0,1) - 1024.D0*Hr5(-1,0,0,
     &    0,1)*x )
       c2qq3 = c2qq3 + fl11*dabc2n * ( 512.D0*Hr5(-1,0,1,0,0) + 1024.D0*
     &    Hr5(-1,0,1,0,0)*x - 512.D0*Hr5(0,1,0,0,1) - 1024.D0*Hr5(0,1,0
     &    ,0,1)*x + 512.D0*Hr5(0,1,1,0,0) + 1024.D0*Hr5(0,1,1,0,0)*x )
       endif
*
* ...The coefficient function in terms of the HPLs: standard parts
*
       if(CC.eq.1) then
      c2qps3 =
     &  + nf*cf*ca * ( 488366.D0/243.D0 - 130832.D0/243.D0*x - 510478.D0
     &    /3645.D0*x**2 - 620.D0*z5 - 132.D0*z5*x + 464.D0/3.D0*z4 - 
     &    382.D0/3.D0*z4*x + 712.D0/3.D0*z4*x**2 - 384.D0/5.D0*z4*x**3
     &     - 4852532.D0/3645.D0*dx + 1984.D0/9.D0*dx*z4 - 73232.D0/135.D
     &    0*z3 + 88132.D0/135.D0*z3*x + 57544.D0/135.D0*z3*x**2 + 32.D0
     &    *z3*x**3 + 3952.D0/45.D0*z3*dx - 65828.D0/81.D0*z2 - 240892.D0
     &    /405.D0*z2*x - 123728.D0/405.D0*z2*x**2 + 16.D0/5.D0*z2*x**3
     &     + 75776.D0/405.D0*z2*dx + 296.D0*z2*z3 + 904.D0/3.D0*z2*z3*x
     &     + 40.D0*Hr1(-1)*z3 + 40.D0*Hr1(-1)*z3*x + 16.D0/3.D0*Hr1(-1)
     &    *z3*x**2 + 16.D0/3.D0*Hr1(-1)*z3*dx + 116.D0/9.D0*Hr1(-1)*z2
     &     - 1348.D0/9.D0*Hr1(-1)*z2*x + 3656.D0/27.D0*Hr1(-1)*z2*x**2
     &     - 96.D0/5.D0*Hr1(-1)*z2*x**3 + 8624.D0/27.D0*Hr1(-1)*z2*dx
     &     + 32.D0/15.D0*Hr1(-1)*z2*dx**2 - 1630676.D0/1215.D0*Hr1(0)
     &     + 847354.D0/1215.D0*Hr1(0)*x - 1199092.D0/1215.D0*Hr1(0)*
     &    x**2 - 188.D0*Hr1(0)*z4 + 772.D0/3.D0*Hr1(0)*z4*x - 198736.D0/
     &    1215.D0*Hr1(0)*dx )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 320.D0/9.D0*Hr1(0)*z3 - 6920.D
     &    0/9.D0*Hr1(0)*z3*x + 3488.D0/9.D0*Hr1(0)*z3*x**2 - 192.D0/5.D0
     &    *Hr1(0)*z3*x**3 - 128.D0/9.D0*Hr1(0)*z3*dx + 101852.D0/135.D0
     &    *Hr1(0)*z2 + 32348.D0/135.D0*Hr1(0)*z2*x + 91736.D0/135.D0*
     &    Hr1(0)*z2*x**2 + 128.D0/5.D0*Hr1(0)*z2*x**3 + 1888.D0/45.D0*
     &    Hr1(0)*z2*dx - 3310.D0/3.D0*Hr1(1) + 16250.D0/27.D0*Hr1(1)*x
     &     - 394996.D0/1215.D0*Hr1(1)*x**2 + 1004296.D0/1215.D0*Hr1(1)*
     &    dx - 140.D0*Hr1(1)*z3 + 356.D0/3.D0*Hr1(1)*z3*x + 400.D0/3.D0
     &    *Hr1(1)*z3*x**2 - 192.D0/5.D0*Hr1(1)*z3*x**3 - 208.D0/3.D0*
     &    Hr1(1)*z3*dx - 64.D0/15.D0*Hr1(1)*z3*dx**2 - 4.D0/9.D0*Hr1(1)
     &    *z2 - 332.D0/3.D0*Hr1(1)*z2*x + 6128.D0/27.D0*Hr1(1)*z2*x**2
     &     + 32.D0/5.D0*Hr1(1)*z2*x**3 - 3320.D0/27.D0*Hr1(1)*z2*dx + 
     &    32.D0/45.D0*Hr1(1)*z2*dx**2 - 256.D0/3.D0*Hr2(-1,-1)*z2 - 256.
     &    D0/3.D0*Hr2(-1,-1)*z2*x - 608.D0/9.D0*Hr2(-1,-1)*z2*x**2 - 
     &    608.D0/9.D0*Hr2(-1,-1)*z2*dx + 22076.D0/135.D0*Hr2(-1,0) - 
     &    32044.D0/135.D0*Hr2(-1,0)*x )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 9032.D0/135.D0*Hr2(-1,0)*x**2
     &     + 16.D0/5.D0*Hr2(-1,0)*x**3 + 44608.D0/135.D0*Hr2(-1,0)*dx
     &     - 16.D0/45.D0*Hr2(-1,0)*dx**2 + 56.D0/3.D0*Hr2(-1,0)*z2 + 56.
     &    D0/3.D0*Hr2(-1,0)*z2*x - 896.D0/9.D0*Hr2(-1,0)*z2*x**2 - 896.D
     &    0/9.D0*Hr2(-1,0)*z2*dx - 128.D0/3.D0*Hr2(0,-1)*z3 + 128.D0/3.D
     &    0*Hr2(0,-1)*z3*x - 260.D0*Hr2(0,-1)*z2 + 860.D0/3.D0*Hr2(0,-1
     &    )*z2*x - 352.D0/3.D0*Hr2(0,-1)*z2*x**2 + 64.D0*Hr2(0,-1)*z2*
     &    dx + 801616.D0/405.D0*Hr2(0,0) + 468976.D0/405.D0*Hr2(0,0)*x
     &     + 22408.D0/405.D0*Hr2(0,0)*x**2 - 16.D0/5.D0*Hr2(0,0)*x**3
     &     + 64.D0/45.D0*Hr2(0,0)*dx - 1024.D0/3.D0*Hr2(0,0)*z3 - 352.D0
     &    *Hr2(0,0)*z3*x - 920.D0/9.D0*Hr2(0,0)*z2 - 2552.D0/9.D0*Hr2(0
     &    ,0)*z2*x - 128.D0/9.D0*Hr2(0,0)*z2*x**2 + 192.D0/5.D0*Hr2(0,0
     &    )*z2*x**3 + 65828.D0/81.D0*Hr2(0,1) + 28952.D0/81.D0*Hr2(0,1)
     &    *x + 123728.D0/405.D0*Hr2(0,1)*x**2 + 58048.D0/405.D0*Hr2(0,1
     &    )*dx - 168.D0*Hr2(0,1)*z3 - 168.D0*Hr2(0,1)*z3*x - 236.D0/3.D0
     &    *Hr2(0,1)*z2 )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 172.D0/3.D0*Hr2(0,1)*z2*x + 
     &    64.D0*Hr2(0,1)*z2*x**2 - 224.D0/3.D0*Hr2(0,1)*z2*dx + 6784.D0/
     &    27.D0*Hr2(1,0) - 2092.D0/27.D0*Hr2(1,0)*x + 13552.D0/81.D0*
     &    Hr2(1,0)*x**2 - 27628.D0/81.D0*Hr2(1,0)*dx - 304.D0*Hr2(1,0)*
     &    z2 + 976.D0/3.D0*Hr2(1,0)*z2*x + 64.D0/3.D0*Hr2(1,0)*z2*x**2
     &     + 192.D0/5.D0*Hr2(1,0)*z2*x**3 - 256.D0/3.D0*Hr2(1,0)*z2*dx
     &     + 64.D0/15.D0*Hr2(1,0)*z2*dx**2 + 668.D0/27.D0*Hr2(1,1) + 
     &    5008.D0/27.D0*Hr2(1,1)*x + 12320.D0/81.D0*Hr2(1,1)*x**2 - 
     &    29348.D0/81.D0*Hr2(1,1)*dx - 320.D0/3.D0*Hr2(1,1)*z2 + 320.D0/
     &    3.D0*Hr2(1,1)*z2*x + 704.D0/9.D0*Hr2(1,1)*z2*x**2 - 704.D0/9.D
     &    0*Hr2(1,1)*z2*dx - 1288.D0/9.D0*Hr3(-1,-1,0) - 1304.D0/9.D0*
     &    Hr3(-1,-1,0)*x + 3248.D0/27.D0*Hr3(-1,-1,0)*x**2 - 64.D0/5.D0
     &    *Hr3(-1,-1,0)*x**3 + 3680.D0/27.D0*Hr3(-1,-1,0)*dx + 64.D0/45.
     &    D0*Hr3(-1,-1,0)*dx**2 - 328.D0*Hr3(-1,0,0) - 776.D0/9.D0*Hr3(
     &    -1,0,0)*x - 6352.D0/27.D0*Hr3(-1,0,0)*x**2 + 64.D0/5.D0*Hr3(
     &    -1,0,0)*x**3 )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 13264.D0/27.D0*Hr3(-1,0,0)*dx
     &     - 64.D0/45.D0*Hr3(-1,0,0)*dx**2 - 760.D0/9.D0*Hr3(-1,0,1) + 
     &    232.D0/3.D0*Hr3(-1,0,1)*x - 2032.D0/27.D0*Hr3(-1,0,1)*x**2 + 
     &    64.D0/5.D0*Hr3(-1,0,1)*x**3 - 6784.D0/27.D0*Hr3(-1,0,1)*dx - 
     &    64.D0/45.D0*Hr3(-1,0,1)*dx**2 + 96.D0*Hr3(0,-1,-1)*z2 - 96.D0
     &    *Hr3(0,-1,-1)*z2*x - 568.D0*Hr3(0,-1,0) + 1256.D0/9.D0*Hr3(0,
     &    -1,0)*x - 5360.D0/27.D0*Hr3(0,-1,0)*x**2 + 64.D0/5.D0*Hr3(0,
     &    -1,0)*x**3 + 416.D0/9.D0*Hr3(0,-1,0)*dx + 208.D0/3.D0*Hr3(0,
     &    -1,0)*z2 - 208.D0/3.D0*Hr3(0,-1,0)*z2*x + 88.D0/3.D0*Hr3(0,0,
     &    -1)*z2 - 88.D0/3.D0*Hr3(0,0,-1)*z2*x - 23416.D0/27.D0*Hr3(0,0
     &    ,0) + 15644.D0/27.D0*Hr3(0,0,0)*x - 2792.D0/3.D0*Hr3(0,0,0)*
     &    x**2 - 64.D0/5.D0*Hr3(0,0,0)*x**3 + 320.D0/3.D0*Hr3(0,0,0)*z2
     &     - 688.D0/3.D0*Hr3(0,0,0)*z2*x - 101852.D0/135.D0*Hr3(0,0,1)
     &     - 13508.D0/135.D0*Hr3(0,0,1)*x - 91736.D0/135.D0*Hr3(0,0,1)*
     &    x**2 - 64.D0/5.D0*Hr3(0,0,1)*x**3 + 64.D0/15.D0*Hr3(0,0,1)*dx
     &     - 296.D0/3.D0*Hr3(0,0,1)*z2 )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 712.D0/3.D0*Hr3(0,0,1)*z2*x
     &     - 2788.D0/9.D0*Hr3(0,1,0) - 232.D0/9.D0*Hr3(0,1,0)*x - 3880.D
     &    0/9.D0*Hr3(0,1,0)*x**2 - 832.D0/9.D0*Hr3(0,1,0)*dx - 784.D0/3.
     &    D0*Hr3(0,1,0)*z2 - 784.D0/3.D0*Hr3(0,1,0)*z2*x - 11800.D0/27.D
     &    0*Hr3(0,1,1) - 2260.D0/27.D0*Hr3(0,1,1)*x - 10552.D0/27.D0*
     &    Hr3(0,1,1)*x**2 - 3280.D0/27.D0*Hr3(0,1,1)*dx - 448.D0/3.D0*
     &    Hr3(0,1,1)*z2 - 448.D0/3.D0*Hr3(0,1,1)*z2*x + 2444.D0/45.D0*
     &    Hr3(1,0,0) + 5956.D0/45.D0*Hr3(1,0,0)*x - 10168.D0/45.D0*Hr3(
     &    1,0,0)*x**2 + 1768.D0/45.D0*Hr3(1,0,0)*dx - 640.D0/9.D0*Hr3(1
     &    ,0,1) + 1648.D0/9.D0*Hr3(1,0,1)*x - 4504.D0/27.D0*Hr3(1,0,1)*
     &    x**2 + 1480.D0/27.D0*Hr3(1,0,1)*dx + 488.D0/9.D0*Hr3(1,1,0)
     &     + 232.D0/9.D0*Hr3(1,1,0)*x - 2696.D0/27.D0*Hr3(1,1,0)*x**2
     &     + 536.D0/27.D0*Hr3(1,1,0)*dx - 40.D0/3.D0*Hr3(1,1,1) + 328.D0
     &    /3.D0*Hr3(1,1,1)*x - 3368.D0/27.D0*Hr3(1,1,1)*x**2 + 776.D0/
     &    27.D0*Hr3(1,1,1)*dx + 368.D0/3.D0*Hr4(-1,-1,-1,0) + 368.D0/3.D
     &    0*Hr4(-1,-1,-1,0)*x )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 320.D0/9.D0*Hr4(-1,-1,-1,0)*
     &    x**2 - 320.D0/9.D0*Hr4(-1,-1,-1,0)*dx - 76.D0*Hr4(-1,-1,0,0)
     &     - 76.D0*Hr4(-1,-1,0,0)*x + 64.D0/3.D0*Hr4(-1,-1,0,0)*x**2 + 
     &    64.D0/3.D0*Hr4(-1,-1,0,0)*dx + 440.D0/3.D0*Hr4(-1,-1,0,1) + 
     &    440.D0/3.D0*Hr4(-1,-1,0,1)*x + 448.D0/9.D0*Hr4(-1,-1,0,1)*
     &    x**2 + 448.D0/9.D0*Hr4(-1,-1,0,1)*dx - 328.D0/3.D0*Hr4(-1,0,
     &    -1,0) - 328.D0/3.D0*Hr4(-1,0,-1,0)*x + 256.D0/9.D0*Hr4(-1,0,
     &    -1,0)*x**2 + 256.D0/9.D0*Hr4(-1,0,-1,0)*dx + 48.D0*Hr4(-1,0,0
     &    ,0) + 48.D0*Hr4(-1,0,0,0)*x + 416.D0/3.D0*Hr4(-1,0,0,0)*x**2
     &     + 416.D0/3.D0*Hr4(-1,0,0,0)*dx - 76.D0*Hr4(-1,0,0,1) - 76.D0
     &    *Hr4(-1,0,0,1)*x + 320.D0/3.D0*Hr4(-1,0,0,1)*x**2 + 320.D0/3.D
     &    0*Hr4(-1,0,0,1)*dx + 8.D0*Hr4(-1,0,1,0) + 8.D0*Hr4(-1,0,1,0)*
     &    x + 64.D0*Hr4(-1,0,1,0)*x**2 + 64.D0*Hr4(-1,0,1,0)*dx + 64.D0/
     &    3.D0*Hr4(-1,0,1,1) + 64.D0/3.D0*Hr4(-1,0,1,1)*x + 704.D0/9.D0
     &    *Hr4(-1,0,1,1)*x**2 + 704.D0/9.D0*Hr4(-1,0,1,1)*dx - 184.D0*
     &    Hr4(0,-1,-1,0) )
      c2qps3 = c2qps3 + nf*cf*ca * ( 88.D0*Hr4(0,-1,-1,0)*x - 64.D0/3.
     &    D0*Hr4(0,-1,-1,0)*x**2 + 128.D0/3.D0*Hr4(0,-1,-1,0)*dx + 1136.
     &    D0/3.D0*Hr4(0,-1,0,0) - 496.D0/3.D0*Hr4(0,-1,0,0)*x + 1792.D0/
     &    9.D0*Hr4(0,-1,0,0)*x**2 - 256.D0/3.D0*Hr4(0,-1,0,0)*dx + 168.D
     &    0*Hr4(0,-1,0,1) - 728.D0/3.D0*Hr4(0,-1,0,1)*x + 320.D0/3.D0*
     &    Hr4(0,-1,0,1)*x**2 - 128.D0/3.D0*Hr4(0,-1,0,1)*dx + 904.D0/3.D
     &    0*Hr4(0,0,-1,0) + 8.D0/3.D0*Hr4(0,0,-1,0)*x + 1664.D0/9.D0*
     &    Hr4(0,0,-1,0)*x**2 + 3416.D0/9.D0*Hr4(0,0,0,0) + 5360.D0/9.D0
     &    *Hr4(0,0,0,0)*x + 920.D0/9.D0*Hr4(0,0,0,1) + 2576.D0/9.D0*
     &    Hr4(0,0,0,1)*x + 128.D0/9.D0*Hr4(0,0,0,1)*x**2 - 192.D0/5.D0*
     &    Hr4(0,0,0,1)*x**3 + 28.D0*Hr4(0,0,1,0) + 476.D0/3.D0*Hr4(0,0,
     &    1,0)*x - 256.D0/3.D0*Hr4(0,0,1,0)*x**2 - 340.D0/9.D0*Hr4(0,0,
     &    1,1) + 1076.D0/9.D0*Hr4(0,0,1,1)*x - 832.D0/9.D0*Hr4(0,0,1,1)
     &    *x**2 + 68.D0/3.D0*Hr4(0,1,0,0) + 724.D0/3.D0*Hr4(0,1,0,0)*x
     &     - 1568.D0/9.D0*Hr4(0,1,0,0)*x**2 + 192.D0/5.D0*Hr4(0,1,0,0)*
     &    x**3 )
      c2qps3 = c2qps3 + nf*cf*ca * ( 128.D0/3.D0*Hr4(0,1,0,0)*dx - 40.
     &    D0/3.D0*Hr4(0,1,0,1) + 40.D0/3.D0*Hr4(0,1,0,1)*x - 224.D0/3.D0
     &    *Hr4(0,1,0,1)*x**2 + 160.D0/3.D0*Hr4(0,1,0,1)*dx + 40.D0/3.D0
     &    *Hr4(0,1,1,0) + 56.D0/3.D0*Hr4(0,1,1,0)*x - 992.D0/9.D0*Hr4(0
     &    ,1,1,0)*x**2 + 160.D0/3.D0*Hr4(0,1,1,0)*dx + 8.D0/9.D0*Hr4(0,
     &    1,1,1) + 176.D0/9.D0*Hr4(0,1,1,1)*x - 800.D0/9.D0*Hr4(0,1,1,1
     &    )*x**2 + 512.D0/9.D0*Hr4(0,1,1,1)*dx - 16.D0/3.D0*Hr4(1,0,-1,
     &    0) + 16.D0/3.D0*Hr4(1,0,-1,0)*x - 128.D0/9.D0*Hr4(1,0,-1,0)*
     &    x**2 + 128.D0/9.D0*Hr4(1,0,-1,0)*dx + 608.D0/3.D0*Hr4(1,0,0,0
     &    ) - 608.D0/3.D0*Hr4(1,0,0,0)*x - 896.D0/9.D0*Hr4(1,0,0,0)*
     &    x**2 + 896.D0/9.D0*Hr4(1,0,0,0)*dx + 740.D0/3.D0*Hr4(1,0,0,1)
     &     - 268.D0*Hr4(1,0,0,1)*x - 128.D0/9.D0*Hr4(1,0,0,1)*x**2 - 
     &    192.D0/5.D0*Hr4(1,0,0,1)*x**3 + 704.D0/9.D0*Hr4(1,0,0,1)*dx
     &     - 64.D0/15.D0*Hr4(1,0,0,1)*dx**2 + 52.D0*Hr4(1,0,1,0) - 52.D0
     &    *Hr4(1,0,1,0)*x - 64.D0*Hr4(1,0,1,0)*x**2 + 64.D0*Hr4(1,0,1,0
     &    )*dx )
      c2qps3 = c2qps3 + nf*cf*ca * ( 40.D0*Hr4(1,0,1,1) - 40.D0*Hr4(1
     &    ,0,1,1)*x - 160.D0/3.D0*Hr4(1,0,1,1)*x**2 + 160.D0/3.D0*Hr4(1
     &    ,0,1,1)*dx - 220.D0/3.D0*Hr4(1,1,0,0) + 284.D0/3.D0*Hr4(1,1,0
     &    ,0)*x - 1280.D0/9.D0*Hr4(1,1,0,0)*x**2 + 192.D0/5.D0*Hr4(1,1,
     &    0,0)*x**3 + 704.D0/9.D0*Hr4(1,1,0,0)*dx + 64.D0/15.D0*Hr4(1,1
     &    ,0,0)*dx**2 + 136.D0/3.D0*Hr4(1,1,0,1) - 136.D0/3.D0*Hr4(1,1,
     &    0,1)*x - 544.D0/9.D0*Hr4(1,1,0,1)*x**2 + 544.D0/9.D0*Hr4(1,1,
     &    0,1)*dx + 136.D0/3.D0*Hr4(1,1,1,0) - 136.D0/3.D0*Hr4(1,1,1,0)
     &    *x - 544.D0/9.D0*Hr4(1,1,1,0)*x**2 + 544.D0/9.D0*Hr4(1,1,1,0)
     &    *dx + 112.D0/3.D0*Hr4(1,1,1,1) - 112.D0/3.D0*Hr4(1,1,1,1)*x
     &     - 448.D0/9.D0*Hr4(1,1,1,1)*x**2 + 448.D0/9.D0*Hr4(1,1,1,1)*
     &    dx + 352.D0/3.D0*Hr5(0,-1,-1,-1,0) - 352.D0/3.D0*Hr5(0,-1,-1,
     &    -1,0)*x - 344.D0/3.D0*Hr5(0,-1,-1,0,0) + 344.D0/3.D0*Hr5(0,-1
     &    ,-1,0,0)*x - 112.D0/3.D0*Hr5(0,-1,-1,0,1) + 112.D0/3.D0*Hr5(0
     &    ,-1,-1,0,1)*x - 304.D0/3.D0*Hr5(0,-1,0,-1,0) + 304.D0/3.D0*
     &    Hr5(0,-1,0,-1,0)*x )
      c2qps3 = c2qps3 + nf*cf*ca * (  - 320.D0/3.D0*Hr5(0,-1,0,0,0)
     &     + 320.D0/3.D0*Hr5(0,-1,0,0,0)*x - 344.D0/3.D0*Hr5(0,-1,0,0,1
     &    ) + 344.D0/3.D0*Hr5(0,-1,0,0,1)*x - 176.D0/3.D0*Hr5(0,-1,0,1,
     &    0) + 176.D0/3.D0*Hr5(0,-1,0,1,0)*x - 64.D0*Hr5(0,-1,0,1,1) + 
     &    64.D0*Hr5(0,-1,0,1,1)*x - 176.D0/3.D0*Hr5(0,0,-1,-1,0) + 368.D
     &    0/3.D0*Hr5(0,0,-1,-1,0)*x - 320.D0/3.D0*Hr5(0,0,-1,0,0) + 112.
     &    D0/3.D0*Hr5(0,0,-1,0,0)*x - 176.D0/3.D0*Hr5(0,0,-1,0,1) + 272.
     &    D0/3.D0*Hr5(0,0,-1,0,1)*x - 496.D0/3.D0*Hr5(0,0,0,-1,0) + 112.
     &    D0/3.D0*Hr5(0,0,0,-1,0)*x - 240.D0*Hr5(0,0,0,0,0) + 240.D0*
     &    Hr5(0,0,0,0,0)*x - 320.D0/3.D0*Hr5(0,0,0,0,1) + 800.D0/3.D0*
     &    Hr5(0,0,0,0,1)*x + 8.D0*Hr5(0,0,0,1,0) + 232.D0*Hr5(0,0,0,1,0
     &    )*x + 88.D0/3.D0*Hr5(0,0,0,1,1) + 760.D0/3.D0*Hr5(0,0,0,1,1)*
     &    x + 104.D0*Hr5(0,0,1,0,0) + 664.D0/3.D0*Hr5(0,0,1,0,0)*x + 
     &    208.D0/3.D0*Hr5(0,0,1,0,1) + 176.D0*Hr5(0,0,1,0,1)*x + 368.D0/
     &    3.D0*Hr5(0,0,1,1,0) + 208.D0*Hr5(0,0,1,1,0)*x + 304.D0/3.D0*
     &    Hr5(0,0,1,1,1) )
      c2qps3 = c2qps3 + nf*cf*ca * ( 592.D0/3.D0*Hr5(0,0,1,1,1)*x + 
     &    32.D0/3.D0*Hr5(0,1,0,-1,0) + 32.D0/3.D0*Hr5(0,1,0,-1,0)*x + 
     &    704.D0/3.D0*Hr5(0,1,0,0,0) + 704.D0/3.D0*Hr5(0,1,0,0,0)*x + 
     &    216.D0*Hr5(0,1,0,0,1) + 216.D0*Hr5(0,1,0,0,1)*x + 296.D0/3.D0
     &    *Hr5(0,1,0,1,0) + 296.D0/3.D0*Hr5(0,1,0,1,0)*x + 80.D0*Hr5(0,
     &    1,0,1,1) + 80.D0*Hr5(0,1,0,1,1)*x + 56.D0*Hr5(0,1,1,0,0) + 56.
     &    D0*Hr5(0,1,1,0,0)*x + 272.D0/3.D0*Hr5(0,1,1,0,1) + 272.D0/3.D0
     &    *Hr5(0,1,1,0,1)*x + 272.D0/3.D0*Hr5(0,1,1,1,0) + 272.D0/3.D0*
     &    Hr5(0,1,1,1,0)*x + 224.D0/3.D0*Hr5(0,1,1,1,1) + 224.D0/3.D0*
     &    Hr5(0,1,1,1,1)*x )
      c2qps3 = c2qps3 + nf*cf**2 * ( 186998.D0/2025.D0 - 1089248.D0/
     &    2025.D0*x + 276604.D0/675.D0*x**2 + 176.D0*z5 + 176.D0*z5*x
     &     + 184.D0*z4 + 668.D0*z4*x - 5008.D0/9.D0*z4*x**2 + 768.D0/5.D
     &    0*z4*x**3 + 24146.D0/675.D0*dx + 96.D0*dx*z4 - 17752.D0/45.D0
     &    *z3 - 36796.D0/15.D0*z3*x - 26768.D0/135.D0*z3*x**2 - 16.D0*
     &    z3*x**3 - 4384.D0/45.D0*z3*dx - 123476.D0/135.D0*z2 - 41204.D0
     &    /135.D0*z2*x + 58312.D0/405.D0*z2*x**2 + 544.D0/75.D0*z2*x**3
     &     - 208.D0/9.D0*z2*dx + 144.D0*z2*z3 + 16.D0*z2*z3*x + 256.D0*
     &    Hr1(-1)*z3 + 256.D0*Hr1(-1)*z3*x - 64.D0*Hr1(-1)*z3*x**2 - 64.
     &    D0*Hr1(-1)*z3*dx + 1528.D0*Hr1(-1)*z2 + 4744.D0/3.D0*Hr1(-1)*
     &    z2*x + 1232.D0/9.D0*Hr1(-1)*z2*x**2 + 48.D0/5.D0*Hr1(-1)*z2*
     &    x**3 + 656.D0/9.D0*Hr1(-1)*z2*dx - 16.D0/15.D0*Hr1(-1)*z2*
     &    dx**2 + 514634.D0/2025.D0*Hr1(0) - 3262136.D0/2025.D0*Hr1(0)*
     &    x + 303352.D0/2025.D0*Hr1(0)*x**2 + 724.D0/3.D0*Hr1(0)*z4 + 
     &    964.D0/3.D0*Hr1(0)*z4*x + 1184.D0/675.D0*Hr1(0)*dx - 80.D0/3.D
     &    0*Hr1(0)*z3 )
      c2qps3 = c2qps3 + nf*cf**2 * ( 848.D0/3.D0*Hr1(0)*z3*x + 1088.D0
     &    /9.D0*Hr1(0)*z3*x**2 + 384.D0/5.D0*Hr1(0)*z3*x**3 - 48028.D0/
     &    45.D0*Hr1(0)*z2 - 74732.D0/45.D0*Hr1(0)*z2*x + 13216.D0/45.D0
     &    *Hr1(0)*z2*x**2 - 64.D0/5.D0*Hr1(0)*z2*x**3 + 128.D0/15.D0*
     &    Hr1(0)*z2*dx + 593936.D0/405.D0*Hr1(1) - 529946.D0/405.D0*
     &    Hr1(1)*x - 12352.D0/405.D0*Hr1(1)*x**2 - 51638.D0/405.D0*Hr1(
     &    1)*dx + 680.D0/3.D0*Hr1(1)*z3 - 184.D0*Hr1(1)*z3*x - 1280.D0/
     &    9.D0*Hr1(1)*z3*x**2 + 384.D0/5.D0*Hr1(1)*z3*x**3 + 128.D0/9.D0
     &    *Hr1(1)*z3*dx + 128.D0/15.D0*Hr1(1)*z3*dx**2 - 172.D0/9.D0*
     &    Hr1(1)*z2 + 116.D0/3.D0*Hr1(1)*z2*x - 112.D0/27.D0*Hr1(1)*z2*
     &    x**2 - 16.D0/5.D0*Hr1(1)*z2*x**3 - 320.D0/27.D0*Hr1(1)*z2*dx
     &     - 16.D0/45.D0*Hr1(1)*z2*dx**2 - 224.D0*Hr2(-1,-1)*z2 - 224.D0
     &    *Hr2(-1,-1)*z2*x + 96.D0*Hr2(-1,-1)*z2*x**2 + 96.D0*Hr2(-1,-1
     &    )*z2*dx - 47216.D0/45.D0*Hr2(-1,0) - 134368.D0/135.D0*Hr2(-1,
     &    0)*x + 704.D0/15.D0*Hr2(-1,0)*x**2 + 544.D0/75.D0*Hr2(-1,0)*
     &    x**3 )
      c2qps3 = c2qps3 + nf*cf**2 * (  - 688.D0/45.D0*Hr2(-1,0)*dx - 
     &    704.D0/675.D0*Hr2(-1,0)*dx**2 + 352.D0*Hr2(-1,0)*z2 + 352.D0*
     &    Hr2(-1,0)*z2*x - 32.D0/3.D0*Hr2(-1,0)*z2*x**2 - 32.D0/3.D0*
     &    Hr2(-1,0)*z2*dx + 224.D0*Hr2(0,-1)*z3 - 224.D0*Hr2(0,-1)*z3*x
     &     + 624.D0*Hr2(0,-1)*z2 - 176.D0*Hr2(0,-1)*z2*x - 224.D0/3.D0*
     &    Hr2(0,-1)*z2*x**2 - 1066.D0/27.D0*Hr2(0,0) + 190.D0/3.D0*Hr2(
     &    0,0)*x + 872.D0/81.D0*Hr2(0,0)*x**2 - 544.D0/75.D0*Hr2(0,0)*
     &    x**3 + 32.D0/15.D0*Hr2(0,0)*dx - 640.D0/3.D0*Hr2(0,0)*z3 - 
     &    256.D0/3.D0*Hr2(0,0)*z3*x - 512.D0/3.D0*Hr2(0,0)*z2 - 2320.D0/
     &    3.D0*Hr2(0,0)*z2*x + 5824.D0/9.D0*Hr2(0,0)*z2*x**2 - 384.D0/5.
     &    D0*Hr2(0,0)*z2*x**3 + 123476.D0/135.D0*Hr2(0,1) - 93164.D0/
     &    135.D0*Hr2(0,1)*x - 58312.D0/405.D0*Hr2(0,1)*x**2 + 352.D0/45.
     &    D0*Hr2(0,1)*dx + 496.D0/3.D0*Hr2(0,1)*z3 + 496.D0/3.D0*Hr2(0,
     &    1)*z3*x + 40.D0/3.D0*Hr2(0,1)*z2 - 72.D0*Hr2(0,1)*z2*x + 640.D
     &    0/3.D0*Hr2(0,1)*z2*x**2 + 18868.D0/27.D0*Hr2(1,0) - 24436.D0/
     &    27.D0*Hr2(1,0)*x )
      c2qps3 = c2qps3 + nf*cf**2 * ( 11000.D0/81.D0*Hr2(1,0)*x**2 + 
     &    5704.D0/81.D0*Hr2(1,0)*dx + 1280.D0/3.D0*Hr2(1,0)*z2 - 1408.D0
     &    /3.D0*Hr2(1,0)*z2*x + 1312.D0/9.D0*Hr2(1,0)*z2*x**2 - 384.D0/
     &    5.D0*Hr2(1,0)*z2*x**3 - 160.D0/9.D0*Hr2(1,0)*z2*dx - 128.D0/
     &    15.D0*Hr2(1,0)*z2*dx**2 + 8684.D0/9.D0*Hr2(1,1) - 9760.D0/9.D0
     &    *Hr2(1,1)*x + 4168.D0/81.D0*Hr2(1,1)*x**2 + 5516.D0/81.D0*
     &    Hr2(1,1)*dx + 280.D0/3.D0*Hr2(1,1)*z2 - 280.D0/3.D0*Hr2(1,1)*
     &    z2*x + 512.D0/9.D0*Hr2(1,1)*z2*x**2 - 512.D0/9.D0*Hr2(1,1)*z2
     &    *dx + 1104.D0*Hr3(-1,-1,0) + 9872.D0/9.D0*Hr3(-1,-1,0)*x + 
     &    992.D0/9.D0*Hr3(-1,-1,0)*x**2 + 32.D0/5.D0*Hr3(-1,-1,0)*x**3
     &     + 992.D0/9.D0*Hr3(-1,-1,0)*dx - 32.D0/45.D0*Hr3(-1,-1,0)*
     &    dx**2 - 5392.D0/3.D0*Hr3(-1,0,0) - 5552.D0/3.D0*Hr3(-1,0,0)*x
     &     - 96.D0*Hr3(-1,0,0)*x**2 + 96.D0/5.D0*Hr3(-1,0,0)*x**3 - 64.D
     &    0*Hr3(-1,0,0)*dx - 32.D0/15.D0*Hr3(-1,0,0)*dx**2 - 976.D0*
     &    Hr3(-1,0,1) - 9296.D0/9.D0*Hr3(-1,0,1)*x - 736.D0/9.D0*Hr3(-1
     &    ,0,1)*x**2 )
      c2qps3 = c2qps3 + nf*cf**2 * (  - 32.D0/5.D0*Hr3(-1,0,1)*x**3
     &     - 160.D0/9.D0*Hr3(-1,0,1)*dx + 32.D0/45.D0*Hr3(-1,0,1)*dx**2
     &     - 256.D0*Hr3(0,-1,-1)*z2 + 256.D0*Hr3(0,-1,-1)*z2*x - 912.D0
     &    *Hr3(0,-1,0) - 6736.D0/9.D0*Hr3(0,-1,0)*x - 992.D0/9.D0*Hr3(0
     &    ,-1,0)*x**2 - 32.D0/5.D0*Hr3(0,-1,0)*x**3 - 128.D0/45.D0*Hr3(
     &    0,-1,0)*dx**2 + 192.D0*Hr3(0,-1,0)*z2 - 192.D0*Hr3(0,-1,0)*z2
     &    *x + 448.D0*Hr3(0,0,-1)*z2 + 5180.D0/9.D0*Hr3(0,0,0) + 3212.D0
     &    /3.D0*Hr3(0,0,0)*x - 1952.D0/9.D0*Hr3(0,0,0)*x**2 - 96.D0/5.D0
     &    *Hr3(0,0,0)*x**3 - 1328.D0/3.D0*Hr3(0,0,0)*z2 - 1328.D0/3.D0*
     &    Hr3(0,0,0)*z2*x + 48028.D0/45.D0*Hr3(0,0,1) + 13684.D0/15.D0*
     &    Hr3(0,0,1)*x - 13216.D0/45.D0*Hr3(0,0,1)*x**2 + 32.D0/5.D0*
     &    Hr3(0,0,1)*x**3 - 128.D0/15.D0*Hr3(0,0,1)*dx - 96.D0*Hr3(0,0,
     &    1)*z2 - 160.D0*Hr3(0,0,1)*z2*x + 6256.D0/9.D0*Hr3(0,1,0) - 
     &    3136.D0/9.D0*Hr3(0,1,0)*x - 3712.D0/27.D0*Hr3(0,1,0)*x**2 + 
     &    640.D0/3.D0*Hr3(0,1,0)*z2 + 640.D0/3.D0*Hr3(0,1,0)*z2*x + 
     &    2540.D0/3.D0*Hr3(0,1,1) )
      c2qps3 = c2qps3 + nf*cf**2 * (  - 736.D0/3.D0*Hr3(0,1,1)*x - 
     &    4288.D0/27.D0*Hr3(0,1,1)*x**2 - 16.D0/3.D0*Hr3(0,1,1)*z2 - 16.
     &    D0/3.D0*Hr3(0,1,1)*z2*x + 16792.D0/45.D0*Hr3(1,0,0) - 22792.D0
     &    /45.D0*Hr3(1,0,0)*x + 13888.D0/135.D0*Hr3(1,0,0)*x**2 + 4112.D
     &    0/135.D0*Hr3(1,0,0)*dx + 5140.D0/9.D0*Hr3(1,0,1) - 5284.D0/9.D
     &    0*Hr3(1,0,1)*x + 1600.D0/27.D0*Hr3(1,0,1)*x**2 - 1168.D0/27.D0
     &    *Hr3(1,0,1)*dx + 3892.D0/9.D0*Hr3(1,1,0) - 3748.D0/9.D0*Hr3(1
     &    ,1,0)*x - 128.D0/27.D0*Hr3(1,1,0)*x**2 - 304.D0/27.D0*Hr3(1,1
     &    ,0)*dx + 3904.D0/9.D0*Hr3(1,1,1) - 3904.D0/9.D0*Hr3(1,1,1)*x
     &     - 64.D0/9.D0*Hr3(1,1,1)*x**2 + 64.D0/9.D0*Hr3(1,1,1)*dx - 
     &    320.D0*Hr4(-1,-1,-1,0) - 320.D0*Hr4(-1,-1,-1,0)*x + 64.D0*
     &    Hr4(-1,-1,-1,0)*x**2 + 64.D0*Hr4(-1,-1,-1,0)*dx + 576.D0*Hr4(
     &    -1,-1,0,0) + 576.D0*Hr4(-1,-1,0,0)*x - 320.D0/3.D0*Hr4(-1,-1,
     &    0,0)*x**2 - 320.D0/3.D0*Hr4(-1,-1,0,0)*dx + 64.D0*Hr4(-1,-1,0
     &    ,1) + 64.D0*Hr4(-1,-1,0,1)*x - 64.D0*Hr4(-1,-1,0,1)*x**2 - 64.
     &    D0*Hr4(-1,-1,0,1)*dx )
      c2qps3 = c2qps3 + nf*cf**2 * ( 320.D0*Hr4(-1,0,-1,0) + 320.D0*
     &    Hr4(-1,0,-1,0)*x - 64.D0*Hr4(-1,0,-1,0)*x**2 - 64.D0*Hr4(-1,0
     &    ,-1,0)*dx - 448.D0*Hr4(-1,0,0,0) - 448.D0*Hr4(-1,0,0,0)*x + 
     &    64.D0/3.D0*Hr4(-1,0,0,0)*x**2 + 64.D0/3.D0*Hr4(-1,0,0,0)*dx
     &     - 192.D0*Hr4(-1,0,0,1) - 192.D0*Hr4(-1,0,0,1)*x - 64.D0/3.D0
     &    *Hr4(-1,0,0,1)*x**2 - 64.D0/3.D0*Hr4(-1,0,0,1)*dx - 64.D0*
     &    Hr4(-1,0,1,0) - 64.D0*Hr4(-1,0,1,0)*x - 64.D0/3.D0*Hr4(-1,0,1
     &    ,0)*x**2 - 64.D0/3.D0*Hr4(-1,0,1,0)*dx - 64.D0*Hr4(-1,0,1,1)
     &     - 64.D0*Hr4(-1,0,1,1)*x - 64.D0/3.D0*Hr4(-1,0,1,1)*x**2 - 64.
     &    D0/3.D0*Hr4(-1,0,1,1)*dx + 416.D0*Hr4(0,-1,-1,0) + 160.D0/3.D0
     &    *Hr4(0,-1,-1,0)*x - 320.D0/3.D0*Hr4(0,-1,-1,0)*x**2 - 736.D0*
     &    Hr4(0,-1,0,0) - 32.D0*Hr4(0,-1,0,0)*x + 320.D0/3.D0*Hr4(0,-1,
     &    0,0)*x**2 - 416.D0*Hr4(0,-1,0,1) + 608.D0/3.D0*Hr4(0,-1,0,1)*
     &    x + 64.D0/3.D0*Hr4(0,-1,0,1)*x**2 - 352.D0*Hr4(0,0,-1,0) - 
     &    160.D0/3.D0*Hr4(0,0,-1,0)*x + 320.D0/3.D0*Hr4(0,0,-1,0)*x**2
     &     - 440.D0/3.D0*Hr4(0,0,0,0) )
      c2qps3 = c2qps3 + nf*cf**2 * ( 880.D0/3.D0*Hr4(0,0,0,0)*x - 
     &    3808.D0/9.D0*Hr4(0,0,0,0)*x**2 + 512.D0/3.D0*Hr4(0,0,0,1) + 
     &    720.D0*Hr4(0,0,0,1)*x - 5824.D0/9.D0*Hr4(0,0,0,1)*x**2 + 384.D
     &    0/5.D0*Hr4(0,0,0,1)*x**3 + 584.D0/3.D0*Hr4(0,0,1,0) + 216.D0*
     &    Hr4(0,0,1,0)*x - 3328.D0/9.D0*Hr4(0,0,1,0)*x**2 + 880.D0/3.D0
     &    *Hr4(0,0,1,1) + 320.D0*Hr4(0,0,1,1)*x - 3488.D0/9.D0*Hr4(0,0,
     &    1,1)*x**2 + 448.D0/3.D0*Hr4(0,1,0,0) - 304.D0*Hr4(0,1,0,0)*x
     &     - 64.D0*Hr4(0,1,0,0)*x**2 - 384.D0/5.D0*Hr4(0,1,0,0)*x**3 + 
     &    584.D0/3.D0*Hr4(0,1,0,1) + 136.D0/3.D0*Hr4(0,1,0,1)*x - 800.D0
     &    /3.D0*Hr4(0,1,0,1)*x**2 + 488.D0/3.D0*Hr4(0,1,1,0) + 40.D0/3.D
     &    0*Hr4(0,1,1,0)*x - 224.D0*Hr4(0,1,1,0)*x**2 + 192.D0*Hr4(0,1,
     &    1,1) + 160.D0/3.D0*Hr4(0,1,1,1)*x - 1856.D0/9.D0*Hr4(0,1,1,1)
     &    *x**2 - 632.D0/3.D0*Hr4(1,0,0,0) + 632.D0/3.D0*Hr4(1,0,0,0)*x
     &     + 224.D0/9.D0*Hr4(1,0,0,0)*x**2 - 224.D0/9.D0*Hr4(1,0,0,0)*
     &    dx - 800.D0/3.D0*Hr4(1,0,0,1) + 928.D0/3.D0*Hr4(1,0,0,1)*x - 
     &    1600.D0/9.D0*Hr4(1,0,0,1)*x**2 )
      c2qps3 = c2qps3 + nf*cf**2 * ( 384.D0/5.D0*Hr4(1,0,0,1)*x**3 + 
     &    448.D0/9.D0*Hr4(1,0,0,1)*dx + 128.D0/15.D0*Hr4(1,0,0,1)*dx**2
     &     + 224.D0/3.D0*Hr4(1,0,1,0) - 224.D0/3.D0*Hr4(1,0,1,0)*x - 
     &    896.D0/9.D0*Hr4(1,0,1,0)*x**2 + 896.D0/9.D0*Hr4(1,0,1,0)*dx
     &     + 72.D0*Hr4(1,0,1,1) - 72.D0*Hr4(1,0,1,1)*x - 96.D0*Hr4(1,0,
     &    1,1)*x**2 + 96.D0*Hr4(1,0,1,1)*dx + 832.D0/3.D0*Hr4(1,1,0,0)
     &     - 320.D0*Hr4(1,1,0,0)*x + 320.D0/9.D0*Hr4(1,1,0,0)*x**2 - 
     &    384.D0/5.D0*Hr4(1,1,0,0)*x**3 + 832.D0/9.D0*Hr4(1,1,0,0)*dx
     &     - 128.D0/15.D0*Hr4(1,1,0,0)*dx**2 + 200.D0/3.D0*Hr4(1,1,0,1)
     &     - 200.D0/3.D0*Hr4(1,1,0,1)*x - 800.D0/9.D0*Hr4(1,1,0,1)*x**2
     &     + 800.D0/9.D0*Hr4(1,1,0,1)*dx + 200.D0/3.D0*Hr4(1,1,1,0) - 
     &    200.D0/3.D0*Hr4(1,1,1,0)*x - 800.D0/9.D0*Hr4(1,1,1,0)*x**2 + 
     &    800.D0/9.D0*Hr4(1,1,1,0)*dx + 176.D0/3.D0*Hr4(1,1,1,1) - 176.D
     &    0/3.D0*Hr4(1,1,1,1)*x - 704.D0/9.D0*Hr4(1,1,1,1)*x**2 + 704.D0
     &    /9.D0*Hr4(1,1,1,1)*dx - 256.D0*Hr5(0,-1,-1,-1,0) + 256.D0*
     &    Hr5(0,-1,-1,-1,0)*x )
      c2qps3 = c2qps3 + nf*cf**2 * ( 448.D0*Hr5(0,-1,-1,0,0) - 448.D0
     &    *Hr5(0,-1,-1,0,0)*x + 128.D0*Hr5(0,-1,-1,0,1) - 128.D0*Hr5(0,
     &    -1,-1,0,1)*x + 256.D0*Hr5(0,-1,0,-1,0) - 256.D0*Hr5(0,-1,0,-1
     &    ,0)*x - 256.D0*Hr5(0,-1,0,0,0) + 256.D0*Hr5(0,-1,0,0,0)*x - 
     &    64.D0*Hr5(0,-1,0,0,1) + 64.D0*Hr5(0,-1,0,0,1)*x + 384.D0*Hr5(
     &    0,0,-1,-1,0) - 256.D0*Hr5(0,0,-1,-1,0)*x - 576.D0*Hr5(0,0,-1,
     &    0,0) + 64.D0*Hr5(0,0,-1,0,0)*x - 256.D0*Hr5(0,0,-1,0,1) - 128.
     &    D0*Hr5(0,0,-1,0,1)*x - 384.D0*Hr5(0,0,0,-1,0) + 240.D0*Hr5(0,
     &    0,0,0,0) + 240.D0*Hr5(0,0,0,0,0)*x + 1328.D0/3.D0*Hr5(0,0,0,0
     &    ,1) + 1328.D0/3.D0*Hr5(0,0,0,0,1)*x + 1072.D0/3.D0*Hr5(0,0,0,
     &    1,0) + 1072.D0/3.D0*Hr5(0,0,0,1,0)*x + 400.D0*Hr5(0,0,0,1,1)
     &     + 400.D0*Hr5(0,0,0,1,1)*x + 544.D0/3.D0*Hr5(0,0,1,0,0) + 544.
     &    D0/3.D0*Hr5(0,0,1,0,0)*x + 288.D0*Hr5(0,0,1,0,1) + 288.D0*
     &    Hr5(0,0,1,0,1)*x + 736.D0/3.D0*Hr5(0,0,1,1,0) + 736.D0/3.D0*
     &    Hr5(0,0,1,1,0)*x + 704.D0/3.D0*Hr5(0,0,1,1,1) + 704.D0/3.D0*
     &    Hr5(0,0,1,1,1)*x )
      c2qps3 = c2qps3 + nf*cf**2 * (  - 496.D0/3.D0*Hr5(0,1,0,0,0) - 
     &    496.D0/3.D0*Hr5(0,1,0,0,0)*x - 256.D0/3.D0*Hr5(0,1,0,0,1) - 
     &    256.D0/3.D0*Hr5(0,1,0,0,1)*x + 448.D0/3.D0*Hr5(0,1,0,1,0) + 
     &    448.D0/3.D0*Hr5(0,1,0,1,0)*x + 144.D0*Hr5(0,1,0,1,1) + 144.D0
     &    *Hr5(0,1,0,1,1)*x + 704.D0/3.D0*Hr5(0,1,1,0,0) + 704.D0/3.D0*
     &    Hr5(0,1,1,0,0)*x + 400.D0/3.D0*Hr5(0,1,1,0,1) + 400.D0/3.D0*
     &    Hr5(0,1,1,0,1)*x + 400.D0/3.D0*Hr5(0,1,1,1,0) + 400.D0/3.D0*
     &    Hr5(0,1,1,1,0)*x + 352.D0/3.D0*Hr5(0,1,1,1,1) + 352.D0/3.D0*
     &    Hr5(0,1,1,1,1)*x )
      c2qps3 = c2qps3 + nf2*cf * (  - 311984.D0/1215.D0 + 224864.D0/
     &    1215.D0*x + 153392.D0/3645.D0*x**2 + 28.D0/3.D0*z4 + 28.D0/3.D
     &    0*z4*x + 107968.D0/3645.D0*dx + 328.D0/27.D0*z3 + 136.D0/27.D0
     &    *z3*x + 160.D0/27.D0*z3*x**2 + 128.D0/27.D0*z3*dx + 1832.D0/
     &    81.D0*z2 + 9176.D0/81.D0*z2*x - 176.D0/9.D0*z2*x**2 + 32.D0/5.
     &    D0*z2*x**3 - 32.D0/9.D0*z2*dx - 219832.D0/1215.D0*Hr1(0) - 
     &    51352.D0/1215.D0*Hr1(0)*x + 46688.D0/405.D0*Hr1(0)*x**2 + 32.D
     &    0/45.D0*Hr1(0)*dx - 16.D0/9.D0*Hr1(0)*z3 - 16.D0/9.D0*Hr1(0)*
     &    z3*x + 848.D0/27.D0*Hr1(0)*z2 + 992.D0/27.D0*Hr1(0)*z2*x + 32.
     &    D0/9.D0*Hr1(0)*z2*x**2 - 4280.D0/81.D0*Hr1(1) + 2120.D0/81.D0
     &    *Hr1(1)*x + 2048.D0/81.D0*Hr1(1)*x**2 + 112.D0/81.D0*Hr1(1)*
     &    dx - 8.D0/3.D0*Hr1(1)*z2 + 8.D0/3.D0*Hr1(1)*z2*x + 32.D0/9.D0
     &    *Hr1(1)*z2*x**2 - 32.D0/9.D0*Hr1(1)*z2*dx + 512.D0/9.D0*Hr2(
     &    -1,0) + 640.D0/9.D0*Hr2(-1,0)*x + 160.D0/9.D0*Hr2(-1,0)*x**2
     &     + 32.D0/5.D0*Hr2(-1,0)*x**3 - 32.D0/9.D0*Hr2(-1,0)*dx - 32.D0
     &    /45.D0*Hr2(-1,0)*dx**2 )
      c2qps3 = c2qps3 + nf2*cf * (  - 12608.D0/81.D0*Hr2(0,0) - 
     &    18080.D0/81.D0*Hr2(0,0)*x + 1744.D0/27.D0*Hr2(0,0)*x**2 - 32.D
     &    0/5.D0*Hr2(0,0)*x**3 + 32.D0/9.D0*Hr2(0,0)*z2 + 32.D0/9.D0*
     &    Hr2(0,0)*z2*x - 1832.D0/81.D0*Hr2(0,1) - 3416.D0/81.D0*Hr2(0,
     &    1)*x + 176.D0/9.D0*Hr2(0,1)*x**2 - 16.D0/3.D0*Hr2(0,1)*z2 - 
     &    16.D0/3.D0*Hr2(0,1)*z2*x - 8.D0*Hr2(1,0) + 8.D0/3.D0*Hr2(1,0)
     &    *x + 304.D0/27.D0*Hr2(1,0)*x**2 - 160.D0/27.D0*Hr2(1,0)*dx + 
     &    200.D0/9.D0*Hr2(1,1) - 200.D0/9.D0*Hr2(1,1)*x + 944.D0/81.D0*
     &    Hr2(1,1)*x**2 - 944.D0/81.D0*Hr2(1,1)*dx + 128.D0/3.D0*Hr3(-1
     &    ,0,0) + 128.D0/3.D0*Hr3(-1,0,0)*x + 128.D0/9.D0*Hr3(-1,0,0)*
     &    x**2 + 128.D0/9.D0*Hr3(-1,0,0)*dx + 128.D0/3.D0*Hr3(0,-1,0)
     &     + 128.D0/9.D0*Hr3(0,-1,0)*x**2 - 1784.D0/27.D0*Hr3(0,0,0) - 
     &    4376.D0/27.D0*Hr3(0,0,0)*x + 256.D0/9.D0*Hr3(0,0,0)*x**2 - 
     &    848.D0/27.D0*Hr3(0,0,1) - 992.D0/27.D0*Hr3(0,0,1)*x - 32.D0/9.
     &    D0*Hr3(0,0,1)*x**2 - 128.D0/9.D0*Hr3(0,1,0) - 176.D0/9.D0*
     &    Hr3(0,1,0)*x )
      c2qps3 = c2qps3 + nf2*cf * (  - 32.D0/9.D0*Hr3(0,1,0)*x**2 - 
     &    152.D0/27.D0*Hr3(0,1,1) - 296.D0/27.D0*Hr3(0,1,1)*x - 128.D0/
     &    9.D0*Hr3(0,1,1)*x**2 + 8.D0/3.D0*Hr3(1,0,1) - 8.D0/3.D0*Hr3(1
     &    ,0,1)*x - 32.D0/9.D0*Hr3(1,0,1)*x**2 + 32.D0/9.D0*Hr3(1,0,1)*
     &    dx + 8.D0/3.D0*Hr3(1,1,0) - 8.D0/3.D0*Hr3(1,1,0)*x - 32.D0/9.D
     &    0*Hr3(1,1,0)*x**2 + 32.D0/9.D0*Hr3(1,1,0)*dx + 32.D0/9.D0*
     &    Hr3(1,1,1) - 32.D0/9.D0*Hr3(1,1,1)*x - 128.D0/27.D0*Hr3(1,1,1
     &    )*x**2 + 128.D0/27.D0*Hr3(1,1,1)*dx - 368.D0/9.D0*Hr4(0,0,0,0
     &    ) - 368.D0/9.D0*Hr4(0,0,0,0)*x - 32.D0/9.D0*Hr4(0,0,0,1) - 32.
     &    D0/9.D0*Hr4(0,0,0,1)*x + 112.D0/9.D0*Hr4(0,0,1,1) + 112.D0/9.D
     &    0*Hr4(0,0,1,1)*x + 16.D0/3.D0*Hr4(0,1,0,1) + 16.D0/3.D0*Hr4(0
     &    ,1,0,1)*x + 16.D0/3.D0*Hr4(0,1,1,0) + 16.D0/3.D0*Hr4(0,1,1,0)
     &    *x + 64.D0/9.D0*Hr4(0,1,1,1) + 64.D0/9.D0*Hr4(0,1,1,1)*x )
*
       endif

       if(CC.eq.1) then
              X2S3A = C2QPS3 
       else
              X2S3A = C2QQ3
       endif
*      
       RETURN
       END
*
* ---------------------------------------------------------------------
*
*
* ..This is the 'local' piece due to the fl11 contribution.
*
       FUNCTION X2S3C (Y, NF)
*
       IMPLICIT REAL*8 (A - Z)
       INTEGER NF, NF2
       PARAMETER ( Z2 = 1.6449 34066 84822 64365 D0,
     ,             Z3 = 1.2020 56903 15959 42854 D0,
     ,             Z4 = 1.0823 23233 71113 81916 D0, 
     ,             Z5 = 1.0369 27755 14336 99263 D0 )
       DIMENSION FL(6), FLS(6)
       DATA FL  / -1.d0, 0.5d0, 0.d0, 0.5d0, 0.2d0, 0.5d0 /
       DATA FLS /  1.d0, 0.1d0, 0.d0, 0.1d0, 0.01818181818d0, 0.1d0 /
*
* ...Colour factors
*
       DABC2N = 5./18.D0 * NF
*
       FL11 = FLS(NF) - FL(NF)
*
* ...The coefficient of delta(1-x)
*
       X2S3C = 
     &     + 64.D0*dabc2n*fl11
     &     + 160.D0*z2*dabc2n*fl11
     &     + 224.D0/3.D0*z3*dabc2n*fl11
     &     - 16.D0*z4*dabc2n*fl11
     &     - 1280.D0/3.D0*z5*dabc2n*fl11
*
       RETURN
       END
*
* =================================================================av==
      END MODULE XC2PS3E