# Adaptive-Cruise-Control
Adaptive Cruise Control project using Matlab
Description
Implement an adaptive cruise control system with five buttons of (1) Set_speed, (2) Adaptive_speed, (3)
Cancel, (4) Increase_speed, and (5) Decrease_speed. When the system is initialized, the display shows the
initial speed of 0.
1. When the Increase_speed button is pressed, the speed increases and when the Decrease_speed
button is pressed the speed decreases however without pressing the Set_speed button the speed
will not remain constant and it changes slowly over time.
2. When the Set_speed button is pressed the system enters the cruise control mode where the
speed is held constant. In this mode, the Increase_speed button and the Decrease_speed button
are still functional and can be used to change the Set_speed. If the Cancel button is pressed, the
system quits the cruise control mode where the speed decreases slowly.
3. If the Adaptive_speed button is pressed, the speed is set and held constant until a vehicle shows
up at the front or an object is detected where the speed automatically decreases. When the road
becomes clear, the speed increases to reach the set speed again. In the adaptive cruise control
mode, the display hat to blink to differentiate this mode from the cruise mode. In this mode, the
Increase_speed button and the Decrease_speed button do not function but the Cancel button can
still be used to quit the adaptive cruise mode. If the Cancel button is pressed, the display stops
blinking and the vehicle speed begins to slow down. 
