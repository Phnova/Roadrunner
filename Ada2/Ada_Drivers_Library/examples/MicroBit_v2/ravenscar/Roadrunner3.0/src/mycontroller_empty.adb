with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with system.Machine_Code; use system.Machine_Code;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
with Ada.Execution_Time; use Ada.Execution_Time;

package body MyController_empty is


   -- Initiation of buffer
   Buffer : SensorBuffer;

   task body sense is
      -- Declare timing variables used to time task
      myClock : Time;
      endTime : Time;
      -- Set up ultrasonic sensors
      package sensorFrontLeft is new Ultrasonic(MB_P0, MB_P1);
      package sensorFrontRight is new Ultrasonic(MB_P2, MB_P8);
      package sensorLeft is new Ultrasonic(MB_P12, MB_P13);
      package sensorRight is new Ultrasonic(MB_P14, MB_P15);

   begin
      loop
         myClock := Clock;

         -- Use declare to make objects inside task
         declare
            NewFrontLeft  : constant Distance_cm := sensorFrontLeft.Read;
            NewFrontRight : constant Distance_cm := sensorFrontRight.Read;
            NewLeft       : constant Distance_cm := sensorLeft.Read;
            NewRight      : constant Distance_cm := sensorRight.Read;
         begin
            -- Add data to the buffer
            Buffer.Add_Data(NewFrontLeft, NewFrontRight, NewLeft, NewRight);
         end;
         -- End timing
         endTime := Clock;
         -- Write timing to terminal
         --Put_Line("Sense Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");
         -- Task worst case is ~200ms, 50ms overhead
         delay until myClock + Milliseconds(340);
      end loop;
   end sense;


   -- Main task for decisionmaking
   -- Use this task to gather data from sense and decide where obsitcles are
   task body think is
      myClock : Time;
      endTime : Time;

      DistanceFrontLeft    : Distance_cm := 0;
      DistanceFrontRight   : Distance_cm := 0;
      DistanceRight        : Distance_cm := 0;
      DistanceLeft         : Distance_cm := 0;  
   
      ZoneFrontLeft        : DistanceZones;
      ZoneFrontRight       : DistanceZones;
      ZoneLeft             : DistanceZones;
      ZoneRight            : DistanceZones;

   begin
      loop
         myClock := Clock;

         -- Retrieve buffered data if available
         if Buffer.Get_Data then
            Buffer.Retrieve_Data(DistanceFrontLeft, DistanceFrontRight, DistanceLeft, DistanceRight);

            --Put_Line("FrontLeft:    " & Distance_cm'Image(DistanceFrontLeft));
            --Put_Line("FrontRight:   " & Distance_cm'Image(DistanceFrontRight));
            --Put_Line("Left:         " & Distance_cm'Image(DistanceLeft));
            --Put_Line("Right:        " & Distance_cm'Image(DistanceRight));


            --Put_Line("FrontLeft:    " & Distance_cm'Image(DistanceFrontLeft));
            --Put_Line("FrontRight:   " & Distance_cm'Image(DistanceFrontRight));
            --Put_Line("Left:         " & Distance_cm'Image(DistanceLeft));
            --Put_Line("Right:        " & Distance_cm'Image(DistanceRight));

            -- Process data here
            -- Example: Check conditions and set directions based on the retrieved data


            if DistanceFrontLeft > 40 and DistanceFrontRight > 40 then
               MotorHandling.SetDirection(Forward);
            elsif DistanceFrontLeft < 40 or DistanceFrontRight < 40 then
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

         end if;

         endTime := Clock;
         --Put_Line("Think Task Duration: " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");

         delay until myClock + Milliseconds(50);
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
         --Put_Line("Act Task Duration:     " & Duration'Image(To_Duration(endTime - myClock)) & " seconds");
        delay until myClock + Milliseconds(40);
     end loop;
  end act;
   
   protected body DistanceHandling is
      
      
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

protected body SensorBuffer is

   -- Adds new sensor data to the buffer
   procedure Add_Data(FrontLeft : in Distance_cm; FrontRight : in Distance_cm; Left : in Distance_cm; Right : in Distance_cm) is
   begin
      if Count < Buffer_Size then
         -- Add data to the buffer at the current write position
         if FrontLeft > 300 or FrontLeft = 0 then
            FrontLeft_Buffer(Write_Index) := 400;
         else
            FrontLeft_Buffer(Write_Index) := FrontLeft;
         end if;
         if FrontRight > 300 or FrontRight = 0 then
            FrontRight_Buffer(Write_Index) := 400;
         else
            FrontRight_Buffer(Write_Index) := FrontRight;
         end if;
         if Left > 300 or Left = 0 then
            Left_Buffer(Write_Index) := 400;
         else 
            Left_Buffer(Write_Index) := Left;
         end if;
         if Right > 300 or Right = 0 then
            Right_Buffer(Write_Index) := 400;
         else 
            Right_Buffer(Write_Index) := Right;
         end if;
         -- Update write index and count
         Write_Index := (Write_Index mod Buffer_Size) + 1;
         Count := Count + 1;
      end if;
   end Add_Data;

   -- Checks if data is available in the buffer
   function Get_Data return Boolean is
   begin
      return Count > 0;
   end Get_Data;

   -- Retrieves data from the buffer if available
   entry Retrieve_Data(FrontLeft : out Distance_cm; FrontRight : out Distance_cm; Left : out Distance_cm; Right : out Distance_cm) when Count > 0 is
   begin
      -- Output the data at the current read position
      FrontLeft := FrontLeft_Buffer(Read_Index);
      FrontRight := FrontRight_Buffer(Read_Index);
      Left := Left_Buffer(Read_Index);
      Right := Right_Buffer(Read_Index);
      
      -- Update read index and count
      Read_Index := (Read_Index mod Buffer_Size) + 1;
      Count := Count - 1;
   end Retrieve_Data;

end SensorBuffer;

end MyController_empty;
