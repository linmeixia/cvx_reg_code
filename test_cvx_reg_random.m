clear all
rng('default');
%%
run_ssnal = 1;
run_sGSADMM = 0;
%%
d = 2;
n = 100;
%%
phi = @(x) max(sum(x),0);
X = 2*(rand(d,n)-0.5);
Y = zeros(n,1);
for i = 1:n
    Y(i) = phi(X(:,i));
end
addnoise = 1;
if addnoise
    varY = var(Y);
    vareps = varY/3;
    eps = sqrt(vareps)*randn(n,1);
    Y = Y+eps;
end
Xorg = X;
Yorg = Y;
scaleoptions.scale = 1;
[X,Y,meanX,normX,meanY,normY] = data_processing(Xorg,Yorg,scaleoptions);
%%
OPTIONS.tol = 1e-4;
OPTIONS.sig_fix = 0;
D_options.monotone = 'non-decreasing';
%%
if run_ssnal
    [~,theta_SSNAL,xi_SSNAL,eta_SSNAL,y_SSNAL,u_SSNAL,v_SSNAL,~,runhist_SSNAL] = Multi_regression_SSNAL(X,Y,d,n,D_options,OPTIONS);
end
%%
if run_sGSADMM
    [~,theta_sGSADMM,xi_sGSADMM,eta_sGSADMM,y_sGSADMM,u_sGSADMM,v_sGSADMM,~,runhist_sGSADMM] = Multi_regression_sGS_ADMM(X,Y,d,n,D_options,OPTIONS);
end