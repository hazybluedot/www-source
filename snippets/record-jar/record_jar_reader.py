#!/usr/bin/env python3

def record_reader(flo):
        """read a stream containing record-jar formatted data, yield a
        complete record

        """

        record = {}
        for line in flo:
                if line.startswith('%%'):
                        yield record
                        record = {}
                else:
                        key, value = line.split(':')
                        record[key.strip()] = value.strip()
                        
        yield record

def load_records(flo):
        """read a complete stream containing record-jar formatted data and
        load all records into memory
        """

        return [ record for record in record_reader(flo) ]

if __name__ == '__main__':
	import sys
	
	for record in record_reader(sys.stdin):
		print("record: {0}\n".format(record))

