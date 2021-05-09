function eomFun = getEom(thrustVac, thrustSL, mDot, m0, A, Cd, Cdss, turnStartTime, turnRate, turnAngle, thrustAngleFromHoriz, burnStartT)
  Radius = 6371000; %Earth Body:Radius
  mu = 398600441800000; % Earth GM

  %Atmosphere
  M = 0.0289644; %molecular weight ?
  R = 8.3145; % the gas constant

  function res = eom(t,s)
      % res : [v' y' r' o']
      %"steppystep"
      %printf("%9.9d : %9.9d : %9.9d : %9.9d : %9.9d\n", t, s(1), s(2), s(3), s(4));
      %s(1)
      %s(2)
      %s(3)
      %s(4)
      %"steppystep"

      P = getPressureAtAltitude(s(3)-Radius); %Pressure
      T = getAtmoTemp(s(3)-Radius); %Temperature

      % drag coefficient get from FAR
      if (s(1) <= 300)
          Cdc = Cd;
      elseif (s(1) > 300 && s(1) < 360)
           Cdc = ((Cd-Cdss)/108000) * s(1)^3 - ((11 * (Cd-Cdss))/1200) * s(1)^2 + 3 * (Cd - Cdss) * s(1) + (-324 * Cd + 325 * Cdss);
      elseif (s(1) >= 360)
          Cdc = Cdss;
      endif

      density = P*M/(R*T);

      drag = 0.5 * density * s(1)^2 * A * Cdc;

      %m0
      %mDot
      %t
      currMass = m0 - (mDot * (t - burnStartT));

      thrust = thrustVac - ((thrustVac-thrustSL) * (P/getPressureAtAltitude(-1))); % thrust "curve" from engine config GameData\RealismOverhaul\Engine_Configs\RD108_RD118_Config.cfg
      thrustVel = thrust;
      liftAccel = 0;
      if (thrustAngleFromHoriz != 180)
          thrustAngleFromVelRad = (thrustAngleFromHoriz*pi/180) - s(2);
          thrustVel = cos(thrustAngleFromVelRad) * thrust;
          thrustLift = sin(thrustAngleFromVelRad) * thrust;
          liftAccel = thrustLift/(currMass * s(1));
      end
      acceleration = (thrustVel-drag)/currMass;

      kick = 0;
      if ( t > turnStartTime && t < turnStartTime + turnAngle/turnRate)
          kick = turnRate * pi/180;
      endif 

      v1 = -(mu/(s(3))^2)* sin(s(2)) + acceleration;% - D/m;
      y1 = -kick + (1/s(3)) * (s(1) - (mu/(s(3) * s(1)))) * cos(s(2)) + liftAccel; % + L/mv
      o1 = ((s(1)/s(3)) * cos(s(2))); % should be atan(...) but close enough it seems!
      %y1 =  (s(1)/s(3)) * cos(s(2)) - atan(cos(s(2)) * (mu/(s(3))^2) / (s(1)-(mu/((s(3))^2)) * sin(s(2)))); %this is the formula that i can "derive" seems similar in result
      %o1 = atan((s(1)/s(3)) * cos(s(2))); % the atan version i can derive, also similar
      r1 = s(1) * sin(s(2));
      res = [v1; y1; r1; o1];
  end
  eomFun = @eom;
end
