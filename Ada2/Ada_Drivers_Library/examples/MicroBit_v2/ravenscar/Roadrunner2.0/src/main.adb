--with MyController; -- This embeds and instantiates the MyController package
with MyController_empty;

--with Tasks.Think;
--With TaskThink;
--With TaskThink;
--With TaskSense;


-- NOTE ----------
-- See the MyController_empty package first for a single file empty Sense-Think-Act (STA) template
-- The MyController package contains a better structured STA template with each task having its own file
-- Build your own controller from scratch using the template and structured coding principles as a guide line.
-- Use
--------------------------------------------------------------------------------------------------------------------------------------------------------
--  
--  TO DO:  Replace motordriver stuff in this program with Microbit.Motordriver stuff  -- DONE
--          Need workaround if the sensor goes out of range                            -- DONE (kinda. See **)
--             - Through testing: If the sensor gets out of range, it registers as 0. 
--             ** Need to ensure that 0 is a valid distance if close to sensor. Maybe try to have a variable that stores data, then check if
--                objects move closer or further by comparing the stored with new?
--          Use built in stuff to time tasks
--          Sense: 	0.016265869 
--          Think: 	0.000030518
--          Act:	   0.000976563
--          All timings are in seconds. Use this data to time tasks better 
--  
--  
--  
--------------------------------------------------------------------------------------------------------------------------------------------------------
--Empty main running as a task currently set to lowest priority. Can be used as it is a normal task!

Procedure Main with Priority => 0 is

begin
   loop -- We need a main loop, otherwise it constantly reboots!
        -- A reboot can be seen in the Serial Ports (View -> Serial Port, select com port, set baudrate to 115200 and press reset button on Microbit)
        -- Every time the Micro:Bit reboots it will begin with a "0" symbol in your Serial Port monitor.

      -- Put code for the servo motor here

      null;
   end loop;
end Main;
