addpath(genpath('/home/lab/uri/matlab_data/tensor_toolbox'));

dim = 50;
rank = 5;
mode = 3;

T = zeros(dim,dim,dim);
v = randn(dim,rank);
lambda = rand(rank,1);

for r = 1:rank   
    for i=1:dim
        for j=1:dim
            for k=1:dim
                T(i,j,k) = T(i,j,k) + v(i,r)*v(j,r)*v(k,r);
            end
        end
    end    
end


theta = randn(dim,1);
theta = theta/norm(theta);
num_iter = 1000;
crr = nan(floor(num_iter/100),rank);
for i=1:100
    theta = double(ttv(ttv(TT,theta,1),theta,1));
    theta = theta/norm(theta);
    if mod(i,1) == 0
        crr(i,:) = corr(theta,v);
        disp(i);
    end        
end
corr(theta,v)