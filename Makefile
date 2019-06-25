all: aus.stl fcs.stl probox.stl tuttle.stl us.stl

%.stl: scad/%.scad
	openscad -o $@ $<
