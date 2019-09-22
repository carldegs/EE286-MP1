[x,fs]=audioread('snare.wav');
figure; plot(x(:,1));
[a,d,s,r,P,t] = getADSR(x,fs);
fs2=8000;
[tenv, env] = ADSRenvelope(a,d,s,r,1.0,fs2);
close all;
figure;plot(t, P); hold; 
plot(tenv,env);



