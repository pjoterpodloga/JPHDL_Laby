library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;  
use ieee.std_logic_arith.all;  

--use work.key_gen_pkg.all;
--use work.lib_aes_pkg.all;

entity aes is
  port(
    clk           : in std_logic;
    rst           : in std_logic;
    key_i         : in std_logic_vector(127 downto 0);  -- key must be kept constant for the time of encryption!
    data_i        : in std_logic_vector(127 downto 0);  -- plain input data
    data_write_i  : in std_logic;                       -- strobe indicating start od encryption
    data_o        : out std_logic_vector(127 downto 0); -- encrypted output data
    data_ready_o  : out std_logic                       -- data ready flag
    );
end entity;                           

-- for EDK comment the following line:
use work.lib_aes_pkg.all;
-- and uncomment the following line:
--library fsl_aes_v2_00_a;
--use fsl_aes_v2_00_a.lib_aes_pkg.all;

architecture beh of aes is  
  signal state            : std_logic_vector(127 downto 0);
  signal data_ready       : std_logic;            
  signal calculating_data : std_logic;
  signal round            : integer range 0 to 10;   
  signal data             : std_logic_vector(127 downto 0);  
  signal start_condition  : std_logic;
  signal key_w0           : std_logic_vector(31 downto 0);
  signal key_w1           : std_logic_vector(31 downto 0);
  signal key_w2           : std_logic_vector(31 downto 0);
  signal key_w3           : std_logic_vector(31 downto 0);
  signal round_key        : std_logic_vector(127 downto 0);
  
begin  
  data_ready_o <= data_ready;
  data_o <= state;
  start_condition <= '1' when (data_write_i = '1' and calculating_data = '0') else '0';
      
  ENCRYPTION_PROC: process (clk, rst)
    variable state_v1 : std_logic_vector(127 downto 0);
    variable state_v2 : std_logic_vector(127 downto 0);
    variable state_v3 : std_logic_vector(127 downto 0);
    variable state_v4 : std_logic_vector(127 downto 0);   
  begin            
    if rst='1' then  --asynchronous reset active high
      round <= 0;                                
      data_ready <= '0';       
      calculating_data <= '0'; 
      state <= (others => '0');
    elsif (clk'event and clk='1') then  --clk rising edge
      if start_condition = '1'  then  -- detect start processing and initialize
        round <= 1;
        data_ready <= '0';            
        calculating_data <= '1';  
        data <= data_i;
        state <= data_i xor key_i; -- round=0 starts here
      elsif calculating_data = '1' then -- normal processing
        ------------ SubBytes ---------------
        state_v1 := sub_bytes(state);
        ------------ ShiftRows ---------------        
        state_v2 := shift_rows(state_v1);
        ------------ MixColumns ---------------          
        if (round > 0 and round <= 9) then
          state_v3 := mix_columns(state_v2);
        else
          state_v3 := state_v2;
        end if;
        ------------ AddRoundKey ---------------
        state_v4 := state_v3 xor round_key;
        ----------------------------------------
        -- update state:
        state <= state_v4;
        
        if (round = 10) then
          data_ready <= '1';
          calculating_data <= '0';
          round <= 0;          
        else
          round <= round + 1;  
        end if;        
      end if; 
    end if;
  end process;                 
  
  round_key <= key_w0 & key_w1 & key_w2 & key_w3;
  
  KEY_GENERATION_PROC: process (clk, rst)
    variable key_tmp_v : std_logic_vector(31 downto 0);
    variable key_w4_new_v : std_logic_vector(31 downto 0);
    variable key_w5_new_v : std_logic_vector(31 downto 0);
    variable key_w6_new_v : std_logic_vector(31 downto 0);
    variable key_w7_new_v : std_logic_vector(31 downto 0);
  begin         
    if rst='1' then  --asynchronous reset active high     
      key_w0      <= (others => '0');
      key_w1      <= (others => '0');
      key_w2      <= (others => '0');
      key_w3      <= (others => '0');
    elsif (clk'event and clk='1') then  --clk rising edge    
      --if round = 0 and start_condition = '0' then -- initial round
      -- corrected to prevent from long-lasting strobe data_write_i:
      if (round = 0 and start_condition = '0') or (round = 10) then -- initial round
        key_w0      <= key_i(127 downto 96);                          
        key_w1      <= key_i(95 downto 64);
        key_w2      <= key_i(63 downto 32);
        key_w3      <= key_i(31 downto 0);
      else --round 1..10
        key_tmp_v := sub_word(rot_word(key_w3)) xor (rcon(round+1)&"000000000000000000000000");
        key_w4_new_v := key_tmp_v xor key_w0;
        key_w5_new_v := key_w4_new_v xor key_w1;  
        key_w6_new_v := key_w5_new_v xor key_w2;  
        key_w7_new_v := key_w6_new_v xor key_w3;  
        key_w0 <= key_w4_new_v;
        key_w1 <= key_w5_new_v;
        key_w2 <= key_w6_new_v;
        key_w3 <= key_w7_new_v;     
      end if;                       
    end if;    
  end process;  
end architecture;

--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package aes_pkg is  
  component aes
    port(
      clk : in std_logic;
      rst : in std_logic;
      key_i : in std_logic_vector(127 downto 0);
      data_i : in std_logic_vector(127 downto 0);
      data_write_i : in std_logic;
      data_o : out std_logic_vector(127 downto 0);
      data_ready_o : out std_logic);
  end component;
end package;                                                              
--------------------------------------------------------------------------

