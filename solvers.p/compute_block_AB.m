function eta_full_tmp = compute_block_AB(idx_tmp,theta,xi,X)
xi_tmp = xi(:,idx_tmp);
X_tmp = X(:,idx_tmp);
eta_full_tmp = X'*xi_tmp-sum(X_tmp.*xi_tmp,1)-theta+theta(idx_tmp)';
end

