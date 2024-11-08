With Ada.Real_Time; use Ada.Real_Time;

-- This task is inteded to be used as the main decicionmaker
-- The intention is to use the getter functions from task.sense and use this information to make decicions regarding 
-- which dirction the vehicle shall drive
-- Example might be if (GetDistance1 < 20 then "change direction") or something
-- The changes in directions will be implemented by calling functions from task.act 


package body Tasks.Think is

  task body think is
   myClock : Time;
   begin
      loop
         myClock := Clock;
        
         --make a decision (could be wrapped nicely in a procedure)
         if Brain.GetMeasurementSensor1 > 5 and Brain.GetMeasurementSensor2 = 1 then            
            MotorDriver.SetDirection (Forward); --our decision what to do based on the sensor values        
         else
            MotorDriver.SetDirection (Stop); 
         end if;
         Put_Line("Thinking");
         delay until myClock + Milliseconds(100);  --random period
      end loop;
   end think;


end Tasks.Think;
