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
-- Explication  : Compute module of complex number input 16bits (15:4 significatifs)
--                and output the module (real^2+comp^2)
--
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity complex_module is
    port (
        clk      : in  std_logic;                       -- clock
        rst      : in  std_logic;                       -- reset
        real_i   : in  std_logic_vector(15 downto 0);   -- real part
        comp_i   : in  std_logic_vector(15 downto 0);   -- complex part
        result_o : out std_logic_vector(31 downto 0));  -- module result
end entity complex_module;

architecture complex_module_a of complex_module is


    component dsp_add48_48
        port (
            clk      : in  std_logic;
            c        : in  std_logic_vector(47 downto 0);
            concat   : in  std_logic_vector(47 downto 0);
            carryout : out std_logic;
            p        : out std_logic_vector(47 downto 0)
            );
    end component;

    component dsp_mult18_48
        port (
            a        : in  std_logic_vector(17 downto 0) := (others => '0');
            b        : in  std_logic_vector(17 downto 0) := (others => '0');
            carryout : out std_logic;
            p        : out std_logic_vector(35 downto 0)
            );
    end component;


    signal power_real_int       : std_logic_vector(47 downto 0);
    signal power_comp_int       : std_logic_vector(47 downto 0);
    signal result_int : std_logic_vector(47 downto 0);


begin  -- architecture complex_module_a

    real1 : dsp_mult18_48 port map (
        a        => "00" & real_i,
        b        => "00" & real_i,
        carryout => open,
        p        => power_real_int(35 downto 0));

    comp1 : dsp_mult18_48 port map (
        a        => "00" & comp_i,
        b        => "00" & comp_i,
        carryout => open,
        p        => power_comp_int(35 downto 0));

    mod1 : dsp_add48_48 port map (
        clk      => clk,
        c        => power_real_int,
        concat   => power_comp_int,
        carryout => open,
        p        => result_int);


    result_o <= result_int(31 downto 0);
    
end architecture complex_module_a;

