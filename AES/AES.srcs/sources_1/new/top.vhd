----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2024 17:44:51
-- Design Name: 
-- Module Name: top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( 
        clk_i   :   in  std_logic;
        rst_i   :   in  std_logic;
        sw_i    :   in  std_logic_vector(7 downto 0);
        ld_o    :   out std_logic_vector(15 downto 0)
    );
end top;

architecture Behavioral of top is

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

    signal key_i        :   std_logic_vector (127 downto 0) := x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
    signal data_i       :   std_logic_vector (127 downto 0) := (others => '0');
    signal data_write_i :   std_logic   :=  '0';
     
    signal data_o       :   std_logic_vector (127 downto 0);
    signal data_ready_o :   std_logic;

begin

    Crypto :  aes
        port map( 
        clk             =>  clk_i,
        rst             =>  rst_i,
        key_i           =>  key_i,
        data_i          =>  data_i,
        data_write_i    =>  data_write_i,
        data_o          =>  data_o,
        data_ready_o    =>  data_ready_o);


    
    process is
    begin
    
        if (rst_i = '1') then
            ld_o <= (others => '0');
            data_write_i <= '0';
        elsif rising_edge(clk_i) then
            data_write_i <= '1';
            if (data_ready_o = '1') then
                ld_o <= data_o(15 downto 0);
                
                data_i(7 downto 0)      <=  sw_i;
                data_i(127 downto 8)    <=  (others => '0');
            end if;
            
        end if;
    
    end process;

end Behavioral;
