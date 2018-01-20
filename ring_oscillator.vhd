----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kamil Pituła
-- 
-- Create Date:    18:32:42 01/16/2018 
-- Design Name: 
-- Module Name:    ring_oscillator - Behavioral 
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

entity ring_oscillator is
	Generic(numberOfNegations : Integer);
    Port (
    	   bitOut : out  STD_LOGIC
    	   --clk	  : in STD_LOGIC
    	 );
end ring_oscillator;

architecture Behavioral of ring_oscillator is

signal wires :std_logic_vector (numberOfNegations downto 0) := (others => '0');

attribute S : boolean;

attribute S of wires : signal is true;


begin
 
osccilator : for i in 1 to numberOfNegations generate
	wires(i) <= not wires(i - 1);
end generate osccilator;

--latch: process( clk )
--begin
--	if(clk='1') then
--		bitOut <= not(wires(numberOfNegations) and '1');
--	end if;
--end process; -- latch



wires(0) <= wires(numberOfNegations);

bitOut <= not(wires(numberOfNegations) and '1');

end Behavioral;

