library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity reg8b is port (
    D     : in  std_logic_vector(7 downto 0);
	 reset : in std_logic;
    Enable: in  std_logic;
    CLK   : in  std_logic;
    Q     : out std_logic_vector(7 downto 0));
end reg8b;
        
        --da Saída q, metade é alfa e metade é beta
        --enable é e2
architecture arqdtp of reg8b is
    begin
    process(CLK,reset)
    begin
        if(reset = '1') then
            q <= "00000000";
        elsif(enable = '1') then
            if (CLK'event AND CLK = '1') then
    				q <= d;		
            end if;
        end if;
    end process;
end arqdtp;