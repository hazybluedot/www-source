#!/usr/bin/env python3

import record_jar_reader as rjr

def print_planet_info(planet):
	print("{name} has an orbital radius of {orbital_radius}".format(
		name=planet['Planet'], 
		orbital_radius=planet['Orbital-Radius'])
	     )

if __name__ == '__main__':
	import sys
	
	for planet in rjr.record_reader(sys.stdin):
		print_planet_info(planet)


