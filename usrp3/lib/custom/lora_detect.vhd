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

    rx_i      : in std_logic_vector(15 downto 0);  -- rx I signal
    rx_q      : in std_logic_vector(15 downto 0);  -- rx Q signal
    vita_time : in std_logic_vector(63 downto 0);  -- vita time
    trigger_i : in std_logic;                      -- external trigger

    -- wishbone
    addr   : in std_logic_vector(7 downto 0);   -- setting reg
    data   : in std_logic_vector(31 downto 0);  -- data
    strobe : in std_logic;

    -- readback output
    lora_time_measured_o : out std_logic_vector(63 downto 0));  -- detected packet's trigger

end entity lora_detect;

architecture lora_detect_behav of lora_detect is

  ------------------------------------
  -- Components
  ------------------------------------
  component ext_event_trigger is
    port (
      clk       : in std_logic;
      rst       : in std_logic;
      trigger_i : in std_logic);
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

  component chipscope_icon is
    port (
      control0 : inout std_logic_vector(35 downto 0));  -- INOUT BUS
  end component chipscope_icon;

  component chipscope_ila_128 is
    port (
      control : inout std_logic_vector(35 downto 0);
      clk     : in    std_logic;                        -- clock in
      trig0   : in    std_logic_vector(127 downto 0));  -- ports in
  end component chipscope_ila_128;


  -------------------------------------------------------
  -- signals
  -------------------------------------------------------
  signal sr0_value_int  : std_logic_vector(31 downto 0) := (others => '0');  -- setting register value
  signal result_mod_int : std_logic_vector(31 downto 0) := (others => '0');
  -- signal debug_measure_int : std_logic_vector(63 downto 0) := (others => '0');  -- debug reg

  signal detected_int   : std_logic := '0';  -- lora detected
  signal en_measure_int : std_logic := '0';  -- enable measure
  signal trigger_int    : std_logic := '0';  -- trigger rising edge

  signal control0 : std_logic_vector(35 downto 0);  -- chipscope control

begin  -- architecture lora_detect_behav

  --------------------------
  -- setting register 0
  -- cpp API trigger
  --------------------------
  sr_lora_0 : setting_reg_vhdl_wrapper port map (
    clk      => bus_clk,
    rst      => rst,
    strobe   => strobe,
    addr     => addr,
    data_in  => data,
    data_out => sr0_value_int);

  --------------------------------
  -- Enable register vita time
  -- combinational
  --------------------------------
  en_measure_int <= detected_int or sr0_value_int(0) or trigger_int;

  -----------------------------------
  -- instance "ext_event_trigger_1"
  -----------------------------------
  ext_event_trigger_1 : entity work.ext_event_trigger
    port map (
      clk       => bus_clk,
      rst       => rst,
      trigger_i => trigger_i,
      trigger_o => trigger_int);

  ----------------------------------------
  -- purpose: timestamp register
  -- type   : sequential
  -- inputs : bus_clk, rst, en_measure_int
  -- outputs: measured_time
  ----------------------------------------
  measure : process (bus_clk, rst) is
  begin  -- process measure
    if rst = '0' then                   -- asynchronous reset (active low)
      lora_time_measured_o <= (others => '0');
    elsif rising_edge(bus_clk) then     -- rising clock edge
      if en_measure_int = '1' then
        lora_time_measured_o <= vita_time;
      end if;
    end if;
  end process measure;

  --------------------------------------
  -- Debug with chipscope
  --------------------------------------
  -- lora_time_measured_o <= debug_measure_int;
  -- trigger_int <= (others => '0') & data & sr0_value_int & debug_measure_int & trigger_int;

  -- chipscope_icon_1 : entity work.chipscope_icon
  --   port map (
  --     control0 => control0);

  -- chipscope_ila_128_1 : entity work.chipscope_ila_128
  --   port map (
  --     control => control0,
  --     clk     => bus_clk,
  --     trig0   => trigger_int);

end architecture lora_detect_behav;
