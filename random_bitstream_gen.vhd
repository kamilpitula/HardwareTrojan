----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kamil Pituła
-- 
-- Create Date:    10:27:59 01/20/2018 
-- Design Name: 
-- Module Name:    random_bitstream_gen - Behavioral 
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

entity random_bitstream_gen is
	Generic(numberOfOscillators : integer;
			negationsMultiplier : integer);
    Port ( out_bitstream : out  STD_LOGIC;
    	   in_clk		 : in   STD_LOGIC
    );
end random_bitstream_gen;

architecture Behavioral of random_bitstream_gen is

signal outputs : std_logic_vector(numberOfOscillators downto 1) := (others => '0');
signal temp : std_logic_vector(numberOfOscillators downto 1) := (others => '0') ;


component ring_oscillator
	generic (
		numberOfNegations : integer
	);
	port (
		bitOut : out std_logic
	);
end component;

begin

bitstream_generator : for i in 1 to numberOfOscillators generate
	oscillator : ring_oscillator
	generic map(numberOfNegations => (i * negationsMultiplier) + 1)
	port map(bitOut => outputs(i));
end generate;

temp(1) <= outputs(1);

outputs_xoring : for i in 2 to numberOfOscillators generate
	temp(i) <= temp(i - 1) xor outputs(i);
end generate;

process (in_clk,temp)
begin
    if (in_clk = '1') then
        out_bitstream <= temp(numberOfOscillators);
    end if;
end process;


end Behavioral;

