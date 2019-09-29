function [S, F, T] = plot_spectrogram( file_path, max_freq )
%PLOT_SPECTROGRAM Plot spectogram of a wav file
    [x, fs] = audioread(file_path);
    x = x(:,1);
    % soundsc(x,fs);
    figure();
    [S, F, T] = spectrogram(x, 256*4, [], 0:max_freq, fs, 'yaxis');
    spectrogram(x, power(2,10), [], 0:max_freq, fs, 'yaxis');
    title(file_path);
end

