clear;clc;close all;
%create variable for each number of the files

A = (1:70);
delimterinIN = ' ';
%The function below uploads all the files from the UCI data sheet into
%individual structures, rather than combining all of the data files into
%one. In addition I also coverted the structures into tables to make it
%easier to manage. 

%To read all of the data we have two for loops the first loop reads data
%files "data-01" through "data-09", the second gets files data-10 though
%data-70. It also changes its names to patient1 - patient70. 
%
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

Person55 = datafiles.Person55; % Assings a variable to Person1 files 
x = categorical(Person55.Var1); %Seperates the cells of "Var1'.  
%the date column on a diffrent cell to transform the data to a numberic,
%system that cab be used later to be plot. 

ttSubset = head(Person55,1327); %Looks for data based on a column paramater
fprintf('Please Enter a Code?\n');
V = input('Code 1: '); 
idx = (ttSubset.Var3 == V);
SelectedCode= ttSubset(idx,:); 
display(SelectedCode);
% The code above shows the results of the 1st code we are looking for 

ttSubset2 = head(Person55,1327); %Looks for data based on a column paramater
fprintf('Please Enter a Code?\n');
Vn = input('Code 2: '); 
idx = (ttSubset2.Var3 == Vn);
SelectedCode2= ttSubset2(idx,:); 
display(SelectedCode2); 
% The code above shows the results of the second code we are looking for 
g = SelectedCode2{:, "Var4"};

ttSubset3 = head(Person55,1327); %Looks for data based on a column paramater
fprintf('Please Enter a Code?\n');
Vn = input('Code 3: '); 
idx = (ttSubset3.Var3 == Vn);
SelectedCode3= ttSubset3(idx,:); 
display(SelectedCode3); 
% The code above shows the results of the second code we are looking for 
h = SelectedCode3{:, "Var4"};

%Graphing Code_______
 dn = datenum(SelectedCode.Var1,'mm-dd-yyyy'); 
 y = SelectedCode{:, "Var4"}; 
 plot(dn,y, 's','MarkerSize',10,...
    'MarkerEdgeColor','black',...
    'MarkerFaceColor','r'); 
hold on 
g = SelectedCode2{:, "Var4"};
plot(dn,g, 's','MarkerSize',10,...
    'MarkerEdgeColor','blue',...
    'MarkerFaceColor','k');  
hold on 
h = SelectedCode3{:, "Var4"};
plot(dn,h, 's','MarkerSize',10,...
    'MarkerEdgeColor','yellow',...
    'MarkerFaceColor','y'); 
legend('Regular insulin dose', 'NPH insulin dose', 'UltraLente insulin dose');  
title('Insulin Levels')
xlabel('Date')
ylabel('Insulin Dosage (mg)')
datetick('x', 'mm-dd-yyyy'); 


% 33 = Regular insulin dose
% 34 = NPH insulin dose
% 35 = UltraLente insulin dose
