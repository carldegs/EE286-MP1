%% PLOT SPECTOGRAM OF THE INSTRUMENTS
plot_spectrogram('Piano_mf_A4.wav', 5000);
plot_spectrogram('snare.wav', 20000);
plot_spectrogram('Trumpet_novib_A4.wav', 15000);

[snare,snareFS] = audioread('snare.wav');

%% Extract ADSR params
[snareAttack, snareDecay, snareSustain, snareRelease] = getADSR(snare, snareFS);


%% Generate ADSR envelope
snareADSREnvelope = ADSRenvelope(snareAttack, snareDecay, snareSustain, snareRelease,0.1,8000);

%% Compate ADSR envelope with original envelope
