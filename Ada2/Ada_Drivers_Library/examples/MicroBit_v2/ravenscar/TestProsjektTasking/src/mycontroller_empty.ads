with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;


package MyController_empty is

   type Directions is (Stop, Forward, Backward, Left, Right);

   --type Obstacle is (Front, left, right, rear, none);
   
   task Sense with Priority => 1;

   task Think with Priority=> 2; -- what happens for the set direction if think and sense have the same prio and period?
                                 -- what happens if think has a higher priority? Why is think' set direction overwritten by sense' set direction?
   
   task Act with Priority=> 3;

   protected DistanceHandling is
      function GetDistance return Distance_cm;
      procedure SetDistance (V : Distance_cm);
      procedure MultiDistance (A : Distance_cm; B : Distance_cm; C : Distance_cm; D : Distance_cm);
   private
      Distance : Distance_cm := 0;
      Sensor1Distance : Distance_cm := 0;
      Sensor2Distance : Distance_cm := 0;
      Sensor3Distance : Distance_cm := 0;
      Sensor4Distance : Distance_cm := 0;
   end DistanceHandling;

   protected MotorHandling is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorHandling;

   
   -- Need a procedure for handling of obstacles
   -- This procedure needs to use sensordata in order to figure out which direction is safe or not
   -- Need a function that checks distance data from sensors and returns an obstacle type
   -- Can use multiple if-statemets to check this
   
   --procedure ObstacleHandling is 
      
end MyController_empty;
