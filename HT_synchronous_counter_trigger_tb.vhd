--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:22:48 04/28/2018
-- Design Name:   
-- Module Name:   C:/Users/kamil/Documents/Praca magisterska/HardwareTrojan/HT_synchronous_counter_trigger_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HT_synchronous_counter_trigger
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY HT_synchronous_counter_trigger_tb IS
END HT_synchronous_counter_trigger_tb;
 
ARCHITECTURE behavior OF HT_synchronous_counter_trigger_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HT_synchronous_counter_trigger
    GENERIC(
        increaseCounterOn : STD_LOGIC_VECTOR(7 downto 0);
        enableAfterOccurences : integer
      );
    PORT(
         input_byte : IN  std_logic_vector(7 downto 0);
         isEnabled : OUT  std_logic
        );
    END COMPONENT;
    
    type VALUES is array (2 downto 0) of std_logic_vector(7 downto 0);
    signal samples : VALUES := (x"49",x"50",x"51");

    signal clock : std_logic := '0';
   --Inputs
   signal input_byte : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal isEnabled : std_logic;
   signal counter : integer := 0;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HT_synchronous_counter_trigger 
    GENERIC MAP(
      increaseCounterOn => x"50",
      enableAfterOccurences => 4
      )
    PORT MAP (
          input_byte => input_byte,
          isEnabled => isEnabled
        );

   -- Clock process definitions
  process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   process( clock )
   begin
    if (rising_edge(clock)) then
      input_byte <= samples(counter);
      counter <= counter + 1;
      if(counter = 2) then
        counter <= 0;
      end if;
      
    end if;
     
   end process ;   

END;
