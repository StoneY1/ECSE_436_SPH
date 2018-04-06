library verilog;
use verilog.vl_types.all;
entity test_block_vlg_check_tst is
    port(
        code_out        : in     vl_logic_vector(7 downto 0);
        r1              : in     vl_logic_vector(7 downto 0);
        r2              : in     vl_logic_vector(7 downto 0);
        r3              : in     vl_logic_vector(7 downto 0);
        r4              : in     vl_logic_vector(7 downto 0);
        r5              : in     vl_logic_vector(7 downto 0);
        r6              : in     vl_logic_vector(7 downto 0);
        r7              : in     vl_logic_vector(7 downto 0);
        r8              : in     vl_logic_vector(7 downto 0);
        shortest_path   : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end test_block_vlg_check_tst;
