close all
clear
clc

load('V_raw.mat');
load('I_raw.mat');
bw = 5000;

% iq demod
Z_mat = [];
if ~exist('freq_vec','var')
    freq_vec = fc;
    phi_vec = 0;
end
for f = freq_vec
    [VIQ, tr, fr] = iq_demod(detrend(V), f, fs, bw);
    [IIQ, tr, fr] = iq_demod(detrend(I), f, fs, bw);
    Z = VIQ ./ IIQ;
    Z_mat = [Z_mat, Z];
end
outName = 'G100_P200_G100_MDA_50mbar_4sines_4Vpp.mat';
Vp = Vp * 4;
save(outName, 'Z_mat', 'R_TIA', 'freq_vec', 'phi_vec', 'fr', 'tr', 'fs', 'Vp', 'bw');
