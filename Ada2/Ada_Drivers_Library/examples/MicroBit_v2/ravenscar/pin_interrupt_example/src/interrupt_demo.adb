with MicroBit.TimeHighspeed; use MicroBit.TimeHighspeed;
with nRF; use nRF;
package body interrupt_demo is

   task body Process_Messages is
      Execution_Start : Time;
      Period : Time_Span := Milliseconds(500);    
   begin
      delay until Clock + Period; --task set to sleep until next 
      loop
         Execution_Start := Clock;
         
         --Put_Line ("START PROCESS MESSAGES");
         
         if Receiver.GetStatus.Pin /= No_Pin then
              Put_Line ("Pin " & Pin_Status'Image(Receiver.GetStatus.Pin) & " : " & Signal_Edge'Image(Receiver.GetStatus.Edge));
            Receiver.SetStatus((Pin => No_Pin, 
                                Edge => Unknown)); --reset the event
         end if;
         
         
         -- execution time of the above took to long (eg. 100 > 0 + 50). At this point we could implement a safety feature to "drop" one or more times depending on how much the overshoot was the next run of this task using an if statement. For hard real time systems overshoot should not be possible because we proved that the software perfectly scheduable and should trigger a (hardware) error handler for graceful degradation or perhaps recovery
         if Clock > Execution_Start + Period then 
            Put_Line ("Deadline missed");
         end if;
         
         delay until Execution_Start + Period; --task set to sleep until next 
      end loop;
   end Process_Messages;
   
    protected body Receiver is
      --  procedures can modify the data
      procedure SetStatus (S : Pin) is
      begin
         Status := S;
      end SetStatus;
     
      --  functions cannot modify the data
      function GetStatus return Pin is
      begin
         return Status;
      end GetStatus;
      
      procedure My_Interrupt_Service_Routine is
         latch_pin0_31 : LATCH_Register;            
      begin
         -- Put_Line ("START INTERRUPT");
         nRF.Events.Disable_Interrupt (nRF.Events.GPIOTE_PORT); --disable interrupt of event so that we do things without interruption
         
         --check which pin it was, we can do that via the GPIO peripheral LATCH register since the event might be already changed
         latch_pin0_31 := GPIO_Periph.LATCH;  
         
         --Debug info
         --Put_Line ("Latch P0: " & HAL.UInt32'Image(latch_pin0_31.Val));
         
         --clear latch, note if not able to clear than sense is still actively driven. Therefore we do a check below
         GPIO_Periph.LATCH := GPIO_Periph.LATCH;
        
         case latch_pin0_31.Val is 
            when 4 => --MB_Pin0 which is P.02 (so 4 in binary) is triggered from low to high
                if GPIO_Periph.IN_k.Arr (2) = High then
                  Receiver.SetStatus((Pin => Pin_0, Edge => Rising_Edge));
                  GPIO_Periph.PIN_CNF (2).SENSE := Low; 
                  GPIO_Periph.PIN_CNF (2).PULL := Pullup;
               else
                  Receiver.SetStatus((Pin => Pin_0, Edge => Falling_Edge));
                  GPIO_Periph.PIN_CNF (2).SENSE := High; 
                  GPIO_Periph.PIN_CNF (2).PULL := Pulldown;
               end if;
               
            when 8 => --MB_Pin1 which is P.03 (so 8) is triggered from low to high
                if GPIO_Periph.IN_k.Arr (3) = High then
                  Receiver.SetStatus((Pin => Pin_1, Edge => Rising_Edge));
                  
               else
                  Receiver.SetStatus((Pin => Pin_1, Edge => Falling_Edge));
                  
               end if;
            when others =>
                Receiver.SetStatus((Pin => No_Pin,
                                Edge => Unknown)); --reset the event
            end case;
            
         nRF.Events.Clear (nRF.Events.GPIOTE_PORT); --we must clear the event otherwise it will trigger again. If LDETECT it will always trigger if LATCH is not zero
         nRF.Events.Enable_Interrupt (nRF.Events.GPIOTE_PORT); --enable interrupt of event   
      end My_Interrupt_Service_Routine;
      
   end Receiver;
   
  
     
   Conf_falling : GPIO_Configuration;
   Conf_rising : GPIO_Configuration;
  
begin
      Put_Line ("START INIT");
    --SETUP GPIO registers (not GPIOTE registers!)
      Conf_rising.Mode         := Mode_In; -- set DIR register to input
      Conf_rising.Resistors    := Pull_Down;
      Conf_rising.Input_Buffer := Input_Buffer_Connect; -- set INPUT register to connect, this is needed for the sense mechanism to get access to the pin (see gpio pin config in manual)
      Conf_rising.Sense        := Sense_For_High_Level; -- set SENSE register (level-interrupt)
    --Conf.Drive        Note: DRIVE register is not set as this is not needed since input
   
      Conf_falling.Mode         := Mode_In; -- set DIR register to input
      Conf_falling.Resistors    := Pull_Up;
      Conf_falling.Input_Buffer := Input_Buffer_Connect; -- set INPUT register to connect, this is needed for the sense mechanism to get access to the pin (see gpio pin config in manual)
      Conf_falling.Sense        := Sense_For_Low_Level; -- set SENSE register (level-interrupt)
   
   --SETUP GPIOTE channel-less interrupts (not using the 8 GPIOTE channels, see My_Interrupt_Service_Routine which now needs to check which pin triggers the event)
     nRF.Events.Disable_Interrupt (nRF.Events.GPIOTE_PORT); --disable interrupt of event
     --setup pin
     MB_P0.Configure_IO (Conf_rising); --configure as input
     MB_P1.Configure_IO (Conf_rising); --configure as input
  
     GPIO_Periph.DETECTMODE.DETECTMODE := NRF_SVD.GPIO.Default; --note that LDETECT will keep on triggering if not all values are zero while DETECT will not trigger if not all values are zero 
   
     nRF.Events.Clear (nRF.Events.GPIOTE_PORT); --clear any prior events of GPIOTE_PORT
     nRF.Events.Enable_Interrupt (nRF.Events.GPIOTE_PORT); --enable interrupt of event
     nRF.Interrupts.Enable (nRF.Interrupts.GPIOTE_Interrupt); --enable interrupt of device
  
     MB_P0.Configure_IO (Conf_rising); --configure as input
     MB_P1.Configure_IO (Conf_falling); --configure as input
     
   null; --some startup code here
end interrupt_demo;
