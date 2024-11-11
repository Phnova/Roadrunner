With Ada.Real_Time; use Ada.Real_Time;

-- This task is inteded to be used as the main decicionmaker
-- The intention is to use the getter functions from task.sense and use this information to make decicions regarding 
-- which dirction the vehicle shall drive
-- Example might be if (GetDistance1 < 20 then "change direction") or something
-- The changes in directions will be implemented by calling functions from task.act 


package body Tasks.Think is

task body think is
      myClock : Time;
      endTime : Time;


      DistanceFront : Distance_cm := 0;
      DistanceRight : Distance_cm := 0;
      DistanceLeft : Distance_cm := 0;
   begin
      loop
         myClock := Clock;

         DistanceFront := Tasks.Sense.DistanceHandling.GetFrontDistance;
         DistanceRight := Tasks.Sense.DistanceHandling.GetRightDistance;
         DistanceLeft := Tasks.Sense.DistanceHandling.GetLeftDistance;
 
         --Put_Line("Thinking");        
         

         if DistanceFront > 20 then
            Tasks.Act.MotorHandling.SetDirection(Forward);
         elsif DistanceRight > 20 then
            Tasks.Act.MotorHandling.SetDirection(Right);
         elsif DistanceLeft > 20 then
            Tasks.Act.MotorHandling.SetDirection(Left);
         else
            Tasks.Act.MotorHandling.SetDirection(Stop);
         end if;
         endTime := Clock;
         Put_Line("Think Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(100);

      end loop;
   end think;

end Tasks.Think;
