LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sad IS
	PORT (
		clk : IN STD_LOGIC; -- ck
		enable : IN STD_LOGIC; -- iniciar
		reset : IN STD_LOGIC; -- reset
		sample_ori : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- Mem_A[end] --saida da memoria e 1 byte
		sample_can : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- Mem_B[end]--saida da memoria e 1 byte
		read_mem,pronto : OUT STD_LOGIC; -- read
		saidaDebug : OUT std_logic_vector(7 downto 0);
		address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0); -- end --vai de 0 ate 63
		sad_value : OUT STD_LOGIC_VECTOR (13 DOWNTO 0) -- SAD --Supondo que o abs de cada posicao na matriz seja 255, teremos 255*64 = 16320, necessitando de 14 bits
	);
END ENTITY; -- sad

ARCHITECTURE arch OF sad IS
signal zi,ci,cpa,cpb,zsoma,csoma,csad_reg,menor : std_logic;

component BO IS PORT (
		clk : IN STD_LOGIC; -- ck
		sample_ori : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- Mem_A[end] --saida da memoria e 1 byte
		sample_can : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- Mem_B[end]--saida da memoria e 1 byte
		zi,ci,cpa,cpb,zsoma,csoma,csad_reg : IN std_logic; --Entradas do BC
		address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0); -- end --vai de 0 ate 63
		menor : OUT STD_LOGIC; --Entrada pro BC
		sad_value : OUT STD_LOGIC_VECTOR (13 DOWNTO 0); -- SAD --Supondo que o abs de cada posicao na matriz seja 255, teremos 255*64 = 16320, necessitando de 14 bits
		saidaDebug : OUT std_logic_vector(7 downto 0)
	);
end component;

component BC IS PORT (
		clk : IN STD_LOGIC; -- ck
		menor : IN std_LOGIC; -- MSB do i
		enable : IN STD_LOGIC; -- iniciar
		reset : IN STD_LOGIC; -- reset
		pronto : OUT STD_LOGIC; 
		read_mem : OUT STD_LOGIC; -- read
		zi,ci,cpa,cpb,zsoma,csoma,csad_reg : OUT std_logic --Saidas do BC	
	);
END component; -- BC

BEGIN
BC1: BC port map(clk,menor,enable,reset,pronto,read_mem,zi,ci,cpa,cpb,zsoma,csoma,csad_reg);
BO1: BO port map(clk, sample_ori,sample_can,zi,ci,cpa,cpb,zsoma,csoma,csad_reg,address,menor,sad_value);

END ARCHITECTURE; -- arch