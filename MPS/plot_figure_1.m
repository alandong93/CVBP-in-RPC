clear

load('G100_P200_G100_MDA_50mbar_4sines_4Vpp.mat');

figure(1); clf;
plot_inds = 1:length(freq_vec);
num_plot = length(plot_inds);
time_mask = tr>=3.25 & tr<3.5;

chunk = abs(Z_mat(time_mask, :));
chunk_orig = chunk;
avg = mean(chunk, 1);
bandwidth = 1e3;
chunk_lpf = lowpass(chunk - avg, bandwidth, fr, 'steepness', 0.95) + avg; % lowpass filtered data

thresh = 25e3;
alph = 0.69;
wname = 'bior1.3';

chunk_clean = joint_wavelet_clean(lowpass(chunk - avg, 1, fr, 'steepness', 0.95) + avg, wname, thresh);
avg = mean(chunk_clean, 1);
chunk_clean = filtfilt(hanning(50)./sum(hanning(50)), 1, chunk_clean - avg) + avg;
chunk_both = alph * chunk_clean + (1-alph) * chunk; % cleaned up

for num = 1:num_plot
    ax(num) = subplot(4, 5, (num-1)*5+1); cla; hold on;    
    plot(tr(time_mask), abs(chunk_both(:, plot_inds(num))), '-', 'linewidth', 2);
%     plot(tr(time_mask), abs(chunk_lpf(:, plot_inds(num))), ':', 'linewidth', 2);
    ylabel(sprintf('real(Z) @ %d kHz [MOhm]', round(freq_vec(plot_inds(num))/1e3)));
end
linkaxes(ax, 'x');
set(gca, 'xlim', [3.335, 3.415]);
xlabel('Time [s]');
