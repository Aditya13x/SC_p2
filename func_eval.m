function f = func_eval(x1,x2)

eqn = fileread('inputfunction.txt');
fh = str2func(eqn);
f1 = fh(x1,x2);
f = -f1;
















%function y = func_eval(x1,x2)
%y = -(x1+x2-2*x1^2-x2^2+x1*x2);
%end