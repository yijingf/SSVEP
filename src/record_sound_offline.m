ss = [];
for i = 1:length(in_te)
    s = play_sound(in_te(i));
    ss = [ss,s];
end
audiowrite('offline.wav',ss,2000)
% soundsc(ss)
% %labels = test_labels;
% % corr = corr_coef_cv;
% % N = 120;
% % l= {};
% % for i = 1:6
% %     temp = find(labels == i);
% %     l{i} = temp;
% % end
% % c = zeros(N,n_target);
% % threshold = zeros(1,n_target);
% % for i = 1:n_target
% %     c(l{i},i) = corr(l{i},i);
% %     s = nonzeros(c(:,i));
% %     threshold(i) = mean(s) - std(s);
% % end
% % ss = corr - repmat(threshold, N,1);
% % ss(find(ss<0))=0;
% % [~,sss] = max(ss,[],2);
% % 120-length(find(sss-labels~=0))
% nh = 6;
% fs = 250;
% L = fs*1.5;
% n_target = 6;
% f = [9,11,13,10,12,15];
% y = nan(2*nh, L, n_target);
% for i = 1:n_target
%     y(:,:,i) = refer(L, f(i), fs, nh);
% end