--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:19:24 12/10/2017
-- Design Name:   
-- Module Name:   C:/Users/kamil/Documents/Praca magisterska/HardwareTrojan/rs232_transmitter_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RS232_Transmitter
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
 
ENTITY rs232_transmitter_tb IS
END rs232_transmitter_tb;
 
ARCHITECTURE behavior OF rs232_transmitter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232_Transmitter
    PORT(
         i_Clk : IN  std_logic;
         i_StartTransmission : IN  std_logic;
         i_Byte : IN  std_logic_vector(7 downto 0);
         o_Active : OUT  std_logic;
         o_TX : OUT  std_logic;
         o_Done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_Clk : std_logic := '0';
   signal i_StartTransmission : std_logic := '0';
   signal i_Byte : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal o_Active : std_logic;
   signal o_TX : std_logic;
   signal o_Done : std_logic;

   -- Clock period definitions
   constant i_Clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS232_Transmitter 
          GENERIC MAP(
                  baud => 115000,
                  frequency => 10000000
                  )
          PORT MAP (
                  i_Clk => i_Clk,
                  i_StartTransmission => i_StartTransmission,
                  i_Byte => i_Byte,
                  o_Active => o_Active,
                  o_TX => o_TX,
                  o_Done => o_Done
                );

   -- Clock process definitions
   i_Clk_process :process
   begin
		i_Clk <= '0';
		wait for i_Clk_period/2;
		i_Clk <= '1';
		wait for i_Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait until rising_edge(i_Clk);
      wait until rising_edge(i_Clk);
        i_StartTransmission   <= '1';
        i_Byte <= X"AB";
      wait until rising_edge(i_Clk);
        i_StartTransmission   <= '0';
      wait until o_Done = '1';

      -- insert stimulus here 

      wait;
   end process;

END;
