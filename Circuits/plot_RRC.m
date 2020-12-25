clear

Ra1 = 10.01e3;
Ra2 = 9.999e3;
% Cb1 = 9.984e-9;
Cb2 = 9.92e-9;

Ra = mean([Ra1,Ra2]);
Cb = Cb2;

freq_Z = xlsread('RRC_without_e.csv', 'A18:E118');
f = freq_Z(:,1);
Z_open = freq_Z(:,4) + 1i .* freq_Z(:,5);

freq_Z = xlsread('RRC_with_e.csv', 'A18:E118');
Z_closed = freq_Z(:,4) + 1i .* freq_Z(:,5);

x = 2*pi*f * Ra * Cb;
z_open = Z_open / Ra;
z_closed = Z_closed / Ra;

figure(1); cla; hold on;
plot(x, abs(z_open), 'o');
plot(x, abs(z_closed), 'o');
set(gca,'xscale','log','yscale','log');

set(gca,'xlim',[1/sqrt(2)/4,10]);
set(gca,'ylim',[0.88,5.8]);
xticks([1,10]);
yticks([1,2,4]);


