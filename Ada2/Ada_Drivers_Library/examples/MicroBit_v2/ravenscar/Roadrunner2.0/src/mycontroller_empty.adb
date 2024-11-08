with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;

with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;

package body MyController_empty is

   -- Main task for sensing environment
   -- Use ultrasonic sensors here
   -- This task is only meant for SENSING the environment, what the vehicle does with this data is supposed to happen in THINK
   task body sense is
      myClock : Time;
      

      package sensor1 is new Ultrasonic(MB_P1, MB_P0);
      package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      package sensor3 is new Ultrasonic(MB_P13, MB_P12);
      --package sensor4 is new Ultrasonic(MB_P14, MB_P15);   


   begin
      loop
         myClock := Clock;

         Put_Line("Sensing");

         DistanceHandling.MultiDistance(sensor1.Read, sensor2.Read, sensor3.Read);

         --Put_Line("Distance front: " & Distance_cm'Image(DistanceHandling.GetFrontDistance));
         --Put_Line("Distance right: " & Distance_cm'Image(DistanceHandling.GetRightDistance));        
         --Put_Line("Distance left: " & Distance_cm'Image(DistanceHandling.GetLeftDistance));
         delay until myClock + Milliseconds(100);




      end loop;

   end sense;

   -- Main task for decisionmaking
   -- Use this task to gather data from sense and decide where obsitcles are
   task body think is
      myClock : Time;

      SafeDistance : Distance_cm := 0;
   begin
      loop
         myClock := Clock;
         --Put_Line("SafeDistance: " & Distance_cm'Image(SafeDistance));
         SafeDistance := DistanceHandling.GetFrontDistance;
         delay (0.05); --simulate 50 ms execution time, replace with your code
         Put_Line("Thinking");         
         if SafeDistance < 20 and SafeDistance /= 0 then
            MotorHandling.SetDirection(Stop);
         else
            MotorHandling.SetDirection(Forward);
         end if;
         delay until myClock + Milliseconds(40);
      end loop;
   end think;
   

  -- Main task to set direction of vehicle
  -- Use motordiver stuff here
  task body act is
     myClock : Time;
  begin
     loop
        myClock := Clock;
        Put_Line("Act");
        MotorHandling.DriveVehicle(MotorHandling.GetDirection);
        --Put_Line ("Direction is: " & Directions'Image (MotorHandling.GetDirection));
        
        delay until myClock + Milliseconds(40);
     end loop;
  end act;
   
   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      
      procedure MultiDistance (Front : Distance_cm; Right : Distance_cm; Left : Distance_cm) is 
      begin 
         SensorFrontDistance := Front;
         SensorRightDistance := Right;
         SensorLeftDistance := Left;
      end MultiDistance;
      function GetDistance return Distance_cm is
      begin
         return Distance;
      end GetDistance;

      function GetFrontDistance return Distance_cm is
      begin
         return SensorFrontDistance;
      end GetFrontDistance;

      function GetRightDistance return Distance_cm is
      begin
         return SensorRightDistance;
      end GetRightDistance;

      function GetLeftDistance return Distance_cm is
      begin
         return SensorLeftDistance;
      end GetLeftDistance;

   end DistanceHandling;   



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
end MyController_empty;
