-------------------------------------------------------------------------------
-- 
-- Company      : HESSO - hepia - ITI
--
-- Project Name : Travail de bachelor 
--
-- Author       : Sebastien Chassot (sebastien.chassot@etu.hesge.ch)
--
-- Create Date  : 17 may 2017
--
-- Explication  : This module detect a LoRa packet in a stream of data from an
--                ADC and timestamp it.
--
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity lora_detect is

--    generic (
--        NB_OF_SAMPLES : 64);            -- sample

    port (
        -- TODO choose one clock
        radio_clk : in std_logic;       -- radio clock 
        bus_clk   : in std_logic;       -- bus clock
        rst       : in std_logic;       -- reset SR registers
        strobe    : in std_logic;

        rx_i      : in std_logic_vector(15 downto 0);  -- rx I signal
        rx_q      : in std_logic_vector(15 downto 0);  -- rx Q signal
        vita_time : in std_logic_vector(63 downto 0);  -- vita time

        addr : in std_logic_vector(7 downto 0);   -- setting reg
        data : in std_logic_vector(31 downto 0);  -- data

        lora_trigger_out : out std_logic);  -- detected packet's trigger

end entity lora_detect;

architecture lora_detect_behav of lora_detect is

    component setting_reg_vhdl_wrapper is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            strobe   : in  std_logic;
            addr     : in  std_logic_vector(7 downto 0);
            data_in  : in  std_logic_vector(31 downto 0);
            data_out : out std_logic_vector(31 downto 0));
    end component setting_reg_vhdl_wrapper;

    component complex_module is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            real_i   : in  std_logic_vector(15 downto 0);
            comp_i   : in  std_logic_vector(15 downto 0);
            result_o : out std_logic_vector(31 downto 0));
    end component complex_module;

    signal sr_0_dat_int   : std_logic_vector(31 downto 0) := (others => '0');
    signal result_mod_int : std_logic_vector(31 downto 0) := (others => '0');

begin  -- architecture lora_detect_behav

    sr_lora_0 : setting_reg_vhdl_wrapper port map (
        clk      => bus_clk,
        rst      => rst,
        strobe   => strobe,
        addr     => addr,
        data_in  => data,
        data_out => sr_0_dat_int);

    comp_m_1 : complex_module port map (
        clk      => bus_clk,
        rst      => rst,
        real_i   => rx_i,
        comp_i   => rx_q,
        result_o => result_mod_int);  -- truncated result (32 bits is enought)

    lora_trigger_out <= '1' when result_mod_int > sr_0_dat_int else '0';


end architecture lora_detect_behav;
