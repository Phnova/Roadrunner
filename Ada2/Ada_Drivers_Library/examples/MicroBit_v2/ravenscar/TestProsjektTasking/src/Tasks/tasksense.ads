With MyBrain; use MyBrain;

-- This entire task is intended for the vehicles abilities to "sense" its environment
-- Ultrasonic sensors will be used to measure distance to objects. 
-- These distances shall be stored in variables/arrays and be possible to read using functoins
-- These functions will be used in "Thinking" for the vehicle

-- Timing and delays needs to be checked

package TaskSense is

   task Sense with Priority => 1; --random priority. argue and calculate what these values should be
   
   -- function get obstacles
   function GetDistance1 return Distance_1;
   --function GetDistance2 return Distance_2;
   --function GetDistance3 return Distance_3;

end TaskSense;
