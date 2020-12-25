% close all
% clear
% clc

%% load model

model = mphload('G100P200G100.mph');

%% prepare loop

l_vec = [5,10,20,50,100,200,500,1000,2000,5000,10000] * 1e-6;
N = length(l_vec);
f_vec = logspace(3,9,601);
Z_mat = zeros(length(f_vec), N);

tic;
for n = 1:N

fprintf('Simulation %d of %d\n', n, N);

%% set pad length and solve

l_str = [num2str(l_vec(n)) ' [m]'];

model.param.set('lp', l_str);
model.param.set('Cs', '0.013 [F/m^2]');
% model.param.set('xc', 'xpad');
model.param.set('xc', 'xout');
model.study('std1').run;
params = mphgetexpressions(model.param);

Z = mpheval(model,'(ec.V0_1-ec.V0_2)/ec.I0_1').d1(:,1);
Z_mat(:,n) = Z;

% save('Z_mat_G100P200G100_pad_lengths_xpad.mat', 'l_vec', 'f_vec', 'Z_mat', 'params');
save('Z_mat_G100P200G100_pad_lengths_xout.mat', 'l_vec', 'f_vec', 'Z_mat', 'params');

%%

tn = toc;
fprintf('Elapsed time: %s\n', datestr(seconds(tn),'HH:MM:SS'));
tN = tn / n * N;
fprintf('Remaining time: %s\n', datestr(seconds(tN-tn),'HH:MM:SS'));

end
