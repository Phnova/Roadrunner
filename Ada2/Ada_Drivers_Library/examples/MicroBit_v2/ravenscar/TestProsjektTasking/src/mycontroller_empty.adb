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
      --package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      --package sensor3 is new Ultrasonic(MB_P12, MB_P13);
      --package sensor4 is new Ultrasonic(MB_P14, MB_P15);   
----
      --Sensor1Distance : Distance_cm := 0;
      --Sensor2Distance : Distance_cm := 0;      
      --Sensor3Distance : Distance_cm := 0;
      --Sensor4Distance : Distance_cm := 0;
   begin
      loop
         myClock := Clock;
         
         --if sensor1.Read /= 0 then
         --   Sensor1Distance := sensor1.read;
         --end if;
         --if sensor2.Read /= 0 then
         --   Sensor2Distance := sensor2.read;
         --end if;
         --if sensor3.Read /= 0 then
         --   Sensor3Distance := sensor3.read;
         --end if;
         --if sensor4.Read /= 0 then
         --   Sensor4Distance := sensor4.read;
         --end if;
         --DistanceHandling.MultiDistance(Sensor1Distance, Sensor2Distance, Sensor3Distance, Sensor4Distance);
         DistanceHandling.SetDistance(Sensor1.Read);
         
         Put_Line("Sensing: " & Distance_cm'Image(DistanceHandling.GetDistance));
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
         SafeDistance := DistanceHandling.GetDistance;
         delay (0.05); --simulate 50 ms execution time, replace with your code
         Put_Line("Thinking");         
         if SafeDistance < 20 then
            MotorHandling.SetDirection(Stop);
            Put_line("Reverse");
         else
            MotorHandling.SetDirection (Forward);
            Put_line("Forward");
         end if;
         delay until myClock + Milliseconds(100);
      end loop;
   end think;
   

   -- Main task to set direction of vehicle
   -- Use motordiver stuff here
   task body act is
      myClock : Time;
   begin
      loop
         myClock := Clock;
       
         Put_Line ("Direction is: " & Directions'Image (MotorHandling.GetDirection));
         
         delay until myClock + Milliseconds(40);
      end loop;
   end act;
   
   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      
      procedure MultiDistance (A : Distance_cm; B : Distance_cm; C : Distance_cm; D : Distance_cm) is 
      begin 
         Sensor1Distance := A;
         Sensor2Distance := B;
         Sensor3Distance := C;
         Sensor4Distance := D;
      end MultiDistance;
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
         MotorDriver.Drive(Stop, (0,0,0,0));
         DriveDirection := Stop;
         end if;

         if V = Forward then
         MotorDriver.Drive(Forward, (2048, 2048, 2048, 2048));
         DriveDirection := Forward;
         end if;

         if V = Backward then
         MotorDriver.Drive(Backward, (2048, 2048, 2048, 2048));
         DriveDirection := Backward;
         end if;
--
         if V = Right then
         MotorDriver.Drive(Right, (2048, 2048, 2048, 2048));
         DriveDirection := Right;
         end if;
--
         if V = Left then
         MotorDriver.Drive(Left, (2048, 2048, 2048, 2048));
         DriveDirection := Left;
         end if;


      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
    end MotorHandling;
end MyController_empty;
