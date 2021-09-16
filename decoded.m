function dec = decoded(A,L)
sum = 0;
for i=0:L/2-1;
    sum = sum + (2^i)*A(L/2-i);
end
dec = sum;
end

