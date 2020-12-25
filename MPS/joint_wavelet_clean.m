function chunk_clean = joint_wavelet_clean(chunk, wname, thresh)
% chunk is time x freq
% wname = 'haar';

% o = chunk(1,:);
% chunk = chunk(2:end,:) - chunk(1:end-1,:);

% m = mean(chunk,1);
m = min(chunk,1);
chunk = chunk - m;
len_orig = size(chunk,1);
num_freq = size(chunk,2);
if mod(log2(len_orig), 1) ~= 0
    len = 2^nextpow2(len_orig);
    chunk = [chunk; zeros(len - len_orig, num_freq)]; % pad
else
    len = len_orig;
end
for i = 1:num_freq
    [c,l] = wavedec(chunk(:,i), log2(len), wname);
    c_mat(:,i) = c;
end
c_mat_clean = hardThresh(c_mat, thresh);
% c_mat_clean(end/2+1:end,:) = 0;
for i = 1:num_freq
%     c_clean = c_mat_clean(:,i);
    chunk_clean(:,i) = waverec(c_mat_clean(:,i), l, wname);
end
% p = 0.4;
% chunk_clean = filtfilt([0.5-p/2,p,0.5-p/2],1,chunk_clean);
chunk_clean(len_orig+1:end,:) = [];
chunk_clean = chunk_clean + m;

% chunk_clean = cumsum([o; chunk_clean]);
end

function x = hardThresh(y, t)
% apply joint sparsity hard-thresholding across 2nd dimension
absy = sqrt(sum(abs(y).^2, 2));
unity = y ./ (repmat(absy, [1,size(y,2)]) + eps);
absy(absy < t) = 0;
x = unity .* repmat(absy, [1,size(y,2)]);
end