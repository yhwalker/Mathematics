function class = classify(sample,training,group)
%����ͳ�ƾ���
%class = classify(��Ʒ����ѵ��Ʒ����ѵ��Ʒ���)������Ʒ���ࡣ
%         ��Ʒ��Ϊn*p����ѵ��Ʒ��Ϊm*p����
%         ���Ϊmά����������ʾ��ѵ��Ʒ���ࡣ
%         classΪnά�����������ظ���Ʒ���ࡣ
%
%����
%     load discrim      %MATLAB�ڲ����ݣ���������329����������ס����9��ָ��
%       					  %����1��2����
%     sample = ratings(idx,:);       %��ʵidx����2��
%     training = ratings(1:200,:);  %��֪ѵ��Ʒ��
%     g = group(1:200);				 %��֪ѵ��Ʒ���������
%     class = classify(sample,training,g)��%��idx����
%     [class,group(idx)]              %���������ȷ
%
%CLASSIFY Linear discriminant analysis.
%   CLASSIFY(SAMPLE,TRAINING,GROUP) classifies each row of 
%   the data in SAMPLE into one of the values of the vector
%   GROUP. GROUP contains integers from one to the number of 
%   groups in the training set, which is the matrix, TRAINING.
%
%   SAMPLE and TRAINING must have the same number of columns.
%   TRAINING and GROUP must have the same number of rows.
%   CLASS is a vector with the same number of rows as SAMPLE.

%   B.A. Jones 2-05-95
%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 2.5 $  $Date: 1997/11/29 01:45:07 $

[gr,gc] = size(group);
if min(gr,gc) ~= 1
   error('Requires a vector third argument.');
end

if gc ~= 1,
   group = group(:);
   gr = gc;
end

if any(group - round(group)) | any(group) < 1
  error('The third input argument must be positive integers.');
end
maxg = max(group);

[tr,tc] = size(training);
if tr ~= gr,
  error('The number of rows in the second and third input arguments must match.');
end

[sr,sc] = size(sample);
if sc ~= tc
  error('The number of columns in the first and second input arguments must match.');
end

d = zeros(sr,maxg);
for k = 1:maxg
   groupk = training(find(group == k),:);
   d(:,k) = mahal(sample,groupk);
end
[tmp, class] = min(d');
class = class';