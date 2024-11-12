with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;
with system.Machine_Code; use system.Machine_Code;

procedure Main is
      --myClock : Time;
      --endTime : Time;

      package sensorFrontLeft is new Ultrasonic(MB_P0, MB_P1);
      package sensorFrontRight is new Ultrasonic(MB_P2, MB_P8);
      package sensorLeft is new Ultrasonic(MB_P12, MB_P13);
      package sensorRight is new Ultrasonic(MB_P14, MB_P15);   


      LastFrontLeft  : Distance_cm := sensorFrontLeft.Read;
      LastFrontRight : Distance_cm := sensorFrontRight.Read;
      LastLeft       : Distance_cm := sensorLeft.Read;
      LastRight      : Distance_cm := sensorRight.Read;
begin
   loop
         --myClock := Clock;

         declare
            NewFrontLeft   : constant Distance_cm := sensorFrontLeft.Read;
            NewFrontRight  : constant Distance_cm := sensorFrontRight.Read;
            NewLeft        : constant Distance_cm := sensorLeft.Read;
            NewRight       : constant Distance_cm := sensorRight.Read;
         begin
            if NewFrontLeft /= LastFrontLeft or
               NewFrontRight /= LastFrontRight or
               NewLeft /= LastLeft or
               NewRight /= LastRight
            then

               --DistanceHandling.MultiDistance(sensorFrontLeft.Read, sensorFrontRight.Read, sensorLeft.Read, sensorRight.Read);

               -- update sensordata
               LastFrontLeft  := NewFrontLeft;
               LastFrontRight := NewFrontRight;
               LastLeft       := NewLeft;
               LastRight      := NewRight;
            end if;
         end;

         --endTime := Clock;
         --Put_Line("Sense Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         Put_Line("Front Left: " &Distance_cm'Image(LastFrontLeft));
         Put_Line("Front Right: " &Distance_cm'Image(LastFrontRight));
         Put_Line("Left: " &Distance_cm'Image(LastLeft));
         Put_Line("Right: " &Distance_cm'Image(LastRight));

         --delay until myClock + Milliseconds(100);
      delay 0.2;
      end loop;

end Main;


