* Two stage opamp circuit with frequency compensation and power-down circuitry

.subckt tinv in out vdd vss
m1 out in vdd vdd pmos w=0.5u l=0.18u
m2 out in vss vss nmos w=0.5u l=0.18u
.ends


.subckt opamp  vdd vss inp inn out
m2 (bias bias vdd vdd) pmos w=7.14u l=0.44u m=1
m8 (a2 bias vdd vdd) pmos w=7.14u l=0.44u m=8             
m11 (out bias vdd vdd) pmos w=7.14u l=0.44u m=8
m3 (bias w_6 vdd vdd) pmos w=0.5um l=0.18u                * shuts-off the output
m4 (a6 vss vss vss) nmos w=0.5um l=0.18u
m6 (a5 inn a2 vdd) pmos w=4.5u l=0.51u m=4
m7 (a6 inp a2 vdd) pmos w=4.5u l=0.51u m=4
m9 (a5 a5 vss vss) nmos w=1.53u l=1.18u m=4
m10 (a6 a5 vss vss) nmos w=1.53u l=1.18u m=4
m5 (out a6 vss vss) nmos w=13.5u l=0.77u m=4
x1 (vss w_6 vdd vss) tinv                                 * Powers down the current mirror
c1 (a6 w_7) c=6.6p
r1 (out w_7) r=750
Ib  bias  gnd   dc=5u
.ends
