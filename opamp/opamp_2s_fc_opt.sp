* Two stage opamp circuit with frequency compensation
* source: Jung,Lee,Kim, variability-aware discrete optimization for analog circuits, IEEE TCAD, 33(8), Aug-2014

.param lambda = 30n
.param lmin = '10*lambda'
.param w1='590*lambda'
.param w2=w1
.param w3='68*lambda'
.param w4=w3
.param w5='438*lambda'
.param w6='200*lambda'
.param w7='640*lambda'
.param w8='17*lambda'

.subckt opamp  vdd vss inp inn out
m2 (bias bias vdd vdd) pmos w=7.14u l=0.44u m=1           * OK -> M8
m8 (a2 bias vdd vdd) pmos w=7.14u l=0.44u m=8             * OK -> M5
m11 (out bias vdd vdd) pmos w=7.14u l=0.44u m=8
m3 (bias w_6 vdd vdd) pmos w=0.5um l=0.18u                * remove
m6 (a5 inn a2 vdd) pmos w=4.5u l=0.51u m=4
m7 (a6 inp a2 vdd) pmos w=4.5u l=0.51u m=4
m9 (a5 a5 vss vss) nmos w=1.53u l=1.18u m=4
m10 (a6 a5 vss vss) nmos w=1.53u l=1.18u m=4
m5 (out a6 vss vss) nmos w=13.5u l=0.77u m=4
c1 (a6 w_7) c=6.6p
r1 (out w_7) r=750
Ib  bias  gnd   dc=5u
.ends



.subckt opamp_kik vdd vss vip vin vo
*NAME  D    G     S     B      MODEL    FEATURE SIZE
*--------------------------------------------------
M1     v1   vip   v3    vss    pmos     w=w1   l=lmin
M2     v1   vin   v4    vss    pmos     w=w2   l=lmin
M3     v3   v3    vss   vdd    nmos     w=w3   l=lmin
M4     v4   v3    vss   vdd    nmos     w=w4   l=lmin
M5     vdd  v2    v1    vss    pmos     w=w5   l=lmin
M6     v0   v4    vss   vdd    nmos     w=w6   l=lmin
M7     vdd  v2    vo    vss    pmos     w=w7   l=lmin
M8     vdd  v2    v2    vss    pmos     w=w8   l=lmin

Ib     v2   gnd   6.7u
Rc     v4   v5    100
Cc     v5   vo    24u

*vb1 vbn 0 dc 1.2
*vb2 vbp 0 dc -1.2
*vd vdd 0 dc 1.2
*vg gnd 0 dc 0
.ends
