function ydot = gravityTurn(t,y)
  mass = 80;
  g = 9.81;
  
  ydot = [y(2); -g + max(20-2*t, 0) + 4/15 * y(2)^2/mass];
