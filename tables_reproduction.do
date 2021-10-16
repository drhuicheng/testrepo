* IVTREATREG: A STATA ROUTINE FOR ESTIMATING BINARY TREATMENT MODELS 
* WITH HETEROGENEOUS RESPONSE TO TREATMENT AND UNOBSERVABLE SELECTION

***********************************************
*** Stata code reproducing table 4, 5 and 6 ***
***********************************************

* Dataset FERTIL2.DTA
use fertil2.dta
global yxvars children educ7 age agesq evermarr urban electric tv
global xvarsh age agesq evermarr urban

**********
* Table 4
**********
ivtreatreg $yxvars, ///
hetero($xvarsh) iv(frsthalf) model(probit-2sls) graphic
    
**********
* Table 5
**********
bootstrap atet=e(atet) atent=e(atent), rep(100): ///
ivtreatreg $yxvars, ///
hetero($xvarsh) iv(frsthalf) model(probit-2sls)


*****************
* Table 6 (new)
*****************
*** Ttest ***
sjlog using tables_reproduction6, replace
regress children educ7
estimates store ttest
ivtreatreg children educ7 age agesq evermarr urban electric tv, hetero(age agesq evermarr urban) iv(frsthalf) model(heckit) graphic 
estimates store heckit
ivtreatreg children educ7 age agesq evermarr urban electric tv, hetero(age agesq evermarr urban) iv(frsthalf) model(probit-ols) graphic 
estimates store probit_ols
ivtreatreg children educ7 age agesq evermarr urban electric tv, hetero(age agesq evermarr urban) iv(frsthalf) model(direct-2sls) graphic 
estimates store direct_2sls
ivtreatreg children educ7 age agesq evermarr urban electric tv, hetero(age agesq evermarr urban) iv(frsthalf) model(probit-2sls) graphic
estimates store probit_2sls
estimates table ttest probit_ols direct_2sls probit_2sls heckit , ///
b(%9.2f) keep(educ7 G_fv) star
sjlog close, replace

* End









