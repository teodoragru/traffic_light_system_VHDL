library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity traffic_light is
    port(   clk: in std_logic;
            reset: in std_logic;
            rc: out std_logic ;
            yc: out std_logic ;
            gc: out std_logic ;
            rp: out std_logic ;
            gp: out std_logic;
            cd_time: out integer range 0 to 10
    );
end traffic_light;

architecture Behavioral of traffic_light is

    constant C_SECOND : integer := 8;
   
    type state_type is (redRed1, redGreen, redRed2, redYellowRed, greenRed, yellowRed);
    signal state_reg, next_state : state_type;
    signal counter: integer range 22*C_SECOND-1 downto 0;
    
    
begin


STATE_TRANSITION: process (clk) is
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= redRed1;
            else
                state_reg <= next_state;
            end if;        
        end if;
    end process STATE_TRANSITION;

NEXT_STATE_LOGIC: process (state_reg, counter) is
    begin
        case state_reg is
            when redRed1 => 
                if counter > (20*C_SECOND) then
                    next_state <= redRed1;
                else
                    next_state <= redGreen;
                end if;
            when redGreen =>
                if counter > (13*C_SECOND) then 
                    next_state <= redGreen;
                else
                    next_state <= redRed2;
                end if;
            when redRed2 =>
                if counter > (11*C_SECOND) then 
                    next_state <= redRed2;
                else
                    next_state <= redYellowRed;
                end if;   
             when redYellowRed =>
                if counter > (10*C_SECOND) then 
                    next_state <= redYellowRed;
                else
                    next_state <= greenRed;
                end if;    
             when greenRed =>
                if counter >  (C_SECOND) then 
                    next_state <= greenRed;
                else
                    next_state <= yellowRed;
                end if;
             when yellowRed =>
                if counter > 0 then 
                    next_state <= yellowRed;
                else
                    next_state <= redRed1;
                end if;                
        end case;
    end process NEXT_STATE_LOGIC;
    
    CNT_PROC: process (clk) is
    begin
        if rising_edge(clk) then
            if counter = 0 or reset = '1' then
                counter <= 22*C_SECOND-1;
            else
                counter <= counter - 1;
            end if;
        end if;
    end process CNT_PROC;

    OUTPUT_LOGIC: process(state_reg, clk) is 
    begin
    if rising_edge(clk) then
            if reset = '1' then
                rc <= '0';
                yc <= '0';
                gc <= '0';
                rp <= '0';
                gp <= '0';
                cd_time <= 10;
            else
                case state_reg is 
                    when redRed1 =>
                        rc <= '1';
                        yc <= '0';
                        gc <= '0';
                        rp <= '1';
                        gp <= '0';
                        cd_time <= 10;
                    when redGreen =>
                        rc <= '1';
                        yc <= '0';
                        gc <= '0';
                        rp <= '0';
                        gp <= '1';
                        cd_time <= 10;

                    when redRed2 => 
                        rc <= '1';
                        yc <= '0';
                        gc <= '0';
                        rp <= '1';
                        gp <= '0'; 
                        cd_time <= 10;
                    when redYellowRed => 
                        rc <= '1';
                        yc <= '1';
                        gc <= '0';
                        rp <= '1';
                        gp <= '0'; 
                        cd_time <= 10;
                    when greenRed => 
                        rc <= '0';
                        yc <= '0';
                        gc <= '1';
                        rp <= '1';
                        gp <= '0';
                        cd_time <= (counter + 1)/C_SECOND;
                    when yellowRed => 
                        rc <= '0';
                        yc <= '1';
                        gc <= '0';
                        rp <= '1';
                        gp <= '0';
                        cd_time <= 10;
                    when others =>
                        rc <= '0';
                        yc <= '0';
                        gc <= '0';
                        rp <= '0';
                        gp <= '0';
                        cd_time <= 10;                      
                    end case;
            end if; 
    end if;
    end process OUTPUT_LOGIC;
       
end Behavioral;