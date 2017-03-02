function mind = D2Ddist(A,p)
x = A(:,1);
y = A(:,2);
x = x - p(1);
y = y - p(2);
d = x.^2+y.^2;
mind = sqrt(min(d));
