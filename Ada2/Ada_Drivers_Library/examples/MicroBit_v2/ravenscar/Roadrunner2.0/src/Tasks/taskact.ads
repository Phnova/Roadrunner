with MyMotorDriver; use MyMotorDriver;

package Tasks.Act is

   task Act with Priority=> 3;

   procedure Setup;    
   procedure Drive (direction : Directions);
   procedure DriveWheel(w : Wheel);
end Tasks.Act;
