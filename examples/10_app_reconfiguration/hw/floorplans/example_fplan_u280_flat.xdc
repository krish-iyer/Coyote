# Flat-DFX floorplan for the Alveo U280, i.e. BUILD_STATIC=1, EN_PR=1, EN_SHELL_PBLOCK=0.
#
# The u55c example floorplan cannot be reused as-is here. Its CLOCKREGION ranges
# resolve to 95520 of this device's 162960 SLICEs. Under nested DFX that is
# harmless, because the vFPGA pblock is a subcell of pblock_inst_shell and Vivado
# intersects the two; flat DFX has no such parent, so the range is taken literally
# and would claim the static layer's territory, PCIe included.
#
# What remains is the site footprint the nested build actually placed into: the
# left half of the top clock-region row, in SLR2. 6540 SLICEs, 384 DSP48E2, 32
# URAM288 -- ample for the two similarity kernels, and the same physical region
# the nested U280 build closed timing in, so the two are comparable.

create_pblock pblock_inst_user_wrapper_0
add_cells_to_pblock [get_pblocks pblock_inst_user_wrapper_0] [get_cells -quiet [list inst_shell/inst_dynamic/inst_user_wrapper_0]]
resize_pblock [get_pblocks pblock_inst_user_wrapper_0] -add {SLICE_X0Y660:SLICE_X116Y719}
resize_pblock [get_pblocks pblock_inst_user_wrapper_0] -add {DSP48E2_X0Y258:DSP48E2_X15Y281}
resize_pblock [get_pblocks pblock_inst_user_wrapper_0] -add {RAMB18_X0Y264:RAMB18_X7Y287}
resize_pblock [get_pblocks pblock_inst_user_wrapper_0] -add {RAMB36_X0Y132:RAMB36_X7Y143}
resize_pblock [get_pblocks pblock_inst_user_wrapper_0] -add {URAM288_X0Y176:URAM288_X1Y191}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_user_wrapper_0]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_user_wrapper_0]
