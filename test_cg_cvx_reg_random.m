clear all
rng('default');
%%
d_list = 2;
n_list = 10000;
%%
OPTIONS.tol = 1e-4;
OPTIONS.use_proximal = 1;
D_options = [];
%%
n_test = length(d_list);
%%
table = cell(n_test+1,11);
table{1,1} = 'd';
table{1,2} = 'n';
table{1,3} = 'CGM rounds';
table{1,4} = 'R_KKT';
table{1,5} = 'R_GAP';
table{1,6} = 'hatR_viotol';
table{1,7} = 'hatR_pinfeas';
table{1,8} = 'Time';
table{1,9} = 'Time(CGM)';
table{1,10} = 'Time(pALM)';
table{1,11} = 'Time(OPT)';
for i_test = 1:n_test
    d = d_list(i_test);
    n = n_list(i_test);
    %%
    phi = @(x) 5*norm(x,inf)+norm(x)^2;
    X = 2*(rand(d,n)-0.5);
    Y = zeros(n,1);
    for i = 1:n
        Y(i) = phi(X(:,i));
    end
    varY = var(Y);
    vareps = varY/10;
    eps = sqrt(vareps)*randn(n,1);
    Y = Y+eps;
    %%
    Xorg = X;
    Yorg = Y;
    scaleoptions.scale = 1;
    [X,Y,meanX,normX,meanY,normY] = data_processing(Xorg,Yorg,scaleoptions);
    [pstar,proxpar] = generate_pstar(D_options,d,n);
    %%
    if d == 2
        n_reduced = 50*n;
    else
        n_reduced = 10*n;
    end
    %%
    num_block = 10;
    n_block = n/num_block;
    fun.pstar = pstar;
    fun.alg = @(I,J) Multi_regression_SSNAL_vec(I,J,X,Y,d,n,D_options,OPTIONS);
    fun.warm_alg = @(I,J,theta,xi,eta,y,u,v) Multi_regression_SSNAL_vec(I,J,X,Y,d,n,D_options,OPTIONS,theta,xi,eta,y,u,v);
    [path_result_AS_SSNAL,num_circle,theta,xi] = constraint_generation_procedure(X,Y,d,n,D_options,OPTIONS,n_reduced,num_block,fun);
    %%
    path_result_AS_SSNAL{num_circle+2,1} = 'Time of whole procedure';
    path_result_AS_SSNAL{num_circle+2,2} = 0;
    for i = 1:num_circle
        path_result_AS_SSNAL{num_circle+2,2}  = path_result_AS_SSNAL{num_circle+2,2}+path_result_AS_SSNAL{i+1,4};
    end
    %%
    paper_max_violation = 0;
    paper_prim_infeas = 0;
    xi = reshape(xi,d,n);
    for j = 1:num_block
        idx_tmp = (j-1)*n_block+1:j*n_block;
        eta_full_tmp = compute_block_AB(idx_tmp,theta,xi,X);
        ueta_tmp = max(eta_full_tmp,0);
        paper_max_violation = max(paper_max_violation,max(max(ueta_tmp)));
        paper_prim_infeas = paper_prim_infeas+norm(ueta_tmp,'fro')^2;
        clear ueta_tmp;
    end
    xi = reshape(xi,d*n,1);
    paper_prim_infeas = sqrt(paper_prim_infeas)/n;
    %%
    path_result_AS_SSNAL{num_circle+3,1} = 'paper_max_violation';
    path_result_AS_SSNAL{num_circle+3,2} = paper_max_violation;
    path_result_AS_SSNAL{num_circle+4,1} = 'paper_prim_infeas';
    path_result_AS_SSNAL{num_circle+4,2} = paper_prim_infeas;
    clear theta;
    clear eps;
    clear eta_full_tmp;
    clear idx_tmp;
    clear xi;
    %%
    table{i_test+1,1} = d;
    table{i_test+1,2} = n;
    table{i_test+1,3} = num_circle;
    table{i_test+1,4} = path_result_AS_SSNAL{num_circle+1,8};
    table{i_test+1,5} = path_result_AS_SSNAL{num_circle+1,9};
    table{i_test+1,6} = path_result_AS_SSNAL{num_circle+3,2};
    table{i_test+1,7} = path_result_AS_SSNAL{num_circle+4,2};
    table{i_test+1,8} = path_result_AS_SSNAL{num_circle+2,2};
    table{i_test+1,9} = sum([path_result_AS_SSNAL{3:num_circle+1,5}]);
    table{i_test+1,10} = sum([path_result_AS_SSNAL{2:num_circle+1,6}]);
    table{i_test+1,11} = sum([path_result_AS_SSNAL{2:num_circle+1,7}]);
end