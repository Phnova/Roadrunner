with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with system.Machine_Code; use system.Machine_Code;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;

package body MyController_empty is

   -- Main task for sensing environment
   -- Use ultrasonic sensors here
   -- This task is only meant for SENSING the environment, what the vehicle does with this data is supposed to happen in THINK
   task body sense is
      myClock : Time;
      endTime : Time;

      package sensorFrontLeft is new Ultrasonic(MB_P0, MB_P1);
      package sensorFrontRight is new Ultrasonic(MB_P2, MB_P8);
      package sensorLeft is new Ultrasonic(MB_P12, MB_P13);
      package sensorRight is new Ultrasonic(MB_P14, MB_P15);   


   begin
      loop
         myClock := Clock;



         --Put_Line("Sensing");

         DistanceHandling.MultiDistance(sensorFrontLeft.Read, sensorFrontRight.Read, sensorLeft.Read, sensorRight.Read);

         --Put_Line("Sense task exec: " & Time'Image(Clock));


         endTime := Clock;
         Put_Line("Sense Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");



         delay until myClock + Milliseconds(100);

      end loop;

   end sense;

   -- Main task for decisionmaking
   -- Use this task to gather data from sense and decide where obsitcles are
   task body think is
      myClock : Time;
      endTime : Time;

      DistanceFrontLeft : Distance_cm := 0;
      DistanceFrontRight : Distance_cm := 0;
      DistanceRight : Distance_cm := 0;
      DistanceLeft : Distance_cm := 0;
   begin
      loop
         myClock := Clock;

         DistanceFrontLeft := DistanceHandling.GetFrontLeftDistance;
         DistanceFrontRight := DistanceHandling.GetFrontRightDistance;
         DistanceLeft := DistanceHandling.GetLeftDistance;
         DistanceRight := DistanceHandling.GetRightDistance;

 
      
         --Put_Line("FrontLeft: " & Distance_cm'Image(DistanceFrontLeft));
         --Put_Line("FrontRight: " & Distance_cm'Image(DistanceFrontRight));


         if DistanceFrontLeft > 40 and DistanceFrontRight > 40 then
            MotorHandling.SetDirection(Forward);
         end if;
         if DistanceFrontLeft < 40 or DistanceFrontRight < 40 then
            MotorHandling.SetDirection(Stop);
            if DistanceFrontLeft < 40 then 
               MotorHandling.SetDirection(Rotating_Left);
            end if;
            if DistanceFrontRight < 40 then 
               MotorHandling.SetDirection(Rotating_Right);
            end if;
         
         end if;
         if DistanceLeft < 20 then
            MotorHandling.SetDirection(Right);
         end if;
         if DistanceRight < 20 then
            MotorHandling.SetDirection(Left);
         end if;
         if DistanceLeft < 20 and DistanceRight < 20 then
            MotorHandling.SetDirection(Forward);
         end if; 
         


         endTime := Clock;
         Put_Line("Think Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(20);

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
        delay until myClock + Milliseconds(20);
     end loop;
  end act;
   
   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      
      procedure MultiDistance (FrontLeft : Distance_cm; FrontRight : Distance_cm; Left : Distance_cm; Right : Distance_cm) is 
      begin 
         if FrontLeft > 300 or FrontLeft = 0 then 
            SensorFrontLeftDistance := 400;
         else
            SensorFrontLeftDistance := FrontLeft;
         end if;
         if FrontRight > 300 or FrontRight = 0 then
            SensorFrontRightDistance := 400;
         else 
            SensorFrontRightDistance := FrontRight;
         end if;

         if Left > 300 or Left = 0 then 
            SensorLeftDistance := 400;
         else
            SensorLeftDistance := Left;
         end if;

         if Right > 300 or Right = 0 then 
            SensorRightDistance := 400;
         else
            SensorRightDistance := Right;
         end if;



      end MultiDistance;

      function GetFrontLeftDistance return Distance_cm is
      begin
         return SensorFrontLeftDistance;
      end GetFrontLeftDistance;
      function GetFrontRightDistance return Distance_cm is
      begin
         return SensorFrontRightDistance;
      end GetFrontRightDistance;

      function GetLeftDistance return Distance_cm is
      begin
         return SensorLeftDistance;
      end GetLeftDistance;
      function GetRightDistance return Distance_cm is
      begin
         return SensorRightDistance;
      end GetRightDistance;

      function GetDistance return Distance_cm is
      begin
         return Distance;
      end GetDistance;

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

         if V = Rotating_Left then
         DriveDirection := Rotating_Left;
         end if;

         if V = Rotating_Right then
         DriveDirection := Rotating_Right;
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
         if V = Rotating_Left then
         MotorDriver.Drive(Rotating_Left, (2048, 2048, 2048, 2048));
         end if;
         if V = Rotating_Right then
         MotorDriver.Drive(Rotating_Right, (2048, 2048, 2048, 2048));
         end if;

      end DriveVehicle;


    end MotorHandling;
end MyController_empty;
