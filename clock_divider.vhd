----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:12 01/06/2018 
-- Design Name: 
-- Module Name:    clock_divider - Behavioral 
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

entity clock_divider is
	Generic(divider : integer);
    Port ( clk_in : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

signal counter : integer := 0;

begin

process( clk_in )
begin
	if(rising_edge(clk_in)) then
		if (counter < divider) then
			clk_out <= '0';
			counter <= counter + 1;
		else
			clk_out <= '1';
			counter <= 0;
		end if;
	end if;
end process;

end Behavioral;

