import os
import subprocess
import platform
import xml.etree.ElementTree
import time
def main():
    if (platform.system() == "Windows"):
        workingDirectory = "C:\\Users\\adel\\code\\analog\\opamp"
        template_filename = "C:\\Users\\adel\\code\\analog\\opamp\\opamp_2s_fc_template.sp"
        report = "C:\\Users\\adel\\code\\analog\\opamp\\log.txt"
    else:
        workingDirectory = "/Users/adel/code/Duplex/bin/"
        report = '/Users/adel/code/Duplex/bin/error.m'

    parameter1 = 'w1_size'
    parameter2 = 'rl_size'
    os.chdir(workingDirectory)
    template = open(template_filename, 'r')
    netlist = open('opamp_netlist.sp', 'w')
    for line in template:
        netlist.write(line.replace(parameter1, '580*lambda').replace(parameter2, '2k'))
    template.close()
    netlist.close()
    
if  __name__ =='__main__':main()
