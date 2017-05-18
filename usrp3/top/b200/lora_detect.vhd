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
        radio_clk        : in  std_logic;   -- radio clock
        bus_clk          : in  std_logic;   -- bus clock
        rx_i             : in  std_logic_vector(11 downto 0);  -- rx I signal
        rx_q             : in  std_logic_vector(11 downto 0);  -- rx Q signal
        vita_time        : in  std_logic_vector(63 downto 0);  -- vita time
        lora_trigger_out : out std_logic);  -- detected packet's trigger

end entity lora_detect;

architecture lora_detect_behav of lora_detect is

begin  -- architecture lora_detect_behav

    lora_trigger_out <= '0';

end architecture lora_detect_behav;
