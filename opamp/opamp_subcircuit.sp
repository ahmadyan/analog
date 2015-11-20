
.subckt opamp vdd vss vin+ vin- vo
*M
*-----------------------------------------------------
m01   3     vin+    2     vss     nmos   w=15u   l=1.2u   as='15u*1u' ad='15u*1u' ps='2*15u+2*1u' pd='2*15u+2*1u'
m02   vo    vin-    2     vss     nmos   w=15u   l=1.2u   as='15u*1u' ad='15u*1u' ps='2*15u+2*1u' pd='2*15u+2*1u'
m03   3     3       vdd   vdd     pmos   w=45u   l=1.2u   as='45u*1u' ad='45u*1u' ps='2*45u+2*1u' pd='2*45u+2*1u'
m04   vo    3       vdd   vdd     pmos   w=45u   l=1.2u   as='45u*1u' ad='45u*1u' ps='2*45u+2*1u' pd='2*45u+2*1u'
m05   1     1       vss   vss     nmos   w=15u   l=1.2u   as='15u*1u' ad='15u*1u' ps='2*15u+2*1u' pd='2*15u+2*1u'
m06   2     1       vss   vss     nmos   w=15u   l=1.2u   as='15u*1u' ad='15u*1u' ps='2*15u+2*1u' pd='2*15u+2*1u'
ib vdd 1 10u
.ends
