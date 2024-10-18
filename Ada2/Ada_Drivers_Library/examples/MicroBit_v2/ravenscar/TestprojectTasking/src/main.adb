with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with DFR0548;
use MicroBit;

procedure Main is
   package sensor1 is new Ultrasonic(MB_P1, MB_P0);
   package sensor2 is new Ultrasonic(MB_P8, MB_P2);

   Distance : Distance_cm := 0;
   run : Integer := 1;
   Last_Distance : Distance_cm := 0;
   Stabilize_Time : constant Duration := 0.2;  -- Time to stabilize before changing direction

   Distance_2 : Distance_cm := 0;
   Last_Distance_2 : Distance_cm := 0;
begin
   loop
      Distance := sensor1.Read;
      Distance_2 := sensor2.Read;

      -- Log distance only if it changes to avoid slowing down
      if Distance /= Last_Distance then
         Put_Line ("Right: " & Distance_cm'Image(Distance));
         Last_Distance := Distance;
      end if;

      -- Log distance only if it changes to avoid slowing down
      if Distance_2 /= Last_Distance_2 then
         Put_Line ("Left: " & Distance_cm'Image(Distance_2));
         Last_Distance_2 := Distance_2;
      end if;


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
         MotorDriver.Drive(Rotating_Right, (4095, 4095, 4095, 4095));
      end if;

      delay 0.05;  -- Allow sensor to refresh

      for I in DFR0548.Degrees range 0..180 loop
         MotorDriver.Servo(1,I);
         delay 0.006; --20 ms
      end loop;

      for I in reverse DFR0548.Degrees range 0..180 loop
         MotorDriver.Servo(1,I);
          delay 0.006; --20 ms
      end loop;

   end loop;

end Main;
