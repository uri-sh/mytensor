function T = make_rand_tensor(k)

T = randn(k,k,k);
T = T + permute(T,[1 3 2]) + permute(T,[2 1 3]) + permute(T,[2 3 1]) + permute(T,[3 1 2]) + permute(T,[3 2 1]);
T = T/6;
