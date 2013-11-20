#!/usr/bin/env python3

def print_planet(planet):
	print("{name} has an orbital radius of {orbital_radius}".format(
		name=planet['Planet'], orbital_radius=planet['Orbital-Radius']))

if __name__ == '__main__':
	import sys

	planet = {}
	for line in sys.stdin:
		try:
			key, value = line.split(':')
			planet[key.strip()] = value.strip()
		except ValueError as e:
			if line.strip() == '%%':
				print_planet(planet)
				planet = {}
		
	print_planet(planet)			
