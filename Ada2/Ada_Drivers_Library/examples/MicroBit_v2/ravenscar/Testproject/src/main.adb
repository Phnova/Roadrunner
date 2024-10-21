with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548;
use MicroBit;



Task Drive_Car;
Task body Drive_Car is 
   begin
   -- Brief pause before switching directions to stabilize sensor
      if (Distance < 20) and (Distance /= 0) and (run = 1) then
         MotorDriver.Drive(Stop, (0, 0, 0, 0)); -- Stop momentarily
         delay Stabilize_Time;
         run := 0;  -- Switch to reverse
         elsif (Distance >= 21) and (run = 0) and (Distance_2 < 21) and (Distance_2 /= 0) then
         MotorDriver.Drive(Stop, (0, 0, 0, 0)); -- Stop momentarily
         delay Stabilize_Time;
         run := 1;  -- Switch to forward
      
      end if;

      -- Run the motor based on the direction
      if run = 1 then
         MotorDriver.Drive(Forward, (4095, 4095, 4095, 4095));
      elsif run = 0 then
         MotorDriver.Drive(Backward, (4095, 4095, 4095, 4095));
      end if;

         delay 0.05;  -- Allow sensor to refresh
   end Drive_car;

procedure Main is
   package sensor1 is new Ultrasonic(MB_P1, MB_P0);
   package sensor2 is new Ultrasonic(MB_P8, MB_P2);
   package sensor3 is new Ultrasonic(MB_P13, MB_P12);


   -- Common shared variables
   -- Variable to set direction(s)
   run : Integer := 1;

   -- Distance variables
   Distance : Distance_cm := 0;
   Last_Distance : Distance_cm := 0;
   
   Distance_2 : Distance_cm := 0;
   Last_Distance_2 : Distance_cm := 0;

   Distance_Rear : Distance_cm := 0;
   Last_Distance_Rear : Distance_cm := 0;

   -- Time variables
   Stabilize_Time : constant Duration := 0.2;  -- Time to stabilize before changing direction

   -- Rear sensor checkstates. Array containing 3 boolean values. Each value represents a field of 60deg.
   -- 180deg will be divided in to left (0,60)deg rear (60,120)deg, right (120,180)deg
   Zones : array (1..3) of Boolean;

begin
   loop
      null;
   end loop;

end Main;
