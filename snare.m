close all;

plot_spectrogram('snare.wav', 10000);

[snare,snareFS] = audioread('snare.wav');
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
for p=[0 0.7 0.8]
    for f=[160 165]
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

%% Generate ADSR envelope
synthSnare= fm_synthesis(snareADSREnvelope, snareFS, 180, 40,20);
synthSnare=filter([0.5 0.5]*0.99, 1, synthSnare);
soundsc((synthSnare), snareFS);


%% Selecting f=170
f=170;
p=0.3;
stretch=1.5;
synthSnare=karplus_strong_drum(snareADSREnvelope, snareFS, round(snareFS/f),p, stretch, 'dc');
soundsc((synthSnare), snareFS);


%% Selecting f=170
f=170;
p=0.4;
stretch=1.5;
synthSnare=karplus_strong_drum(snareADSREnvelope, snareFS, round(snareFS/f),p, stretch);
soundsc((synthSnare), snareFS);

%% Selecting f=160
f=180;
p=0.5;
stretch=1.5;
synthSnare=karplus_strong_drum(snareADSREnvelope, snareFS, round(snareFS/f),p, stretch);
soundsc((synthSnare), snareFS);

