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
      endTime : Time;

      package sensor1 is new Ultrasonic(MB_P1, MB_P0);
      package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      package sensor3 is new Ultrasonic(MB_P13, MB_P12);
      --package sensor4 is new Ultrasonic(MB_P14, MB_P15);   


   begin
      loop
         myClock := Clock;

         --Put_Line("Sensing");

         DistanceHandling.MultiDistance(sensor1.Read, sensor2.Read, sensor3.Read);
         endTime := Clock;
         Put_Line("Sense Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(50);

      end loop;

   end sense;

   -- Main task for decisionmaking
   -- Use this task to gather data from sense and decide where obsitcles are
   task body think is
      myClock : Time;
      endTime : Time;


      DistanceFront : Distance_cm := 0;
      DistanceRight : Distance_cm := 0;
      DistanceLeft : Distance_cm := 0;
   begin
      loop
         myClock := Clock;

         DistanceFront := DistanceHandling.GetFrontDistance;
         DistanceRight := DistanceHandling.GetRightDistance;
         DistanceLeft := DistanceHandling.GetLeftDistance;
 
         --Put_Line("Thinking");        


         if DistanceFront > 20 then
            MotorHandling.SetDirection(Forward);
         elsif DistanceRight > 20 then
            MotorHandling.SetDirection(Right);
         elsif DistanceLeft > 20 then
            MotorHandling.SetDirection(Left);
         else
            MotorHandling.SetDirection(Stop);
         end if;
         endTime := Clock;
         Put_Line("Think Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(100);

      end loop;
   end think;
   

  -- Main task to set direction of vehicle
  -- Use motordiver stuff here
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
   
   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      
      procedure MultiDistance (Front : Distance_cm; Right : Distance_cm; Left : Distance_cm) is 
      begin 
         if Front > 300 or Front = 0 then 
            SensorFrontDistance := 400;
         else
            SensorFrontDistance := Front;
         end if;

         if Right > 300 or Right = 0 then 
            SensorRightDistance := 400;
         else
            SensorRightDistance := Right;
         end if;

         if Left > 300 or Left = 0 then 
            SensorLeftDistance := 400;
         else
            SensorLeftDistance := Left;
         end if;

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
