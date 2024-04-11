----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2024 11:46:43 AM
-- Design Name: 
-- Module Name: aes_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
use std.textio.all;
use ieee.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity aes_tb is
    --Port ( );
end aes_tb;
 
architecture Behavioral of aes_tb is
 
component aes is
        port( 
        clk             : in std_logic;     
        rst             : in std_logic;     
        key_i           : in std_logic_vector(127 downto 0);   
        data_i          : in std_logic_vector(127 downto 0);
        data_write_i    : in std_logic;
        data_o          : out std_logic_vector(127 downto 0);
        data_ready_o    : out std_logic    
        );
end component;
 
function to_std_logic_vector(a : string) return std_logic_vector is
    variable ret  : std_logic_vector(a'length*4-1 downto 0);
    variable char : character;
    begin
        for i in a'length - 1 downto 0 loop
            char := a(i + 1);
            
            case char is
                when '0' => ret(i*4+3 downto i*4) := x"0";
                when '1' => ret(i*4+3 downto i*4) := x"1";
                when '2' => ret(i*4+3 downto i*4) := x"2";
                when '2' => ret(i*4+3 downto i*4) := x"2";
                when '3' => ret(i*4+3 downto i*4) := x"3";
                when '4' => ret(i*4+3 downto i*4) := x"4";
                when '5' => ret(i*4+3 downto i*4) := x"5";
                when '6' => ret(i*4+3 downto i*4) := x"6";
                when '7' => ret(i*4+3 downto i*4) := x"7";
                when '8' => ret(i*4+3 downto i*4) := x"8";
                when '9' => ret(i*4+3 downto i*4) := x"9";
                when 'a' => ret(i*4+3 downto i*4) := x"A";
                when 'b' => ret(i*4+3 downto i*4) := x"B";
                when 'c' => ret(i*4+3 downto i*4) := x"C";
                when 'd' => ret(i*4+3 downto i*4) := x"D";
                when 'e' => ret(i*4+3 downto i*4) := x"E";
                when 'f' => ret(i*4+3 downto i*4) := x"F";
                when others => ret(i*4+3 downto i*4) := x"0";
            end case;
             
        end loop;
        return ret;
end function to_std_logic_vector;
 
signal clk          :   std_logic   :=  '0';
signal rst          :   std_logic   :=  '0';
signal key_i        :   std_logic_vector (127 downto 0) := (others => '0');
signal data_i       :   std_logic_vector (127 downto 0) := (others => '0');
signal data_write_i :   std_logic   :=  '0';
 
signal data_o       :   std_logic_vector (127 downto 0);
signal data_ready_o :   std_logic;
 
signal data_str         : string(32 downto 1);
signal encrypted_str    : string(32 downto 1);
signal str              : string(66 downto 1);


signal data_check_o     :   std_logic_vector (127 downto 0);

signal data_valid       :   std_logic := '0';
 
constant key : std_logic_vector(127 downto 0) := x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
 
begin
 
    UUT :  aes
        port map( 
        clk             =>  clk,
        rst             =>  rst,
        key_i           =>  key_i,
        data_i          =>  data_i,
        data_write_i    =>  data_write_i,
        data_o          =>  data_o,
        data_ready_o    =>  data_ready_o);
        
    process is
    
    begin
        clk <= not clk;
        wait for 5ns;
    end process; 
        
    process is
    
        file input_file     : text is in "J:\Kody\vhdl\JPHDL_Laby\AES\tajne_koty.txt";
        variable input_line : line;
        variable str_in     : string(66 downto 1);
        variable good_v     : boolean;
        
        variable data_input     : std_logic_vector(127 downto 0);
        variable data_output    : std_logic_vector(127 downto 0);
    
    begin
            
             
        key_i <= key;  
        rst <= '1';
        wait for 100ns;
        rst <= '0';      
        
        while not endfile(input_file) loop
      
            readline(input_file, input_line);
            read(input_line, str_in);        
            str <= str_in;
            
            wait for 10ns;
            
            data_str <= str(66 downto 35);
            encrypted_str <= str(32 downto 1);
            wait for 10ns;
            
            data_i <= to_std_logic_vector(data_str);
            --data_i <= x"3243f6a8885a308d313198a2e0370734";
            data_check_o <= to_std_logic_vector(encrypted_str);
            wait for 10ns;
            
            data_write_i <= '1';
            wait until data_ready_o = '1';       
            
            data_write_i <= '0';
            
            if (data_check_o = data_o) then
                data_valid <= '1';
            else 
                data_valid <= '0';
            end if;
            
            wait for 100ns;
        
        end loop;

       
        wait;
    end process;    
    
 
end Behavioral;