%% ERA
% nin,nout number of inputs and outputs
% m,n dimensions of Hankel matrix
% r, dimensions of reduced model
function [Ar,Br,Cr,Dr,HSVs] = ERA(YY,m,n,nin,nout,r)

% Code to format data into Hankel matrix H
for i=1:nout
    for j=1:nin
        Dr(i,j) = YY(i,j,1);
        Y(i,j,:) = YY(i,j,2:end);
    end
end

% i refers to i-th output
% j refers to j-th input
% k refers to k-th timestep

assert(length(Y(:,1,1))==nout);
assert(length(Y(1,:,1))==nin);
assert(length(Y(1,1,:))>=m+n);

H = zeros(nout*m-nout+nout,nin*n-nin+nin);
H2 = zeros(nout*m-nout+nout,nin*n-nin+nin);

for i=1:m
    for j=1:n
        for Q=1:nout
            for P=1:nin
                % hankel matrix
                H(nout*i-nout+Q,nin*j-nin+P) = Y(Q,P,i+j-1);
                % hankel prime matrix
                H2(nout*i-nout+Q,nin*j-nin+P) = Y(Q,P,i+j);
            end
        end
    end
end

% singular value decomposition
[U,S,V] = svd(H,'econ');

% Hankel singular values
HSVs = diag(S);

% reduced model
Sigma = S(1:r,1:r);
Ur = U(:,1:r);
Vr = V(:,1:r);
Ar = Sigma^(-.5)*Ur'*H2*Vr*Sigma^(-.5);
Br = Sigma^(-.5)*Ur'*H(:,1:nin);
Cr = H(1:nout,:)*Vr*Sigma^(-.5);