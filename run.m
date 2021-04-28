clear all


thrustVac = 941.4;
thrustSL = 741.1;
burnTime = 170.81;
mDot = 0.30507;
m0 = 59.342;
A = 5.4;
Cd = 0.05;
Cdss = 0.75;
launchRadius = 6371111.561;
turnStartSpeed = 100;
turnAngle = 1.65;

turnStartTime = 15;
turnRate = 1;

timerange = [0 4*5500];

  %G = 6.672*10^-11; %(*Gravitational Constant*)
  %M = 5.97219*10^24 ; %(*Mass of Earth*)
  %R = 6.378 *10^6; %(*Radius of Earth*)
  %r = R + 150000;
  %mu = G * M;
  %v = sqrt((mu/r));
  init = [1 (pi/2 ) launchRadius 0];
  %init = [ pi/2 6372808.958 0];

%options = odeset("InitialStep", 1e-3, "MaxStep", 1e-3);
eomFun = getEom(thrustVac, thrustSL, burnTime, mDot, m0, A, Cd, Cdss, turnStartTime, turnRate, turnAngle);
options = odeset('RelTol',1e-10,'AbsTol',1e-11*ones(1,4), 'MaxStep', 3, 'Events', @gravityTurnEvents);%, 'NormControl', 'on');
[t, y, te, ye, ie] = ode45(eomFun, timerange, init, options);

%polyCoeff = polyfit(y(:,3), y(:,2), 10);

%polyRadiusRange =  1750945 : ye(3);

%polyValues = polyval(polyCoeff, y(:, 3), 10);

%plot(polyRadiusRange, polyValues);
%plot(y(:,3), polyValues);
toKOSJson("r.json", y(:,3) - 6371000 );
toKOSJson("a.json", y(:,2) * 180/pi );
%hold on;

plot(y(:,3) - 6371000 , y(:,2));

%pp = spline(y(:,3), y(:,2));
%splineVals = ppval(pp, y(:,3));
%ppf = splinefit(y(:,3), y(:,2), 100);
%splineValsf = ppval(ppf, y(:,3));
%plot(y(:,3), splineValsf);
hold off;
