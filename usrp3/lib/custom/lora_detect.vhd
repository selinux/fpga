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
    radio_clk : in std_logic;           -- radio clock 
    bus_clk   : in std_logic;           -- bus clock
    rst       : in std_logic;           -- reset SR registers
    strobe    : in std_logic;

    rx_i      : in std_logic_vector(15 downto 0);  -- rx I signal
    rx_q      : in std_logic_vector(15 downto 0);  -- rx Q signal
    vita_time : in std_logic_vector(63 downto 0);  -- vita time

    addr : in std_logic_vector(7 downto 0);   -- setting reg
    data : in std_logic_vector(31 downto 0);  -- data

    lora_time_measured_o : out std_logic_vector(63 downto 0));  -- detected packet's trigger

end entity lora_detect;

architecture lora_detect_behav of lora_detect is

  component ext_event_trigger is
    port (
      clk           : in  std_logic;
      rst           : in  std_logic;
      trigger_i     : in  std_logic);
  end component ext_event_trigger;

  component setting_reg_vhdl_wrapper is
    port (
      clk      : in  std_logic;
      rst      : in  std_logic;
      strobe   : in  std_logic;
      addr     : in  std_logic_vector(7 downto 0);
      data_in  : in  std_logic_vector(31 downto 0);
      data_out : out std_logic_vector(31 downto 0));
  end component setting_reg_vhdl_wrapper;


  -------------------------------------------------------
  -- signals
  -------------------------------------------------------
  signal sr0_value_int : std_logic := 0;  -- setting register value
  signal result_mod_int : std_logic_vector(31 downto 0) := (others => '0');

  signal detected_int : std_logic := 0;  -- lora_detected
  signal en_measure_int : std_logic := 0;  -- enable measure
  signal trigger_int : std_logic := 0;  -- trigger rising edge

begin  -- architecture lora_detect_behav

  -- setting register 0
  sr_lora_0 : setting_reg_vhdl_wrapper port map (
    clk      => bus_clk,
    rst      => rst,
    strobe   => strobe,
    addr     => addr,
    data_in  => data,
    data_out => sr0_value_int);

  -- Enable register vita time
  en_measure_int <= detected_int or sr0_value_int or trigger_int;

  -- instance "ext_event_trigger_1"
  ext_event_trigger_1 : entity work.ext_event_trigger
    port map (
      clk           => clk,
      rst           => rst,
      trigger_i     => trigger_i,
      trigger_o     => trigger_int);

  -- purpose: timestamp register
  -- type   : sequential
  -- inputs : bus_clk, rst, en_measure_int
  -- outputs: measured_time
  measure: process (bus_clk, rst) is
  begin  -- process measure
    if rst = '0' then                   -- asynchronous reset (active low)
      measured_time <= (others => '0');
    elsif rising_edge(bus_clk) then  -- rising clock edge
      if en_measure_int then
        measured_time <= vita_time;
      end if;
    end if;
  end process measure;

end architecture lora_detect_behav;
