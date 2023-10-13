library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity traffic_light_tb is
--  Port ( );
end traffic_light_tb;

architecture Behavioral of traffic_light_tb is
    
    component traffic_light is 
        port(  clk: in std_logic;
                reset: in std_logic;
                rc: out std_logic ;
                yc: out std_logic ;
                gc: out std_logic ;
                rp: out std_logic ;
                gp: out std_logic;
                cd_time: out integer range 0 to 10
        );  
        end component;
        
        constant C_CLK_PERIOD: time := 125 ms;
                
        signal clk : std_logic := '1';
        signal reset: std_logic ;
        signal rc: std_logic ;
        signal yc: std_logic ;
        signal gc: std_logic ;
        signal rp: std_logic ;
        signal gp: std_logic ;
        signal cd_time: integer range 0 to 10;
       

begin
    DUT: traffic_light 
        port map(
            clk => clk,
            reset => reset,
            rc => rc,
            yc => yc,
            gc => gc,
            rp => rp,
            gp => gp,
            cd_time => cd_time         
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

end Behavioral;