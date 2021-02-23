clear;clc;close all;

A = (1:70);
delimterinIN = ' ';
%{The function below uploads all the files from the UCI data sheet into
%individual structures, rather than combining all of the data files into
%one. In addition I also coverted the structures into tables to make it
%easier to manage. 

%To read all of the data we have two for loops the first loop reads data
%files "data-01" through "data-09", the second gets files data-10 though
%data-70. It also changes its names to patient1 - patient70. 

%% System that opens and saves the information of each persom 
for k = 1:9
    
    N = string(A(k));
    fileName = strcat('data-0',N);
    data = strcat('Person',num2str(k));
    datafiles.(data) = readtable(fileName);
    
end

for i = 10:70

    N = string(A(i));
    fileName = strcat('data-',N);
    data = strcat('Person',num2str(i));
    datafiles.(data) = readtable(fileName);
    
end

fld = fieldnames(datafiles);

for n = 1:70
    
    dataset = datafiles.(fld{n});
    d2 = table2cell(dataset);
    data = strcat('Person',num2str(n));
    datafiles2.(data) = d2;
  
end

%% Need to determine how to make a loop that opens everyones files: 

Person = datafiles.Person1;
codes = unique(Person.Var3);
figure;
tmax = max(datenum(Person.Var1));
tmin = min(datenum(Person.Var1));

nCodes = length(codes);
maxSubplots = 3;
for i = 1:nCodes
    idx = (Person.Var3 == codes(i));
    values = Person.Var4(idx);
    time = datenum(Person.Var1(idx)); % convert date-string to a # representing time
    figure(ceil(i/maxSubplots));
    subplot(maxSubplots, 1, (mod(i, maxSubplots)==0)*3 + mod(i, maxSubplots));
    plot(time, values, 'k-','MarkerIndices',1:1:length(values));
    datetick('x', 'mm-dd-yyyy'); 
    %iCode = find(codeNums == codes(i));
    %ylabel(CodeAbbrev(iCode))
    axis([tmin tmax -inf inf]);
    ylabel('Insulin-Dosage(mg)');
end

%create variable for each number of the files

% codeNums = [33:35 48 57:72];
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

