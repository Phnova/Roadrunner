with System;
with Ada.Interrupts;
with nRF.GPIO; use nRF.GPIO;
with NRF_SVD.GPIO; use NRF_SVD.GPIO;
with nRF.Interrupts;
with nRF.Events;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Interrupts.Names; 
with MicroBit.Console; use MicroBit.Console;
use MicroBit;
with HAL; use HAL;

package interrupt_demo is
  
   type Pin_Status is (No_Pin, DOUBLE_PIN, Pin_0, Pin_1, Pin_2);
   
   type Signal_Edge is (Rising_Edge, Falling_Edge, Unknown);
   
   type Pin is record
      Pin : Pin_Status;
      Edge: Signal_Edge;
   end record;
   
   
   protected Receiver is  -- the first-level handler using interrupt priorities (all higher than application)
      function GetStatus return Pin;
      procedure SetStatus (S : Pin);
      
      pragma Interrupt_Priority (System.Interrupt_Priority'First);      
      
   private
      procedure My_Interrupt_Service_Routine;
      pragma Attach_Handler (My_Interrupt_Service_Routine, Ada.Interrupts.Names.GPIOTE_Interrupt);
      Status : Pin;      
   end Receiver;
   

   task Process_Messages with Priority => 1;  --the second-level handler using application prioritizes (different than in cited example where all processing is done at same prio)

      
   
   

end interrupt_demo;
