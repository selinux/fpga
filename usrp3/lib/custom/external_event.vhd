-------------------------------------------------------------------------------
-- Title      : Pulse generator
-- Project    : Travail de bachelor
-------------------------------------------------------------------------------
-- File       : external_event.vhd
-- Author     : Sebastien Chassot (sebastien.chassot@etu.hesge.ch) 
-- Company    : HESSO - hepia - ITI
-- Created    : 2017-05-17
-- Last update: 2017-06-17
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This module is triggered by an external pulse and keep
--              vita_time64 in a register
-------------------------------------------------------------------------------
-- Copyright (c) 2017
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-06-17  1.0      seba	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_event_trigger is
  port (
    clk       : in  std_logic;          -- clock in
    rst       : in  std_logic;          -- reset
    trigger_i : in  std_logic;          -- external trigger rising edge
    trigger_o : out std_logic);         -- trigger detected
end entity gen_event_trigger;

architecture external_event_trigger_behav of gen_event_trigger is

  signal trig_nxt : std_logic := '0';         -- first state

begin  -- architecture external_event_trigger_beav

  -- purpose: edge detector second edge
  -- type   : sequential
  -- inputs : clk, rst, trigger_i
  -- outputs: 
  process (clk, rst) is
  begin  -- process sec_edge
    if rst = '1' then                   -- asynchronous reset (active low)
      trig_nxt <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      trig_nxt <= trigger_i;
    end if;
  end process sec_edge;

  -- rising edge detected
  trigger_o <= '1' when (trig_nxt = '0' and trigger_i = '1') else '0';

end architecture external_event_trigger_behav;
