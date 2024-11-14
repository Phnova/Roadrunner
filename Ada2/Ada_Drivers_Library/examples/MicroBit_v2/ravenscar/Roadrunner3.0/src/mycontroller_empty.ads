with MicroBit.Ultrasonic;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver; --using the procedures defined here
with DFR0548;
use MicroBit;


package MyController_empty is

   type Directions is (Stop, Forward, Backward, Left, Right, Rotating_Left, Rotating_Right);

   subtype Buffer_Index is Positive range 1 .. 5; -- Adjust this according to the size of the buffer

   type Distance_Array is array (Buffer_Index) of Distance_cm;
   type DistanceZones is (Close, Medium, Far);
   
   task Sense  with Priority  => 3;

   task Think  with Priority  => 2; 
   
   task Act    with Priority  => 1;

   protected MotorHandling is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
      procedure DriveVehicle (V : Directions);
   private
      DriveDirection             : Directions := Stop;
   end MotorHandling;

   
   protected type SensorBuffer is
      procedure Add_Data(FrontLeft : in Distance_cm; FrontRight : in Distance_cm; Left : in Distance_cm; Right : in Distance_cm);
      function Get_Data return Boolean;
      entry Retrieve_Data(FrontLeft : out Distance_cm; FrontRight : out Distance_cm; Left : out Distance_cm; Right : out Distance_cm);
   private
      Buffer_Size       : Positive := 5;
      FrontLeft_Buffer  : Distance_Array := (others => 0);
      FrontRight_Buffer : Distance_Array := (others => 0);
      Left_Buffer       : Distance_Array := (others => 0);
      Right_Buffer      : Distance_Array := (others => 0);

      Count             : Natural      := 0;  -- Number of items currently in buffer
      Read_Index        : Buffer_Index := 1;
      Write_Index       : Buffer_Index := 1;
   end SensorBuffer;
      
end MyController_empty;
