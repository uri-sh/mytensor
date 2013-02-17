function [v1,v2,v3,v4,v5] = tensor_multiplication_comp(T,num_iter)

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

theta0 = randn(k,1);
theta0 = theta0/norm(theta0);
TT = tensor(T);

theta = theta0;
tic
for i=1:num_iter
    theta = double(ttv(ttv(TT,theta,1),theta,1));
    theta = theta/norm(theta);
end
toc
fprintf('tensor library \n');
v1 = theta;

theta = theta0;
tic;
for i=1:num_iter
    theta = tensor_mult1(T,theta,k);
    theta = theta/norm(theta);
end
toc
fprintf('bilinear form \n');
v2 = theta;

theta = theta0;
tic;
for i=1:num_iter
    theta = tensor_mult2(T,theta,k);
    theta = theta/norm(theta);
end
toc
fprintf('outer product form \n');
v3 = theta;

theta = theta0;
tic;
for i=1:num_iter
    theta = tensor_mult3(T,theta);
    theta = theta/norm(theta);
end
toc
fprintf('bsxfun \n');
v4 = theta;

theta = theta0;
tic;
Tr = reshape(T,[k^2 k]);
for i=1:num_iter
    theta = tensor_mult4(Tr,theta,k);
    theta = theta/norm(theta);
end
toc
fprintf('unroll \n');
v5 = theta;







function w = tensor_mult1(T,v,k)
%w = T(I,v,v)
w = zeros(k,1);
for i=1:k
    w(i) = v'*(T(:,:,i)*v);
end

function w = tensor_mult2(T,v,k)
%w = T(I,v,v)
w = zeros(k,1);
v_sq = v*v';
for i=1:k
    w(i) = sum(sum(T(:,:,i).*v_sq));
end

function w = tensor_mult3(T,v)
%w = T(I,v,v)
v_sq = v*v';
w = squeeze(sum(sum(bsxfun(@times,T,v_sq),2),1));

function w = tensor_mult4(Tr,v,k)
%w = T(I,v,v)
w = reshape(Tr*v,[k k])*v;

