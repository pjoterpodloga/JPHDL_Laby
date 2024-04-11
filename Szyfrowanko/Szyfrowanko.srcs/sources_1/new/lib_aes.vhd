library ieee;
use ieee.std_logic_1164.all;

package lib_aes_pkg is         
  function xtime (xtime_i : std_logic_vector(7 downto 0)) return std_logic_vector;
  function sub_byte(sbox_i : std_logic_vector(7 downto 0)) return std_logic_vector;      

  function sub_bytes(state_i : std_logic_vector(127 downto 0)) return std_logic_vector;  
  function shift_rows(state_i : std_logic_vector(127 downto 0)) return std_logic_vector;
  function mix_columns (state_i : std_logic_vector(127 downto 0)) return std_logic_vector;
 
  -- key generation:
  function rcon (rcon_i : integer range 0 to 15) return std_logic_vector;  
  function rot_word(signal word_i : std_logic_vector(31 downto 0)) return std_logic_vector;
  function sub_word(sbox_i : std_logic_vector(31 downto 0)) return std_logic_vector;          
  
  -- aes.vhd, old version:
  type t_COL is array (0 to 3) of std_logic_vector(7 downto 0 );
  type t_ROW is array (0 to 3) of std_logic_vector(7 downto 0 );
  function sub_column(sbox_i : t_COL) return t_COL;
  function mix_one_column (col_i : t_COL) return t_COL;
  function shift_one_row_1(row_i : t_ROW) return t_ROW;
  function shift_one_row_2(row_i : t_ROW) return t_ROW;
  function shift_one_row_3(row_i : t_ROW) return t_ROW;
  
end package;                               

-- state* matrix:
--  ---------------------------------------
-- |         |         |         |         |
-- | 127:120 |  95:88  |  63:56  |  31:24  | 
-- |         |         |         |         |
--  ---------------------------------------
-- |         |         |         |         |
-- | 119:112 |  87:80  |  55:48  |  23:16  | 
-- |         |         |         |         |
--  ---------------------------------------
-- |         |         |         |         |
-- | 111:104 |  79:72  |  47:40  |  15:8   | 
-- |         |         |         |         |
--  ---------------------------------------
-- |         |         |         |         |
-- | 103:96  |  71:64  |  39:32  |   7:0   | 
-- |         |         |         |         |
--  ---------------------------------------

package body lib_aes_pkg is
  ------------------------------------------------------------------------------------------
  function xtime (xtime_i : std_logic_vector(7 downto 0)) return std_logic_vector is
    variable xtime_v : std_logic_vector(7 downto 0);
  begin
    xtime_v := (xtime_i(6 downto 0) & '0');
    if xtime_i(7) = '1' then
      xtime_v := xtime_v xor "00011011";
    end if;   
    return xtime_v;
  end function;                                                                             
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function sub_byte(sbox_i : std_logic_vector(7 downto 0)) return std_logic_vector is
  begin                                          
    case sbox_i is
      when "00000000" => return X"63";
      when "00000001" => return X"7C";
      when "00000010" => return X"77";
      when "00000011" => return X"7B";
      when "00000100" => return X"F2";
      when "00000101" => return X"6B";
      when "00000110" => return X"6F";
      when "00000111" => return X"C5";
      when "00001000" => return X"30";
      when "00001001" => return X"01";
      when "00001010" => return X"67";
      when "00001011" => return X"2B";
      when "00001100" => return X"FE";
      when "00001101" => return X"D7";
      when "00001110" => return X"AB";
      when "00001111" => return X"76";
      when "00010000" => return X"CA";
      when "00010001" => return X"82";
      when "00010010" => return X"C9";
      when "00010011" => return X"7D";
      when "00010100" => return X"FA";
      when "00010101" => return X"59";
      when "00010110" => return X"47";
      when "00010111" => return X"F0";
      when "00011000" => return X"AD";
      when "00011001" => return X"D4";
      when "00011010" => return X"A2";
      when "00011011" => return X"AF";
      when "00011100" => return X"9C";
      when "00011101" => return X"A4";
      when "00011110" => return X"72";
      when "00011111" => return X"C0";
      when "00100000" => return X"B7";
      when "00100001" => return X"FD";
      when "00100010" => return X"93";
      when "00100011" => return X"26";
      when "00100100" => return X"36";
      when "00100101" => return X"3F";
      when "00100110" => return X"F7";
      when "00100111" => return X"CC";
      when "00101000" => return X"34";
      when "00101001" => return X"A5";
      when "00101010" => return X"E5";
      when "00101011" => return X"F1";
      when "00101100" => return X"71";
      when "00101101" => return X"D8";
      when "00101110" => return X"31";
      when "00101111" => return X"15";
      when "00110000" => return X"04";
      when "00110001" => return X"C7";
      when "00110010" => return X"23";
      when "00110011" => return X"C3";
      when "00110100" => return X"18";
      when "00110101" => return X"96";
      when "00110110" => return X"05";
      when "00110111" => return X"9A";
      when "00111000" => return X"07";
      when "00111001" => return X"12";
      when "00111010" => return X"80";
      when "00111011" => return X"E2";
      when "00111100" => return X"EB";
      when "00111101" => return X"27";
      when "00111110" => return X"B2";
      when "00111111" => return X"75";
      when "01000000" => return X"09";
      when "01000001" => return X"83";
      when "01000010" => return X"2C";
      when "01000011" => return X"1A";
      when "01000100" => return X"1B";
      when "01000101" => return X"6E";
      when "01000110" => return X"5A";
      when "01000111" => return X"A0";
      when "01001000" => return X"52";
      when "01001001" => return X"3B";
      when "01001010" => return X"D6";
      when "01001011" => return X"B3";
      when "01001100" => return X"29";
      when "01001101" => return X"E3";
      when "01001110" => return X"2F";
      when "01001111" => return X"84";
      when "01010000" => return X"53";
      when "01010001" => return X"D1";
      when "01010010" => return X"00";
      when "01010011" => return X"ED";
      when "01010100" => return X"20";
      when "01010101" => return X"FC";
      when "01010110" => return X"B1";
      when "01010111" => return X"5B";
      when "01011000" => return X"6A";
      when "01011001" => return X"CB";
      when "01011010" => return X"BE";
      when "01011011" => return X"39";
      when "01011100" => return X"4A";
      when "01011101" => return X"4C";
      when "01011110" => return X"58";
      when "01011111" => return X"CF";
      when "01100000" => return X"D0";
      when "01100001" => return X"EF";
      when "01100010" => return X"AA";
      when "01100011" => return X"FB";
      when "01100100" => return X"43";
      when "01100101" => return X"4D";
      when "01100110" => return X"33";
      when "01100111" => return X"85";
      when "01101000" => return X"45";
      when "01101001" => return X"F9";
      when "01101010" => return X"02";
      when "01101011" => return X"7F";
      when "01101100" => return X"50";
      when "01101101" => return X"3C";
      when "01101110" => return X"9F";
      when "01101111" => return X"A8";
      when "01110000" => return X"51";
      when "01110001" => return X"A3";
      when "01110010" => return X"40";
      when "01110011" => return X"8F";
      when "01110100" => return X"92";
      when "01110101" => return X"9D";
      when "01110110" => return X"38";
      when "01110111" => return X"F5";
      when "01111000" => return X"BC";
      when "01111001" => return X"B6";
      when "01111010" => return X"DA";
      when "01111011" => return X"21";
      when "01111100" => return X"10";
      when "01111101" => return X"FF";
      when "01111110" => return X"F3";
      when "01111111" => return X"D2";
      when "10000000" => return X"CD";
      when "10000001" => return X"0C";
      when "10000010" => return X"13";
      when "10000011" => return X"EC";
      when "10000100" => return X"5F";
      when "10000101" => return X"97";
      when "10000110" => return X"44";
      when "10000111" => return X"17";
      when "10001000" => return X"C4";
      when "10001001" => return X"A7";
      when "10001010" => return X"7E";
      when "10001011" => return X"3D";
      when "10001100" => return X"64";
      when "10001101" => return X"5D";
      when "10001110" => return X"19";
      when "10001111" => return X"73";
      when "10010000" => return X"60";
      when "10010001" => return X"81";
      when "10010010" => return X"4F";
      when "10010011" => return X"DC";
      when "10010100" => return X"22";
      when "10010101" => return X"2A";
      when "10010110" => return X"90";
      when "10010111" => return X"88";
      when "10011000" => return X"46";
      when "10011001" => return X"EE";
      when "10011010" => return X"B8";
      when "10011011" => return X"14";
      when "10011100" => return X"DE";
      when "10011101" => return X"5E";
      when "10011110" => return X"0B";
      when "10011111" => return X"DB";
      when "10100000" => return X"E0";
      when "10100001" => return X"32";
      when "10100010" => return X"3A";
      when "10100011" => return X"0A";
      when "10100100" => return X"49";
      when "10100101" => return X"06";
      when "10100110" => return X"24";
      when "10100111" => return X"5C";
      when "10101000" => return X"C2";
      when "10101001" => return X"D3";
      when "10101010" => return X"AC";
      when "10101011" => return X"62";
      when "10101100" => return X"91";
      when "10101101" => return X"95";
      when "10101110" => return X"E4";
      when "10101111" => return X"79";
      when "10110000" => return X"E7";
      when "10110001" => return X"C8";
      when "10110010" => return X"37";
      when "10110011" => return X"6D";
      when "10110100" => return X"8D";
      when "10110101" => return X"D5";
      when "10110110" => return X"4E";
      when "10110111" => return X"A9";
      when "10111000" => return X"6C";
      when "10111001" => return X"56";
      when "10111010" => return X"F4";
      when "10111011" => return X"EA";
      when "10111100" => return X"65";
      when "10111101" => return X"7A";
      when "10111110" => return X"AE";
      when "10111111" => return X"08";
      when "11000000" => return X"BA";
      when "11000001" => return X"78";
      when "11000010" => return X"25";
      when "11000011" => return X"2E";
      when "11000100" => return X"1C";
      when "11000101" => return X"A6";
      when "11000110" => return X"B4";
      when "11000111" => return X"C6";
      when "11001000" => return X"E8";
      when "11001001" => return X"DD";
      when "11001010" => return X"74";
      when "11001011" => return X"1F";
      when "11001100" => return X"4B";
      when "11001101" => return X"BD";
      when "11001110" => return X"8B";
      when "11001111" => return X"8A";
      when "11010000" => return X"70";
      when "11010001" => return X"3E";
      when "11010010" => return X"B5";
      when "11010011" => return X"66";
      when "11010100" => return X"48";
      when "11010101" => return X"03";
      when "11010110" => return X"F6";
      when "11010111" => return X"0E";
      when "11011000" => return X"61";
      when "11011001" => return X"35";
      when "11011010" => return X"57";
      when "11011011" => return X"B9";
      when "11011100" => return X"86";
      when "11011101" => return X"C1";
      when "11011110" => return X"1D";
      when "11011111" => return X"9E";
      when "11100000" => return X"E1";
      when "11100001" => return X"F8";
      when "11100010" => return X"98";
      when "11100011" => return X"11";
      when "11100100" => return X"69";
      when "11100101" => return X"D9";
      when "11100110" => return X"8E";
      when "11100111" => return X"94";
      when "11101000" => return X"9B";
      when "11101001" => return X"1E";
      when "11101010" => return X"87";
      when "11101011" => return X"E9";
      when "11101100" => return X"CE";
      when "11101101" => return X"55";
      when "11101110" => return X"28";
      when "11101111" => return X"DF";
      when "11110000" => return X"8C";
      when "11110001" => return X"A1";
      when "11110010" => return X"89";
      when "11110011" => return X"0D";
      when "11110100" => return X"BF";
      when "11110101" => return X"E6";
      when "11110110" => return X"42";
      when "11110111" => return X"68";
      when "11111000" => return X"41";
      when "11111001" => return X"99";
      when "11111010" => return X"2D";
      when "11111011" => return X"0F";
      when "11111100" => return X"B0";
      when "11111101" => return X"54";
      when "11111110" => return X"BB";
      when "11111111" => return X"16";
      when others     => return "XXXXXXXX";  
    end case;
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function sub_bytes(state_i : std_logic_vector(127 downto 0)) return std_logic_vector is
    variable state_v :std_logic_vector(127 downto 0);
  begin                                          
    L0: for i in 0 to 15 loop
      state_v(8*i+7 downto 8*i) := sub_byte(state_i(8*i+7 downto 8*i));   
    end loop;
    return state_v;
  end function;  
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function shift_rows(state_i : std_logic_vector(127 downto 0)) return std_logic_vector is
    variable state_v : std_logic_vector(127 downto 0);
  begin
    -- row 0:
    state_v(127 downto 120):= state_i(127 downto 120);
    state_v(95 downto 88)  := state_i(95 downto 88);
    state_v(63 downto 56)  := state_i(63 downto 56);
    state_v(31 downto 24)  := state_i(31 downto 24);
    -- row 1:
    state_v(119 downto 112):= state_i(87 downto 80);
    state_v(87 downto 80)  := state_i(55 downto 48);
    state_v(55 downto 48)  := state_i(23 downto 16);
    state_v(23 downto 16)  := state_i(119 downto 112);
    -- row 2:
    state_v(111 downto 104):= state_i(47 downto 40);
    state_v(79 downto 72)  := state_i(15 downto 8);
    state_v(47 downto 40)  := state_i(111 downto 104);
    state_v(15 downto 8)   := state_i(79 downto 72);
    -- row 3:
    state_v(103 downto 96) := state_i(7 downto 0);
    state_v(71 downto 64)  := state_i(103 downto 96);
    state_v(39 downto 32)  := state_i(71 downto 64);
    state_v(7 downto 0)    := state_i(39 downto 32);                               
    
    return state_v;    
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function mix_columns (state_i : std_logic_vector(127 downto 0)) return std_logic_vector is
    variable state_v : std_logic_vector(127 downto 0);
  begin
    MIX_COLUMN_L0OP: for i in 0 to 3 loop
      -- row 0 of columns:
      state_v(32*i + 31 downto 32*i + 24) := 
      xtime(state_i(32*i + 31 downto 32*i + 24)) 
      xor xtime(state_i(32*i + 23 downto 32*i + 16))
      xor state_i(32*i + 23 downto 32*i + 16) 
      xor state_i(32*i + 15 downto 32*i + 8) 
      xor state_i(32*i + 7 downto 32*i + 0);
      -- row 1 of columns:          
      state_v(32*i + 23 downto 32*i + 16) := 
      state_i(32*i + 31 downto 32*i + 24)
      xor xtime(state_i(32*i + 23 downto 32*i + 16))
      xor xtime(state_i(32*i + 15 downto 32*i + 8))
      xor state_i(32*i + 15 downto 32*i + 8)
      xor state_i(32*i + 7 downto 32*i + 0);
      -- row 2 of columns:               
      state_v(32*i + 15 downto 32*i + 8) :=
      state_i(32*i + 31 downto 32*i + 24)
      xor state_i(32*i + 23 downto 32*i + 16)
      xor xtime(state_i(32*i + 15 downto 32*i + 8))
      xor xtime(state_i(32*i + 7 downto 32*i + 0))
      xor state_i(32*i + 7 downto 32*i + 0);
      -- row 3 of columns:    
      state_v(32*i + 7 downto 32*i + 0) := 
      xtime(state_i(32*i + 31 downto 32*i + 24))
      xor state_i(32*i + 31 downto 32*i + 24)
      xor state_i(32*i + 23 downto 32*i + 16)
      xor state_i(32*i + 15 downto 32*i + 8)
      xor xtime(state_i(32*i + 7 downto 32*i + 0));
    end loop;    
    return state_v;
  end function;
  ------------------------------------------------------------------------------------------    
  ------------------------------------------------------------------------------------------  
  function rcon (rcon_i : integer range 0 to 15) return std_logic_vector is
  begin
    case rcon_i is
      when 1 =>      return "00000001";
      when 2 =>      return "00000010";
      when 3 =>      return "00000100";
      when 4 =>      return "00001000";
      when 5 =>      return "00010000";
      when 6 =>      return "00100000";
      when 7 =>      return "01000000";
      when 8 =>      return "10000000";
      when 9 =>      return "00011011";
      when 10 =>     return "00110110";
      when others => return "00000000";
    end case;  
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function rot_word(signal word_i : std_logic_vector(31 downto 0)) return std_logic_vector is
  begin            
    return word_i(23 downto 16) & word_i(15 downto 8) & word_i(7 downto 0) & word_i(31 downto 24);
  end function;  
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function sub_word(sbox_i : std_logic_vector(31 downto 0)) return std_logic_vector is
  begin
    return sub_byte(sbox_i(31 downto 24)) & sub_byte(sbox_i(23 downto 16))
    & sub_byte(sbox_i(15 downto 8)) & sub_byte(sbox_i(7 downto 0));
  end function;  
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function sub_column(sbox_i : t_COL) return t_COL is
    variable sbox_v :t_COL;
  begin                                          
    sbox_v(0) := sub_byte(sbox_i(0));
    sbox_v(1) := sub_byte(sbox_i(1));
    sbox_v(2) := sub_byte(sbox_i(2));
    sbox_v(3) := sub_byte(sbox_i(3));
    return sbox_v;
  end function;  
  ------------------------------------------------------------------------------------------    
  ------------------------------------------------------------------------------------------  
  function mix_one_column (col_i : t_COL) return t_COL is
    variable col_v : t_COL;
  begin
    col_v(0) := xtime(col_i(0)) xor xtime(col_i(1)) xor col_i(1) xor col_i(2) xor col_i(3);
    col_v(1) := col_i(0) xor xtime(col_i(1)) xor xtime(col_i(2)) xor col_i(2) xor col_i(3);
    col_v(2) := col_i(0) xor col_i(1) xor xtime(col_i(2)) xor xtime(col_i(3)) xor col_i(3);
    col_v(3) := xtime(col_i(0)) xor col_i(0) xor col_i(1) xor col_i(2) xor xtime(col_i(3));
    return col_v;
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function shift_one_row_1(row_i : t_ROW) return t_ROW is
    variable row_v : t_ROW;
  begin                                          
    row_v(0) := row_i(1);
    row_v(1) := row_i(2);
    row_v(2) := row_i(3);
    row_v(3) := row_i(0);
    return row_v;
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function shift_one_row_2(row_i : t_ROW) return t_ROW is
    variable row_v : t_ROW;
  begin                                          
    row_v(0) := row_i(2);
    row_v(1) := row_i(3);
    row_v(2) := row_i(0);
    row_v(3) := row_i(1);
    return row_v;
  end function;
  ------------------------------------------------------------------------------------------  
  ------------------------------------------------------------------------------------------  
  function shift_one_row_3(row_i : t_ROW) return t_ROW is
    variable row_v : t_ROW;
  begin                                          
    row_v(0) := row_i(3);
    row_v(1) := row_i(0);
    row_v(2) := row_i(1);
    row_v(3) := row_i(2);
    return row_v;
  end function;
  ------------------------------------------------------------------------------------------  
end package body;
