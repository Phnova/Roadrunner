With Ada.Real_Time; use Ada.Real_Time;
With MicroBit.Console; use MicroBit.Console;

--Important: use Microbit.IOsForTasking for controlling pins as the timer used there is implemented as an protected object
With MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body Tasks.Act is

   task body act is
      myClock : Time;
      endTime: Time;

  begin
     loop
        myClock := Clock;
        --Put_Line("Act");
        MotorHandling.DriveVehicle(MotorHandling.GetDirection);
        --Put_Line ("Direction is: " & Directions'Image (MotorHandling.GetDirection));
         endTime := Clock;
         Put_Line("Act Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");
        delay until myClock + Milliseconds(10);
     end loop;
  end act;

protected body MotorHandling is
      --  procedures can modify the data
      procedure SetDirection (V : Directions) is
      begin
         if V = Stop then
         DriveDirection := Stop;
         end if;

         if V = Forward then
         DriveDirection := Forward;
         end if;

         if V = Backward then
         DriveDirection := Backward;
         end if;

         if V = Right then
         DriveDirection := Right;
         end if;

         if V = Left then
         DriveDirection := Left;
         end if;

      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
      procedure DriveVehicle (V : Directions) is 
      begin
         if V = Stop then
         MotorDriver.Drive(Stop, (0,0,0,0));
         end if;
         if V = Forward then
         MotorDriver.Drive(Forward, (2048, 2048, 2048, 2048));
         end if;
         if V = Backward then
         MotorDriver.Drive(Backward, (2048, 2048, 2048, 2048));
         end if;
         if V = Right then
         MotorDriver.Drive(Right, (2048, 2048, 2048, 2048));
         end if;
         if V = Left then
         MotorDriver.Drive(Left, (2048, 2048, 2048, 2048));
         end if;

      end DriveVehicle;   
   end MotorHandling;
end Tasks.Act;
