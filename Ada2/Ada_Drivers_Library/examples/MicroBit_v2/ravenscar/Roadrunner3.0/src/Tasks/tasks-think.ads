with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;
with Tasks.Act;
with Tasks.Think;

-- This task is inteded to be used as the main decicionmaker
-- The intention is to use the getter functions from task.sense and use this information to make decicions regarding 
-- which dirction the vehicle shall drive
-- Example might be if (GetDistance1 < 20 then "change direction") or something
-- The changes in directions will be implemented by calling functions from task.act 


package Tasks.Think is

   task Think with Priority=> 2;
  
end Tasks.Think;
