close all;

plot_spectrogram('snare.wav', 10000);

[snare,snareFS] = audioread('snare.wav');
soundsc(snare, snareFS);
snare = snare(:,1)';

%% Extract ADSR params
[snareAttack, snareDecay, snareSustain, snareRelease] = getADSR(snare, snareFS);

%% Generate ADSR envelope
snareADSREnvelope = ADSRenvelope(snareAttack, snareDecay, snareSustain, snareRelease,0.1,8000);
figure; plot(snareADSREnvelope);


%% Check Snare Spectrum
snareFFT = fft(snare);
snareMag = abs(snareFFT);
snareMag = snareMag./max(snareMag);
figure(2);plot(linspace(0, snareFS, length(snare)), (snareMag)); 
axis([0 1000 -1.1 1.1]);
figure(3);plot(linspace(0, snareFS, length(snare)), 20*log10(snareMag));
axis([0 1000 -40 10]);



%% Synthesize Snare
worig=linspace(0, snareFS, length(snare));
figure(4);plot(worig, (snareMag), 'r'); 
axis([0 1000 -1.1 1.1]); hold off;
for p=[0.5 0.6]
    for f=[220:230]

        fprintf("f=%ld, p=%0.2f \n", f, p);

        synthSnare=karplus_strong_drum(snareADSREnvelope, snareFS, round(snareFS/f),p);
        soundsc(snare, snareFS);
        pause;
        soundsc(synthSnare,snareFS);
        synthSnareMag = fft(synthSnare);
        synthSnareMag = abs(synthSnareMag);
        synthSnareMag= synthSnareMag./max(synthSnareMag);
        wsynth = linspace(0, snareFS, length(synthSnareMag));
        figure(4); plot(worig, mag2db(snareMag), 'r',wsynth, mag2db(synthSnareMag), 'g');
        axis([0 1000 -40 10]);
        hold off;
        pause;
    end

end

%% Selecting f=180
f=160;
p=0.3;
synthSnare=karplus_strong_drum(snareADSREnvelope, snareFS, round(snareFS/f),p);
soundsc((synthSnare), snareFS);
pause;