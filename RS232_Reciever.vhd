----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:14:51 12/06/2017 
-- Design Name: 
-- Module Name:    RS232_Reciever - Behavioral 
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

entity RS232_Reciever is

	generic(
		baud		:positive:=115000;
		frequency	:positive:=10000000
		);

    Port ( i_Clk : in  STD_LOGIC;
           i_Rx : in  STD_LOGIC;
           o_TransmissionEnded : out  STD_LOGIC;
           o_RecievedData : out  STD_LOGIC_VECTOR (7 downto 0));
end RS232_Reciever;

architecture Behavioral of RS232_Reciever is
	constant clkPerBit	:	integer := frequency/baud;
	type uartStates is (Idle, StartBit, RecieveDataBits, StopBit);

	signal clockTicksCounter :	integer range 0 to clkPerBit-1 := 0;
	signal baudTick 	: STD_LOGIC := '0';

	signal currentState :	uartStates := Idle;
	signal RecieveDataRegister :  STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
	signal TransmissionEndedTemp : STD_LOGIC := '0';

	signal bitIndex : integer := 0;

	begin

	RecieveData : process( i_Clk )
	begin
		if rising_edge(i_Clk) then
	
			case(currentState) is
				when Idle => 
					TransmissionEndedTemp <= '0';
					bitIndex <= 0;
					if(i_Rx = '0') then	
						currentState<=StartBit;
					end if;
							
				when StartBit => 
					if(clockTicksCounter=(clkPerBit-1)/2) then
						if(i_Rx='0') then
							clockTicksCounter <= 0;
							currentState <= RecieveDataBits;
						else
							currentState <= Idle;
						end if;	
					else
						clockTicksCounter <= clockTicksCounter + 1;
						currentState <= StartBit;
					end if;

				when RecieveDataBits => 
					 if (clockTicksCounter<clkPerBit-1) then
					 	clockTicksCounter <= clockTicksCounter + 1;
					 	currentState <= RecieveDataBits;
					 else
					 	clockTicksCounter<=0;
					 	RecieveDataRegister(bitIndex) <= i_Rx;
					 	if (bitIndex<7) then
					 		bitIndex<=bitIndex+1;
					 		currentState<=RecieveDataBits;
					 	else
					 		bitIndex<=0;
					 		currentState<=StopBit;
					 	end if;
					 end if;
				when StopBit => 
					if (clockTicksCounter<clkPerBit-1) then
						clockTicksCounter<=clockTicksCounter+1;
						currentState<=StopBit;
					else
						clockTicksCounter<=0;
						o_TransmissionEnded<='1';
						currentState<=Idle;
					end if;
				when others =>
					currentState<=Idle;
			end case;
		end if;
		o_RecievedData<=RecieveDataRegister;
	o_TransmissionEnded<=TransmissionEndedTemp;
	end process ; -- RecieveData





end Behavioral;

