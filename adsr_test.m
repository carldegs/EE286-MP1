close all;

%% Test 1 Test ADSRenvelope
% Generate an envelope with
% Attack 0.1s
% Decay 0.1s to 0.8
% Sustain 0.8 level for 0.1sec
% Release decays from 0.8 to near 0 in 0.1 sec
[tenv, env] = ADSRenvelope(0.1,0.1,0.8,0.1,0.3,8000);
figure(1);plot(tenv, env); 

%% Test 2 Test ADSR Extraction, piano
[x,fs]=audioread('Piano_mf_A4.wav');
[a,d,s,r,tP,P,sDuration] = getADSR(x,fs);
figure(2); subplot(3,1,1);
offset = max(tP)-(a+d+sDuration+r);
plot(tP, P);hold on; 
plot(offset, P(find(tP>=offset,1)), 'go'); 
plot(a+offset, P(find(tP>=a+offset,1)), 'rx'); 
plot(a+d+offset, P(find(tP>a+d+offset,1)), 'rx'); 
plot(linspace(offset+a+d, a+d+sDuration+offset ,100), s*ones(100), '--'); 
plot(offset+a+d+sDuration, P(find(tP>=a+d+sDuration+offset,1)), 'rx'); 

[tenv, env] = ADSRenvelope(a,d,s,r,sDuration+a+d,16000);
plot(tenv+offset,env, 'r'); hold off;

%% Test 3 Test ADSR Extraction, snare
[x,fs]=audioread('snare.wav');
[a,d,s,r,tP,P,sDuration] = getADSR(x,fs);
subplot(3,1,2);
plot(tP, P);hold on; 
plot(a, P(find(tP==a)), 'rx'); 
plot(a+d, P(find(tP==a+d)), 'rx'); 
plot(linspace(a+d, a+d+sDuration ,100), s*ones(100), '--'); 
plot(a+d+sDuration, P(find(tP==a+d+sDuration)), 'rx'); 

[tenv, env] = ADSRenvelope(a,d,s,r,sDuration+a+d,16000);
plot(tenv,env, 'r'); hold off;


%% Test 4 Test ADSR Extraction, Trumpet
[x,fs]=audioread('Trumpet_novib_A4.wav');
[a,d,s,r,tP,P,sDuration] = getADSR(x,fs);
subplot(3,1,3);
plot(tP, P);hold on; 
plot(a, P(find(tP==a)), 'rx'); 
plot(a+d, P(find(tP==a+d)), 'rx'); 
plot(linspace(a+d, a+d+sDuration ,100), s*ones(100), '--'); 
plot(a+d+sDuration, P(find(tP==a+d+sDuration)), 'rx'); 

[tenv, env] = ADSRenvelope(a,d,s,r,sDuration+a+d,16000);
plot(tenv,env, 'r'); hold off;



