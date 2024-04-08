clear all
close all

%% parameters
numInputs = 1;
numOutputs = 1;
r = 20;

%% impulse response
% load impulse response
[RIR_matrix,Fs] = audioread("rir-S1-R1-HOM1.wav");
% normalization
RIR_matrix = RIR_matrix ./ norm(RIR_matrix , "fro");

%% plot signal (8 channels)
for i = 1:8
    figure
    plot(RIR_matrix(:,i))
    title(strcat("single capsule ", num2str(i), " signal"));
end
%% silence 306
threshold = 5e-04; % da vedere!!
min_count = 48000;
for j = 1:8
    count = 0;
    for i=1:48000
        if (abs(RIR_matrix(i,j))<threshold)
            count = count+1;
        else 
            disp(count);
            if (min_count>count)
                min_count = count; 
            end
            break;
        end
    end
end
disp(strcat("min_count: ",num2str(min_count)));

%% segnale senza silenzio
y = RIR_matrix(min_count:end,:);
%% plot signal without silence (8 channels)
for i = 1:8
    figure
    plot(y(:,i))
    title(strcat("single capsule ", num2str(i), " signal"));
end
%% first channel
y_1 = y(:,1);

%% remove the initial noise of y to apply t60 
y__1 = y_1(1000-min_count:end); % come scegliere quanto rimuovere??
[rt,iidc] = t60(y__1,48000,1);
disp(rt);
cutoff_sample = (ceil(Fs*rt/1000));
y_1 = y_1(1:cutoff_sample);

%% plot new signal
figure
plot(y(:,1))
hold on
plot(y_1)
title(strcat("single capsule ", num2str(i), " signal"));

%% 
% normalization
%y = y/max(abs(y));
%y(:,2) = i;

%% subsampling (prima o dopo aver tolto il silenzio?)
y_sub = y_1(1:3:end, :);
%y_sub(:, :, 2) = y_sub(:, :);
 
%% MATLAB era on first channel
sys = era(y_sub(:,1));
%%
[y2,t2] = impulse(sys);
%%
figure
stairs(y_sub(:,1),'LineWidth',2);
hold on
stairs(y2(:),'LineWidth',1.2);


%% Compute ERA from impulse response on first channel
YY = permute(y_sub(:,1),[2 3 1]);
% dimension of hankel matrix
mco = floor((length(YY)-1)/2);  % m_c = m_o = (m-1)/2
% ERA
[Ar,Br,Cr,Dr,HSVs] = ERA(YY,mco,mco,numInputs,numOutputs,r);

%% state-space model
sysERA = ss(Ar,Br,Cr,Dr,-1);
% reduced impulse response
[y2,t2] = impulse(sysERA, 0:1:15845);

%% plot
% plot hankel singular values vs r
figure
plot(HSVs)
title('Hankel singular values');

% plot original impulse response vs reduced impulse response
figure
stairs(y_sub(:,1),'LineWidth',2);
hold on
stairs(y2(:),'LineWidth',1.2);

%% MSE
mse = mean((y_sub(:,1)-y2).^2);