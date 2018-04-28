----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:58:57 04/24/2018 
-- Design Name: 
-- Module Name:    HT_synchronous_trigger - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HT_synchronous_trigger is
	Generic(
		clockFrequency : integer;
		enableAfterMiliSeconds : integer
		);
    Port ( clk : in  STD_LOGIC;
           isEnabled : out  STD_LOGIC);
end HT_synchronous_trigger;

architecture Behavioral of HT_synchronous_trigger is

signal ticks : integer := 0;
signal miliseconds : integer := 0;

begin
	process( clk )
	begin
		if (rising_edge(clk)) then
			if( ticks = (clockFrequency - 1)/1000) then
				ticks <= 0;
				miliseconds <= miliseconds + 1;
				
			else
				ticks <= ticks + 1;
			end if;
		end if;
		if (miliseconds >= enableAfterMiliSeconds) then
			isEnabled <= '1';
		else
			isEnabled <= '0';
		end if;
		
	end process ; -- triggerProcess
end Behavioral;

