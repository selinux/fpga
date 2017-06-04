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
-- Explication  : This module is triggered by an external pulse and keep
--                vita_time64 in a register 
--
--
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ext_event_trigger is
  port (
    clk       : in  std_logic;          -- clock in
    rst       : in  std_logic;          -- reset
    trigger_i : in  std_logic;          -- external trigger rising edge
    trigger_o : out std_logic);         -- trigger detected
end entity ext_event_trigger;

architecture external_event_trigger_behav of ext_event_trigger is

  signal r0_i : std_logic := '0';         -- first state
  signal r1_i : std_logic := '0';         -- second state

begin  -- architecture external_event_trigger_beav

  -- purpose: edge detector second edge
  -- type   : sequential
  -- inputs : clk, rst, trigger_i
  -- outputs: 
  process (clk, rst) is
  begin  -- process sec_edge
    if rst = '0' then                   -- asynchronous reset (active low)
      r0_i <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      r0_i <= trigger_i;
    end if;
  end process sec_edge;

  -- purpose: edge detector first edge
  -- type   : sequential
  -- inputs : clk, rst, r0_i
  -- outputs: 
  process (clk, rst) is
  begin  -- process sec_edge
    if rst = '0' then                   -- asynchronous reset (active low)
      r1_i <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      r1_i <= r0_i;
    end if;
  end process sec_edge;

  -- rising edge detected
  trigger_o <= '1' when (r0_i = '1' and r1_i = '0') else '0';

end architecture external_event_trigger_behav;
