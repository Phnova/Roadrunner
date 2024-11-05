With Ada.Real_Time; use Ada.Real_Time;


-- This entire task is intended for the vehicles abilities to "sense" its environment
-- Ultrasonic sensors will be used to measure distance to objects. 
-- These distances shall be stored in variables/arrays and be possible to read using functoins
-- These functions will be used in "Thinking" for the vehicle

-- Timing and delays needs to be checked


package body TaskSense is

    task body sense is
      myClock : Time;

               
      -- array of booleans to store sensordata
      package sensor1 is new Ultrasonic(MB_P1, MB_P0);
      package sensor2 is new Ultrasonic(MB_P8, MB_P2);
      package sensor3 is new Ultrasonic(MB_P12, MB_P13);
      -- package sensor4 is new Ultrasonic(MB_P14, MB_P15);   

      Distance_1 : Distance_cm := 0;
      Distance_2 : Distance_cm := 0;
      Distance_3 : Distance_cm := 0;
      --Distance_4 : Distance_cm := 0;
   begin
      
      null; -- note that you can place Setup code here that is only run once for the entire task
      
      loop
         myClock := Clock; --important to get current time such that the period is exactly 200ms.
                           --you need to make sure that the instruction NEVER takes more than this period. 
                           --make sure to measure how long the task needs, see Tasking_Calculate_Execution_Time example in the repository.
                           --What if for some known or unknown reason the execution time becomes larger?
                           --When Worst Case Execution Time (WCET) is overrun so higher than your set period, see : https://www.sigada.org/ada_letters/dec2003/07_Puente_final.pdf
                           --In this template we put the responsiblity on the designer/developer.
         ----------------------------------------------------------------------------------      
         Distance_1 := sensor1.Read;      
         Distance_2 := sensor2.Read;
         Distance_3 := sensor3.Read;
         --Distance_4 := sensor4.Read;





         --delay (0.024); --simulate a sensor eg the ultrasonic sensors needs at least 24ms for 400cm range, replace with your code!!!
                        -- to integrate for example an ultrasonic sensor: copy paste the ultrasonic package for the ultrasonic example to the src directory
                        -- include it using  "with ultrasonic; use ultrasonic". The ultrasonic sensor uses type Distance_CM how can we make that compatible with our Brain.SetMeasurementSensor1?  
         --Put_Line("Sensing");
         --Brain.SetMeasurementSensor1 (10); -- random value, hook up a sensor here note that you might need to either cast to integer OR -better- change type of Brain.SetMeasurementSensor1
         --Brain.SetMeasurementSensor2 (1); -- random value, hook up another sensor here

      
      -- need a function here that returns where obstacles are detected
      -- this function will be used by task think



         delay until myClock + Milliseconds(200); --random period
      end loop;
   end sense;

   function GetDistance1 return Distance_1 is
   begin
      return Distance_1;
   end GetDistance1;

   function GetDistance2 return Distance_2 is
   begin
      return Distance_2;
   end GetDistance2;

   function GetDistance3 return Distance_3 is
   begin
      return Distance_3;
   end GetDistance3;
end TaskSense;
