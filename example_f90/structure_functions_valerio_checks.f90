!! An example program which prints out the DIS structure functions up
!! to N3LO. This program produces the checks that were carried out
!! with Valerio Bertone in Feb 2023, and which are contained in the
!! folder valerio-checks.!!
!!

program structure_functions_valerio_checks
  use hoppet_v1
  use dummy_pdfs
  use streamlined_interface
  use structure_functions
  implicit none
  real(dp) :: sqrts, xmur, xmuf, Qmin, ymax, Q, mc, mb, mt, asQ, Q0alphas, muR_Q, Q0pdf
  real(dp) :: xpdf_at_xQ(-6:6)
  integer  :: order_max, sc_choice,nloop,ix
  real(dp), parameter :: heralhc_xvals(9) = &
       & (/1e-5_dp,1e-4_dp,1e-3_dp,1e-2_dp,0.1_dp,0.3_dp,0.5_dp,0.7_dp,0.9_dp/)
  

  sqrts = 13000.0_dp ! This is Qmax
  order_max = 4
  xmur = one
  xmuf = one
  sc_choice = 1
  ! For toy pdf and fixed nf = 5
  Qmin = one

  ! Set heavy flavour scheme
  mc = 1.414213563_dp   ! sqrt(2.0_dp) + epsilon
  mb = 4.5_dp
  mt = 175.0_dp
  call hoppetSetPoleMassVFN(mc, mb, mt)

  call StartStrFct(sqrts, order_max, xR = xmur, xF = xmuf, sc_choice = sc_choice, &
       param_coefs = .true., Qmin_PDF = Qmin)
  nloop = 3
  asQ = 0.35_dp
  Q0alphas = sqrt(2.0_dp)
  muR_Q = 1.0_dp
  Q0pdf = sqrt(2.0_dp) ! The initial evolution scale
  call hoppetEvolve(asQ, Q0alphas, nloop,muR_Q, lha_unpolarized_dummy_pdf, Q0pdf)

  write(6,*) "Quick test that PDFs have been read in correctly"
    Q = 100.0_dp
    print*, 'Q = ', Q, ' GeV'
    print*, 'αS(Q) = ', Value(coupling, Q)

    write(6,'(a)')
    write(6,'(a,f8.3,a)') "           Evaluating PDFs at Q = ",Q," GeV"
    write(6,'(a5,2a12,a14,a10,a12)') "x",&
       & "u-ubar","d-dbar","2(ubr+dbr)","c+cbar","gluon"
    do ix = 1, size(heralhc_xvals)
     call EvalPdfTable_xQ(tables(0),heralhc_xvals(ix),Q,xpdf_at_xQ)
     write(6,'(es7.1,5es12.4)') heralhc_xvals(ix), &
          &  xpdf_at_xQ(2)-xpdf_at_xQ(-2), &
          &  xpdf_at_xQ(1)-xpdf_at_xQ(-1), &
          &  2*(xpdf_at_xQ(-1)+xpdf_at_xQ(-2)), &
          &  (xpdf_at_xQ(-4)+xpdf_at_xQ(4)), &
          &  xpdf_at_xQ(0)
    end do
    print*, ''

    
    Q = 500.0_dp
    call EvalPdfTable_xQ(tables(0),0.01_dp,Q,xpdf_at_xQ)
    print*, 'Q = ', Q, ' GeV'
    print*, 'αS(Q) = ', Value(coupling, Q)
    print*, 'PDF above mt'
    print*, xpdf_at_xQ(-6:6)
    print*, ''
    Q = 100.0_dp
    call EvalPdfTable_xQ(tables(0),0.01_dp,Q,xpdf_at_xQ)
    print*, 'Q = ', Q, ' GeV'
    print*, 'αS(Q) = ', Value(coupling, Q)
    print*, 'PDF above mb'
    print*, xpdf_at_xQ(-6:6)
    print*, ''
    Q = 2.0_dp
    call EvalPdfTable_xQ(tables(0),0.01_dp,Q,xpdf_at_xQ)
    print*, 'Q = ', Q, ' GeV'
    print*, 'αS(Q) = ', Value(coupling, Q)
    print*, 'PDF above mc'
    print*, xpdf_at_xQ(-6:6)
    print*, ''
  
! Fixed nf=5 call below
  !call StartStrFct(sqrts, order_max, nflav = 5, xR = xmur, xF = xmuf, sc_choice = sc_choice, &
  !     param_coefs = .true., Qmin_PDF = Qmin)
!  call read_PDF(toyQ0 = sqrt(2.0_dp), nflav = 5)

  call InitStrFct(order_max, .true.)

  open(unit = 99, file = 'valerio-checks/structure-functions-Q-2.0-GeV.dat')
  Q = 2.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
  open(unit = 99, file = 'valerio-checks/structure-functions-Q-5.0-GeV.dat')
  Q = 5.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
  open(unit = 99, file = 'valerio-checks/structure-functions-Q-10.0-GeV.dat')
  Q = 10.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
  open(unit = 99, file = 'valerio-checks/structure-functions-Q-50.0-GeV.dat')
  Q = 50.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
  open(unit = 99, file = 'valerio-checks/structure-functions-Q-100.0-GeV.dat')
  Q = 100.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
  open(unit = 99, file = 'valerio-checks/structure-functions-Q-500.0-GeV.dat')
  Q = 500.0_dp
  call write_f1_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f2_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  call write_f3_valerio(99, Q, -3.0_dp, 10.0_dp, 200)
  close(99)
  
contains 
  !----------------------------------------------------------------------
  ! fill the streamlined interface PDF table with the toy PDF from Andreas
!  subroutine read_PDF(toyQ0, xR_PDF, nflav)
!    real(dp), optional :: toyQ0, xR_PDF
!    integer, optional :: nflav
!    interface
!       subroutine EvolvePDF(x,Q,res)
!         use types; implicit none
!         real(dp), intent(in)  :: x,Q
!         real(dp), intent(out) :: res(*)
!       end subroutine EvolvePDF
!    end interface
!    !----------------
!    real(dp) :: toy_Q0, Q0pdf, xmuR_PDF, xpdf_at_xQ(-6:6)
!    real(dp) :: res_lhapdf(-6:6), x, Q
!    real(dp) :: res_hoppet(-6:6)
!    real(dp) :: toy_pdf_at_Q0(0:grid%ny,ncompmin:ncompmax)
!    real(dp), parameter :: mz = 91.2_dp
!    real(dp) :: pdf_at_Q0(0:grid%ny,ncompmin:ncompmax)
!    integer :: nf_lcl
!    real(dp), parameter :: heralhc_xvals(9) = &
!       & (/1e-5_dp,1e-4_dp,1e-3_dp,1e-2_dp,0.1_dp,0.3_dp,0.5_dp,0.7_dp,0.9_dp/)
!  integer  :: ix
!
!    toy_Q0       = sqrt(2.0_dp)
!    xmuR_PDF     = one  
!    if(present(toyQ0)) toy_Q0=toyQ0
!    if(present(xR_PDF)) xmuR_PDF=xR_PDF
!    if(present(nflav)) nf_lcl = nflav
!
!    if (toy_Q0 > zero) then
!       write(6,*) "Using toy PDF"
!       toy_pdf_at_Q0 = unpolarized_dummy_pdf(xValues(grid))
!       if(present(nflav)) then 
!         call InitRunningCoupling(coupling, alfas=toy_alphas_Q0, &
!            &                   nloop = 3, Q = toy_Q0, fixnf=nf_lcl)
!        else
!         call InitRunningCoupling(coupling, alfas=toy_alphas_Q0, &
!            &                   nloop = 3, Q = toy_Q0)
!        endif
!       call EvolvePdfTable(tables(0), toy_Q0, toy_pdf_at_Q0, dh, coupling, nloop=3)
!    else
!       stop 'Need positive Q starting scale for the toy PDF'
!    end if
!
!    stop
!
!  end subroutine read_PDF

 !----------------------------------------------------------------------
  ! write the F1 structure function to idev
  subroutine write_f1_valerio (idev, Qtest, logxomx_min, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_min, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F1Z_LO, F1Z_NLO, F1Z_NNLO, F1Z_N3LO, res(-6:7)
    real(dp) :: F1g_LO, F1g_NLO, F1g_NNLO, F1g_N3LO
    integer  :: iy
    !F1 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F1Wp(LO) F1Wm(LO) F1Wp(NLO) F1Wm(NLO) F1Wp(NNLO) F1Wm(NNLO)', &
          & ' F1Wp(N3LO) F1Wm(N3LO) F1Z(LO) F1Z(NLO) F1Z(NNLO) F1Z(N3LO) F1γ(LO) F1γ(NLO) F1γ(NNLO) F1γ(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, 0, -1
       ytest = logxomx_max + iy * (logxomx_min - logxomx_max) / nx
       xval = exp(-ytest)/(one+exp(-ytest))
       ytest = - log(xval)
       res = F_LO(ytest, Qtest, mR, mF)
       write(idev,'(3es22.12)',advance='no') xval, res(F1Wp),res(F1Wm)
       F1Z_LO = res(F1Z)
       F1g_LO = res(F1EM)
       res = F_NLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_NLO = res(F1Z)
       F1g_NLO = res(F1EM)
       res = F_NNLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_NNLO = res(F1Z)
       F1g_NNLO = res(F1EM)
       res = F_N3LO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_N3LO = res(F1Z)
       F1g_N3LO = res(F1EM)
       write(idev,'(4es22.12)',advance='no') F1Z_LO, F1Z_NLO, F1Z_NNLO, F1Z_N3LO
       write(idev,'(4es22.12)',advance='no') F1g_LO, F1g_NLO, F1g_NNLO, F1g_N3LO
       write(idev,*)
    end do
    write(idev,*)
    write(idev,*)
  end subroutine write_f1_valerio

  !----------------------------------------------------------------------
  ! write the F2 structure function to idev
  subroutine write_f2_valerio (idev, Qtest, logxomx_min, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_min, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F2Z_LO, F2Z_NLO, F2Z_NNLO, F2Z_N3LO, res(-6:7)
    real(dp) :: F2g_LO, F2g_NLO, F2g_NNLO, F2g_N3LO
    integer  :: iy
    !F2 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F2Wp(LO) F2Wm(LO) F2Wp(NLO) F2Wm(NLO) F2Wp(NNLO) F2Wm(NNLO)', &
          & ' F2Wp(N3LO) F2Wm(N3LO) F2Z(LO) F2Z(NLO) F2Z(NNLO) F2Z(N3LO) F2γ(LO) F2γ(NLO) F2γ(NNLO) F2γ(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, 0, -1
       ytest = logxomx_max + iy * (logxomx_min - logxomx_max) / nx
       xval = exp(-ytest)/(one+exp(-ytest))
       ytest = - log(xval)
       res = F_LO(ytest, Qtest, mR, mF)
       write(idev,'(3es22.12)',advance='no') xval, res(F2Wp),res(F2Wm)
       F2Z_LO = res(F2Z)
       F2g_LO = res(F2EM)
       res = F_NLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_NLO = res(F2Z)
       F2g_NLO = res(F2EM)
       res = F_NNLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_NNLO = res(F2Z)
       F2g_NNLO = res(F2EM)
       res = F_N3LO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_N3LO = res(F2Z)
       F2g_N3LO = res(F2EM)
       write(idev,'(4es22.12)',advance='no') F2Z_LO, F2Z_NLO, F2Z_NNLO, F2Z_N3LO
       write(idev,'(4es22.12)',advance='no') F2g_LO, F2g_NLO, F2g_NNLO, F2g_N3LO
       write(idev,*)
    end do
    write(idev,*)
    write(idev,*)
  end subroutine write_f2_valerio

  !----------------------------------------------------------------------
  ! write the F3 structure function to idev
  subroutine write_f3_valerio (idev, Qtest, logxomx_min, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_min, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F3Z_LO, F3Z_NLO, F3Z_NNLO, F3Z_N3LO, res(-6:7)
    integer  :: iy
    !F3 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F3Wp(LO) F3Wm(LO) F3Wp(NLO) F3Wm(NLO) F3Wp(NNLO) F3Wm(NNLO)', &
          & ' F3Wp(N3LO) F3Wm(N3LO) F3Z(LO) F3Z(NLO) F3Z(NNLO) F3Z(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, 0, -1
       ytest = logxomx_max + iy * (logxomx_min - logxomx_max) / nx
       xval = exp(-ytest)/(one+exp(-ytest))
       ytest = - log(xval)
       res = F_LO(ytest, Qtest, mR, mF)
       write(idev,'(3es22.12)',advance='no') xval, res(F3Wp),res(F3Wm)
       F3Z_LO = res(F3Z)
       res = F_NLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F3Wp), res(F3Wm)
       F3Z_NLO = res(F3Z)
       res = F_NNLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F3Wp), res(F3Wm)
       F3Z_NNLO = res(F3Z)
       res = F_N3LO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F3Wp), res(F3Wm)
       F3Z_N3LO = res(F3Z)
       write(idev,'(4es22.12)',advance='no') F3Z_LO, F3Z_NLO, F3Z_NNLO, F3Z_N3LO
       write(idev,*)
    end do
    write(idev,*)
    write(idev,*)
  end subroutine write_f3_valerio

end program structure_functions_valerio_checks
