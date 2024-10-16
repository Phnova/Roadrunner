with interrupt_demo;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
procedure Main with Priority => 0 is

   --good to know:
   -- This example has port 0 implemented not port 1. Some pins like pin 16 need additional work (eg replace GPIO_Periph with GPIO_Periph1)
   --in system.ads it is defined (and explained why) that no task can have a higher interrupt priority than the hardware meaning
   -- meaning there is a seperation between application level and hardware level priorities
   -- in additional it also not allowed by the spec to have application interrupts higher than hardware interrupts
   -- https://www.adaic.org/resources/add_content/docs/95style/html/sec_6/6-1-1.html. With ceiling locking errors happen if not done.
   -- using mutex and locks with ADA's protected objects https://blog.adacore.com/priority-extending-mutexes
   -- "The priority-based approach to providing mutual exclusive access for protected objects only works on a uniprocessor."

   -- this example is partly based on https://www.adacore.com/gems/ada-gem-13
   -- and https://devzone.nordicsemi.com/f/nordic-q-a/47973/how-to-implement-interrupt-using-gpio-not-gpiote-peripheral


begin
   delay until Clock + Milliseconds (100); -- delayed start
   Put_Line ("START MAIN");
   loop --generate some square wave pattern
      Set(7,True);
      delay until Clock + Milliseconds (2000);
      Set(7, False);
      delay until Clock + Milliseconds (1000);
   end loop;
end Main;
