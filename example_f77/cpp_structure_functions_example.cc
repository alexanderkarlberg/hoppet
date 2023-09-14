/// An example in C++ similar to the one found in examples_f90
///
#include "../src/hoppet_v1.h"
#include<iostream>
#include<cmath>
#include<cstdio>

using namespace std;


// definition of the initial condition function
void  lha_unpolarized_dummy_pdf(const double & x,
                   const double & Q,
                   double * pdf);


//----------------------------------------------------------------------
int main () {

  double mc = 1.414213563;   
  double mb = 4.5;
  double mt = 175.0;
  
  hoppetSetPoleMassVFN(mc,mb,mt);
  
  int nflav = -5;
  double Qmax   = 13000.0;
  int order_max = 4;
  double xmur   = 1.0;
  double xmuf   = 1.0;
  int sc_choice = 1 ;
  double Qmin   = 1.0;
  double zmass = 91.2;
  double wmass = 81.0;
  bool param_coefs = true;

  hoppetStartStrFctExtended(Qmax, order_max, nflav, xmur,xmuf,sc_choice,zmass,param_coefs,Qmin,wmass,zmass);
    
  int    nloop    = 3;
  double asQ      = 0.35;
  double Q0       = sqrt(2.0);
  double muR_Q    = 1.0;
  
  hoppetEvolve(asQ, Q0, nloop, muR_Q, lha_unpolarized_dummy_pdf, Q0);

  hoppetInitStrFct(order_max,param_coefs);
    
  // output the results
  double pdf[13];
  double xvals[9]={1e-5,1e-4,1e-3,1e-2,0.1,0.3,0.5,0.7,0.9};
  double Q = 100;
  double StrFct[14];
  printf("                                Evaluating PDFs and structure functions at Q = %8.3f GeV\n",Q);
  printf("    x      u-ubar      d-dbar    2(ubr+dbr)    c+cbar       gluon       F1γ         F2γ         F1Z         F2Z         F3Z\n");
  for (int ix = 0; ix < 9; ix++) {
    hoppetEval(xvals[ix], Q, pdf);
    hoppetStrFct(  -log(xvals[ix]),Q,Q,Q,StrFct);
    printf("%7.1E %11.4E %11.4E %11.4E %11.4E %11.4E %11.4E %11.4E %11.4E %11.4E %11.4E\n",xvals[ix],
           pdf[6+2]-pdf[6-2], 
           pdf[6+1]-pdf[6-1], 
           2*(pdf[6-1]+pdf[6-2]),
           (pdf[6-4]+pdf[6+4]),
           pdf[6+0],
	   StrFct[F1EM],
	   StrFct[F2EM],
	   StrFct[F1Z],
	   StrFct[F2Z ],
	   StrFct[F3Z ]);
  }
  
}


//----------------------------------------------------------------------
// the initial condition
void  lha_unpolarized_dummy_pdf(const double & x,
                   const double & Q,
                   double * pdf) {
  double uv, dv;
  double ubar, dbar;
  double N_g=1.7, N_ls=0.387975;
  double N_uv=5.107200, N_dv=3.064320;
  double N_db=N_ls/2;

  uv = N_uv * pow(x,0.8) * pow((1-x),3);
  dv = N_dv * pow(x,0.8) * pow((1-x),4);
  dbar = N_db * pow(x,-0.1) * pow(1-x,6);
  ubar = dbar * (1-x);

  pdf[ 0+6] = N_g * pow(x,-0.1) * pow(1-x,5);
  pdf[-3+6] = 0.2*(dbar + ubar);
  pdf[ 3+6] = pdf[-3+6];
  pdf[ 2+6] = uv + ubar;
  pdf[-2+6] = ubar;
  pdf[ 1+6] = dv + dbar;
  pdf[-1+6] = dbar;

  pdf[ 4+6] = 0;
  pdf[ 5+6] = 0;
  pdf[ 6+6] = 0;
  pdf[-4+6] = 0;
  pdf[-5+6] = 0;
  pdf[-6+6] = 0;
}

