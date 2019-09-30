# EE286-MP1
Synthesizer Machine Problem

# Methodology

## Spectrogram

# Trumpet 
As seen in the spectrogram below, the trumpet shows peaks at F0 = 440Hz and its other harmonics at nF0. The energy is consistent along the time domain, and the energy decreases at higher harmonics.

![Figure X](https://github.com/carldegs/EE286-MP1/blob/master/spectrogram_trumpet.png?raw=true)

# Piano
The piano also shows peaks at F0 = 440Hz and its harmonics but it is non-evident as it reached the 7th and 8th harmonics. The energy in the time domain is also not consistent, with multiple tracks at each pitch.

![Figure X](https://github.com/carldegs/EE286-MP1/blob/master/spectrogram_piano.png?raw=true)

## Envelope
Instead of creating an ADSR envelope, **Hilbert Transform** is used to create an envelope based on the original signal. The created envelope as seen below.

![Figure X](https://github.com/carldegs/EE286-MP1/blob/master/piano_envelope.jpg?raw=true)

Applying this to the sum of sine waves at f = NF0 (N = 1:6) then adding a high pass filter at f = 3kHz returns the synthesized piano.
![Figure X](https://github.com/carldegs/EE286-MP1/blob/master/piano_synth.jpg?raw=true)


# Snare
The snare is an unpitched percussion instrument. This is illustrated in the spectrogram below, which unlike the piano or the trumpet, does not show peaks at multiples of an F0. 

![Figure X](https://github.com/carldegs/EE286-MP1/blob/master/spectrogram_snare.png?raw=true)

## ADSR Envelope

When a mechanical musical instrument produces sound, the relative volume of the sound produced changes over time. The way that this
varies is different from instrument to instrument [1]. 

A module was developed to extract ADSR parameters from the samples and use these to generate ADSR envelopes. The ADSR extractor identifies the attack start and end times, decay start and end times, sustain levels, and release start and end times by examining the differential of the intensity contour. 

The attack start is identified as the point where the power rises by at least 6dB per frame.  This 6dB threshold was chosen based on the average hearing thresholds for tones between 200Hz and 1000Hz. The attack ends on reaching the maxima of the intensity contour.
The decay phase also starts at this point. To identify the decay's end, the ADSR extractor traverses the intensity differential forward in time, until it reaches a change >=0dB, which ends the decay phase.
The sustain phase is identified by 
The following diagram shows the intensity contours of each sample plotted against the generated ADSR envelope. The attack, decay and release time bounds are marked as x on the plots.

![Figure X](https://github.com/narzdavid/EE286-MP1/blob/master/envelopes.jpg)
Figure X. ADSR Envelopes

## Snare Synthesis

# Results

# References 

[1] CM3106 Chapter 5: Digital Audio Synthesis
Prof David Marshall
dave.marshall@cs.cardiff.ac.uk
and
Dr Kirill Sidorov
School of Computer Science & Informatics
Cardi University, UK
[2] Florian LE BOURDAIS, "Understanding the Karplus-Strong with Python (Synthetic Guitar Sounds Included)",  20 Apr 2017, https://flothesof.github.io/Karplus-Strong-algorithm-Python.html
