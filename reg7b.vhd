library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity reg7b is port (
    D     : in  std_logic_vector(6 downto 0);
    Reset : in  std_Logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(6 downto 0));
end reg7b;
        
        --da Saída q, metade é alfa e metade é beta
        --enable é e2
architecture arqdtp of reg7b is
    begin
    process(CLK,reset)
    begin
        if(reset = '1') then
            q <= "0000000";
        elsif(enable = '1') then
            if (CLK'event AND CLK = '1') then
    				q <= d;		
            end if;
        end if;
    end process;
end arqdtp;