function eomFun = localFunTest(p1)
  Radius = 6371000; %Earth Body:Radius
  mu = 398600441800000; % Earth GM

  %Atmosphere
  M = 0.0289644; %molecular weight ?
  R = 8.3145; % the gas constant
  turned = 1;

  function res = eom(t)
      turned = turned + 1;
      res = turned;
  end
  eomFun = @eom;
end
