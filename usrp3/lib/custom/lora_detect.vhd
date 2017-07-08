-------------------------------------------------------------------------------
-- Title      : LoRa core
-- Project    : Travail de bachelor
-------------------------------------------------------------------------------
-- File       : lora_detect.vhd
-- Author     :   <seba@t440p>
-- Company    : HESSO - hepia - ITI
-- Created    : 2017-06-18
-- Last update: 2017-07-08
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This module detect a LoRa packet in a stream of data from an
--              ADC and timestamp it.
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-05-17  1.0      seba  Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity lora_detect is

  generic (
    PULSE_LEN : integer             := 100000000;
    COMP_VAL0 : signed(63 downto 0) := To_signed(10000, 64);  -- comparator value 0
    COMP_VAL1 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 1
    COMP_VAL2 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 2
    COMP_VAL3 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 3
    COMP_VAL4 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 4
    COMP_VAL5 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 5
    COMP_VAL6 : signed(63 downto 0) := To_signed(20000, 64);  -- comparator value 6
    COMP_VAL7 : signed(63 downto 0) := To_signed(30000, 64));  -- comparator value 7

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

    lora_trig_o : out std_logic;        -- lora counter trigger

    -- debug chipscope
    chipscope_bus_o      : out std_logic_vector(71 downto 0);  -- probe chipscope
    lora_time_measured_o : out std_logic_vector(63 downto 0));  -- detected packet's trigger

end entity lora_detect;

architecture lora_detect_behav of lora_detect is

  ------------------------------------
  -- Components
  ------------------------------------
  component gen_event_trigger is
    port (
      clk       : in std_logic;
      rst       : in std_logic;
      trigger_i : in std_logic);
  end component gen_event_trigger;

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
  signal sr0_value_int     : std_logic_vector(31 downto 0);  -- setting register value
  signal sr0_value_nxt_int : std_logic_vector(31 downto 0);  -- setting register value

  signal save_time_int        : std_logic := '0';  -- enable measure
  signal gen_uart_trigger_int : std_logic;         -- trigger rising edge
  signal gen_lora_trigger_int : std_logic := '0';  -- trigger rising edge

  signal lora_detected         : std_logic;     -- lora detect
  signal iq_module             : signed(31 downto 0);           -- IQ module
  signal comparator_int        : std_logic_vector(7 downto 0);  -- Comparator
  signal trigger_pulse_counter : integer := 0;  -- pulse length counter

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
  -- save_time_int <= gen_lora_trigger_int or gen_uart_trigger_int;

  -----------------------------------
  -- instance "gen_event_trigger_1"
  -----------------------------------
  -- gen_uart_trigger_1 : entity work.gen_event_trigger
  --   port map (
  --     clk       => radio_clk,
  --     rst       => rst,
  --     trigger_i => trigger_i,
  --     trigger_o => gen_uart_trigger_int);

  -----------------------------------
  -- instance "gen_soft_trigger_1"
  -----------------------------------
  -- gen_soft_trigger_1 : entity work.gen_event_trigger
  --   port map (
  --     clk       => bus_clk,
  --     rst       => rst,
  --     trigger_i => sr0_value_int(0),
  --     trigger_o => gen_soft_trigger_int);

  -----------------------------------
  -- instance "gen_lora_trigger_1"
  -----------------------------------
  -- gen_lora_trigger_1 : entity work.gen_event_trigger
  --   port map (
  --     clk       => bus_clk,
  --     rst       => rst,
  --     trigger_i => lora_i,
  --     trigger_o => gen_lora_trigger_int);

  ----------------------------------------
  -- purpose: one cycle only trigger
  -- type   : sequential
  -- inputs : bus_clk, rst, sr0_value_int
  -- outputs: one pulse when register ==0x1
  ----------------------------------------
  -- software_trig : process (bus_clk, rst) is
  -- begin  -- process measure
  --   if rst = '0' then                   -- asynchronous reset (active low)
  --   --sr0_value_int <= (others => '0');
  --   elsif rising_edge(bus_clk) then     -- rising clock edge
  --     sr0_value_nxt_int <= sr0_value_int;
  --   end if;
  -- end process software_trig;

  -- gen_soft_trigger_int <= '1' when sr0_value_nxt_int(0) = '0' and sr0_value_int(0) = '1' else '0';

----------------------------------------
-- purpose: timestamp register
-- type   : sequential
-- inputs : bus_clk, rst, en_measure_int
-- outputs: measured_time
----------------------------------------
  -- measure : process (radio_clk, rst) is
  -- begin  -- process measure
  --   if rst = '1' then                   -- asynchronous reset (active low)
  --     lora_time_measured_o <= (others => '0');
  --   elsif rising_edge(radio_clk) then   -- rising clock edge
  --     if save_time_int = '1' then
  --       lora_time_measured_o <= vita_time;
  --     end if;
  --   end if;
  -- end process measure;

  ----------------------------------------
-- purpose: trigger out register
-- type   : sequential
-- inputs : radio_clk, rst, save_time_int
-- outputs: lora_trig_o
----------------------------------------
  trig : process (radio_clk, rst) is
  begin  -- process measure


    if rst = '1' then                   -- asynchronous reset (active low)
      lora_trig_o <= '0';

    elsif rising_edge(radio_clk) then   -- rising clock edge

      lora_trig_o <= '0';

      if lora_detected = '1' and trigger_pulse_counter = 0 then
        trigger_pulse_counter <= PULSE_LEN;
      end if;

      if trigger_pulse_counter > 0 then

        lora_trig_o           <= '1';
        trigger_pulse_counter <= trigger_pulse_counter - 1;

      end if;
    end if;
  end process trig;

--------------------------------------
-- LoRa detection
--------------------------------------

  comparator_int(0) <= '0' when iq_module < COMP_VAL0 else '1';
  comparator_int(1) <= '0' when iq_module < COMP_VAL1 else '1';
  comparator_int(2) <= '0' when iq_module < COMP_VAL2 else '1';
  comparator_int(3) <= '0' when iq_module < COMP_VAL3 else '1';
  comparator_int(4) <= '0' when iq_module < COMP_VAL4 else '1';
  comparator_int(5) <= '0' when iq_module < COMP_VAL5 else '1';
  comparator_int(6) <= '0' when iq_module < COMP_VAL6 else '1';
  comparator_int(7) <= '0' when iq_module < COMP_VAL7 else '1';

  -- purpose: Detect Lora from I Q samples
  -- type   : sequential
  -- inputs : radio_clk, rst, rx_i, rx_q
  -- outputs: iq_module
  lora_detection : process (radio_clk, rst) is
  begin  -- process lora_detection
    if rst = '1' then                   -- asynchronous reset (active low)

      iq_module <= (others => '0');

    elsif rising_edge(radio_clk) then   -- rising clock edge

      iq_module <= abs(signed(rx_i))*abs(signed(rx_i))  + abs(signed(rx_q))*abs(signed(rx_q));

    end if;
  end process lora_detection;

  -- purpose: <[description]>
  mux_detections : process (comparator_int) is
  begin  -- process mux_detections
    -- MUX for chipscope
    case sr0_value_int(2 downto 0) is
      when "000"  => lora_detected <= comparator_int(0);
      when "001"  => lora_detected <= comparator_int(1);
      when "010"  => lora_detected <= comparator_int(2);
      when "011"  => lora_detected <= comparator_int(3);
      when "100"  => lora_detected <= comparator_int(4);
      when "101"  => lora_detected <= comparator_int(5);
      when "110"  => lora_detected <= comparator_int(6);
      when others => lora_detected <= comparator_int(7);
    end case;
  end process mux_detections;

--------------------------------------
-- Debug with chipscope
--------------------------------------
  -- chipscope_bus_o   <= (strobe & rst & sr0_value_int(5 downto 0) & sr0_value_int(7 downto 0) & addr);
  chipscope_bus_o <= (std_logic_vector(iq_module) & rx_q & rx_i & comparator_int);
  -- chipscope_radio_o <= (rx_q & rx_i & save_time_int & gen_lora_trigger_int & gen_uart_trigger_int);

end architecture lora_detect_behav;
