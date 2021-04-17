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

subj = 1;
nMeas = length(database(subj).data); % # of measurements

tmin = zeros(nMeas, 1);
codesForSubj = zeros(nMeas, 1);
dataForSubj = zeros(nMeas, 1);
dateForSubj = zeros(nMeas, 1); 

for iMeas = 1:nMeas,
    time = database(subj).data(iMeas).Var2;
    iColon =findstr(time, ':');
    hr = str2num(time(1:iColon-1));
    minutes = str2num(time(iColon+1:end));
    codesForSubj(iMeas) = database(subj).data(iMeas).Var3;
    dataForSubj(iMeas) =  database(subj).data(iMeas).Var4;
    dateForSubj(iMeas) = datenum(database(subj).data(iMeas).Var1); 
    tmin(iMeas) = dateForSubj(iMeas)*24*60 + hr*60+minutes; % time in minutes.
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
                                                                                                                                                                                       
codeNums = [58 59 61:71]; 

iCode = 1;
tCode = cell(length(codeNums), 1);
val = cell(length(codeNums), 1);

maxT = []; minT = [];
 for i = 1:13,
    maxT = [maxT max(tCode{i})];
    minT = [minT min(tCode{i})];
 end
maxTime = max(maxT);
minTime = min(minT);

figure('Name','Comparing');

codeNums1 = 58; 
 for code = codeNums1
   iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code 
   x1 = tmin(iMeas); 
   y1 = dataForSubj(iMeas);
   subplot(3,1,1);
   plot(x1, y1); 
   title('Pre-Breakfast'); 
   ylabel('Glucose Level'); 
 end
 codeNums2 = 62; 
 for code = codeNums2
   iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code 
   x2 = tmin(iMeas); 
   y2 = dataForSubj(iMeas);
   subplot(3,1,2);
   plot(x2, y2);
   title('Pre-Supper');
   ylabel('Glucose Level'); 
 end
%   codeNums2 = 63; 
%  for code = codeNums2
%    iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code 
%    x1 = tmin(iMeas); 
%    y1 = dataForSubj(iMeas);
%    subplot(5,1,3);
%    plot(x1, y1);
%    title('Post-supper blood glucose measurement');
%    ylabel('Glucose Level'); 
%  end
%   codeNums2 = 64; 
%  for code = codeNums2
%    iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code 
%    x1 = tmin(iMeas); 
%    y1 = dataForSubj(iMeas);
%    subplot(4,1,3);
%    plot(x1, y1);
%    title('Pre-snack blood glucose measurement');
%    ylabel('Glucose Level'); 
%  end
codeNums3 = 65; 
 %for code = codeNums3
 code = codeNums3;
  iMeas = find(codesForSubj == [code]); % all the indices of measurements where code was the given code
  subplot(3,1,3); 
  tEvents = tmin(iMeas);
  stem(tEvents, ones(length(iMeas), 1)); 
   title('HP');
 %end
 
 %% Sets all of the possible poins in the same time scale.
 
 tMinimum = min([min(x1) min(x2) min(tEvents)]);
 tMaximum = max([max(x1) max(x2) max(tEvents)]);
 timeInt = [tMinimum:500:tMaximum]; 
 y1Int = interp1(x1, y1, timeInt);
 y2Int = interp1(x2, y2, timeInt);
 
 tEventsInt = zeros(1, length(timeInt));
 for i = 1:length(tEvents),
     [mindiff, imin] = min(abs(timeInt- tEvents(i)));
     tEventsInt(imin) = 1;
 end
 
 iEvents = find(tEventsInt);
 iNonEvents = find(tEventsInt==0);
 figure;
% subplot(1,2,1);
 plot(y1Int(iEvents), y2Int(iEvents), 'gv');
 hold on;
 plot(y1Int(iNonEvents), y2Int(iNonEvents), 'rx');

figure;
boxplot([y1Int(iEvents) y1Int(iNonEvents) y2Int(iEvents) y2Int(iNonEvents)]', ...
    [zeros(length(iEvents),1); ones(length(iNonEvents),1); 2*ones(length(iEvents),1); 3*ones(length(iNonEvents),1)]); 
set(gca, 'FontSize', 14);
set(gca,'XTickLabel', {'y1 At Events' 'y1 No Events' 'y2 At Events' 'y2 No Events'})

y1era = [];
y2era = [];
for i = 1:length(iEvents)-1,
    y1era = [y1era; y1Int(iEvents(i)-5:iEvents(i)+5)];
    y2era = [y2era; y2Int(iEvents(i)-5:iEvents(i)+5)];
end

figure;
subplot(2,1,1);
plot([-5:5], mean(y1era, 1))
subplot(2,1,2);
plot([-5:5], mean(y2era, 1))
