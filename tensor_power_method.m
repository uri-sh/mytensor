function [v,diffs] = tensor_power_method(T,num_iter)

tic;
if ~exist('num_iter','var')
    num_iter  = 200;
end
k = size(T,1);
if size(size(T),2) ~= 3
    error('Expecting an order 3 tensor');
end
if length(unique(size(T)))>1
    error('Input should have the same dimension for each order');
end

theta = randn(k,1);
theta = theta/norm(theta);


Tr = reshape(T,[k^2 k]);
diffs = zeros(num_iter,1);
for i=1:num_iter    
    theta_new = reshape(Tr*theta,[k k])*theta;
    theta_new = theta_new/norm(theta_new);
    diffs(i) = norm(theta_new-theta);
    theta = theta_new;
end
v = theta;
toc;
