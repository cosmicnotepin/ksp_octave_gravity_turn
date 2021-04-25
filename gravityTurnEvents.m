function [angle, isterminal, direction] = gravityTurnEvents(t,y)
    angle = y(2);
    isterminal = 1;
    direction = 0;

