/***********************************************************************
 *compute y = sum(sum(X.*Y))
***********************************************************************/

#include <math.h>
#include <mex.h>
#include <matrix.h>
#include <string.h> /* needed for memcpy() */


/**********************************************************
* 
***********************************************************/
void mexFunction(
      int nlhs,   mxArray  *plhs[], 
      int nrhs,   const mxArray  *prhs[] )

{        
    double   *X, *y, *Y;   
    double   nrm2=0.0, tmp;

    mwIndex  subs[2];
    mwSize   nsubs=2;
    mwSize   m, n, j, k, jm; 

/* CHECK FOR PROPER NUMBER OF ARGUMENTS */

   if (nrhs > 2){
      mexErrMsgTxt("mexsumsum: requires at most 2 input arguments."); }
   if (nlhs > 1){ 
      mexErrMsgTxt("mexsumsum: requires at most 1 output argument."); }   

/* CHECK THE DIMENSIONS */

    m = mxGetM(prhs[0]); 
    n = mxGetN(prhs[0]); 
    X = mxGetPr(prhs[0]);
    Y = mxGetPr(prhs[1]);
    /***** create return argument *****/    
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL); 
    y = mxGetPr(plhs[0]);  

    /***** Do the computations in a subroutine *****/  
    y[0] = 0;
    for (j=0; j<n; j++) { 
        jm = j*m; 
        tmp = 0;
        for (k=0; k<m; k++) { tmp += X[k+jm]*Y[k+jm]; }
        y[0] = y[0]+tmp;
    }
    return;
}
/**********************************************************/
