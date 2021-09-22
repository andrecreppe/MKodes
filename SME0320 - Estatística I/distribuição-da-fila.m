L = diag(.5*ones(30,1),1) - diag(.5*ones(31,1));

L(31,31)=0;

% caso da competição:

% L = diag(.5*ones(30,1),1) - diag(1*ones(31,1));

% L = L + diag(.5*ones(30,1),-1);

% L(1,1)=-.5; L(31,31)=-.5;

p0=[ 1 zeros(1,30)];

% p60 = p0*expm(L*60);

% p60(6)*100





% animação de como a distrib. varia no 'tempo' t:

count = 1;

for t=0:.5:90,

plot(0,1,'.');

text(10,.8,'bar(p0*expm(L*t))')

hold on

bar(p0*expm(L*t));

hold off

pause(.5)

end



%movie(frame,1)

