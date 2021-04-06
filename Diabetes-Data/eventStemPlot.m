
for i = 1:7,
subplot(8,1,i)
plot(tCode{i}, val{i})
axis([tmin(1) tmin(end) -inf inf])
end
subplot(8,1,8)
stem(tmin(iMeas), ones(length(iMeas), 1))
axis([tmin(1) tmin(end) -0.5 1.5])


subjectIDs = [1 3:21 23:24 26 28 30:39 41:68 70];

%% code 70 occurs > 5 times
iCol = find(codeNums == 70)
iRows = find(numEventsAll(:,iCol) > 5); % the rows for which code 70 occured more than 5 times
subjectIDs(iRows)

% 4     5     6    15    16    35    36    37    38

%% code 67
iCol = find(codeNums == 67)
iRows = find(numEventsAll(:,iCol) > 5); % the rows for which code 67 occured more than 5 times
subjectIDs(iRows)
%     3     4     8    11    12    13    14    15    16    32    33    34    35    36    37   51    52    54    58    59    60    62    65    67

