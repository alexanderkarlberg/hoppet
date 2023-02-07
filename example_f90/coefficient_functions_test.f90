!! An example program using structure functions up to N3LO
!!
!!

program coefficient_functions_test
  use hoppet_v1
  implicit none

  call print()
contains 
  !----------------------------------------------------------------------
  ! fill the streamlined interface PDF table (possibly using hoppet's
  ! evolution)
  subroutine print()
    use xclns3e
    use xclns3p
    use XCLPS3E
    use XCLSG3P
    use XCLGL3E

    use xc2ns3e
    use xc2ns3p
    use XC2PS3E
    use XC2SG3P
    use XC2GL3E

    USE XC3NS3E
    USE XC3NS3P

    USE XC3NS2E
    USE XC3NS2P

    use XCDIFF3P
    use XCDIFF3PNEW

    use coefficient_functions_holder

!    use XCLSG3PV
    implicit none
    integer, parameter :: nf_lc = 5, nbins=100
    real(dp), parameter :: logxmin = -12_dp, logxmax=zero
    integer :: ix
    real(dp) :: logx, delx, x, y, param, exact
    character (len=400) :: filename

    delx = (logxmax - logxmin) / dble(nbins)

    ! First we do the FL coefficient functions
   do cc_piece = 1,4
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       !param = cfN3LO_F2NS_plus_e(y)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    enddo
    filename = 'CL_NS_3loop_param_vs_exact.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = CLNP3A(x, -y, nf_lc, 1) + CLNP3A(x, -y, nf_lc, 0) 

       exact = XLNP3A(x,nf_lc, 1) +  XLNP3A(x,nf_lc, 1)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'CL_PS_3loop_param_vs_exact.dat'

    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx


       param = CLS3A(x, -y, nf_lc, 1) + CLS3A(x, -y, nf_lc, 0) 

       exact = XLS3A(x,nf_lc,1) + XLS3A(x,nf_lc,0)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'CL_gluon_3loop_param_vs_exact.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = CLG3A(x, -y, nf_lc, 1) + CLG3A(x, -y, nf_lc, 0) 

       exact = XLG3A(x,nf_lc,1) + XLG3A(x,nf_lc,0)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    ! Then we do the F2 coefficient functions
   call SET_C3SOFT_N3LO(nf_lc)
    filename = 'C2_NS_3loop_param_vs_exact_A.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2NP3A(x, -y, nf_lc, 1) + C2NP3A(x, -y, nf_lc, 0)

       exact = X2NP3A(x,nf_lc,1) + X2NP3A(x,nf_lc,0)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_NS_3loop_param_vs_exact_B.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2NS3B(x, -y, nf_lc)

       exact = X2NS3B(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_NS_3loop_param_vs_exact_C.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2NP3C(x, nf_lc, 1) + C2NP3C(x, nf_lc, 0)

       exact = X2NP3C(x,nf_lc, 1) + X2NP3C(x,nf_lc, 0) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_PS_3loop_param_vs_exact.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2S3A(x, -y, nf_lc, 1) + C2S3A(x, -y, nf_lc, 0)

       exact = X2S3A(x,nf_lc,1) + X2S3A(x,nf_lc,0)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_gluon_3loop_param_vs_exact.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2G3A(x, -y, nf_lc, 1) + C2G3A(x, -y, nf_lc, 0) 

       exact = X2G3A(x,nf_lc,1) + X2G3A(x,nf_lc,0)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_NS_3loop_param_vs_exact_A.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NM3A(x, -y, nf_lc, 0) 

       exact = X3NM3A(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_NS_3loop_param_vs_exact_B.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NS3B(x, -y, nf_lc)

       exact = X3NS3B(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_NS_3loop_param_vs_exact_C.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NM3C(x, nf_lc) 

       exact = X3NS3C(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    call SET_C3SOFT(nf_lc)
    filename = 'C3_NS_2loop_param_vs_exact_A.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NM2A(x,nf_lc)  

       exact = X3NM2A(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_NS_2loop_param_vs_exact_B.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NS2B(x, nf_lc) 

       exact = X3NS2B(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_NS_2loop_param_vs_exact_C.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3NM2C(x, nf_lc) 

       exact = X3NS2C(x,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)


    filename = 'C2_diff_3loop_param_vs_param_low_mom.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2Q3DF(x,-y,nf_lc,0)  

       exact = C2Q3DFP(x,-y,nf_lc)  + C2Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

   filename = 'CL_diff_3loop_param_vs_param_low_mom.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = CLQ3DF(x,-y,nf_lc,0)  

       exact = CLQ3DFP(x,-y,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_diff_3loop_param_vs_param_low_mom.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3Q3DF(x,-y,nf_lc,0)  

       exact = C3Q3DFP(x,-y,nf_lc)  + C3Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_diff_3loop_param_vs_param_low_mom_1.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2Q3DF(x,-y,nf_lc,1)  

       exact = C2Q3DFP(x,-y,nf_lc)  + C2Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

   filename = 'CL_diff_3loop_param_vs_param_low_mom_1.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = CLQ3DF(x,-y,nf_lc,1)  

       exact = CLQ3DFP(x,-y,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_diff_3loop_param_vs_param_low_mom_1.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3Q3DF(x,-y,nf_lc,1)  

       exact = C3Q3DFP(x,-y,nf_lc)  + C3Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C2_diff_3loop_param_vs_param_low_mom_2.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C2Q3DF(x,-y,nf_lc,2)  

       exact = C2Q3DFP(x,-y,nf_lc)  + C2Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

   filename = 'CL_diff_3loop_param_vs_param_low_mom_2.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = CLQ3DF(x,-y,nf_lc,2)  

       exact = CLQ3DFP(x,-y,nf_lc) 

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)

    filename = 'C3_diff_3loop_param_vs_param_low_mom_2.dat'
    open(unit = 99, file = trim(filename))
    logx = zero
    do ix = 1, nbins
       logx = logxmin + (ix - 0.5_dp) * delx
       x = exp(logx)
       y = -logx

       param = C3Q3DF(x,-y,nf_lc,2)  

       exact = C3Q3DFP(x,-y,nf_lc)  + C3Q3DFPC(x,nf_lc)

       write(99,*) logx, param, exact, one - exact/param
    enddo
    close(unit = 99)



  end subroutine print

end program coefficient_functions_test

