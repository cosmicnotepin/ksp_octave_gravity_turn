clear all


Radius = 6371000; %Earth Body:Radius
AtmoHeight = 140000;
tend = 2000;
thrustVac = [3379.8 945.4 49.4 0];
thrustSL = [2906.0 738.3 40.2 0];
%thrustVac = [3379.8 945.4 50.4 0];
%thrustSL = [2906.0 738.3 50.2 0];
%burnTime = [22.96, 175.78, 444.9 9000];
burnTime = [22.96, 175.78, 400.9 9000];
mDot = [1.46333 0.30604 0.01594 0];
m0s = [108, 67, 8.7, 1.5];
droppedMass = [7.083 4.720 0 0];
m0 = 109.13;
A = [32.3 5.4 5.4 0];
Cd = [0.05 0.05 0.05 0];
Cdss = [0.5 0.75 0.75 0];

launchRadius = 6371111.561;
%turnStartSpeed = 100;
turnAngle = 12.5;

turnStartTime = 10;
turnRate = 2;

thrustAngleFromHoriz = 180 %180 means ignore value

  %G = 6.672*10^-11; %(*Gravitational Constant*)
  %M = 5.97219*10^24 ; %(*Mass of Earth*)
  %R = 6.378 *10^6; %(*Radius of Earth*)
  %r = R + 150000;
  %mu = G * M;
  %v = sqrt((mu/r));
  %init = [ pi/2 6372808.958 0];

%options = odeset("InitialStep", 1e-3, "MaxStep", 1e-3);

    %solve 0.5 = a 300^3 + b 300^2 + c 300 + d , 1= a 360^3 + b 360^2 + c 360 + d, 0 = 3 a 300^2 + 2 b 300 + c, 0 = 3 a 360^2 + 2 b 360 + c
function [value, isterminal, direction ] = reenterAtmoEvent(t,y)
    value = y(3) - 6371000 - 140000;
    isterminal = true;
    direction = -1; 
end
    
t = [0];
y = [[1 (pi/2 ) launchRadius 0]];
burnStartT = 0;
stage = 1;
eomFun = getEom(thrustVac(stage), thrustSL(stage), mDot(stage), m0, A(stage), Cd(stage), Cdss(stage), turnStartTime, turnRate, turnAngle, thrustAngleFromHoriz, burnStartT);
%options = odeset('RelTol',1e-6,'AbsTol',1e-6*ones(1,4), 'MaxStep', 3);%, 'Events'), @gravityTurnEvents);%, 'NormControl', 'on');
options = odeset('RelTol',1e-10,'AbsTol',1e-11*ones(1,4), 'MaxStep', 3, 'Events', @reenterAtmoEvent);%, 'NormControl', 'on');
stage = 1;
while t < tend

    %[at, ay, te, ye, ie] = ode15s(eomFun, [t(end), t(end)+burnTime(stage)], y(end,:), options);
    [at, ay, te, ye, ie] = ode45(eomFun, [t(end), t(end)+burnTime(stage)], y(end,:), options);
    t = cat(1, t, at(2:end));
    y = cat(1, y, ay(2:end, :));
    ay(end,1:2)
    ay(end,3) - Radius
    plot(t, y(:,3) - 6371000);

    m0 = m0 - mDot(stage)*burnTime(stage) - droppedMass(stage)
    stage = stage + 1;
    if stage > 4
        break;
    end
    m0 = m0s(stage);
    burnStartT = at(end)
    %rest = m0 - mDot(stage)*burnTime(stage)
    if stage == 3
        thrustAngleFromHoriz = 3;
    end


    eomFun = getEom(thrustVac(stage), thrustSL(stage), mDot(stage), m0, A(stage), Cd(stage), Cdss(stage), turnStartTime, turnRate, turnAngle, thrustAngleFromHoriz, burnStartT);
end

plot(t, y(:,3) - 6371000);
%toKOSJson("C:/Users/dmad/ksp/RSS_RO_RP-1_KOS/Ships/Script/r.json", y(:,3) - 6371000 );
%toKOSJson("C:/Users/dmad/ksp/RSS_RO_RP-1_KOS/Ships/Script/a.json", y(:,2) * 180/pi );
%hold on;

%plot(y(:,3) - 6371000 , y(:,2));
%plot(t, y(:,3))
%plot(y(:,3) - 6371000 - 140000, y(:,1));

%pp = spline(y(:,3), y(:,2));
%splineVals = ppval(pp, y(:,3));
%ppf = splinefit(y(:,3), y(:,2), 100);
%splineValsf = ppval(ppf, y(:,3));
%plot(y(:,3), splineValsf);
%hold off;
