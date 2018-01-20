--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:40:37 12/06/2017
-- Design Name:   
-- Module Name:   F:/Master Degree Project/Hardware Implementation/HardwareTrojan/rs232_reciever_tb.vhd
-- Project Name:  HardwareTrojan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RS232_Reciever
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
 
ENTITY rs232_reciever_tb IS
END rs232_reciever_tb;
 
ARCHITECTURE behavior OF rs232_reciever_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232_Reciever
    PORT(
         i_Clk : IN  std_logic;
         i_Rx : IN  std_logic;
         o_TransmissionEnded : OUT  std_logic;
         o_RecievedData : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_Clk : std_logic := '0';
   signal i_Rx : std_logic := '0';

 	--Outputs
   signal o_TransmissionEnded : std_logic;
   signal o_RecievedData : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant i_Clk_period : time := 50 ns;
   constant data :std_logic_vector (7 downto 0) := X"AA";
   constant c_BIT_PERIOD : time := 1000 ns;
 
BEGIN
 
	-- Instantiate the Unit Un-der Test (UUT)
   uut: RS232_Reciever 
        GENERIC MAP(
          baud => 115000,
          frequency => 10000000
          )
        PORT MAP (
          i_Clk => i_Clk,
          i_Rx => i_Rx,
          o_TransmissionEnded => o_TransmissionEnded,
          o_RecievedData => o_RecievedData
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

      i_Rx <= '0';
      wait for c_BIT_PERIOD;
      for i in 0 to 7 loop
        i_Rx<=data(i);       
        wait for c_BIT_PERIOD; 
      end loop;
      i_Rx<='1';
      wait for c_BIT_PERIOD;


      -- insert stimulus here 

      wait;
   end process;

END;
