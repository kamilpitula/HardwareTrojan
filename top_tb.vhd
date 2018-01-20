--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:19:27 01/06/2018
-- Design Name:   
-- Module Name:   C:/Users/kamil/Documents/Praca magisterska/HardwareTrojan/top_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Generator_TOP
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
 
ENTITY top_tb IS
END top_tb;
 
ARCHITECTURE behavior OF top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Generator_TOP
    PORT(
         clk : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         led_control : OUT  std_logic_vector(7 downto 0);
         switches : IN  std_logic_vector(7 downto 0);
         buttons : IN  std_logic_vector(4 downto 0);
         uart_tx : OUT  std_logic;
         uart_rx : IN  std_logic;
         data_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal switches : std_logic_vector(7 downto 0) := (others => '1');
   signal buttons : std_logic_vector(4 downto 0) := (others => '0');
   signal uart_rx : std_logic := '0';

 	--Outputs
   signal led_control : std_logic_vector(7 downto 0);
   signal uart_tx : std_logic;
   signal data_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Generator_TOP PORT MAP (
          clk => clk,
          data_in => data_in,
          led_control => led_control,
          switches => switches,
          buttons => buttons,
          uart_tx => uart_tx,
          uart_rx => uart_rx,
          data_out => data_out
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
      wait for 5 ms; 
      switches(0)<='0';
     

      -- insert stimulus here 

      wait;
   end process;

END;
