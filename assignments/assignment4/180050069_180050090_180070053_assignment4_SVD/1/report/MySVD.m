%% Function for computing SVD

function [U S V]=MySVD(A)
    [U eig_values1]=eig(A*A');
    [V eig_values2]=eig(A'*A);
    [m m]=size(U);
    [n n]=size(V);
    if m>n
        S=eig_values1(:,m-n+1:end);
    else
        S=eig_values2(n-m+1:end,:);
    end
    S=S.^(0.5);
    LHS=A*V;
    RHS=U*S;
    %To check for the sign of eigenvectors because with the constraint
    %a'a=1 two vectors a and -a are possible
    for i=1:n
        if norm(LHS(:,i)-RHS(:,i))>=10e-2
            U(:,i)=-1*U(:,i);
        end
        
end