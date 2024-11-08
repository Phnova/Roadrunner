--with MyController; -- This embeds and instantiates the MyController package
with MyController_empty;

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
--  TO DO:  Replace motordriver stuff in this program with Microbit.Motordriver stuff -- DONE
--          
--          Make funcitonality in SENSE that stores sensordata in an enum or some sort of datastructure in regards to obstacle sensing
--          - Like one boolean or something for each sensor. This value if something a function can return if the "think" needs to check this
--          - Example: Sense stores sensordata for front,back,left,right. Think checks these spots, if something is close front, think needs
--             to check if back/left/right is safe, and maneuver to a safe direction.
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
