--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:00:20 01/16/2018
-- Design Name:   
-- Module Name:   C:/Users/kamil/Documents/Praca magisterska/HardwareTrojan/ring_oscillator_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ring_oscillator
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
 
ENTITY ring_oscillator_tb IS
END ring_oscillator_tb;
 
ARCHITECTURE behavior OF ring_oscillator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ring_oscillator
    GENERIC(numberOfNegations : Integer);
    PORT(
         bitOut : OUT  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal bitOut : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ring_oscillator 
        GENERIC MAP(numberOfNegations => 100)
        PORT MAP (
          bitOut => bitOut,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
