Authors: Meixia Lin, Defeng Sun, and Kim-Chuan Toh. 

A MATLAB software is designed to solve the multivariate convex regression problems of the form:
   (P)  min  0.5*||theta-Y||^2 + p(y)
        s.t. eta + A*theta - B*xi = 0
             xi - y = 0
             eta <= 0
      where p(.) is an indicate function of a given convex closed set D,
      A*theta = theta*e' - e*theta'
      B*xi = mat*diag(B_1,...,B_n)*[xi_1;...;xi_n]
      B_j = X'-e*X_j'
   (D)  max  0.5*||Y||^2 - 0.5*||Y+A^*u||^2 - p^*(-B^*u)
        s.t. u >= 0
=========================================================================================================================
Set up:

In the Matlab command window, type: 
>> Startup

Run files are provided for demonstration purpose: 
(a) test_cvx_reg_random: pALLM for convex regression problems with randomly generated data
(b) test_cg_cvx_reg_random: CGM+pALLM for convex regression problems with randomly generated data


Real datasets:  ex1029.mat (downloaded from R package Sleuth2 https://cran.r-project.org/web/packages/Sleuth2/index.html)
                2011_2520data.mat (downloaded from the website of Chile's National Institute of Statistics)
                Belgianla.mat (downloaded from https://www.wiley.com/legacy/wileychi/verbeek2ed/datasets.html)



