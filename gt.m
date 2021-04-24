function res = gt(t,s)
  % res : [v' y' r' o']
  %G = 6.672*10^-11; %(*Gravitational Constant*)
  %M = 5.97219*10^24 ; %(*Mass of Earth*)
  %R = 6.378 *10^6; %(*Radius of Earth*)
  %mu = G * M;
  mu = 4903895801650.72;
  m0 = 5.53235; % initial mass tons
  burn_time = 207.99;
  m_dot = 0.012613; % mass flow rate
  thrust = 33.7; %KN ?
  %second_burn_duration = 240;

  %second_burn_start = 2000 - second_burn_duration/2;
  acceleration = thrust/(m0-(m_dot*t));
  if (t > burn_time)
    acceleration = 0;
  endif
  %
  %if (t > second_burn_start)
  %  acceleration = 20;
  %endif
  %
  %  if (t > second_burn_start + second_burn_duration)
  %  acceleration = 0;
  %endif
  
  v1 = -(mu/(s(3))^2)* sin(s(2)) + acceleration;% - D/m;
  y1 = (1/s(3)) * (s(1) - (mu/(s(3) * s(1)))) * cos(s(2)); % + L/mv
  o1 = ((s(1)/s(3)) * cos(s(2))); % should be atan(...) but close enough it seems!
  %y1 =  (s(1)/s(3)) * cos(s(2)) - atan(cos(s(2)) * (mu/(s(3))^2) / (s(1)-(mu/((s(3))^2)) * sin(s(2))));
  %o1 = atan((s(1)/s(3)) * cos(s(2))); % should be atan(...) but close enough it seems!
  r1 = s(1) * sin(s(2));
  res = [v1; y1; r1; o1];
