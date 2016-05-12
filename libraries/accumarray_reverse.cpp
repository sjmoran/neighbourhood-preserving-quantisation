#include <mex.h>
#include <stdio.h>
#include <math.h>
#include "types.h"

/*
dist = (vec1, vec2)

Input: 
   vec1, vec2: 
   size(vec1) = 
   size(vec2) = 

Output:
   dist:
   size(dist) =

/* Input Arguments */
#define	MAT1   	prhs[0]
#define MAT2    prhs[1]
#define K       prhs[2]

/* Output Arguments */
#define	OUT1	plhs[0]
#define	OUT2	plhs[1]


void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )
     
{ 
    int nWords, nMats1, nMats2, nWords_Mats,  i, j;
    unsigned int dist;
    UINT32 *outp1, *outp2;
    UINT16 *pMat1;
    mxLogical *pMat2;
    
    /* Check for proper number of arguments */    
    if (nrhs != 3) { 
	mexErrMsgTxt("Three input arguments required."); 
    }
        
    /* Get dimensions of inputs */
    int n = (int) mxGetM(MAT1);
    int m = (int) mxGetN(MAT1);
    if (n != (int) mxGetM(MAT2) || m != (int) mxGetN(MAT2)) {
	mexErrMsgTxt("First and second arguments should be equal size matrices");
	return;
    }
    int k = (int) mxGetScalar(K);

    // Create output array
    OUT1 = mxCreateNumericMatrix(k, 1, mxUINT32_CLASS, mxREAL);
    outp1 = (UINT32*) mxGetPr(OUT1);

    OUT2 = mxCreateNumericMatrix(k, 1, mxUINT32_CLASS, mxREAL);
    outp2 = (UINT32*) mxGetPr(OUT2);
    
    pMat1 = (UINT16*) mxGetPr(MAT1);
    pMat2 = (mxLogical*) mxGetPr(MAT2);
    
    UINT32 *outp1cur = 0;
    UINT32 *outp2cur = 0;
    outp1cur = outp1;
    outp2cur = outp2;
    UINT16 *pMat1cur = pMat1;
    mxLogical *pMat2cur = pMat2;
    for (int j=0; j<m; j++) {
	// outp1cur = outp1 + j*k;
	// outp2cur = outp2 + j*k;
	for (int i=0; i<n; i++) {
	    outp1cur[pMat1cur[i]] = outp1cur[pMat1cur[i]] + (UINT32)pMat2cur[i];
	    outp2cur[pMat1cur[i]]++;
	}
	pMat1cur += n;
	pMat2cur += n;
    }
    return;
}
