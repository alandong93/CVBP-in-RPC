function [xIQ, tr, fr] = iq_demod(x, f0, fs, bw)

if size(x,1) == 1, x = x.'; end

t = (0:length(x)-1).'/fs; % time vector [s]

mixI = 2 * cos(2*pi*f0*t);
mixQ = 2 * -sin(2*pi*f0*t);

xIQ = x .* mixI + 1i .* x .* mixQ;

fr = min(bw * 10, fs);
M = floor(fs / fr); % downsampling factor
fr = fs / M;

avg = mean(xIQ);
xIQ = xIQ - avg;

m = M;
while mod(m, 10)==0
    xIQ = resample(xIQ, 1, 10);
    m = m / 10;
end
if m > 1
    xIQ = resample(xIQ, 1, m);
end

xIQ = lowpass(xIQ, bw, fr, 'Steepness', 0.95);
xIQ = xIQ + avg;
tr = t(1:M:end);

end
