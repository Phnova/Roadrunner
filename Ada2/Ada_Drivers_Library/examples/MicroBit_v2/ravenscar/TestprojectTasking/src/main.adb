with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548; use DFR0548;
use MicroBit;

procedure Main is
   package Sensor1 is new Ultrasonic(MB_P1, MB_P0);  -- Front right sensor
   package Sensor2 is new Ultrasonic(MB_P8, MB_P2);  -- Front left sensor
   package Servo_Sensor is new Ultrasonic(MB_P12, MB_P13);  -- Rear sensor on servo

   -- Shared variables for distances
   Distance_Sensor1 : Distance_cm := 0;
   Distance_Sensor2 : Distance_cm := 0;
   Distance_Servo_Sensor : Distance_cm := 0;  -- Distance for the third sensor on the servo

   -- Flags for angular zones
   Zone_Clear : array (1..3) of Boolean := (True, True, True);  -- Flags for 3 zones: 0-60°, 60-120°, 120-180°

   Stabilize_Time   : constant Duration := 0.2;
   Sensor_Period    : constant Duration := 0.05;

   -- Degree tracking for servo
   Deg_Rot : DFR0548.Degrees := 0;

   procedure Motor_Control is
   begin
      Distance_Sensor1 := Sensor1.Read;
      Distance_Sensor2 := Sensor2.Read;

      -- If both front sensors detect no obstacles, move forward
      if (Distance_Sensor1 >= 20) and (Distance_Sensor2 >= 20) then
         Microbit.MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));
         
      -- If an object is detected by front sensors, consult rear zone flags
      elsif (Distance_Sensor1 < 20) or (Distance_Sensor2 < 20) then
         if Zone_Clear(1) then
            Microbit.MotorDriver.Drive(Rotating_Right, (4095, 4095, 4095, 4095));  -- Move right (0-60° clear)
         elsif Zone_Clear(3) then
            Microbit.MotorDriver.Drive(Rotating_Left, (4095, 4095, 4095, 4095));   -- Move left (120-180° clear)
         elsif Zone_Clear(2) then
            MicroBit.MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));         -- Continue forward (60-120° clear)
         end if;
      end if;
   end Motor_Control;
   procedure Servo_Control is
   begin
      -- Forward rotation: 0 to 180 degrees
      for I in DFR0548.Degrees range 0..180 loop
         Microbit.MotorDriver.Servo(1, I);
         Deg_Rot := I;

         -- Reset zone flags when servo reaches boundaries
         if Deg_Rot = 0 then
            Zone_Clear(1) := True;  -- Reset zone 0-60°
         elsif Deg_Rot = 59 then
            Zone_Clear(2) := True;  -- Reset zone 60-120° during normal rotation
         elsif Deg_Rot = 119 then
            Zone_Clear(3) := True;  -- Reset zone 120-180° during normal rotation
         end if;

         -- Read distance from servo-mounted sensor
         Distance_Servo_Sensor := Servo_Sensor.Read;

         -- Update zone flags based on distance
         if (Deg_Rot >= 0) and (Deg_Rot < 60) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(1) := False;
         elsif (Deg_Rot >= 60) and (Deg_Rot < 120) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(2) := False;
         elsif (Deg_Rot >= 120) and (Deg_Rot <= 180) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(3) := False;
         end if;

         Put_Line("Degrees: " & DFR0548.Degrees'Image(Deg_Rot) &
                  " | Distance (Servo Sensor): " & Distance_cm'Image(Distance_Servo_Sensor));

         delay 0.006;  -- 20 ms
      end loop;

      -- Reverse rotation: 180 to 0 degrees
      for I in reverse DFR0548.Degrees range 0..180 loop
         Microbit.MotorDriver.Servo(1, I);
         Deg_Rot := I;

         -- Reset zone flags when servo reaches boundaries
         if Deg_Rot = 61 then
            Zone_Clear(1) := True;  -- Reset zone 0-60°
         elsif Deg_Rot = 121 then
            Zone_Clear(2) := True;  -- Reset zone 60-120° during reverse
         elsif Deg_Rot = 180 then
            Zone_Clear(3) := True;  -- Reset zone 120-180° during reverse
         end if;

         -- Read distance from servo-mounted sensor
         Distance_Servo_Sensor := Servo_Sensor.Read;

         -- Update zone flags based on distance
         if (Deg_Rot >= 0) and (Deg_Rot < 60) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(1) := False;
         elsif (Deg_Rot >= 60) and (Deg_Rot < 120) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(2) := False;
         elsif (Deg_Rot >= 120) and (Deg_Rot <= 180) and (Distance_Servo_Sensor < 30) then
            Zone_Clear(3) := False;
         end if;

         Put_Line("Degrees: " & DFR0548.Degrees'Image(Deg_Rot) &
                  " | Distance (Servo Sensor): " & Distance_cm'Image(Distance_Servo_Sensor));

         delay 0.006;  -- 20 ms
      end loop;
   end Servo_Control;

begin
   -- Main loop to initiate the system
   loop
      Motor_Control;
      Servo_Control;
      delay 0.05;  -- Allow small pause for task scheduling
   end loop;
end Main;
