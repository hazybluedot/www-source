#!/usr/bin/env python3

import record_jar_reader as rjr

class Planet: # note 1
	def __init__(self, planet_dict): # note 2
		self.name = planet_dict['Planet']
		self.orbital_radius = planet_dict['Orbital-Radius']
		self.diameter = planet_dict['Diameter']
		self.mass = planet_dict['Mass']
		self.moons = planet_dict['Moons'] if 'Moons' in planet_dict else None

	def __str__(self): # note 3
	   return "{name} has an orbital radius of {orbital_radius}".format(
		name=self.name, 
		orbital_radius=self.orbital_radius)


if __name__ == '__main__':
	import sys
	
	planets = [ Planet(planet) for planet in rjr.record_reader(sys.stdin) ] # note 4
	
	for planet in planets:
		print(planet) # note 5


# note 1: this how we define a class in python. We won't get to too
# many details about OOP in Python in the remaining days of class, but
# hopfully you can tell from the example that it is fairly clean and
# simple (Python was designed to be an OOP language from the ground
# up) 
#
# Notice that all member functions take the variable 'self' as their
# first argument. This is a reference the object itself, like the
# 'this' pointer in C++

# note 2: The special '__init__' function is kind of like a
# constructor in C++, it is called when an object is created

# note 3: The special '__str__' function is called when a string
# representation is needed for an object of this class.

# note 4: This is a list comprehension. The variable 'planets' will
# contain a list of planet objects.  Something should bother you about
# using this list comprehension along with the record_reader generator
# we wrote earlier, what is it?

# note 5: I pass a object of type Planet to the 'print' function. The
# print function makes use of the object's '__str__' function to get a
# string representation of the object.
