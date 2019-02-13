library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_memory is Port(
  CLK, RST  : in std_logic;
  Addr      : in std_logic_vector(31 downto 0);
  Instruction   : out std_logic_vector(31 downto 0));
end entity;

Architecture RTL of Instruction_memory is
  
  type table is array (63 downto 0) of std_logic_vector(31 downto 0);
  
  -- Fonction d'initialisation 
  function init_banc return table is
  
  variable result : table;
  
  begin
    
    for i in 63 downto 0 loop 
      result(i) := (others =>'0');
    end loop;
    return result;
    
    end init_banc;
    
    -- Declaration et initialisation du Banc de registre 
  signal Banc : table := init_banc;
  
  
  
  Begin
    
    Instruction <= Banc(to_integer(unsigned(Addr)));
    
    process(clk, rst)
      begin
        
        if RST = '1' then
          for i in 63 downto 0 loop 
            Banc(i) <= (others =>'0');
          end loop;
          
        elsif rising_edge(clk) then
          Banc(to_integer(unsigned(Addr))) <= DataIn;-- � modifier
        end if;
        
    end process;
    
    
    
    
end RTL;
