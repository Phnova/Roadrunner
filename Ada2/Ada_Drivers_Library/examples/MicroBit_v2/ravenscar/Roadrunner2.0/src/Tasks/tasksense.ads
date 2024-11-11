with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;
-- This entire task is intended for the vehicles abilities to "sense" its environment
-- Ultrasonic sensors will be used to measure distance to objects. 
-- These distances shall be stored in variables/arrays and be possible to read using functoins
-- These functions will be used in "Thinking" for the vehicle

-- Timing and delays needs to be checked

package Tasks.Sense is

   task Sense with Priority => 1; --random priority. argue and calculate what these values should be
   
   -- function get obstacles
   protected DistanceHandling is
      function GetDistance return Distance_cm;

      procedure SetDistance (V : Distance_cm);

      procedure MultiDistance (Front : Distance_cm; Right : Distance_cm; Left : Distance_cm);
      function GetFrontDistance return Distance_cm;
      function GetRightDistance return Distance_cm;
      function GetLeftDistance return Distance_cm;
   private
      Distance : Distance_cm := 0;

      SensorFrontDistance : Distance_cm := 0;
      SensorRightDistance : Distance_cm := 0;
      SensorLeftDistance : Distance_cm := 0;

   end DistanceHandling;

end Tasks.Sense;
