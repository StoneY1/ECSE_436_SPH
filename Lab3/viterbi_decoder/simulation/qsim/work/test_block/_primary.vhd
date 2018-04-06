library verilog;
use verilog.vl_types.all;
entity test_block is
    port(
        code_out        : out    vl_logic_vector(7 downto 0);
        CLK             : in     vl_logic;
        code_in         : in     vl_logic_vector(7 downto 0);
        r1              : out    vl_logic_vector(7 downto 0);
        r2              : out    vl_logic_vector(7 downto 0);
        r3              : out    vl_logic_vector(7 downto 0);
        r4              : out    vl_logic_vector(7 downto 0);
        r5              : out    vl_logic_vector(7 downto 0);
        r6              : out    vl_logic_vector(7 downto 0);
        r7              : out    vl_logic_vector(7 downto 0);
        r8              : out    vl_logic_vector(7 downto 0);
        shortest_path   : out    vl_logic_vector(7 downto 0)
    );
end test_block;
