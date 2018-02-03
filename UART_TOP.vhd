----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kamil Pituła
-- 
-- Create Date:    13:12:46 01/02/2018 
-- Design Name: 
-- Module Name:    UART_TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: test
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

entity Generator_TOP is
	GENERIC(
			top_numberOfOscillators : integer;
			top_negationsMultiplier : integer
		);
    Port ( clk : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           led_control : out STD_LOGIC_VECTOR (7 downto 0);
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           buttons : in STD_LOGIC_VECTOR (4 downto 0);
           uart_tx : out  STD_LOGIC;
           uart_rx : in  STD_LOGIC;
           data_out : out  STD_LOGIC);
end Generator_TOP;

architecture Behavioral of Generator_TOP is
  --rs232 transmitter
	signal tx_data : STD_LOGIC_VECTOR (7 downto 0);
	signal tx_start : STD_LOGIC:='0';
	signal tx_active : STD_LOGIC;
	signal tx_done : STD_LOGIC;
  --clk divider output
  signal clk_2 : STD_LOGIC;
  signal clk_3 : STD_LOGIC;
  --lfsr
  constant seed_vector : std_logic_vector(7 downto 0) := x"B5";

  signal lfsr_clk :STD_LOGIC := '0';
  signal out_LFSR_data :STD_LOGIC_VECTOR (7 downto 0);
  signal in_register_enable :STD_LOGIC := '1';
  signal in_seed_vector : std_logic_vector(7 downto 0) := seed_vector;
  signal in_seed_enable : std_logic := '1';
  signal out_oscillator_driven_LFSR_DATA : STD_LOGIC_VECTOR(7 downto 0);

  --oscillator
  signal random_bitstream : std_logic;

  --common
  signal xored_registers_data : STD_LOGIC_VECTOR(7 downto 0);

--components

	COMPONENT RS232_Transmitter
    GENERIC(
    baud    :positive;
    frequency :positive
    );
    PORT(
         i_Clk : IN  std_logic;
         i_StartTransmission : IN  std_logic;
         i_Byte : IN  std_logic_vector(7 downto 0);
         o_Active : OUT  std_logic;
         o_TX : OUT  std_logic;
         o_Done : OUT  std_logic
        );
    END COMPONENT;

   COMPONENT clock_divider
    GENERIC(divider : integer);
    PORT(
         clk_in : IN  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;

    COMPONENT LFSR
    GENERIC (register_width : integer range 3 to 32);
    PORT(
         in_clk : IN  std_logic;
         in_register_enable : IN  std_logic;
         in_seed_vector : IN  std_logic_vector(7 downto 0);
         in_seed_enable : IN  std_logic;
         out_LFSR_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

    COMPONENT random_bitstream_gen
    GENERIC (
    		numberOfOscillators : integer;
			negationsMultiplier : integer
			);
    PORT (out_bitstream : out  STD_LOGIC;
    	  in_clk :in STD_LOGIC
    	 );
    END COMPONENT;

--components end

begin

--port mapping
rs_tran: RS232_Transmitter 
          GENERIC MAP (baud => 9600,
                       frequency => 100000000)
          PORT MAP (
                  i_Clk => clk,
                  i_StartTransmission => tx_start,
                  i_Byte => tx_data,
                  o_Active => tx_Active,
                  o_TX => uart_tx,
                  o_Done => tx_Done
                );

clk_div: clock_divider 
          GENERIC MAP (divider => 10000)
          PORT MAP (
            clk_in => clk,
            clk_out => clk_2
          );

clk_div2: clock_divider 
          GENERIC MAP (divider => 10000000)
          PORT MAP (
            clk_in => clk,
            clk_out => clk_3
          );

random_bits_generator: LFSR
          GENERIC MAP (register_width => 8)
          PORT MAP (
            in_clk => tx_Done,
            in_register_enable => in_register_enable,
            in_seed_vector => in_seed_vector,
            in_seed_enable => in_seed_enable,
            out_LFSR_data => out_LFSR_data
        );

circle_osccilators_driven_lfsr: LFSR
          GENERIC MAP (register_width => 8)
          PORT MAP (
            in_clk => random_bitstream,
            in_register_enable => in_register_enable,
            in_seed_vector => in_seed_vector,
            in_seed_enable => in_seed_enable,
            out_LFSR_data => out_oscillator_driven_LFSR_DATA
        );

circle_osccilators: random_bitstream_gen
		  GENERIC MAP (
		  	numberOfOscillators => top_numberOfOscillators,
		  	negationsMultiplier => top_negationsMultiplier
		  	)
		  PORT MAP(out_bitstream=>random_bitstream,
		  		   in_clk=>tx_Done); 

--port mapping end

process( clk,clk_2,tx_Active,tx_data )
begin
 
	if(clk_2='1') then
		if (tx_Active = '0') then
			
			
			--data from generator here
			tx_start <= '1';
		else
			tx_start<='0';
		end if;
  else
    tx_start<='0';
	end if;

end process ; 
      
xored_registers_data <= out_LFSR_data(7 downto 1) & (out_LFSR_data(0) xor out_oscillator_driven_LFSR_DATA(0)) ; --delete this for single prng-lfsr
--tx_data <= out_LFSR_data; --tested and good working
tx_data <= xored_registers_data; --untested and random
--tx_data <= out_oscillator_driven_LFSR_DATA; 
in_seed_enable <= switches(0);

end Behavioral;
