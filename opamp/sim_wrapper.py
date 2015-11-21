import os
import subprocess
import platform
import xml.etree.ElementTree
import time
def main():
    if (platform.system() == "Windows"):
        workingDirectory = "C:\\Users\\adel\\code\\analog\\opamp"
        template_filename = "C:\\Users\\adel\\code\\analog\\opamp\\opamp_2s_fc_template.sp"
    else:
        workingDirectory = "/Users/adel/code/Duplex/bin/"


    os.chdir(workingDirectory)
    for w1 in range (10,61):
        for w3 in range (20, 21):
            parameter1 = 'w1_size'
            parameter2 = 'w3_size'
            value1 = "'" + str(w1) + "0*lambda'"
            value2 = "'" + str(w3) + "0*lambda'"
            print ("running simulaition for " + value1 + " " + value2)
            template = open(template_filename, 'r')
            netlist = open('opamp_netlist.sp', 'w')
            for line in template:
                netlist.write(line.replace(parameter1, value1).replace(parameter2, value2))
            template.close()
            netlist.close()
            #duplex = subprocess.Popen(['hspice', 'opamp_netlist.sp', ' > opamp_log.txt'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            logfile= open("opamp_" + str(w1) + "0_" + str(w3) + "0.log", 'w')
            spice = subprocess.Popen(['hspice', 'opamp_test.sp'], stdout=logfile)
            output, error = spice.communicate('\n')
            logfile.close()

if  __name__ =='__main__':main()
