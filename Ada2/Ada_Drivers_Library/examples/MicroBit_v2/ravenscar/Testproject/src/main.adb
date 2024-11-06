with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548;
use MicroBit;



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
