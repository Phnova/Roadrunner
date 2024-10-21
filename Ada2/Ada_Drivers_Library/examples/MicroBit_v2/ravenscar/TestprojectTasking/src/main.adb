with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
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
   
   
   -- Shared data: protected object for shared access
   protected Shared_Data is
      procedure Set_Sensor1 (Value : Distance_cm);
      procedure Set_Sensor2 (Value : Distance_cm);
      procedure Set_Servo_Sensor (Value : Distance_cm);
      procedure Set_Zone_Clear (Index : Positive; Status : Boolean);

      function Get_Sensor1 return Distance_cm;
      function Get_Sensor2 return Distance_cm;
      function Get_Servo_Sensor return Distance_cm;
      function Get_Zone_Clear (Index : Positive) return Boolean;

   private
      Distance_Sensor1 : Distance_cm := 0;
      Distance_Sensor2 : Distance_cm := 0;
      Distance_Servo_Sensor : Distance_cm := 0;
      Zone_Clear : array (1..3) of Boolean := (True, True, True);  -- 3 zones: 0-60°, 60-120°, 120-180°
   end Shared_Data;

   protected body Shared_Data is
      procedure Set_Sensor1 (Value : Distance_cm) is
      begin
         Distance_Sensor1 := Value;
      end Set_Sensor1;

      procedure Set_Sensor2 (Value : Distance_cm) is
      begin
         Distance_Sensor2 := Value;
      end Set_Sensor2;

      procedure Set_Servo_Sensor (Value : Distance_cm) is
      begin
         Distance_Servo_Sensor := Value;
      end Set_Servo_Sensor;

      procedure Set_Zone_Clear (Index : Positive; Status : Boolean) is
      begin
         Zone_Clear(Index) := Status;
      end Set_Zone_Clear;

      function Get_Sensor1 return Distance_cm is
      begin
         return Distance_Sensor1;
      end Get_Sensor1;

      function Get_Sensor2 return Distance_cm is
      begin
         return Distance_Sensor2;
      end Get_Sensor2;

      function Get_Servo_Sensor return Distance_cm is
      begin
         return Distance_Servo_Sensor;
      end Get_Servo_Sensor;

      function Get_Zone_Clear (Index : Positive) return Boolean is
      begin
         return Zone_Clear(Index);
      end Get_Zone_Clear;
   end Shared_Data;

   -- Degree tracking for servo
   Deg_Rot : DFR0548.Degrees := 0;

   -- Periodic task for motor control
   task type Motor_Control is
      entry Control_Motors;
   end Motor_Control;

   task body Motor_Control is
   begin
      loop
         -- Get sensor readings from the protected object
         declare
            Sensor1_Dist : Distance_cm := Shared_Data.Get_Sensor1;
            Sensor2_Dist : Distance_cm := Shared_Data.Get_Sensor2;
         begin
            -- If both front sensors detect no obstacles, move forward
            if (Sensor1_Dist >= 20) and (Sensor2_Dist >= 20) then
               MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));

            -- If an object is detected by front sensors, consult rear zone flags
            elsif (Sensor1_Dist < 20) or (Sensor2_Dist < 20) then
               if Shared_Data.Get_Zone_Clear(1) then
                  MotorDriver.Drive(Rotating_Right, (4095, 4095, 4095, 4095));  -- Move right (0-60° clear)
               elsif Shared_Data.Get_Zone_Clear(3) then
                  MotorDriver.Drive(Rotating_Left, (4095, 4095, 4095, 4095));   -- Move left (120-180° clear)
               elsif Shared_Data.Get_Zone_Clear(2) then
                  MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));         -- Continue forward (60-120° clear)
               end if;
            end if;
         end;

         delay Sensor_Period;  -- Short delay to yield control to other tasks
      end loop;
   end Motor_Control;

   -- Periodic task for servo control and zone updates
   task type Servo_Control is
      entry Control_Servo;
   end Servo_Control;

   task body Servo_Control is
   begin
      loop
         -- Forward rotation: 0 to 180 degrees
         for I in DFR0548.Degrees range 0..180 loop
            MotorDriver.Servo(1, I);
            Deg_Rot := I;

            -- Read distance from the servo sensor
            declare
               Servo_Dist : Distance_cm := Servo_Sensor.Read;
            begin
               -- Ignore false zero readings
               if Servo_Dist /= 0 then
                  Shared_Data.Set_Servo_Sensor(Servo_Dist);
               end if;
            end;

            -- Update zone flags based on position and distance
            if (Deg_Rot >= 0) and (Deg_Rot < 60) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(1, False);
               else
                  Shared_Data.Set_Zone_Clear(1, True);
               end if;
            elsif (Deg_Rot >= 60) and (Deg_Rot < 120) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(2, False);
               else
                  Shared_Data.Set_Zone_Clear(2, True);
               end if;
            elsif (Deg_Rot >= 120) and (Deg_Rot <= 180) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(3, False);
               else
                  Shared_Data.Set_Zone_Clear(3, True);
               end if;
            end if;

            delay 0.006;  -- Short delay to allow task switching
         end loop;

         -- Reverse rotation: 180 to 0 degrees
         for I in reverse DFR0548.Degrees range 0..180 loop
            MotorDriver.Servo(1, I);
            Deg_Rot := I;

            -- Read distance from the servo sensor
            declare
               Servo_Dist : Distance_cm := Servo_Sensor.Read;
            begin
               -- Ignore false zero readings
               if Servo_Dist /= 0 then
                  Shared_Data.Set_Servo_Sensor(Servo_Dist);
               end if;
            end;

            -- Update zone flags during reverse rotation
            if (Deg_Rot >= 0) and (Deg_Rot < 60) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(1, False);
               else
                  Shared_Data.Set_Zone_Clear(1, True);
               end if;
            elsif (Deg_Rot >= 60) and (Deg_Rot < 120) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(2, False);
               else
                  Shared_Data.Set_Zone_Clear(2, True);
               end if;
            elsif (Deg_Rot >= 120) and (Deg_Rot <= 180) then
               if Shared_Data.Get_Servo_Sensor < 30 then
                  Shared_Data.Set_Zone_Clear(3, False);
               else
                  Shared_Data.Set_Zone_Clear(3, True);
               end if;
            end if;

            delay 0.006;  -- Short delay to allow task switching
         end loop;

         delay 0.05;  -- Small pause for task scheduling
      end loop;
   end Servo_Control;

   -- Instantiate the tasks
   Motor_Task : Motor_Control;
   Servo_Task : Servo_Control;

begin
   -- Main loop to initiate the system
   loop
      -- Call tasks
      Motor_Task.Control_Motors;
      Servo_Task.Control_Servo;

      delay 0.05;  -- Small pause for task scheduling
   end loop;
end Main;
