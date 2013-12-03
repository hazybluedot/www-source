#!/usr/bin/env python3

import record_jar_reader as rjr

class Planet:
	def __init__(self, planet_dict):
		self.name = planet_dict['Planet']
		self.orbital_radius = planet_dict['Orbital-Radius']
		self.diameter = planet_dict['Diameter']
		self.mass = planet_dict['Mass']
		self.moons = planet_dict['Moons'] if 'Moons' in planet_dict else None

	def __str__(self):
	   return "{name} has an orbital radius of {orbital_radius}".format(
		name=self.name, 
		orbital_radius=self.orbital_radius)


if __name__ == '__main__':
	import sys
	
<<<<<<< HEAD
	print("A Happy List of Planets")

	for planet in rjr.record_reader(sys.stdin):
		print_planet_info(planet)
=======
	planets = [ Planet(planet) for planet in rjr.record_reader(sys.stdin) ]
	
	for planet in planets:
		print(planet)
>>>>>>> 327027ca0550baeb2eb3fa5de965b4ccb5957b56

