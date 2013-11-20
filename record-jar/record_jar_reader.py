#!/usr/bin/env python3

def record_reader(flo):
	record = {}
	for line in flo:
		try:
			key, value = line.split(':')
			record[key.strip()] = value.strip()
		except ValueError as e:
			if line.strip() == '%%':
				yield record
				record = {}
	yield record

if __name__ == '__main__':
	import sys
	
	for record in reord_reader(sys.stdin):
		print("record: {0}\n".format(record))

