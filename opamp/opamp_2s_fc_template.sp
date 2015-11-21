* Two stage opamp circuit with frequency compensation
* source: Jung,Lee,Kim, variability-aware discrete optimization for analog circuits, IEEE TCAD, 33(8), Aug-2014

.param lambda = 30n
.param lmin = '10*lambda'
*.param lmin = 300n
.param w1=w1_size
.param w2=w1
.param w3=w3_size
.param w4=w3
.param w5='438*lambda'
.param w6='200*lambda'
.param w7='640*lambda'
.param w8='17*lambda'
.param ibias=6.7u
.param clopt=24f
.param rlopt=1k

.subckt opamp  vdd vss inp inn out
m1 (a5 inn a2 vdd) pmos  w=w1   l=lmin *w=4.5u l=0.51u m=4
m2 (a6 inp a2 vdd) pmos  w=w2   l=lmin *w=4.5u l=0.51u m=4
m3 (a5 a5 vss vss) nmos w=w3   l=lmin  *w=1.53u l=1.18u m=4
m4 (a6 a5 vss vss) nmos w=w4   l=lmin  *w=1.53u l=1.18u m=4
m5 (a2 bias vdd vdd) pmos w=w5   l=lmin *w=7.14u l=0.44u m=8
m6 (out a6 vss vss) nmos w=w6   l=lmin *w=13.5u l=0.77u m=4
m7 (out bias vdd vdd) pmos  w=w7   l=lmin  *w=7.14u l=0.44u m=8
m8 (bias bias vdd vdd) pmos w=w8   l=lmin *w=7.14u l=0.44u m=1
r1 (a6 w_7) r=rlopt
c1 (out w_7) c=clopt

Ib  bias  gnd   dc=ibias
.ends
