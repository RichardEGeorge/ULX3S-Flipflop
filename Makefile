ulx3s.bit: ulx3s_out.config
	ecppack ulx3s_out.config ulx3s.bit

ulx3s_out.config: flipflop.json
	nextpnr-ecp5 --85k --json flipflop.json \
		--lpf ulx3s_v20.lpf \
		--textcfg ulx3s_out.config

flipflop.json: flipflop.ys flipflop.v
	yosys flipflop.ys

prog: ulx3s.bit
	fujprog ulx3s.bit
