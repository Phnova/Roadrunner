pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E074 : Short_Integer; pragma Import (Ada, E074, "ada__tags_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings__text_buffers_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "system__bb__timing_events_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "ada__exceptions_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "system__soft_links_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "system__exception_table_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "ada__streams_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "system__finalization_root_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "ada__finalization_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__storage_pools_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "system__finalization_masters_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "ada__real_time_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__pool_global_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "system__tasking__protected_objects_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "system__tasking__restricted__stages_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "hal__gpio_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "hal__i2c_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "hal__spi_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "hal__uart_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "memory_barriers_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "cortex_m__nvic_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "nrf__events_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "nrf__gpio_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "nrf__gpio__tasks_and_events_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "nrf__interrupts_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "nrf__rtc_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "nrf__spi_master_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "nrf__tasks_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "nrf__adc_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "nrf__clock_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "nrf__ppi_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "nrf__timers_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "nrf__twi_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "nrf__uart_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "nrf__device_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "microbit__iosfortasking_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "microbit__servos_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "microbit__timewithrtc1_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "microbit__buttons_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Ada.Strings.Text_Buffers'Elab_Spec;
      E005 := E005 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E072 := E072 + 1;
      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      Ada.Tags'Elab_Body;
      E074 := E074 + 1;
      System.Exception_Table'Elab_Body;
      E042 := E042 + 1;
      E044 := E044 + 1;
      E012 := E012 + 1;
      Ada.Streams'Elab_Spec;
      E146 := E146 + 1;
      System.Finalization_Root'Elab_Spec;
      E153 := E153 + 1;
      Ada.Finalization'Elab_Spec;
      E151 := E151 + 1;
      System.Storage_Pools'Elab_Spec;
      E155 := E155 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E150 := E150 + 1;
      Ada.Real_Time'Elab_Body;
      E195 := E195 + 1;
      System.Pool_Global'Elab_Spec;
      E157 := E157 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E223 := E223 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E230 := E230 + 1;
      HAL.GPIO'ELAB_SPEC;
      E148 := E148 + 1;
      HAL.I2C'ELAB_SPEC;
      E185 := E185 + 1;
      HAL.SPI'ELAB_SPEC;
      E178 := E178 + 1;
      HAL.UART'ELAB_SPEC;
      E189 := E189 + 1;
      E221 := E221 + 1;
      E219 := E219 + 1;
      E214 := E214 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E143 := E143 + 1;
      E239 := E239 + 1;
      E216 := E216 + 1;
      E173 := E173 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E176 := E176 + 1;
      E201 := E201 + 1;
      E237 := E237 + 1;
      E199 := E199 + 1;
      E241 := E241 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E180 := E180 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E183 := E183 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E187 := E187 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E133 := E133 + 1;
      Microbit.Iosfortasking'Elab_Spec;
      Microbit.Iosfortasking'Elab_Body;
      E235 := E235 + 1;
      E245 := E245 + 1;
      Microbit.Timewithrtc1'Elab_Spec;
      Microbit.Timewithrtc1'Elab_Body;
      E193 := E193 + 1;
      Microbit.Buttons'Elab_Body;
      E191 := E191 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
   end;

--  BEGIN Object file/option list
   --   C:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\servos\obj\main.o
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\servos\obj\
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\servos\obj\
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\boards\MicroBit_v2\obj\full_lib_Debug\
   --   -LC:\users\saos\appdata\local\alire\cache\toolchains\gnat_arm_elf_14.1.3_184f9b28\arm-eabi\lib\gnat\embedded-nrf52833\adalib\
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
