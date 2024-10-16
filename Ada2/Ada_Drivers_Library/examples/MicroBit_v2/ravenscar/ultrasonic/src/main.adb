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

   Distance_1 : Distance_cm := 0;
   Distance_2 : Distance_cm := 0;
begin
   loop


      Distance_1 := sensor1.Read;
      Put_Line ("Distance_1: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      delay 0.5; --50ms
      Distance_2 := sensor1.Read;
      Put_Line ("Distance_2: " & Distance_cm'Image(Distance)); -- a console line delay the loop significantly
      delay 0.5; --50ms
            


   end loop;

end Main;


