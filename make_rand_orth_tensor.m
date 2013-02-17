function T = make_rand_orth_tensor(dim,rnk)

T = randn(rnk,rnk,rnk);
T = T + permute(T,[1 3 2]) + permute(T,[2 1 3]) + permute(T,[2 3 1]) + permute(T,[3 1 2]) + permute(T,[3 2 1]);
T = T/6;
