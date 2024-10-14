package body Microbit_Compass is
   procedure Initialize is
   begin
      -- Start I2C communication with the magnetometer
      System.Microbit.I2C.Write(Magnetometer_Address, Control_Reg1, 16#01#);  -- Set active mode
   end Initialize;

   function Get_Heading return Integer is
      X_Val, Y_Val : Integer;
      Heading      : Integer;
   begin
      X_Val := Read_Magnetometer_Value(X_MSB_Reg);
      Y_Val := Read_Magnetometer_Value(Y_MSB_Reg);

      Heading := Integer(Float(180.0 / 3.14159) * Arctan2(Float(Y_Val), Float(X_Val)));

      if Heading < 0 then
         Heading := Heading + 360;
      end if;

      return Heading;
   end Get_Heading;

   function Read_Magnetometer_Value(Register : Byte) return Integer is
      High_Byte, Low_Byte : Byte;
      Value               : Integer;
   begin
      High_Byte := System.Microbit.I2C.Read(Magnetometer_Address, Register);
      Low_Byte := System.Microbit.I2C.Read(Magnetometer_Address, Register + 1);

      Value := (High_Byte * 16#100#) + Low_Byte;

      if Value >= 16#8000# then
         Value := Value - 16#10000#;
      end if;

      return Value;
   end Read_Magnetometer_Value;

end Microbit_Compass;
