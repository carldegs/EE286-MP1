# EE286-MP1
Synthesizer Machine Problem

# Methodology

## Spectrogram

# Trumpet 
# Piano

# Snare
The snare is an unpitched percussion instrument. This is illustrated in the spectrogram below, which unlike the piano or the trumpet, does not show peaks at multiples of an F0. 


## ADSR Envelope

When a mechanical musical instrument produces sound, the relative volume of the sound produced changes over time. The way that this
varies is different from instrument to instrument [1]. 

A module was developed to extract ADSR parameters from the samples and use these to generate ADSR envelopes. The ADSR extractor identifies the attack start and end times, decay start and end times, sustain levels, and release start and end times by examining the differential of the intensity contour. 

The attack start is identified as the point where the power rises by at least 6dB per frame.  This 6dB threshold was chosen based on the average hearing thresholds for tones between 200Hz and 1000Hz. The attack ends on reaching the maxima of the intensity contour.
The decay phase also starts at this point. To identify the decay's end, the ADSR extractor traverses the intensity differential forward in time, until it reaches a change >=0dB, which ends the decay phase.
The sustain phase is identified by 
The following diagram shows the intensity contours of each sample plotted against the generated ADSR envelope. The attack, decay and release time bounds are marked as x on the plots.

![Figure 1](https://github.com/narzdavid/EE286-MP1/blob/master/envelopes.jpg)
Figure 1. ADSR Envelopes

## Snare Synthesis

# Results

# References 

[1] CM3106 Chapter 5: Digital Audio Synthesis
Prof David Marshall
dave.marshall@cs.cardiff.ac.uk
and
Dr Kirill Sidorov
K.Sidorov@cs.cf.ac.uk
www.facebook.com/kirill.sidorov
School of Computer Science & Informatics
Cardi University, UK
