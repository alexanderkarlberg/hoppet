// -*- C++ -*-
// C++ include file for hoppet's vanilla interface
#ifndef __HOPPET_V1__
#define __HOPPET_V1__

// define nicer forms of standard f77 naming
#define hoppetStart                    hoppetstart_
#define hoppetStartExtended            hoppetstartextended_
#define hoppetAssign                   hoppetassign_
#define hoppetEvolve                   hoppetevolve_        
#define hoppetPreEvolve                hoppetpreevolve_     
#define hoppetCachedEvolve             hoppetcachedevolve_
#define hoppetAlphaS                   hoppetalphas_ 
#define hoppetSetFFN                   hoppetsetffn_       
#define hoppetSetVFN                   hoppetsetvfn_       
#define hoppetSetPoleMassVFN           hoppetsetpolemassvfn_       
#define hoppetSetMSbarMassVFN          hoppetsetmsbarmassvfn_       
#define hoppetEval                     hoppeteval_          
#define hoppetEvalSplit                hoppetevalsplit_
#define hoppetStartStrFct              hoppetstartstrfct_
#define hoppetStartStrFctExtended      hoppetstartstrfctextended_
#define hoppetInitStrFct               hoppetinitstrfct_
#define hoppetStrFct                   hoppetstrfct_
#define hoppetStrFctLO                 hoppetstrfctlo_
#define hoppetStrFctNLO                hoppetstrfctnlo_
#define hoppetStrFctNNLO               hoppetstrfctnnlo_
#define hoppetStrFctN3LO               hoppetstrfctn3lo_

// indices for the different structure functions
int F1Wp= 1+6, F2Wp= 2+6, F3Wp= 3+6;
int F1Wm=-1+6, F2Wm=-2+6, F3Wm=-3+6;
int F1Z = 4+6, F2Z = 5+6, F3Z = 6+6;
int F1EM = -4+6, F2EM = -5+6;
int F1gZ = 0+6, F2gZ = -6+6, F3gZ = 7+6;
  
extern "C" {

  /// initialise the underlying grid, splitting functions and pdf-table
  /// objects, using the dy grid spacing and splitting functions up to
  /// nloop loops; all other parameters are set automatically
  void hoppetStart(const double & dy, const int & nloop);


  // the "factorisation" schemes
  const int factscheme_MSbar    = 1; //< the unpolarised MSbar fact. scheme
  const int factscheme_DIS      = 2; //< the unpolarised DIS fact. scheme (partial support)
  const int factscheme_PolMSbar = 3; //< the polarised MSbar fact. scheme
  

  /// an extended interface for starting hoppet
  void hoppetStartExtended(
       const double & ymax,   //< highest value of ln1/x user wants to access
       const double & dy,     //< internal ln1/x grid spacing: 0.1-0.25 is a sensible range
       const double & Qmin,   //< lower limit of Q range
       const double & Qmax,   //< upper limit of Q range
       const double & dlnlnQ, //< internal table spacing in lnlnQ (e.g. dy/4)
       const int & nloop,     //< the maximum number of loops we'll want (<=3)
       const int & order,     //< order of numerical interpolation (e.g. -6)
       const int & factscheme //< one of the factschemes defined above
       );


  /// Set things up to be a fixed-flavour number scheme with the given
  /// fixed_nf number of flavours
  void hoppetSetFFN(const int & fixed_nf);


  /// Set things up to be a variable-flavour number scheme with the given
  /// quark (pole) masses. Now deprecated; use hoppetSetPoleMassVFN instead
  void  hoppetSetVFN(const double &mc, const double & mb, const double & mt);

  /// Set things up to be a variable-flavour number scheme with the
  /// given quark (pole) masses. Thresholds are crossed at the pole
  /// masses, both for the coupling and the PDF evolution.
  void  hoppetSetPoleMassVFN(const double &mc, const double & mb, const double & mt);

  /// Set things up to be a variable-flavour number scheme with the given
  /// quark (MSbar) masses. Thresholds are crossed at the MSbar
  /// masses, both for the coupling and the PDF evolution.
  void  hoppetSetMSbarMassVFN(const double &mc, const double & mb, const double & mt);

  /// Given a pdf_subroutine with the interface shown below, initialise
  /// our internal pdf table.
  void hoppetAssign(void (* pdf_subroutine)(const double & x, 
                                            const double & Q, double * res) );


  /// Given a pdf_subroutine with the interface shown below, fill the 
  /// table by evolving the PDF from scale Q0pdf, with alphas provided 
  /// at scale Q0alphas
  void hoppetEvolve(const double & asQ0,
                    const double & Q0alphas,
                    const int    & nloop,
                    const double & muR_Q,
                    void (* pdf_subroutine)(const double & x, 
                                            const double & Q, double * res),
                    const double & Q0pdf);


  /// Prepare a cached evolution
  void hoppetPreEvolve(const double & asQ0, 
                       const double & Q0alphas, 
                       const int    & nloop, 
                       const double & muR_Q, 
                       const double & Q0pdf);


  /// Carry out a cached evolution based on the initial condition
  /// that can be obtained from pdf_subroutine at the scale Q0pdf set in
  /// hoppetPreEvolve
  void hoppetCachedEvolve(void (*pdf_subroutine)(const double & x, 
                                     const double & Q, double * res));

  /// Return the coupling at scale Q
  double hoppetAlphaS(const double & Q);

  /// Return in f[0..12] the value of the internally stored pdf at the
  /// given x,Q, with the usual LHApdf meanings for the indices -6:6.
  void hoppetEval(const double & x,
                  const double & Q,
                  double * f);


  /// Return in f[0..12] the value of 
  ///
  ///    [P(iloop,nf) \otimes pdf] (x,Q)
  ///
  /// where P(iloop,nf) is the iloop-splitting function for the given
  /// value of nf, and pdf is our internally stored pdf.
  ///
  /// The normalisation is such that the nloop dglap evolution equation is
  ///
  ///     dpdf/dlnQ^2 = sum_{iloop=1}^nloop 
  ///                        (alphas/(2*pi))^iloop * P(iloop,nf) \otimes pdf
  ///
  /// Note that each time nf changes relative to a previous call for the
  /// same iloop, the convolution has to be repeated for the whole
  /// table. So for efficient results when requiring multiple nf values,
  /// calls with the same nf value should be grouped together.
  ///
  /// In particular, for repeated calls with the same value of nf, the
  /// convolutions are carried out only on the first call (i.e. once for
  /// each value of iloop). Multiple calls with different values for
  /// iloop can be carried out without problems.
  ///
  void hoppetEvalSplit(const double & x,
                       const double & Q,
                       const int    & iloop,
                       const int    & nf,
                       double * f);
  
  //----------------------------------------------------------------------
  // Setup of constants and parameters needed for structure functions
  void hoppetStartStrFct(const double & rts,
			 const int & order_max);
			 
  
  //----------------------------------------------------------------------
  // Setup of constants and parameters needed for structure functions
  void hoppetStartStrFctExtended(const double & rts,
				 const int & order_max,
				 const int & nflav,
				 const double & xR,
				 const double & xF,
				 const int & sc_choice,
				 const double & cmu,
				 const bool & param_coefs,
				 const double & Qmin_PDF,
				 const double & wmass,
				 const double & zmass);
  
  // Initialize the structure functions up to specified order
  // this requires the PDF to have been set up beforehand, and filled in tables(0)
  void hoppetInitStrFct(const int & order_max,
			const bool & separate_orders);


  // F
  // calculate the structure function at x, muF
  // this is the sum over all orders
  void hoppetStrFct(const double & y,
		    const double & Q,
		    const double & muR_in,
		    const double & muF_in,
		    double * F);
  
  // F_LO
  // calculate the leading order structure function at x, muF
  //
  void hoppetStrFctLO(const double & y,
		       const double & Q,
		       const double & muR_in,
		       const double & muF_in,
		       double * F);
  // F_NLO
  // calculate the next-to-leading order structure function at x, muF
  //
  void hoppetStrFctNLO(const double & y,
			const double & Q,
			const double & muR_in,
			const double & muF_in,
			double * F);
  // F_NNLO
  // calculate the next-to-next-to-leading order structure function at x, muF
  //
  void hoppetStrFctNNLO(const double & y,
			 const double & Q,
			 const double & muR_in,
			 const double & muF_in,
			 double * F);
  // F_N3LO
  // calculate the next-to-next-to-next-to-leading order structure function at x, muF
  //
  void hoppetStrFctN3LO(const double & y,
			 const double & Q,
			 const double & muR_in,
			 const double & muF_in,
			 double * F);
  
}
#endif // __HOPPET_V1__
