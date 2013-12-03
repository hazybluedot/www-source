#!/usr/bin/env python3

def planet_reader(flo):
	planet = {}
	for line in flo:
		if line.strip() == '%%':
			yield planet
			planet = {}
		else:
			try:
				key, value = line.split(':')
				planet[key.strip()] = value.strip()
			except ValueError as e:
				pass #TODO: decide what we want to do on an 
	yield planet

def print_planet_info(planet):
	print("{name} has an orbital radius of {orbital_radius}".format(
		name=planet['Planet'], 
		orbital_radius=planet['Orbital-Radius'])
	     )


if __name__ == '__main__':
	import sys
	
	for planet in planet_reader(sys.stdin):
		print_planet_info(planet)

