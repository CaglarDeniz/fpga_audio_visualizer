#!/usr/bin/env python
from argparse import ArgumentParser

parser = ArgumentParser(description='A script to convert binary assembly to a mif file')

parser.add_argument('infile', help='Input File', metavar='FILE')
parser.add_argument('outfile', help='Output Assembly File', metavar='FILE')

parser.add_argument('-d', '--depth', type=int, default=1024)
parser.add_argument('-w', '--width', type=int, default=32)
parser.add_argument('-r', '--radix', type=str, default="DEC")
parser.add_argument('-dr', '--data-radix', metavar='RADIX', type=str, default='BIN')
args = parser.parse_args()

with open(args.infile, 'rb') as binary_text:
  with open(args.outfile, 'w') as mif_file:
    mif_file.write('DEPTH={};\n'.format(args.depth))
    mif_file.write('WIDTH = {};\n'.format(args.width))
    mif_file.write('ADDRESS_RADIX = {};\n'.format(args.radix))
    mif_file.write('DATA_RADIX = {};\n\n'.format(args.data_radix))
    mif_file.write('CONTENT\n')
    mif_file.write('BEGIN\n')

    inst_num = 0
    curr_word = binary_text.read(4);
    while curr_word != b'' :
        mif_file.write('{0}: '.format(inst_num))
        byte_list = []
        for byte in curr_word:
            byte_list.append(byte)

        for byte in reversed(byte_list): # to account for little-endian mp3 file?
            val = str(hex(byte))[2:]
            if len(val) == 1:
                val = '0' + val
            mif_file.write('{0}'.format(val))
        mif_file.write(' ;\n')
        inst_num += 1
        curr_word = binary_text.read(4)

    print(f"File has {inst_num} 4-byte words")



    # for line in binary_text:
    #     for byte in line:
    #         mif_file.write('{0}: {1};\n'.format(inst_num, hex(byte)))
    #         inst_num += 1

    mif_file.write('END;\n')
