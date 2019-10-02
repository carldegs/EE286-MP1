function y = fm_synthesis(envelope, fs, fc, fm, Imag)
    t = (0:length(envelope)-1)/fs;
    I = t.*Imag/(fs/length(envelope));
    y = envelope.*sin(2*pi*fc*t + I.*sin(2*pi*fm*t));
end