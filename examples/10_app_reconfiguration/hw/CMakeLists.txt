######################################################################################
# This file is part of the Coyote <https://github.com/fpgasystems/Coyote>
# 
# MIT Licence
# Copyright (c) 2025, Systems Group, ETH Zurich
# All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
######################################################################################

cmake_minimum_required(VERSION 3.5)
set(CYT_DIR ${CMAKE_SOURCE_DIR}/../../../)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CYT_DIR}/cmake)
find_package(CoyoteHW REQUIRED)

project(example_10_partial_reconfiguration)
message("*** Coyote Example 10: Partial (application) reconfiguration [Hardware] ***")

# Two input streams, one for each input vector, which are used to calculate the similarity
set(EN_STRM 1)
set(N_STRM_AXI 2)

# Enable partial (application) reconfiguration and specify that there are two possible configurations for the (single) vFPGA
set(EN_PR 1)
set(N_CONFIG 2)
set(N_REGIONS 1)

# Target platform; u55c unless -DFDEV_NAME names another, with the floorplan
# following the device name unless -DFPLAN_PATH overrides that too. A floorplan is
# specific to both the device and the build flow, so it does not always follow from
# the device alone -- example_fplan_u280_flat.xdc is for the flat flow
# (BUILD_STATIC=1, EN_PR=1, EN_SHELL_PBLOCK=0) and has to be named explicitly.
if(FDEV_NAME STREQUAL "0")
    set(FDEV_NAME "u55c")
endif()
if(FPLAN_PATH STREQUAL "0")
    set(FPLAN_PATH "${CMAKE_SOURCE_DIR}/floorplans/example_fplan_${FDEV_NAME}.xdc")
endif()

# The v80 needs EN_SHELL_PBLOCK=0 as well; Versal devices do not support nested DFX:
#   cmake .. -DFDEV_NAME=v80 -DEN_SHELL_PBLOCK=0

# Load the vector similarity kernels; note the C0_0, corresponding to Config 0, Region 0 and C1_0, corresponding to Config 1, Region 0
validation_checks_hw()
load_apps (
    VFPGA_C0_0 "apps/euclidean_distance"
    VFPGA_C1_0 "apps/cosine_similarity"
)
create_hw()
