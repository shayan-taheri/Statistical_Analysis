clear all; close all; clc;
uiopen('C:\Users\shaya\Desktop\Midterm_Project\Original Data\schdata.xlsx',1);

Cat_1 = sum(read <= 40)
Cat_2 = sum(40 < read & read <= 46)
Cat_3 = sum(46 < read & read <= 48)
Cat_4 = sum(48 < read & read <= 52)
Cat_5 = sum(read > 52)

% Cat_1 = 10
% Cat_2 = 11
% Cat_3 = 13
% Cat_4 = 9
% Cat_5 = 12

Data_Mean = mean(read)
Data_Std = std(read)

% Data_Mean = 47.7636
% Data_Std = 8.8170