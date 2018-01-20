--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:11:28 11/13/2017
-- Design Name:   
-- Module Name:   F:/Master Degree Project/Hardware Implementation/HardwareTrojan/lfsr_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFSR
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
 
ENTITY lfsr_tb IS
END lfsr_tb;
 
ARCHITECTURE behavior OF lfsr_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LFSR
    PORT(
         in_clk : IN  std_logic;
         in_register_enable : IN  std_logic;
         in_seed_vector : IN  std_logic_vector(7 downto 0);
         in_seed_enable : IN  std_logic;
         out_LFSR_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_clk : std_logic := '0';
   signal in_register_enable : std_logic := '1';
   signal in_seed_vector : std_logic_vector(7 downto 0) := x"B5";
   signal in_seed_enable : std_logic := '1';

 	--Outputs
   signal out_LFSR_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant in_clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LFSR PORT MAP (
          in_clk => in_clk,
          in_register_enable => in_register_enable,
          in_seed_vector => in_seed_vector,
          in_seed_enable => in_seed_enable,
          out_LFSR_data => out_LFSR_data
        );

   
   -- Clock process definitions
   in_clk_process :process
   begin
		in_clk <= '0';
		wait for in_clk_period/2;
		in_clk <= '1';
		wait for in_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
      in_seed_enable<='0';
     

      -- insert stimulus here 

      wait;
   end process;

END;
