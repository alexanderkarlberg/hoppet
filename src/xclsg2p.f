      MODULE XCLSG2P
      CONTAINS
*
* ..File: xclsg2p.f    FL_S
*
*
* ..Calculation of the 2-loop x-space MS(bar) coefficient functions 
*    for F2 via compact parametrizations involving only logarithms.
*    Singlet, mu_r = mu_f = Q. Expansion parameter: alpha_s/(4 pi).
*
*  ..The relative accuracy of the coefficient functions, as well as of 
*    the convolution results, amounts to a few thousandth.
*
*  ..Reference: W.L. van Neerven and A. Vogt, 
*               hep-ph/0006154 = Nucl. Phys. B588 (2000) 345
*  ..The user should also cite the original calculations,
*      J. Sanchez Guillen et al, Nucl. Phys. B353 (1991) 337  and 
*      E.B. Zijlstra and W.L. van Neerven, Phys. Lett. B273 (1991) 476 
*     
* 
* =====================================================================
*
*
* ..This is the pure singlet piece, denoted by C2S in WvN's program. 
*    Six numerical coefficients (all but the one of 1/y, which is 
*    exact up to truncation) are fitted to his results, using x values 
*    between 10^-6 and 1-10^-6.
*
       FUNCTION CLS2A (Y, NF)
       IMPLICIT REAL*8 (A-Z)
       INTEGER NF
*
       DL  = LOG (Y)
       OMY = 1.0D0 - Y
       DL1 = LOG (OMY)
*
       CLS2A = NF * ( (15.94D0 - 5.212D0 * Y) * OMY**2 * DL1 + (0.421D0
     $      + 1.520D0 * Y) * DL**2 + 28.09D0 * OMY * DL - (2.370D0/Y -
     $      19.27D0) * OMY**3 )
*
       RETURN
       END FUNCTION
*
* ---------------------------------------------------------------------
*
*
* ..This is the gluon contribution, denoted by C2G2 in WvN's program. 
*    Six numerical coefficients are fitted as above, the one of 1/y is
*    exact up to truncation.
*
       FUNCTION CLG2A (Y, NF)
       IMPLICIT REAL*8 (A-Z)
       INTEGER NF
*
       DL  = LOG (Y)
       OMY = 1.0D0 - Y
       DL1 = LOG (OMY)
*
       CLG2A = NF * ( (94.74D0 - 49.20D0 * Y) * OMY * DL1**2 + 864.8D0 *
     $      OMY * DL1 + 1161.D0* Y * DL * DL1 + 60.06D0 * Y * DL**2 +
     $      39.66D0 * OMY * DL - 5.333D0 * (1.D0/Y - 1.D0) )
*
       RETURN
       END FUNCTION
* 
* =================================================================av==

      END MODULE XCLSG2P
