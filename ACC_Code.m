% Initialize Arduino uno

% a = arduino('COM3','Uno','Libraries',{'Ultrasonic','ExampleLCD/LCDAddon'},'ForceBuildOn',true);
% ultrasonicsensor = ultrasonic(a,'D11','D12','OutputFormat','double');
% lcd = addon(a,'ExampleLCD/LCDAddon','RegisterSelectPin','D7','EnablePin','D6','DataPins',{'D5','D4','D3','D2'});
% initializeLCD(lcd);


% Intialize values
Set_speed=0;               %set cruise button
Adaptive_speed=0;          %adaptive cruise control button
Cancel=0;                  %cancel button
Increase_speed=0;          %increase speed button
Decrease_speed=0;          %decrease speed button
speed=0;                   %Initial velocity
trg=0;                     %checking which is button pressed
itr=1;


% Logic Implementation
while 1
   Set_speed = readVoltage(a,'A1');                %Reading Cruise Control Button pin
   Adaptive_speed = readVoltage(a,'A2');           %Reading Adaptive Cruise Control Button pin
   Cancel = readVoltage(a,'A3');                   %Reading Cancel Button pin
   Increase_speed = readVoltage(a,'A4');           %Reading increase Button pin
   Decrease_speed = readVoltage(a,'A5');           %Reading decrese Button pin
   distance = readDistance(ultrasonicsensor);      %Reading sensor data pin
    
  

    if trg==0                         % When Set_speed button is off
    if Increase_speed>=4.5            % When increse Button pressed
        speed=speed+5;
    elseif Decrease_speed>=4.5        % When decrese Button pressed
        speed=speed-5;
    else
        speed=speed-1;                % The speed will automatically decrease
    end
    
    elseif trg==1                     % When Set_speed button is on
        speed=speed; 
        
    elseif trg==2                     % When adaptive cruise control button is on
        if distance<0.2               % When the front car is too close                      
            speed=speed-1;
        else                          % When the front car is far enough
            speed=speed+1;
        end
        if speed>spdlim
            speed=spdlim;
        end
    end
    
    if Set_speed>=4.5               % When Set_speed button is on
    trg=1;
    elseif Adaptive_speed>=4.5  % When adaptive cruise control button is on
        trg=2;
        spdlim=speed;                    % The maximum speed in adaptive cruise control mode              
    elseif Cancel>=4.5                   % When cancal button is on
        trg=0;
    elseif Increase_speed>=4.5 && trg==1  % Increase speed in cruise control mode
        speed=speed+1;
    elseif Decrease_speed>=4.5 && trg==1  % Decrease speed in cruise control mode
        speed=speed-1;
    end
    
    if speed<0
        speed=0;
    end
    

    
% Display Speed on LCD
        
    if trg==2
        printLCD(lcd,'Adaptive CC:');
        printLCD(lcd,[strcat(num2str(round(speed)))]);
        pause(500/1000)
        
        clearLCD(lcd)
        pause(500/1000)
        printLCD(lcd,'Adaptive CC: ');
        printLCD(lcd,[strcat(num2str(round(speed)))]);  
        
    else
    printLCD(lcd,'Speed: ');
    printLCD(lcd,[strcat(num2str(round(speed)))]);
    end
    
    itr=itr+1;
    
    if trg==2
        pause(1000/1000)
    else
        pause(500/1000)
    end
    
end
