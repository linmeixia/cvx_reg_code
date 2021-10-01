function [pstar,proxpar,prox_function_name] = generate_pstar(D_options,d,n)
proxpar.d = d;
proxpar.n = n;
prox_function_name = [];
if isfield(D_options,'knearest')
    k = D_options.k;
    normops = D_options.knearest;
    D_options.L = generate_knearest_L(X,Y,n,k,normops);
    if strcmp(normops,'1-norm')
        D_options.norm = 'inf-norm';
    elseif strcmp(normops,'2-norm')
        D_options.norm = '2-norm';
    elseif strcmp(normops,'inf-norm')
        D_options.norm = '1-norm';
    end
end
if isempty(D_options)
    pstar = @(x) 0;
elseif isfield(D_options,'norm')
    if isfield(D_options,'L')
        proxpar.L = D_options.L;
    else
        proxpar.L = 1;
    end
    if strcmp(D_options.norm,'1-norm')
        prox_function_name = 'proxL1_mat';
        pstar = @(x) pstar_1norm(x,proxpar);
    elseif strcmp(D_options.norm,'2-norm')
        prox_function_name = 'proxL2_mat';
        pstar = @(x) pstar_2norm(x,proxpar);
    elseif strcmp(D_options.norm,'inf-norm')
        prox_function_name = 'proxLinf_mat';
        pstar = @(x) pstar_infnorm(x,proxpar);
    end
elseif isfield(D_options,'monotone')
    if strcmp(D_options.monotone,'non-increasing')
        prox_function_name = 'prox_negative';
        pstar = @(x) 0;
    elseif strcmp(D_options.monotone,'non-decreasing')
        prox_function_name = 'prox_positive';
        pstar = @(x) 0;
    elseif strcmp(D_options.monotone,'partial')
        prox_function_name = 'prox_partialmonotone';
        if isfield(D_options,'positiveindex')
            proxpar.positiveindex = D_options.positiveindex;
        end
        if isfield(D_options,'negativeindex')
            proxpar.negativeindex = D_options.negativeindex;
        end
        pstar = @(x) 0;
    elseif strcmp(D_options.monotone,'two_bound')
        prox_function_name = 'prox_two_bound';
        proxpar.LB = D_options.LB;
        proxpar.UB = D_options.UB;
        pstar = @(x) pstar_two_bound(x,proxpar);
    end
end
end