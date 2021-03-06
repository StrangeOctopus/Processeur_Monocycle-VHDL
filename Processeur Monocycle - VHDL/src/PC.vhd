library ieee;
use ieee.std_logic_1164.all;

Entity PC is Port(
  CLK, RST  : in std_logic;
  Entree    : in std_logic_vector(31 downto 0);
  Sortie    : out std_logic_vector(31 downto 0));
end entity;

Architecture RTL of PC is
  signal data : std_logic_vector(31 downto 0);
  Begin
    
    Sortie <= data;
    
    process(clk, rst)
      
      begin
        
        if rst = '1' then
          
          data <= (others => '0');
          
        elsif rising_edge(clk) then
            
          data <= Entree;
          
        end if;
        
    end process;
  
end RTL;



