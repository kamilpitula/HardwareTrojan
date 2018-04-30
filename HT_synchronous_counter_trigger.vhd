----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kamil Pituła
-- 
-- Create Date:    11:11:40 04/28/2018 
-- Design Name: 
-- Module Name:    HT_synchronous_counter_trigger - Behavioral 
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

entity HT_synchronous_counter_trigger is
	Generic(
			increaseCounterOn : STD_LOGIC_VECTOR(7 downto 0);
			enableAfterOccurences : integer
		);
    Port ( input_byte : in  STD_LOGIC_VECTOR (7 downto 0);
           isEnabled : out  STD_LOGIC);
end HT_synchronous_counter_trigger;

architecture Behavioral of HT_synchronous_counter_trigger is

signal ticks : integer := 0;
signal tempIsEnabled : STD_LOGIC := '0';

begin

 process( input_byte )
 begin
	if(input_byte = increaseCounterOn and not (tempIsEnabled = '1')) then
		ticks <= ticks + 1;
	end if;
	if (ticks >= enableAfterOccurences) then
		tempIsEnabled <= '1';
	else
		tempIsEnabled <= '0';
	end if;
 end process ; -- 

isEnabled <= tempIsEnabled;

end Behavioral;

