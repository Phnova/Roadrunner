with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;
with Tasks.Sense;

package Tasks.Act is

   task Act with Priority=> 3;

   type Directions is (Stop, Forward, Backward, Left, Right);

   protected MotorHandling is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
      procedure DriveVehicle (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorHandling;

end Tasks.Act;
