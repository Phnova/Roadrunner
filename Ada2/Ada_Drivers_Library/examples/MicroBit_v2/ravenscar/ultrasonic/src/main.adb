with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;

procedure Main is
   package sensor1 is new Ultrasonic(MB_P16, MB_P15);
   --package sensor2 is new Ultrasonic(MB_P15, MB_P0);
   --package sensor3 is new Ultrasonic(MB_P14, MB_P0);

   Distance : Distance_cm := 0;
   run : Integer := 1;
begin
   loop
      Put_Line("0");
      if run = 1 then
         Put_Line("1");
         MotorDriver.Drive(Forward,(4095, 4095, 4095, 4095));
         Put_Line("2");
      else
         Put_Line("3");
         MotorDriver.Drive(Backward,(4095, 4095, 4095, 4095));
         Put_Line("4");
         --delay 2.0;
      end if;

      Put_Line ("5");
      Distance := sensor1.Read;
      Put_Line("6");
      Put_Line ("Distance: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      Put_Line("7");
      delay 0.05; --50ms
      Put_Line ("8");
      if (Distance < 10) and (Distance /= 0) then
         Put_Line("9");
         run := 0;
         Put_Line("10");
      else
         Put_Line("11");
         run := 1;
         Put_Line("12");
      end if;
      Put_Line("13");
   end loop;

end Main;


