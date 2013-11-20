#!/usr/bin/env python3

from sys import stderr

def record_reader(flo):
	record = {}
	for line in flo:
		if line.strip() == '%%':
			yield record
			record = {}
		else:
			try:
				key, value = line.split(':')
				record[key.strip()] = value.strip()
			except ValueError as e:
				stderr.write("{0}\n".format(e))		
	yield record

if __name__ == '__main__':
	import sys
	
	for record in record_reader(sys.stdin):
		print("record: {0}\n".format(record))

