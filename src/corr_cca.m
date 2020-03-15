function corr_coef = corr_cca(tr, te, y,n_target, threshold)
if nargin < 5
    threshold = zeros(1,n_target);
end
corr_coef = nan(5,n_target);
%corr_coef = nan(4,n_target);

for i = 1:n_target
    [a1,~,r1,u1,v1] = canoncorr(te', y(:,:,i)'); %te-re
    [a2,b2,~,u2,v2] = canoncorr(te', tr(:,:,i)');%te-tr
    [a3,~,~,~,~] = canoncorr(tr(:,:,i)',y(:,:,i)');%tr-ref
    
    t = 1;
    r1 = corrcoef(u1(:,1:t),v1(:,1:t));
    corr_coef(1,i) = r1(1,2)-threshold(i);
    r2 = corrcoef(u2,v2);
    corr_coef(2,i) = r2(1,2);
    t1 = te'*a1;
    t2 = tr(:,:,i)'*a1;
    r3 = corrcoef(t1,t2);
    corr_coef(3,i) = r3(1,2);
    t1 = te'*a3;
    t2 = tr(:,:,i)'*a3;
    r4 = corrcoef(t1, t2);
    corr_coef(4,i) = r4(1,2);
    t1 = tr(:,:,i)'*a2;
    t2 = tr(:,:,i)'*b2;
    r5 = corrcoef(t1, t2);
    corr_coef(5,i) = r5(1,2);
end
s = sign(corr_coef);
%corr_coef = corr_coef.^2;
corr_coef = sum(s.* (corr_coef.^2));