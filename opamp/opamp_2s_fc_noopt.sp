* Two stage opamp circuit, non-optimized version
*  gain=  3.2714E+01    at=  1.0233E+00  from=  1.0000E+00    to=  1.0000E+12
*  ugf=  4.8824E+04
*  min_phase= -1.7942E+02    at=  1.7783E+07 from=  1.0000E+00    to=  1.0000E+12
*  phase_shift= -8.9311E+01
*  phase_margin=  9.0689E+01
*  phase_margin_alt=  9.0689E+01
*  gm=  5.7999E+01
*  first_pole=  7.8993E+01
*  second_pole=  5.0531E+06
*  power=  8.9706E-05  from=  0.0000E+00     to=  4.9900E-07
*  hivolt=  7.4974E-01
*  lovolt=  4.4920E-01
*  risestart=  5.8559E-08
*  risestop=  1.2314E-07
*  fallstart=  1.0200E-08
*  fallstop=  6.8695E-08
*  sr_rise=  3.7231E+00
*  sr_fall=  4.1103E+00
*  crosst_rise=  3.7991E-07
*  crossb_rise=  1.2739E-07
*  crosst_fall=  1.0057E-07
*  crossb_fall= failed
*  ts_rise=  3.7991E-01
*  ts_fall= failed                         measure parameter failed

.subckt opamp  vdd vss inp inn out
m2 (bias bias vdd vdd) pmos w=7.14u l=0.44u m=1
m8 (a2 bias vdd vdd) pmos w=7.14u l=0.44u m=8
m11 (out bias vdd vdd) pmos w=7.14u l=0.44u m=8
m6 (a5 inn a2 vdd) pmos w=4.5u l=0.51u m=4
m7 (a6 inp a2 vdd) pmos w=4.5u l=0.51u m=4
m9 (a5 a5 vss vss) nmos w=1.53u l=1.18u m=4
m10 (a6 a5 vss vss) nmos w=1.53u l=1.18u m=4
m5 (out a6 vss vss) nmos w=13.5u l=0.77u m=4
c1 (a6 w_7) c=6.6p
r1 (out w_7) r=750
Ib  bias  gnd   dc=5u
.ends
