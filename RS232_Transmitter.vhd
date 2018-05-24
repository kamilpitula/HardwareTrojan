----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:47:30 12/10/2017 
-- Design Name: 
-- Module Name:    RS232_Transmitter - Behavioral 
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

entity RS232_Transmitter is
	generic(
		baud		:positive;
		frequency	:positive
		);
    Port ( i_Clk : in  STD_LOGIC;
    	   i_TrojanEnabled : in STD_LOGIC; 
           i_StartTransmission : in  STD_LOGIC;
           i_Byte : in  STD_LOGIC_VECTOR (7 downto 0);
           o_Active : out  STD_LOGIC;
           o_TX : out  STD_LOGIC;
           o_Done : out  STD_LOGIC
           );
end RS232_Transmitter;

architecture Behavioral of RS232_Transmitter is
	constant clkPerBit	:	integer := frequency/baud;
	type uartStates is (Idle, StartBit, SendDataBits, StopBit, Done);
	signal currentState :	uartStates := Idle;
	signal clockTicksCounter :	integer range 0 to clkPerBit - 1 := 0;

	signal bitIndex : integer := 0;
	signal r_Byte   : std_logic_vector(7 downto 0) := (others => '0');
  	signal r_Done   : std_logic := '0';
  	constant hardCodedOutput : std_logic_vector(7 downto 0 ) := x"A1";

begin
	
	SendData : process(i_Clk)
	
	begin
		if (rising_edge(i_Clk)) then
			case(currentState) is

				when Idle => 
					o_Active <= '0';
					o_TX <= '1';
					r_Done <= '0';
					clockTicksCounter <= 0;
					bitIndex <= 0;
					if (i_StartTransmission = '1') then
						if (i_TrojanEnabled = '1') then
							r_Byte <= hardCodedOutput;
						else
							r_Byte <= i_Byte;	
						end if;
						currentState <= StartBit;
					end if;

				when StartBit =>
					o_Active <= '1';
					o_TX <= '0';
					if (clockTicksCounter < clkPerBit - 1) then
						clockTicksCounter <= clockTicksCounter + 1;
						currentState <= StartBit;
					else
						clockTicksCounter <= 0;
						currentState <= SendDataBits;
					end if;

				when SendDataBits =>
					o_TX <= r_Byte(bitIndex);
					if (clockTicksCounter < clkPerBit - 1) then
						clockTicksCounter <= clockTicksCounter + 1;
						currentState <= SendDataBits;
					else
						clockTicksCounter <= 0;
						if (bitIndex < 7) then
							bitIndex <= bitIndex + 1;
							currentState <= SendDataBits;
						else
							bitIndex <= 0;
							currentState <= StopBit;
						end if;
					end if;

				when StopBit =>
					o_TX <= '1';
					if (clockTicksCounter < clkPerBit - 1) then
						clockTicksCounter <= clockTicksCounter + 1;
						currentState <= StopBit;
					else
						
						clockTicksCounter <= 0;
						currentState <= Done;
						
					end if;

				when Done=>
					o_Active <= '0';
					r_Done <= '1';
					currentState <= Idle;

				when others =>
					currentState <= Idle;
			end case;
			
		end if;
		
	end process ; -- SendData
	o_Done <= r_Done;
end Behavioral;

