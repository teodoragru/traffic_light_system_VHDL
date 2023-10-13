library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light_system is
	port(
		clk : in std_logic;
		reset : in std_logic;
		rc : out std_logic;
		gc : out std_logic;
		yc : out std_logic;
		gp : out std_logic;
		rp : out std_logic;
		display : out std_logic_vector(6 downto 0)
	);
end traffic_light_system ;


architecture rtl of traffic_light_system is

signal digit_int: integer range 0 to 9;
--signal cd_time: integer range 0 to 10;

begin
	TRAFFIC_LIGHT: entity work.traffic_light port map ( reset => reset,
	                                                    clk => clk,
	                                                    rc => rc,
	                                                    yc => yc,
	                                                    gc => gc,
	                                                    rp => rp,
	                                                    gp => gp,
	                                                    cd_time => digit_int);
	BCD_TO_7SEGMENT : entity work.bcd_to_7seg port map  (  display => display,
	                                                       digit => digit_int 
	                                                     );

end architecture rtl; 
