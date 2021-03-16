clear;clc;close all;

A = (1:70);
delimterinIN = ' ';

for k = 1:70,
    
    N = string(A(k));
    if k < 10,
        fileName = strcat('data-0',N);
    else
        fileName = strcat('data-',N);
    end
    tablek = readtable(fileName);
    database(k).data = table2struct(tablek);
end

subj = 65;
nMeas = length(database(subj).data); % # of measurements

tmin = zeros(nMeas, 1);
codesForSubj = zeros(nMeas, 1);
dataForSubj = zeros(nMeas, 1);
dateForSubj = zeros(nMeas, 1); 

for iMeas = 1:nMeas,
    time = database(subj).data(iMeas).Var2;
    iColon =findstr(time, ':');
    hr = str2num(time(1:iColon-1));
    min = str2num(time(iColon+1:end));
    codesForSubj(iMeas) = database(subj).data(iMeas).Var3;
    dataForSubj(iMeas) =  database(subj).data(iMeas).Var4;
    dateForSubj(iMeas) = datenum(database(subj).data(iMeas).Var1); 
    tmin(iMeas) = dateForSubj(iMeas)*24*60 + hr*60+min; % time in minutes.
end

%% Find all the measurements for a particular variable code (Var 3)
% 34 = NPH insulin dose
% 35 = UltraLente insulin dose
% 48 = Unspecified blood glucose measurement
% 57 = Unspecified blood glucose measurement
% 58 = Pre-breakfast blood glucose measurement
% 59 = Post-breakfast blood glucose measurement
% 60 = Pre-lunch blood glucose measurement
% 61 = Post-lunch blood glucose measurement
% 62 = Pre-supper blood glucose measurement
% 63 = Post-supper blood glucose measurement
% 64 = Pre-snack blood glucose measurement
% 65 = Hypoglycemic symptoms
% 66 = Typical meal ingestion
% 67 = More-than-usual meal ingestion
% 68 = Less-than-usual meal ingestion
% 69 = Typical exercise activity
% 70 = More-than-usual exercise activity
% 71 = Less-than-usual exercise activity
% 72 = Unspecified special event

codeNums = 62; 

for code = codeNums
   
   iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code
   figure(codeNums); 
   hold on
   plot(tmin(iMeas), dataForSubj(iMeas)); 
   x1 = tmin(iMeas); 
   y1 = dataForSubj(iMeas); 
end

codeNums2 = 60; 

for code = codeNums2
   
   iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code
   figure(codeNums2); 
   hold on
   plot(tmin(iMeas), dataForSubj(iMeas)); 
   x2 = tmin(iMeas); 
   y2 = dataForSubj(iMeas);
end
%% Look for correlation between 2 different codes.
%% need to get 1-to-1 time correspondence between the 2 signals.

% find the range of times for the data for both
% create desired time vector of evenly (and finely) spaced points across
% the bigger range of the two.

%interpolate signal 1 onto the desired time vector
%interpolate signal 2 onto the desired time vector

% then create a dot plot of interpoloated data 1 vs interpolated data 2

figure(1); 
plot(x1, y1, x2, y2); 
Vq = interp1(x2,y2,x1); 
figure(2); 
plot(x2, y2, x1, Vq); 