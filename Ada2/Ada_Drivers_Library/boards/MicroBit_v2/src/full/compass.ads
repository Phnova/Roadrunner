package Microbit_Compass is
   -- Initialize the compass
   procedure Initialize;

   -- Get the heading in degrees (0 - 360)
   function Get_Heading return Integer;

private
   Magnetometer_Address : constant Byte := 16#0E#;
   Control_Reg1 : constant Byte := 16#10#;
   X_MSB_Reg    : constant Byte := 16#01#;
   Y_MSB_Reg    : constant Byte := 16#03#;

   -- Read a 16-bit value from the magnetometer
   function Read_Magnetometer_Value(Register : Byte) return Integer;
end Microbit_Compass;
