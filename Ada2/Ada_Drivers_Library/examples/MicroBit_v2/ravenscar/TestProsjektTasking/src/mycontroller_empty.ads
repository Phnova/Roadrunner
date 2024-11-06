with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;


package MyController_empty is

   type Directions is (Forward, Stop);
   

   
   task Sense with Priority => 1;
   task Think with Priority=> 2; -- what happens for the set direction if think and sense have the same prio and period?
                                 -- what happens if think has a higher priority? Why is think' set direction overwritten by sense' set direction?
   
   task Act with Priority=> 3;

   protected DistanceHandling is
      function GetDistance return Distance_cm;
      procedure SetDistance (V : Distance_cm);
   private
      Distance : Distance_cm := 0;
   end DistanceHandling;

   protected MotorDriver is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorDriver;
end MyController_empty;
