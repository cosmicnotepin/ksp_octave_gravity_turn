function res = gt(t,s)
  % res : [v' y' r' o']
  %G = 6.672*10^-11; %(*Gravitational Constant*)
  %M = 5.97219*10^24 ; %(*Mass of Earth*)
  Radius = 6371000; %Body:Radius
  %mu = G * M;
  %mu = 4903895801650.72; % moon
  mu = 398600441800000;

  %m0 = 5.53235; % initial mass tons
  m0 = 50.069; % not the moon test vehicel
  burn_time = 2*60 + 51 - 34.3;
  m_dot = 0.305; % mass flow rate
  thrustVac = 941.4; % VAC KN ?
  thrustASL = 741.1;


  M = 0.0289644; %molecular weight ?
  P =  getPressureAtAltitude(s(3)-Radius); %Pressure
  R = 8.3145; % the gas constant
  T = getAtmoTemp(s(3)-Radius); %Temperature

  A = 5.4; %Area get from FAR
  Cd = 0.05; % drag coefficient get from FAR
  if (s(1)>330)
      Cd = 0.75;
  end

  density = P*M/(R*T);

  drag = 0.5 * density * s(1)^2 * A * Cd;

  currMass = max(m0-(m_dot*t), m0-(m_dot*burn_time));

  %TODO make thrust depend on altitude!

  %second_burn_duration = 240;

  %second_burn_start = 2000 - second_burn_duration/2;
  thrust = thrustVac - ((thrustVac-thrustASL) * (P/getPressureAtAltitude(-1)));
  acceleration = (thrust-drag)/currMass;
  if (t > burn_time)
    acceleration = -drag/currMass;
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
