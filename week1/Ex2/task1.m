A = (0:255);
step = 256/4;

% Each value of A will be rounded by step
QA1 = quant(A, step);

% Create partition, each value is a cut-off index in A
partition = step:step:256-step;

% Create codebook, each value that will 
% replace A's value at each cut-off index
codebook = step/2:step:256-step/2;

% This will replace A's value by values in codebook
% each index will have its own bin base on the
% partition
[indx,QA2] = quantiz(A, partition, codebook);

% Unique value in QA1 and QA2
unique_QA1 = unique(QA1)
unique_QA2 = unique(QA2)
