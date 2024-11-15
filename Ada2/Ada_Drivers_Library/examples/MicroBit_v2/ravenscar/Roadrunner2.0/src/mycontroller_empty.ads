with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;


package MyController_empty is

   type Directions is (Stop, Forward, Backward, Left, Right, Rotating_Left, Rotating_Right);

   --type Obstacle is (Front, left, right, rear, none);
   
   task Sense with Priority => 3;

   task Think with Priority=> 2; -- what happens for the set direction if think and sense have the same prio and period?
                                 -- what happens if think has a higher priority? Why is think' set direction overwritten by sense' set direction?
   
   task Act with Priority=> 1;

   protected DistanceHandling is
      procedure SetDistance (V : Distance_cm);
      procedure MultiDistance (FrontLeft : Distance_cm; FrontRight : Distance_cm; Left : Distance_cm; Right : Distance_cm);
      
      function GetDistance return Distance_cm;
      function GetFrontLeftDistance return Distance_cm;
      function GetFrontRightDistance return Distance_cm;
      function GetLeftDistance return Distance_cm;
      function GetRightDistance return Distance_cm;

   private
      Distance : Distance_cm := 0;

      SensorFrontLeftDistance : Distance_cm := 0;
      SensorFrontRightDistance : Distance_cm := 0;
      SensorRightDistance : Distance_cm := 0;
      SensorLeftDistance : Distance_cm := 0;

   end DistanceHandling;

   protected MotorHandling is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
      procedure DriveVehicle (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorHandling;

   
   -- Need a procedure for handling of obstacles
   -- This procedure needs to use sensordata in order to figure out which direction is safe or not
   -- Need a function that checks distance data from sensors and returns an obstacle type
   -- Can use multiple if-statemets to check this
   
   --procedure ObstacleHandling is 
      
end MyController_empty;
