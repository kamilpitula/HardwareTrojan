----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kamil Pitula
-- 
-- Create Date:    17:13:36 10/30/2017 
-- Design Name: Pseudo Random Number Generator
-- Module Name:    LFSR - Behavioral 
-- Project Name: Hardware Trojan
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

entity LFSR is
	generic (
			register_width : integer range 3 to 32 := 8
		);
    port ( in_clk : in  std_logic;
           in_register_enable : in  std_logic;
           in_seed_vector : in std_logic_vector(register_width - 1 downto 0);
           in_seed_enable : in std_logic;

           out_LFSR_data : out std_logic_vector(register_width - 1 downto 0)
         );
end LFSR;

architecture Behavioral of LFSR is

--type ArrayOfTaps is array(2 to 32) of std_logic_vector(31 downto 0);

signal register_LFSR : std_logic_vector(register_width downto 1) := (others => '0');
--signal ActualTap : std_logic_vector(register_width downto 1); 
signal feedback :std_logic;


begin

--main logic:
--Load seed data if seed_enable is on
--if not, run lfsr
LFSR_main_process : process (in_clk,  register_LFSR)

--variable Taps : ArrayOfTaps;
--variable feedback : std_logic:='0';


begin

--Set up Polynomial

	
 ----------end----------------

  if ( rising_edge( in_clk ) ) then
  	if ( in_register_enable = '1' ) then
  		if ( in_seed_enable = '1' ) then
  			register_LFSR <= in_seed_vector;
  		else
  			register_LFSR <= register_LFSR( register_width - 1 downto 1 ) & feedback ;
  		end if;
  	end if;
  end if;

  --feedback_generator : for i in 1 to register_width loop
	--if (ActualTap(i) = '1') then
	--	feedback := feedback xor register_LFSR(i);
	--end if;
 -- end loop;


end process LFSR_main_process;


feedback<=register_LFSR(8) xnor register_LFSR(6) xnor register_LFSR(5) xnor register_LFSR(4);

out_LFSR_data <= register_LFSR;

end Behavioral;

