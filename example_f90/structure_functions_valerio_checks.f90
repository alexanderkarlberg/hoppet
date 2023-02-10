!! An example program using structure functions up to N3LO
!!
!!

program structure_functions_example
  use hoppet_v1
  use dummy_pdfs
  use streamlined_interface
  use structure_functions
  real(dp) :: sqrts, xmur, xmuf, Qmin, ymax, Q
  integer  :: ipdf, order_max, sc_choice
  
  !! if using LHAPDF, rename a couple of hoppet functions which
  !! would otherwise conflict with LHAPDF 
  ! use hoppet_v1, EvolvePDF_hoppet => EvolvePDF, InitPDF_hoppet => InitPDF
  !implicit none

  ipdf = 91200
  sqrts = 13000.0_dp
  order_max = 4
  xmur = one
  xmuf = one
  sc_choice = 1
  ymax = log(1e5) !ymax=20
  
  ! initialize PDF set
  call PDFSET('DEFAULT', dble(ipdf))
  call getQ2min(0,Qmin)
  Qmin = sqrt(Qmin)

  ! Uncomment below to get PDF from LHAPDF
  ! initialise hoppet
  !call StartStrFct(sqrts, order_max, xR = xmur, xF = xmuf, sc_choice = sc_choice, &
  !     param_coefs = .true., Qmin_PDF = Qmin)
  !call read_PDF()

  ! For toy pdf and fixed nf = 5
  Qmin = one
  call StartStrFct(sqrts, order_max, nflav = 5, xR = xmur, xF = xmuf, sc_choice = sc_choice, &
       param_coefs = .true., Qmin_PDF = Qmin)
  call read_PDF(toyQ0 = sqrt(2.0_dp))

  call InitStrFct(order_max, .true.)

  open(unit = 99, file = 'structure-functions.dat')

  !call write_f1(99, 100.0_dp, ymax, 100)
  !call write_f2(99, 100.0_dp, ymax, 100)
  !call write_f3(99, 100.0_dp, ymax, 100)

  open(unit = 99, file = 'structure-functions-Q-2.0-GeV.dat')
  Q = 2.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  open(unit = 99, file = 'structure-functions-Q-5.0-GeV.dat')
  Q = 5.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  open(unit = 99, file = 'structure-functions-Q-10.0-GeV.dat')
  Q = 10.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  open(unit = 99, file = 'structure-functions-Q-50.0-GeV.dat')
  Q = 50.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  open(unit = 99, file = 'structure-functions-Q-100.0-GeV.dat')
  Q = 100.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  open(unit = 99, file = 'structure-functions-Q-500.0-GeV.dat')
  Q = 500.0_dp
  call write_f1_valerio(99, Q, -12.0_dp, 100)
  call write_f2_valerio(99, Q, -12.0_dp, 100)
  call write_f3_valerio(99, Q, -12.0_dp, 100)
  close(99)
  
  !call write_f2(99, 100.0_dp, ymax, 100)
  !call write_f3(99, 100.0_dp, ymax, 100)

contains 
  !----------------------------------------------------------------------
  ! fill the streamlined interface PDF table (possibly using hoppet's
  ! evolution)
  subroutine read_PDF(toyQ0, dglapQ0, xR_PDF)
    real(dp), external :: alphasPDF
    real(dp), optional :: toyQ0, dglapQ0, xR_PDF
    interface
       subroutine EvolvePDF(x,Q,res)
         use types; implicit none
         real(dp), intent(in)  :: x,Q
         real(dp), intent(out) :: res(*)
       end subroutine EvolvePDF
    end interface
    !----------------
    real(dp) :: toy_Q0, Q0pdf, xmuR_PDF
    real(dp) :: res_lhapdf(-6:6), x, Q
    real(dp) :: res_hoppet(-6:6)
    real(dp) :: toy_pdf_at_Q0(0:grid%ny,ncompmin:ncompmax)
    real(dp), parameter :: mz = 91.2_dp
    real(dp) :: pdf_at_Q0(0:grid%ny,ncompmin:ncompmax)

    toy_Q0       = -one
    Q0pdf        = -one
    xmuR_PDF     = one  
    if(present(toyQ0)) toy_Q0=toyQ0
    if(present(dglapQ0)) Q0pdf=dglapQ0
    if(present(xR_PDF)) xmuR_PDF=xR_PDF

    if (toy_Q0 > zero) then
       write(6,*) "WARNING: Using toy PDF"
       toy_pdf_at_Q0 = unpolarized_dummy_pdf(xValues(grid))
       call InitRunningCoupling(coupling, alfas=toy_alphas_Q0, &
            &                   nloop = 3, Q = toy_Q0, fixnf=nf_int)
       call EvolvePdfTable(tables(0), toy_Q0, toy_pdf_at_Q0, dh, coupling, nloop=3)
    elseif (Q0pdf > zero) then

       write(6,*) "WARNING: Using internal HOPPET DGLAP evolution"
       call InitPDF_LHAPDF(grid, pdf_at_Q0, EvolvePDF, Q0pdf)
       call InitRunningCoupling(coupling, alphasPDF(MZ) , MZ , 4,&
            & -1000000045, quark_masses_sf(4:6), .true.)
       call EvolvePdfTable(tables(0), Q0pdf, pdf_at_Q0, dh, coupling, &
            &  muR_Q=xmuR_PDF, nloop=3)

    else
       ! InitRunningCoupling has to be called for the HOPPET coupling to be initialised 
       ! Default is to ask for 4 loop running and threshold corrections at quark masses.  
       call InitRunningCoupling(coupling, alphasPDF(MZ) , MZ , 4,&
            & -1000000045, quark_masses_sf(4:6), masses_are_MSbar = .true.)
       ! fixnf can be set to a positive number for
       ! fixed nf. -1000000045 gives variable nf
       ! and threshold corrections at quarkmasses.
       call hoppetAssign(EvolvePDF)
    end if

    ! quickly test that we have read in the PDFs correctly
    write(6,*) "Quick test that PDFs have been read in correctly"
    x = 0.08_dp
    Q = 17.0_dp
    call EvolvePDF(x, Q, res_lhapdf)
    call EvalPdfTable_xQ(tables(0), x, Q, res_hoppet)
    write(6,*) 'lhapdf: ', res_lhapdf
    write(6,*) 'hoppet: ', res_hoppet
  end subroutine read_PDF

 !----------------------------------------------------------------------
  ! write the F1 structure function to idev
  subroutine write_f1_valerio (idev, Qtest, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F1Z_LO, F1Z_NLO, F1Z_NNLO, F1Z_N3LO, res(-6:7)
    integer  :: iy
    !F1 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F1Wp(LO) F1Wm(LO) F1Wp(NLO) F1Wm(NLO) F1Wp(NNLO) F1Wm(NNLO)', &
          & ' F1Wp(N3LO) F1Wm(N3LO) F1Z(LO) F1Z(NLO) F1Z(NNLO) F1Z(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, -nx, -1
       ytest = iy * logxomx_max / nx
       xval = exp(-ytest)/(one+exp(-ytest))
       ytest = - log(xval)
       res = F_LO(ytest, Qtest, mR, mF)
       write(idev,'(3es22.12)',advance='no') xval, res(F1Wp),res(F1Wm)
       F1Z_LO = res(F1Z)
       res = F_NLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_NLO = res(F1Z)
       res = F_NNLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_NNLO = res(F1Z)
       res = F_N3LO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F1Wp), res(F1Wm)
       F1Z_N3LO = res(F1Z)
       write(idev,'(4es22.12)',advance='no') F1Z_LO, F1Z_NLO, F1Z_NNLO, F1Z_N3LO
       write(idev,*)
    end do
    write(idev,*)
    write(idev,*)
  end subroutine write_f1_valerio

  !----------------------------------------------------------------------
  ! write the F2 structure function to idev
  subroutine write_f2_valerio (idev, Qtest, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F2Z_LO, F2Z_NLO, F2Z_NNLO, F2Z_N3LO, res(-6:7)
    integer  :: iy
    !F2 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F2Wp(LO) F2Wm(LO) F2Wp(NLO) F2Wm(NLO) F2Wp(NNLO) F2Wm(NNLO)', &
          & ' F2Wp(N3LO) F2Wm(N3LO) F2Z(LO) F2Z(NLO) F2Z(NNLO) F2Z(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, -nx, -1
       ytest = iy * logxomx_max / nx
       xval = exp(-ytest)/(one+exp(-ytest))
       ytest = - log(xval)
       res = F_LO(ytest, Qtest, mR, mF)
       write(idev,'(3es22.12)',advance='no') xval, res(F2Wp),res(F2Wm)
       F2Z_LO = res(F2Z)
       res = F_NLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_NLO = res(F2Z)
       res = F_NNLO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_NNLO = res(F2Z)
       res = F_N3LO(ytest, Qtest, mR, mF)
       write(idev,'(2es22.12)',advance='no') res(F2Wp), res(F2Wm)
       F2Z_N3LO = res(F2Z)
       write(idev,'(4es22.12)',advance='no') F2Z_LO, F2Z_NLO, F2Z_NNLO, F2Z_N3LO
       write(idev,*)
    end do
    write(idev,*)
    write(idev,*)
  end subroutine write_f2_valerio

  !----------------------------------------------------------------------
  ! write the F3 structure function to idev
  subroutine write_f3_valerio (idev, Qtest, logxomx_max, nx)
  implicit none
    real(dp), intent(in) :: Qtest, logxomx_max
    integer, intent(in)  :: idev, nx
    real(dp) :: ytest, xval, mR, mF, F3Z_LO, F3Z_NLO, F3Z_NNLO, F3Z_N3LO, res(-6:7)
    integer  :: iy
    !F3 Wp Wm Z
    write(idev,'(a,f10.4,a,f10.4)') '# Q = ', Qtest
    write(idev,'(a,a)') '# x  F3Wp(LO) F3Wm(LO) F3Wp(NLO) F3Wm(NLO) F3Wp(NNLO) F3Wm(NNLO)', &
          & ' F3Wp(N3LO) F3Wm(N3LO) F3Z(LO) F3Z(NLO) F3Z(NNLO) F3Z(N3LO)'
    mF = muF(Qtest)
    mR = muR(Qtest)
    do iy = nx, -nx, -1
       ytest = iy * logxomx_max / nx
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

end program structure_functions_example
