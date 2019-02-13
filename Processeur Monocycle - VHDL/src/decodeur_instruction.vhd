library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity decodeur_instruction is Port(
  instruction, flag: in std_logic_vector(31 downto 0);
  nPCsel, PSREn, RegWr, RegSel, ALUsrc, WrSrc, MemWr  : out std_logic;
  Rn, Rm, Rd : out std_logic_vector(3 downto 0);
  ALUCtr : out std_logic_vector(1 downto 0));
end entity;

Architecture RTL of decodeur_instruction is
  
  Begin
    
    process(instruction)
      begin
        
        if instruction(27 downto 26) = "00" then -- (ADD, MOV, CMP)
          
          if instruction(24 downto 21) = "0100" then -- ADD
            
            if instruction(25) = '1' then    -- ADD (Immediate)
            
              Rn <= instruction(19 downto 16);
              Rd <= instruction(15 downto 12);
              nPCSel <= '0';
              RegWr <= '1';
              ALUSrc <= '1';
              ALUCtr <= "00";
              PSREn <= '0';
              MemWr <= '0';
              WrSrc <= '0';
              RegSel <= '0';
              
            elsif instruction(25) = '0' then  -- ADD (register)
              
              Rn <= instruction(19 downto 16);
              Rd <= instruction(15 downto 12);
              Rm <= instruction(3 downto 0);
              nPCSel <= '0';
              RegWr <= '1';
              ALUSrc <= '0';
              ALUCtr <= "00";
              PSREn <= '0';
              MemWr <= '0';
              WrSrc <= '0';
              RegSel <= '0';
              
           end if;
           
          elsif instruction(24 downto 21) = "1101" then -- MOV
            
            Rd <= instruction(15 downto 12);
            nPCSel <= '0';
            RegWr <= '1';
            ALUSrc <= '1';
            ALUCtr <= "01";
            PSREn <= '0';
            MemWr <= '0';
            WrSrc <= '0';
            RegSel <= '0';
          
          elsif instruction(24 downto 21) = "1010" then -- CMP
            
            Rn <= instruction(19 downto 16);
            nPCSel <= '0';
            RegWr <= '0';
            ALUSrc <= '1';
            ALUCtr <= "10";
            PSREn <= '1';
            MemWr <= '0';
            WrSrc <= '0';
            RegSel <= '0';
            
          end if;
          
        elsif instruction(27 downto 26) = "01" then -- (LDR, STR)
          
          if instruction(20) = '1' then  -- LDR
            
            Rn <= instruction(19 downto 16);
            Rd <= instruction(15 downto 12);
            nPCSel <= '0';
            RegWr <= '1';
            ALUSrc <= '1';
            ALUCtr <= "00";
            PSREn <= '0';
            MemWr <= '0';
            WrSrc <= '1';
            RegSel <= '0';
            
          elsif instruction(20) = '0' then -- STR
            
            Rn <= instruction(19 downto 16);
            Rd <= instruction(15 downto 12);
            nPCSel <= '0';
            RegWr <= '0';
            ALUSrc <= '1';
            ALUCtr <= "00";
            PSREn <= '0';
            MemWr <= '1';
            RegSel <= '1';
            
          end if;
            
        elsif instruction(27 downto 26) = "10" then -- (BAL, BLT)
          
          if instruction(31 downto 28) = "1110" then  -- BAL
            
            nPCSel <= '1';
            RegWr <= '0';
            PSREn <= '0';
            MemWr <= '0';
            WrSrc <= '0';
            RegSel <= '0';
            
          elsif instruction(31 downto 28) = "1011" then  -- BLT
            
            if flag = std_logic_vector(to_unsigned(1, 32)) then -- Conditon respectee
              
              nPCSel <= '1';
              RegWr <= '0';
              PSREn <= '0';
              MemWr <= '0';
              RegSel <= '0';
              
            elsif flag = std_logic_vector(to_unsigned(0, 32)) then    -- Condition non respectee
              
             
              nPCSel <= '0';
              RegWr <= '0';
              PSREn <= '0';
              MemWr <= '0';
              RegSel <= '0';
              
            end if;
            
          end if;
          
        end if;
        
      end process;
    
    
end RTL;
  