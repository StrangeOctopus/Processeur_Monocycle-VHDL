library ieee;
use ieee.std_logic_1164.all;

Entity unite_de_gestion is Port(
  CLK, RST    : in std_logic;
  offset      : in std_logic_vector(23 downto 0);
  nPCsel      : in std_logic;
  instruction : out std_logic_vector(31 downto 0));
end entity;

Architecture RTL of unite_de_gestion is
  
  signal extOut, updatedPC, PCout : std_logic_vector(31 downto 0);
   
  Begin
    
    C0 : entity work.PC_EXTENDER(RTL) port map(E => offset, S => extOut);
    C1 : entity work.majCPT(RTL) port map(nPCsel => nPCsel, majPCin => PCout, SignExt => extOut, majPCout => updatedPC);
    C3 : entity work.PC(RTL) port map(CLK => CLK, RST => RST, Entree => updatedPC, Sortie => PCout);
    C4 : entity work.instruction_memory(RTL) port map(PC => PCout, Instruction => instruction);
    
end RTL;
  