LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BC IS
	PORT (
		-- ATENÇÃO: modifiquem a largura de bits das entradas e saídas que
		-- estão marcadas com DEFINIR de acordo com o número de bits B e
		-- de acordo com o necessário para cada versão da SAD (tentem utilizar
		-- os valores N e P descritos acima para criar apenas uma descrição
		-- configurável que funcione tanto para a SAD v1 quanto para a SAD v3).
		-- Não modifiquem os nomes das portas, apenas a largura de bits quando
		-- for necessário.
		clk : IN STD_LOGIC; -- ck
		menor : IN std_LOGIC; -- MSB do i
		enable : IN STD_LOGIC; -- iniciar
		reset : IN STD_LOGIC; -- reset
		pronto : OUT STD_LOGIC; 
		read_mem : OUT STD_LOGIC; -- read
		zi,ci,cpa,cpb,zsoma,csoma,csad_reg : OUT std_logic --Saidas do BC	
	);
END ENTITY; -- BC

ARCHITECTURE arch OF BC IS
TYPE Tipo_estado IS (S0, S1, S2, S3, S4, S5);
signal EA, PE : Tipo_estado;

BEGIN
	PROCESS(reset, clk)
	begin
	if reset = '1' then
		EA <= S0;
	elsif (rising_edge(clk)) then
		EA<=PE;
	end if;
	end process;
	
	PROCESS(enable, EA, menor)
	BEGIN
		CASE EA is
			when S0 =>
				pronto <= '1';
				read_mem <= '0';
				zi <= '0';
				ci <= '0';
				cpa <= '0';
				cpb <= '0';
				zsoma <= '0'; 
				csoma <= '0';
				csad_reg <= '0';				
				
				if enable = '0' then
					PE <= S0;
				else 
					PE <= S1;
				end if;					
					
			when s1 =>
				pronto <= '0';
				read_mem <= '0';
				zi <= '1';
				ci <= '1';
				cpa <= '0';
				cpb <= '0';
				zsoma <= '1'; 
				csoma <= '1';
				csad_reg <= '0';				
				
				PE <= S2;
					
			when s2 =>
				pronto <= '0';
				read_mem <= '0';
				zi <= '0';
				ci <= '0';
				cpa <= '0';
				cpb <= '0';
				zsoma <= '0'; 
				csoma <= '0';
				csad_reg <= '0';				
				
			
				if menor = '0' then
					pe <= s3;
				else
					pe <= s5;
				end if;

					
			when s3 =>
				pronto <= '0';
				read_mem <= '1';
				zi <= '0';
				ci <= '0';
				cpa <= '1';
				cpb <= '1';
				zsoma <= '0'; 
				csoma <= '0';
				csad_reg <= '0';		

				PE <= S4;	
				
			when s4 =>
				pronto <= '0';
				read_mem <= '0';
				zi <= '0';
				ci <= '0';
				cpa <= '0';
				cpb <= '0';
				zsoma <= '0'; 
				csoma <= '1';
				csad_reg <= '0';		
	
				
				PE <= s5;

			when s5 =>
				pronto <= '0';
				read_mem <= '0';
				zi <= '0';
				ci <= '0';
				cpa <= '0';
				cpb <= '0';
				zsoma <= '0'; 
				csoma <= '0';
				csad_reg <= '1';	
				
				PE <= S0;
		end case;
	end process;
END ARCHITECTURE; -- arch