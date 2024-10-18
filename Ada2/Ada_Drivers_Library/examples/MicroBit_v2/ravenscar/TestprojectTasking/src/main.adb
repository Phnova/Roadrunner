with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548;
use MicroBit;

procedure Main is
   package Sensor1 is new Ultrasonic(MB_P1, MB_P0);  -- Front right sensor
   package Sensor2 is new Ultrasonic(MB_P8, MB_P2);  -- Front left sensor
   package Servo_Sensor is new Ultrasonic(MB_P9, MB_P10);  -- Rear sensor on servo

   -- Shared variables for distances
   Distance_Sensor1 : Distance_cm := 0;
   Distance_Sensor2 : Distance_cm := 0;
   Distance_Servo_Sensor : Distance_cm := 0;  -- Distance for the third sensor on the servo

   -- Flags for angular zones
   Zone_0_60_Clear   : Boolean := False;  -- No obstacles in 0-60°
   Zone_60_120_Clear : Boolean := False;  -- No obstacles in 60-120°
   Zone_120_180_Clear: Boolean := False;  -- No obstacles in 120-180°

   Stabilize_Time   : constant Duration := 0.2;
   Sensor_Period    : constant Duration := 0.05;

   -- Degree tracking for servo
   Deg_Rot : DFR0548.Degrees := 0;
   Deg_Rot_Rev : DFR0548.Degrees := 180;

   -- Shared variable between tasks
   Current_Angle : DFR0548.Degrees := 0;
   Current_Distance_Servo : Distance_cm := 0;

   -- Task to handle motor control logic
   task type Motor_Control is
      entry Control_Motors;
   end Motor_Control;

   task body Motor_Control is
   begin
      loop
         Distance_Sensor1 := Sensor1.Read;
         Distance_Sensor2 := Sensor2.Read;

         -- If both front sensors detect no obstacles, move forward
         if (Distance_Sensor1 >= 20) and (Distance_Sensor2 >= 20) then
            MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));

         -- If an object is detected by front sensors, consult rear zone flags
         elsif (Distance_Sensor1 < 20) or (Distance_Sensor2 < 20) then
            if Zone_0_60_Clear then
               -- No obstacle in 0-60°, move right
               MotorDriver.Drive(Rotating_Right, (4095, 4095, 4095, 4095));

            elsif Zone_120_180_Clear then
               -- No obstacle in 120-180°, move left
               MotorDriver.Drive(Rotating_Left, (4095, 4095, 4095, 4095));

            elsif Zone_60_120_Clear then
               -- No obstacle in 60-120°, continue moving forward
               MotorDriver.Drive(Backward, (4095, 4095, 4095, 4095));
            end if;
         end if;

         delay Sensor_Period;
      end loop;
   end Motor_Control;

   -- Task to handle servo control logic with degree tracking and rear sensor
   task type Servo_Control is
      entry Control_Servo;
   end Servo_Control;

   task body Servo_Control is
   begin
      loop
         -- Reset flags for a new scan
         Zone_0_60_Clear := True;
         Zone_60_120_Clear := True;
         Zone_120_180_Clear := True;

         -- Servo rotates between 0 and 180 degrees to allow rear sensor to scan
         for I in DFR0548.Degrees range 0..180 loop
            MotorDriver.Servo(1, I);
            Deg_Rot := I;

            -- Read the distance from the third sensor while rotating
            Distance_Servo_Sensor := Servo_Sensor.Read;

            -- Update shared data for motor control task
            Current_Angle := Deg_Rot;
            Current_Distance_Servo := Distance_Servo_Sensor;

            -- Update flags for the different zones based on distance
            if (Deg_Rot >= 0) and (Deg_Rot < 60) and (Distance_Servo_Sensor < 30) then
               Zone_0_60_Clear := False;
            elsif (Deg_Rot >= 60) and (Deg_Rot < 120) and (Distance_Servo_Sensor < 30) then
               Zone_60_120_Clear := False;
            elsif (Deg_Rot >= 120) and (Deg_Rot <= 180) and (Distance_Servo_Sensor < 30) then
               Zone_120_180_Clear := False;
            end if;

            Put_Line("Degrees: " & DFR0548.Degrees'Image(Deg_Rot) &
                     " | Distance (Servo Sensor): " & Distance_cm'Image(Distance_Servo_Sensor));
            
            delay 0.006; -- 20 ms
         end loop;

         -- Reverse rotation
         for I in reverse DFR0548.Degrees range 0..180 loop
            MotorDriver.Servo(1, I);
            Deg_Rot_Rev := I;

            -- Read the distance from the third sensor while rotating
            Distance_Servo_Sensor := Servo_Sensor.Read;

            -- Update shared data for motor control task
            Current_Angle := Deg_Rot_Rev;
            Current_Distance_Servo := Distance_Servo_Sensor;

            -- Update flags for the different zones based on distance
            if (Deg_Rot_Rev >= 0) and (Deg_Rot_Rev < 60) and (Distance_Servo_Sensor < 30) then
               Zone_0_60_Clear := False;
            elsif (Deg_Rot_Rev >= 60) and (Deg_Rot_Rev < 120) and (Distance_Servo_Sensor < 30) then
               Zone_60_120_Clear := False;
            elsif (Deg_Rot_Rev >= 120) and (Deg_Rot_Rev <= 180) and (Distance_Servo_Sensor < 30) then
               Zone_120_180_Clear := False;
            end if;

            Put_Line("Degrees: " & DFR0548.Degrees'Image(Deg_Rot_Rev) &
                     " | Distance (Servo Sensor): " & Distance_cm'Image(Distance_Servo_Sensor));
            
            delay 0.006; -- 20 ms
         end loop;

         delay 0.05;  -- Allow servo to reset
      end loop;
   end Servo_Control;

   -- Instantiate the tasks
   Motor_Task : Motor_Control;
   Servo_Task : Servo_Control;

begin
   -- Main loop to initiate the system
   loop
      -- Invoke motor control logic
      Motor_Task.Control_Motors;

      -- Invoke servo control logic with degree tracking and rear sensor reading
      Servo_Task.Control_Servo;

      delay 0.05;  -- Allow small pause for task scheduling
   end loop;
end Main;
