with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;

with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;

package body MyController_empty is

   -- Main task for sensing environment
   -- Use ultrasonic sensors here
   task body sense is
      myClock : Time;
      
      -- array of booleans to store sensordata
      package sensor1 is new Ultrasonic(MB_P1, MB_P0);
      --package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      --package sensor3 is new Ultrasonic(MB_P12, MB_P13);
      --package sensor4 is new Ultrasonic(MB_P14, MB_P15);   

      --Distance_1 : Distance_cm := 0;
      --Distance_2 : Distance_cm := 0;
      --Distance_3 : Distance_cm := 0;
      --Distance_4 : Distance_cm := 0;
      -- need a function here that returns where obstacles are detected
      -- this function will be used by task think
   begin
      loop
         myClock := Clock;
         
         
         Put_Line("Sensing: " & Distance_cm'Image(DistanceHandling.GetDistance));
         delay until myClock + Milliseconds(100);

         DistanceHandling.SetDistance(sensor1.Read);
      end loop;

   end sense;

   -- Main task for decisionmaking
   -- Use this task to gather data from sense and decide where obsitcles are
   task body think is
      myClock : Time;
   begin
      loop
         myClock := Clock;
         
         delay (0.05); --simulate 50 ms execution time, replace with your code
         
         MotorDriver.SetDirection (Forward);
         Put_Line("Thinking");
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
       
         Put_Line ("Direction is: " & Directions'Image (MotorDriver.GetDirection));
         
         delay until myClock + Milliseconds(40);
      end loop;
   end act;
   
   protected body DistanceHandling is
      
      procedure SetDistance (V : Distance_cm) is
      begin
         Distance := V;
      end SetDistance;
      function GetDistance return Distance_cm is
      begin
         return Distance;
      end GetDistance;

   end DistanceHandling;
   

    protected body MotorDriver is
      --  procedures can modify the data
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
    end MotorDriver;
end MyController_empty;
