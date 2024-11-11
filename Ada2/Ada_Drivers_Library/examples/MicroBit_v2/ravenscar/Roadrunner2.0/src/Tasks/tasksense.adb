With Ada.Real_Time; use Ada.Real_Time;


-- This entire task is intended for the vehicles abilities to "sense" its environment
-- Ultrasonic sensors will be used to measure distance to objects. 
-- These distances shall be stored in variables/arrays and be possible to read using functoins
-- These functions will be used in "Thinking" for the vehicle

-- Timing and delays needs to be checked


package body Tasks.Sense is

    task body sense is
      myClock : Time;
      endTime : Time;

      package sensor1 is new Ultrasonic(MB_P1, MB_P0);
      package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      package sensor3 is new Ultrasonic(MB_P13, MB_P12);
      --package sensor4 is new Ultrasonic(MB_P14, MB_P15);   


   begin
      loop
         myClock := Clock;

         --Put_Line("Sensing");

         DistanceHandling.MultiDistance(sensor1.Read, sensor2.Read, sensor3.Read);
         endTime := Clock;
         Put_Line("Sense Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(50);

      end loop;

   end sense;

   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      
      procedure MultiDistance (Front : Distance_cm; Right : Distance_cm; Left : Distance_cm) is 
      begin 
         if Front > 300 or Front = 0 then 
            SensorFrontDistance := 400;
         else
            SensorFrontDistance := Front;
         end if;

         if Right > 300 or Right = 0 then 
            SensorRightDistance := 400;
         else
            SensorRightDistance := Right;
         end if;

         if Left > 300 or Left = 0 then 
            SensorLeftDistance := 400;
         else
            SensorLeftDistance := Left;
         end if;

      end MultiDistance;
      function GetDistance return Distance_cm is
      begin
         return Distance;
      end GetDistance;

      function GetFrontDistance return Distance_cm is
      begin
         return SensorFrontDistance;
      end GetFrontDistance;

      function GetRightDistance return Distance_cm is
      begin
         return SensorRightDistance;
      end GetRightDistance;

      function GetLeftDistance return Distance_cm is
      begin
         return SensorLeftDistance;
      end GetLeftDistance;

   end DistanceHandling;   

end Tasks.Sense;
