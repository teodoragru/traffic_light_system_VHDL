library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;s
--use UNISIM.VComponents.all;

entity traffic_light_system_tb is
--  Port ( );
end traffic_light_system_tb;

architecture Behavioral of traffic_light_system_tb is

    component traffic_light_system
    port
    (
        clk : in std_logic;
  		reset : in std_logic;
  		rc,gc,yc,gp,rp : out std_logic;
		display : out std_logic_vector(6 downto 0)
    
    );
    end component;
    
    signal clk : std_logic := '1';
    signal reset: std_logic := '0';
    signal rc: std_logic := '0';
    signal yc: std_logic := '0';
    signal gc: std_logic := '0';
    signal rp: std_logic := '0';
    signal gp: std_logic := '0';
    signal display : std_logic_vector (6 downto 0) := "0000000";
    
    constant C_CLK_PERIOD: time := 125 ms;
     
begin 
    DUT: traffic_light_system 
        port map(
            clk => clk,
            reset => reset,
            rc => rc,
            yc => yc,
            gc => gc,
            rp => rp,
            display => display,
            gp => gp
        );
        
        clk <= not clk after C_CLK_PERIOD/2;
        
        STIMULUS: process is
        begin
        reset <= '1';
        wait for C_CLK_PERIOD*2;
        reset <= '0';
        wait for C_CLK_PERIOD*200;
        reset <= '1';
        wait for C_CLK_PERIOD*2;
        reset <= '0';
        wait for C_CLK_PERIOD*50;
        wait;
        
        end process STIMULUS ;

        

end Behavioral;s