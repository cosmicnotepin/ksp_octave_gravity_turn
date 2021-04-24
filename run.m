clear all

timerange = [0 4*5500];

  %G = 6.672*10^-11; %(*Gravitational Constant*)
  %M = 5.97219*10^24 ; %(*Mass of Earth*)
  %R = 6.378 *10^6; %(*Radius of Earth*)
  %r = R + 150000;
  %mu = G * M;
  %v = sqrt((mu/r));
  init = [171.217 (pi/2 - 50*(pi)/180) 1750945.775 0];

%options = odeset("InitialStep", 1e-3, "MaxStep", 1e-3);
options = odeset('RelTol',1e-10,'AbsTol',1e-11*ones(1,4), 'MaxStep', 3);%, 'NormControl', 'on');
[t, y] = ode45(@gt, timerange, init, options);

plot(t, y(:,3));
