with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;
with system.Machine_Code; use system.Machine_Code;


procedure Main is
   package sensor1 is new Ultrasonic(MB_P0, MB_P1);
   package sensor2 is new Ultrasonic(MB_P2, MB_P8);
   package sensor3 is new Ultrasonic(MB_P12, MB_P13);
   package sensor4 is new Ultrasonic(MB_P14, MB_P15);   

   --Distance_1 : Distance_cm := 0;
   --Distance_2 : Distance_cm := 0;
   --Distance_3 : Distance_cm := 0;
   --Distance_4 : Distance_cm := 0;
begin
   loop
      --Distance_1 := sensor1.Read;      
      --Distance_2 := sensor2.Read;
      --Distance_3 := sensor3.Read;
      --Distance_4 := sensor4.Read;

      MotorDriver.Drive(Forward, (2048, 2048, 2048, 2048));


      Put_Line("Sensortest FrontLeft: " & Distance_cm'Image(sensor1.Read));
      delay 0.2;
      Put_Line("Sensortest FrontRight: " & Distance_cm'Image(sensor2.Read));
      delay 0.2;
      --Put_Line("Sensortest Left: " & Distance_cm'Image(sensor3.Read));
      --delay 0.2;
      --Put_Line("Sensortest Right: " & Distance_cm'Image(sensor4.Read));
      --delay 0.2;
      --if (Distance_1 /= 0) and (Distance_1 < 100) then
      --   Put_Line ("Distance_L: " & Distance_cm'Image(Distance_1)); -- a console line delay the loop significantly
      --   delay 0.2; --50ms
      --end if;

      --if (Distance_2 /= 0) and (Distance_2 < 100) then      
      --   Put_Line ("Distance_R: " & Distance_cm'Image(Distance_2)); -- a console line delay the loop significantly
      --   delay 0.2; --50ms 
      --            
      --end if;
      --if (Distance_3 /= 0) and (Distance_3 < 100) then
      --   Put_Line ("Distance_L: " & Distance_cm'Image(Distance_3)); -- a console line delay the loop significantly
      --   delay 0.2; --50ms
      --end if;

      --if (Distance_4 /= 0) and (Distance_4 < 100) then      
      --   Put_Line ("Distance_R: " & Distance_cm'Image(Distance_4)); -- a console line delay the loop significantly
      --   delay 0.2; --50ms           
      --end if;
      delay 0.2;
   end loop;

end Main;


