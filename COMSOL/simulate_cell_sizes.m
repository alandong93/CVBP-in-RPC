% close all
% clear
% clc

%% load model

model = mphload('G100P200G100.mph');

%% prepare loop

d_vec = 1e-6:1e-6:15e-6;
N = length(d_vec);
f_vec = logspace(2,6,101);
Z_mat = zeros(length(f_vec), N);

tic;
for n = 1:N

fprintf('Simulation %d of %d\n', n, N);

%% set cell size and solve

d_str = [num2str(d_vec(n)) ' [m]'];

model.param.set('dc', d_str);
model.param.set('Cs', '0.013 [F/m^2]');
model.study('std1').run;
params = mphgetexpressions(model.param);

Z = mpheval(model,'(ec.V0_1-ec.V0_2)/ec.I0_1').d1(:,1);
Z_mat(:,n) = Z;

save('Z_mat_G100P200G100_cell_sizes.mat', 'd_vec', 'f_vec', 'Z_mat', 'params');

%%

tn = toc;
fprintf('Elapsed time: %s\n', datestr(seconds(tn),'HH:MM:SS'));
tN = tn / n * N;
fprintf('Remaining time: %s\n', datestr(seconds(tN-tn),'HH:MM:SS'));

end
