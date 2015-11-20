* opamp testbench

*--------------------------------------------------------
* Header files an library definitions
* Includes the process library and the opamp netlist
*--------------------------------------------------------
.option post probe nomod dcon=1 ingold=2 numdgt=10 runlvl=4
* Set temperature of the simulation, for simulation of fast or slow corner, set it as 0 or 85 respectively
.TEMP 25
*.include p35_cmos_models_tt.inc
*.include opamp_subcircuit.sp
.include ptm65.lib
.include opamp_2s_fc_opt.sp

*--------------------------------------------------------
* Simulation Parameters
*--------------------------------------------------------
.param vdd_v=2					       * Supply Voltage Value, for fast condition, change it to 2.2, and for slow condition, change it to 1.8
.param vss_v=0
.param vin_cm='0.5*vdd_v'		   * Common-mode Voltage
.param vin_low='0.375*vdd_v'   * Input step voltages
.param vin_high='0.625*vdd_v'
.param period=1e-6			     * Square wave period
.param risetime=1e-9			     * Transition time (rising edge)
.param falltime=1e-9			     * Transition time (falling edge)

*--------------------------------------------------------
* Supply Voltages
*--------------------------------------------------------
vdd_ac vdd_ac 0 vdd_v
vss_ac vss_ac 0 vss_v
vdd_tr1 vdd_tr1 0 vdd_v
vdd_tr2 vdd_tr2 0 vdd_v
vss_tr1 vss_tr1 0 vss_v
vss_tr2 vss_tr2 0 vss_v
vgnd gnd 0 0

*--------------------------------------------------------
* Subcircuit instantiation for frequency analysis
*--------------------------------------------------------
xac vdd_ac  vss_ac vin_ac+  vin_ac-  vo_ac  opamp
e+  vin_ac+  101 100 0 vdd_v
e-  vin_ac-  102 100 0 vss_v
voff_ac  101 102 dc=0
vcm_ac 102 vss_ac dc=1
vs_ac  100 0 dc=0  ac=1
*cl_ac  vo_ac  0 5p

*--------------------------------------------------------
* Subcircuit instantiation for transient analysis
*--------------------------------------------------------

xtr1 vdd_tr1  vss_tr1  vi_tr1 vo_tr1  vo_tr1  opamp
xtr2 vdd_tr2  vss_tr2  vi_tr2 vo_tr2  vo_tr2  opamp
cl_tr1 vo_tr1 0 5p
cl_tr2 vo_tr2 0 5p
*vpulse_tr1 vi_tr1 0 pwl(0 0 1n 0.5 500n 0.5 500.1n 0)
*vpulse_tr2 vi_tr2 0 pwl(0 0 1n 0.5 500n 0.5 500.1n 0)
vpulse1 vi_tr1 0 pulse (vin_low vin_high 0 risetime falltime 'period/2-risetime' period)
vpulse2 vi_tr2 0 pulse (vin_high vin_low 0 risetime falltime 'period/2-risetime' period)

*xac vdd_ac  vss_ac vin_ac+  vin_ac-  vo_ac  opamp
*.subckt opamp vdd vss vin+ vin- vo
*xtr1 vdd_tr1 vss_tr1 vin_tr+1 vo_tr1 vo_tr1  opamp
*xtr2 vdd_tr2 vss_tr2 vin_tr+2 vo_tr2 vo_tr2  opamp
**xtr1 vin_tr+1 vo_tr1 vo_tr1 vdd_tr1 vss_tr1 opamp
**xtr2 vin_tr+2 vo_tr2 vo_tr2 vdd_tr2 vss_tr2 opamp
*vpulse1 vin_tr+1 vss_tr1 pulse (vin_low vin_high 0 risetime falltime 'period/2-risetime' period)
*vpulse2 vin_tr+2 vss_tr2 pulse (vin_high vin_low 0 risetime falltime 'period/2-risetime' period)
*.probe  v(vo_tr1) v(vo_tr2) v(vin_tr+1) v(vin_tr+2)
*.trans 'period/10000' 'period/2-risetime'



*--------------------------------------------------------
* DC analysis & measurement
*--------------------------------------------------------
.dc vs_ac  -100m 100m  0.1m
.tf v(vo_ac) vs_ac
.probe  v(vo_ac)
.op

*--------------------------------------------------------
* AC analysis & measurement
*--------------------------------------------------------
.ac dec 100 1m 1000g
.probe ac vdb(vo_ac) vp(vo_ac)
.pz v(vo_ac) vs_ac

.meas ac GAIN max vdb(vo_ac) from=1 to=1000g                                    *  Open-loop Gain
.meas ac UGF when vdb(vo_ac)=0                                                  *  Unity-gain Frequency
.measure ac min_phase MIN vp(vo_ac) from=1 to=1000g                             * Minimum phase
.measure ac phase_shift find vp(vo_ac) when v(vo_ac) = 1                        * Phase shift
.measure ac phase_margin find  par('180+vp(vo_ac)') at=ugf                      * alternative measure for phase margin
.measure ac phase_margin_alt param='180 + phase_shift'                          * alternative measure for phase margin
.meas ac GM find par('abs(vdb(vo_ac))') when vp(vo_ac)=-179                     * Gain Margin
.measure ac first_pole when vp(vo_ac)=-4
.measure ac second_pole when vp(vo_ac)=-135


*--------------------------------------------------------
* Transient analysis & measurement
*--------------------------------------------------------
*.trans 0.1n 1u
.trans 'period/10000' 'period/2-risetime'
.probe v(vi_tr1) v(vo_tr1) v(vi_tr2) v(vo_tr2)
.meas Power avg par('abs((i(vdd_tr1)+i(vdd_tr2))*vdd_v/2)') from=0 to='period/2-risetime'				$ Measure Power consumption 	(Power) 	(W)
.meas HiVolt find v(vo_tr1) at='period/2-risetime'													$ Measure the final voltage of output (high)
.meas LoVolt find v(vo_tr2) at='period/2-risetime'													$ Measure the final voltage of output (low)
.meas RiseStart when v(vo_tr1)='LoVolt+0.1*(HiVolt-LoVolt)' rise=1									$ Measure when does output start rising across 10% of (HiVolt-LoVolt)
.meas RiseStop 	when v(vo_tr1)='LoVolt+0.9*(HiVolt-LoVolt)' rise=1									$ Measure when does output stop rising across 90% of (HiVolt-LoVolt)
.meas FallStart when v(vo_tr2)='HiVolt-0.1*(HiVolt-LoVolt)' fall=1									$ Measure when does output start falling across 10% of (HiVolt-LoVolt)
.meas FallStop 	when v(vo_tr2)='HiVolt-0.9*(HiVolt-LoVolt)' fall=1									$ Measure when does output stop falling across 90% of (HiVolt-LoVolt)
.meas SR_Rise param='abs(0.8*(HiVolt-LoVolt)*1e-6/(RiseStop-RiseStart))'							$ Calculate Slew-rate (rising edge) 	(V/us)
.meas SR_Fall param='abs(0.8*(HiVolt-LoVolt)*1e-6/(FallStop-FallStart))'							$ Calculate Slew-rate (falling edge)	(V/us)
.meas CrossT_Rise when v(vo_tr1)='HiVolt+0.01*(HiVolt-LoVolt)' cross=last 							$ Measure when does output entering the error band from the top (rising edge)
.meas CrossB_Rise when v(vo_tr1)='HiVolt-0.01*(HiVolt-LoVolt)' cross=last 							$ Measure when does output entering the error band from the bottom (rising edge)
.meas CrossT_Fall when v(vo_tr2)='LoVolt+0.01*(HiVolt-LoVolt)' cross=last 							$ Measure when does output entering the error band from the top (falling edge)
.meas CrossB_Fall when v(vo_tr2)='LoVolt-0.01*(HiVolt-LoVolt)' cross=last 							$ Measure when does output entering the error band from the bottom (falling edge)
.meas Ts_Rise param='max(CrossT_Rise,CrossB_Rise)*1e6'												$ The maximum of CrossT_Rise and CrossB_Rise are defined as the settling time of 1% tolerance for rising edge 	(Unit: us)
.meas Ts_Fall param='max(CrossT_Fall,CrossB_Fall)*1e6'												$ The maximum of CrossT_Fall and CrossB_Fall are defined as the settling time of 1% tolerance for falling edge	(Unit: us)

.end
