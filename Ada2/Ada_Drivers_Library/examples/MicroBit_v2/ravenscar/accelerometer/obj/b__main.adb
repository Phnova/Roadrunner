pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E111 : Short_Integer; pragma Import (Ada, E111, "ada__tags_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__strings__text_buffers_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__bb__timing_events_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "ada__exceptions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__soft_links_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "system__exception_table_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "ada__streams_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "system__finalization_root_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "ada__finalization_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "system__storage_pools_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__finalization_masters_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__real_time_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "ada__real_time__timing_events_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "ada__strings__maps_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "ada__strings__unbounded_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__pool_global_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "system__tasking__protected_objects_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "generic_timers_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "hal__gpio_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "hal__i2c_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "hal__spi_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "hal__uart_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "lsm303agr_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "nrf__gpio_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "nrf__rtc_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "nrf__spi_master_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "nrf__timers_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "nrf__twi_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "nrf__uart_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "nrf__device_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "microbit__console_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "microbit__displayrt_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "microbit__displayrt__symbols_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "microbit__i2c_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "microbit__accelerometer_E");

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
      E100 := E100 + 1;
      System.Bb.Timing_Events'Elab_Spec;
      E098 := E098 + 1;
      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      Ada.Tags'Elab_Body;
      E111 := E111 + 1;
      System.Exception_Table'Elab_Body;
      E050 := E050 + 1;
      E052 := E052 + 1;
      E022 := E022 + 1;
      Ada.Streams'Elab_Spec;
      E139 := E139 + 1;
      System.Finalization_Root'Elab_Spec;
      E145 := E145 + 1;
      Ada.Finalization'Elab_Spec;
      E143 := E143 + 1;
      System.Storage_Pools'Elab_Spec;
      E147 := E147 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E142 := E142 + 1;
      Ada.Real_Time'Elab_Body;
      E006 := E006 + 1;
      Ada.Real_Time.Timing_Events'Elab_Spec;
      E205 := E205 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E211 := E211 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E207 := E207 + 1;
      System.Pool_Global'Elab_Spec;
      E149 := E149 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E225 := E225 + 1;
      E223 := E223 + 1;
      HAL.GPIO'ELAB_SPEC;
      E166 := E166 + 1;
      HAL.I2C'ELAB_SPEC;
      E137 := E137 + 1;
      HAL.SPI'ELAB_SPEC;
      E185 := E185 + 1;
      HAL.UART'ELAB_SPEC;
      E195 := E195 + 1;
      LSM303AGR'ELAB_SPEC;
      LSM303AGR'ELAB_BODY;
      E135 := E135 + 1;
      Nrf.Gpio'Elab_Spec;
      Nrf.Gpio'Elab_Body;
      E164 := E164 + 1;
      E180 := E180 + 1;
      Nrf.Spi_Master'Elab_Spec;
      Nrf.Spi_Master'Elab_Body;
      E183 := E183 + 1;
      Nrf.Timers'Elab_Spec;
      Nrf.Timers'Elab_Body;
      E187 := E187 + 1;
      Nrf.Twi'Elab_Spec;
      Nrf.Twi'Elab_Body;
      E190 := E190 + 1;
      Nrf.Uart'Elab_Spec;
      Nrf.Uart'Elab_Body;
      E193 := E193 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E155 := E155 + 1;
      Microbit.Console'Elab_Body;
      E201 := E201 + 1;
      Microbit.Displayrt'Elab_Body;
      E203 := E203 + 1;
      E227 := E227 + 1;
      E199 := E199 + 1;
      Microbit.Accelerometer'Elab_Body;
      E197 := E197 + 1;
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
   --   C:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\accelerometer\obj\main.o
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\accelerometer\obj\
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\examples\MicroBit_v2\ravenscar\accelerometer\obj\
   --   -LC:\Users\Saos\Git\Ada2\Ada_Drivers_Library\boards\MicroBit_v2\obj\full_lib_Debug\
   --   -LC:\users\saos\appdata\local\alire\cache\toolchains\gnat_arm_elf_14.1.3_184f9b28\arm-eabi\lib\gnat\embedded-nrf52833\adalib\
   --   -static
   --   -lgnarl
   --   -lgnat
--  END Object file/option list   

end ada_main;
