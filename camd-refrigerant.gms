SET i /CH3, CH2, CH, C, CH2db, CHdb, Cdb, Cdbdb, CHtb, Ctb, F, Cl, Br, I, OH, O, CO, CHO, COOH, COO, Odb, NH2, N, NH, Ndb, CN, SH, S/;
SET k / Tb, Tc, Pc, Hvap, Toxicity/;
SET c /Cp0a, Cp0b, Cp0c, Cp0d/;
SET l /Val, a, MW, SB, DB, TB/;

ALIAS (i,j);

INTEGER VARIABLES
n(i) Number of functional groups in molecule
Zsb 
Zdb
Ztb
;

VARIABLES
Alpha 'Alpha'
Beta 'Beta'
G 'Parameter G in RPM'
h 'Parameter h in RPM'
IV1 'Intermediate variable 1 for alpha'
IV2 'Intermediate variable 2 for alpha' 
IV3 'Intermediate variable 3 for alpha and beta'
IV4 'Intermediate variable 4 for beta' 
IV5 'Intermediate variable 5 for liquid heat capacity'
IV6 'Intermediate variable 6 for liquid heat capacity'
IV7 'Intermediate variable 7 for liquid heat capacity'
IV8 'Intermediate variable 8 for heat of vaporisation at evaporating temperature'
IV9 'Intermediate variable 9 for RPM'
IV10 'Intermediate variable 10 for RPM'
IV11 'Intermediate variable 11 for RPM'
IV12 'Intermediate variable 12 for toxicity'
kP 'Parameter k in RPM'
LC50 'LC50 level'
Omega 'Acentric factor'
z 'Objective function to be maximised'
;

POSITIVE VARIABLES
Cpl 'Liquid heat capacity of molecule [J/(mol.K)]'
Cp0 'Ideal Gas Heat Capacity of a molecule [J/(mol.K)]'
Hvapboil 'Heat of vaporization at boiling temperature [kJ/mol]'
Hvapevap 'Heat of vaporisation at evaporating temperature [kJ/mol]'
MWeight 'Molecular weight [g/mol]'
Pcrit 'Critical pressure [bar]'
Pvpc 'Vapor pressure at condensing temperature [bar]'
Pvpcr 'Reduced vapor pressure at condensing temperature [bar]'
Pvpe 'Vapor pressure at evaporating temperature [bar]'
Pvper 'Reduced vapor pressure at evaporating temperature [bar]'
Tavgr 'Reduced average temperature [K]'
Tbr 'Reduced boiling temperature [K]'
Tboil 'Boiling temperature [K]'
Tcrit 'Critical temperature [K]'
Tcndr 'Reduced condensing temperature [K]'
Tevpr 'Reduced evaporating temperaure [K]'
;

Binary Variable
Ysdx '1 if groups with both single and double bonds are present, 0 otherwise'
Ysdy '1 if groups with only single bonds are present, 0 otherwise'
Ysdz '1 if groups with only double bonds are present, 0 otherwise'
Yh '1 if higher-bonded groups are present, 0 otherwise'
;


TABLE 
GC(i,k) 'Group contribution for functional group i'
	Tb	Tc	Pc	Hvap	Toxicity
 CH3	23.58	0.0141	-0.0012	2.373	0.6172
 CH2	22.88	0.0189	0.0000	2.226	0.4464
 CH	21.74	0.0164	0.0020	1.691	0.1522
 C	18.25	0.0067	0.0043	0.636	-0.1861
 CH2db	18.18	0.0113	-0.0028	1.724	0.0000
 CHdb	24.96	0.0129	-0.0006	2.205	0.0000
 Cdb	24.14	0.0117	0.0011	2.138	0.0000
 Cdbdb	26.15	0.0026	0.0028	2.661	0.0000
 CHtb	9.20	0.0027	-0.0008	1.155	0.0000
 Ctb	27.38	0.0020	0.0016	3.302	0.0000
 F      -0.03	0.0111	-0.0057	-0.6700	1.152	
 Cl	38.13	0.0105	-0.0049	4.532	0.8970
 Br	66.86	0.0133	0.0057	6.582	1.7817
 I	93.84	0.0068	-0.0034	9.520	0.0000
 OH	92.88	0.0741	0.0112	16.826	-0.2125
 O	22.42	0.0168	0.0015	2.410	-0.2392
 CO	76.75	0.0380	0.0031	8.972	0.0004
 CHO	72.24	0.0379	0.0030	9.093	2.5539
 COOH	169.09	0.0791	0.0077	19.537	2.2621
 COO	81.10	0.0481	0.0005	9.633	0.9461
 Odb	-10.50	0.0143	0.0101	5.909	0.0000
 NH2	73.23	0.0243	0.0109	10.788	0.5110
 NH	50.17	0.0295	0.0077	6.436	-0.1157
 N	11.74	0.0169	0.0074	1.896	-0.7043
 Ndb    74.60	0.0255	-0.0099	3.3350	-0.222
 CN	125.66	0.0496	-0.0101	12.851	0.6447
 SH	63.56	0.0031	0.0084	6.884	0.0000
 S	68.78	0.0119	0.0049	6.817	0.0000
 ;

TABLE
Cp(i,c) 'Ideal gas heat capacity parameters for functional group i'
	Cp0a	        Cp0b	        Cp0c	        Cp0d
 CH3	1.95E+01	-8.08E-03	1.53E-04	-9.67E-08
 CH2	-9.09E-01	9.50E-02	-5.44E-05	1.19E-08
 CH	-2.30E+01	2.04E-01	-2.65E-04	1.20E-07
 C	-6.62E+01	4.27E-01	-6.41E-04	3.01E-07
 CH2db	2.36E+01	-3.81E-02	1.72E-04	-1.03E-07
 CHdb	-8	        1.05E-01	-9.63E-05	3.56E-08
 Cdb	-2.81E+01	2.08E-01	-3.06E-04	1.46E-07
 Cdbdb	2.74E+01	-5.57E-02	1.01E-04	-5.02E-08
 CHtb	2.45E+01	-2.71E-02	1.11E-04	-6.78E-08
 Ctb	7.87	         2.01E-02	-8.33E-06	1.39E-09
 F	2.65E+01	-9.13E-02	1.91E-04	-1.03E-07
 Cl	3.33E+01	-9.63E-02	1.87E-04	-9.96E-08
 Br	2.86E+01	-6.49E-02	1.36E-04	-7.45E-08
 I	3.21E+01	-6.41E-02	1.26E-04	-6.87E-08
 OH	2.57E+01	-6.91E-02	1.77E-04	-9.88E-08
 O	2.55E+01	-6.32E-02	1.11E-04	-5.48E-08
 CO	6.45	        6.70E-02	-3.57E-05	2.86E-09
 CHO	3.09E+01	-3.36E-02	1.60E-04	-9.88E-08
 COOH	2.41E+01	4.27E-02	8.04E-05	-6.87E-08
 COO	2.45E+01	4.02E-02	4.02E-05	-4.52E-08
 Odb	6.82	        1.96E-02	1.27E-05	-1.78E-08
 NH2	2.69E+01	-4.12E-02	1.64E-04	-9.76E-08
 NH	-1.21	        7.62E-02	-4.86E-05	1.05E-08
 N	-3.11E+01	2.27E-01	-3.20E-04	1.46E-07
 Ndb    0               0               0               0
 CN	3.65E+01	-7.33E-02	1.84E-04	-1.03E-07
 SH	3.53E+01	-7.58E-02	1.85E-04	-1.03E-07
 S	1.96E+01	-5.61E-03	4.02E-05	-2.76E-08
;

TABLE
P(i,l) 'Specific parameters for functional group i'
	Val	a	MW	SB	DB	TB
 CH3	1	4	15.021	1	0	0
 CH2	2	3	14.014	2	0	0
 CH	3	2	13.007	3	0	0
 C	4	1	12	4	0	0
 CH2db	1	3	14.014	0	1	0
 CHdb	2	2	13.007	1	1	0
 Cdb	3	1	12	2	1	0
 Cdbdb	2	1	12	0	2	0
 CHtb	1 	2	13.007	0	0	1
 Ctb	2	1	12	1	0	1
 F	1	1	18.998	1	0	0
 Cl	1	1	34.968	1	0	0
 Br	1	1	78.918	1	0	0
 I	1	1	126.904	1	0	0
 OH	1	2	17.001	1	0	0
 O	2	1	15.994	2	0	0
 CO	2	2	27.994	2	0	0
 CHO	1	3	29.001	1	0	0
 COOH	1	4	44.995	1	0	0
 COO	2	3	43.988	2	0	0
 Odb	1	1	15.994	0	1	0
 NH2	1	3	16.017	1	0	0
 NH	2	2	15.01	2	0	0
 N	3	1	14.003	3	0	0
 Ndb	2	1	14.003	1	1	0
 CN	1	2	26.003	1	0	0
 SH	1	2	33.107	1	0	0
 S	2	1	32.1	2	0	0
;

Parameters
CplR134a 'Liquid heat capacity of R134a [J/(mol.K)]'          /143.14 /
hvapR134a 'Ideal gas heat of vaporisation of R134a [kJ/mol]'  /20.249 /
Nmaximum 'Maximum number of functional groups in a molecule' / 10/
Tavg   'Average process temperature [K]'  / 294/
Tcond  'Condensing temperature [K]'       / 316/ 
Tevap  'Evaporating temperature [K]'      / 272/
;

*Variable bounds
n.lo(i) = 0;
Zdb.lo = 0;
Ztb.lo = 0;
CpL.lo = 0.000001;
Tbr.up = 1;
Tavgr.up = 1;
Tcndr.up = 1;
Tevpr.up = 1;
Pvpcr.up = 1;
Pvper.up = 1;
z.up = 1;
Alpha.lo = -5.4;
Alpha.up = 6100;
n.up('Odb') = 1;
Beta.lo = -16000;
Beta.up = 0;
Hvapboil.lo = 10;
Hvapboil.up = 110;
Hvapevap.lo = 18.4;
Hvapevap.up = 100;
Omega.lo = -1;
Omega.up = 1.3;
Cp0.lo = 1;
Cp0.up = 135;
Tboil.lo = 50;
Tboil.up = 1000;
n.up('Cdbdb')=1;

Equations
Boiltemp1
Crittemp2
Critpre3
Cp04
Hvapboil5
ReducedT6
ReducedTavg7
ReducedTcnd8
ReducedTevp9
Alpha10a, Alpha10b, Alpha10c, Alpha10
Beta11a, Beta11
Omega12
Cpl13a, Cpl13b, Cpl13c, Cpl13
Hvapevap14a, Hvapevap14
Parameterh15
ParameterG16
Parameterk17a, Parameterk17
ReducedPvpc18a, ReducedPvpc18
ReducedPvpe19a, ReducedPvpe19
Pvpc20
Pvpe21
Toxicity22a,Toxicity22,Toxicity23a,Toxicity23
ni24a
ni24b
rule25
transitionSDx26a, transitionSDx26b
transitionSDy27a, transitionSDy27b
transitionSDz28a, transitionSDz28b
Transition29
singlebond30
doublebond31
triplebond32
octet33
octet34(i)
HalideAmine35
SatBond36
ethertransition37
NSC38
NSC39
NSC40
NSC41
NSC42
Process43
Process44
Process45
Process46
Process47a, Process47b
obj
;

*Group contribution calculations for boiling temperature, critical temperature, critical pressure and ideal gas heat capacity (Joback)
Boiltemp1..        Tboil =e= 198.2 + sum(i,n(i)*GC(i,'Tb'));
Crittemp2..        Tcrit*(0.584+0.965*sum(i,n(i)*GC(i,'Tc'))- power((sum(i,n(i)*GC(i,'Tc'))),2)) =e= Tboil;
Critpre3..         Pcrit*power((0.113 + 0.0032*sum(i,n(i)*P(i,'a')) - sum(i,n(i)*GC(i,'Pc'))),2) =e= 1;
Cp04..             Cp0 =e= sum(i,n(i)*Cp(i,'Cp0a'))-37.93 +
                   (sum(i,n(i)*Cp(i,'Cp0b'))+0.21)*Tavg+ power(Tavg,2)*(sum(i,n(i)*Cp(i,'Cp0c'))-3.91E-4) + power(Tavg,3)*(sum(i,n(i)*Cp(i,'Cp0d'))+2.06E-7);
Hvapboil5..        Hvapboil =e= 15.3 + sum(i,n(i)*GC(i,'Hvap'));

*Reduced temperature calculations (Joback)                           
ReducedT6..         Tbr*Tcrit =e= Tboil;
ReducedTavg7..      Tavgr*Tcrit =e= Tavg;
ReducedTcnd8..      Tcndr*Tcrit =e= Tcond;
ReducedTevp9..      Tevpr*Tcrit =e= Tevap;

*Acentric factor equations
Alpha10a..      exp(IV1) =e= (Pcrit/1.013);
Alpha10b..      IV2*Tbr =e= 6.09648;
Alpha10c..      exp(IV3) =e= Tbr;
Alpha10..       Alpha =e= -5.97214 - IV1 + IV2 + 1.28862*IV3 - 0.169347*power(Tbr,6);
Beta11a..       IV4*Tbr =e= 15.6875;
Beta11..        Beta =e= 15.2518 - IV4 - 13.4721*IV3 + 0.43577*power(Tbr,6);
Omega12..       Omega*Beta =e= Alpha;

*Liquid heat capacity calculation (Rowlinson's modificaition of Bondi's equation)
Cpl13a..       IV5*(1-Tavgr) =e= 0.45;
Cpl13b..       IV6*Tavgr =e= rpower((1-Tavgr),(1/3));
Cpl13c..       IV7*(1-Tavgr) =e= 1.742;
Cpl13..        Cpl =e= Cp0 + 8.314*(1.45+IV5+0.25*omega*(17.11+25.2*IV6+IV7));

*Heat of vaporization at evaporating temperature (Watson's method) 
Hvapevap14a..   IV8*(1-Tbr) =e= 1-Tevpr;
Hvapevap14..    Hvapevap =e= Hvapboil*rpower(IV8,0.38);

*Vapor pressure calculations (Riedel-Plank-Miller)
Parameterh15..      h*(1-Tbr) =e= Tbr*IV1;
ParameterG16..      G =e= 0.4835 + 0.4605*h;
Parameterk17a..     IV9*G =e= h;
Parameterk17..      kP*(3+Tbr)*power((1-Tbr),2) =e= IV9-(1+Tbr);
ReducedPvpc18a..    exp(IV10) =e= Pvpcr;
ReducedPvpc18..     Tcndr*IV10 =e= -G*(1-power(Tcndr,2)+kP*(3+Tcndr)*power((1-Tcndr),3));
ReducedPvpe19a..    exp(IV11) =e= Pvper;
ReducedPvpe19..     Tevpr*IV11 =e= -G*(1-power(Tevpr,2)+kP*(3+Tevpr)*power((1-Tevpr),3));
Pvpc20..            Pvpc =e= Pvpcr*Pcrit;
Pvpe21..            Pvpe =e= Pvper*Pcrit;

*Safety Constraints
Toxicity22a..       IV12 =e= sum(i,n(i)*GC(i,'Toxicity'));
Toxicity22..        LC50*rpower(10,IV12) =e= 1;
Toxicity23a..       MWeight =e= sum(i,n(i)*P(i,'MW'));
Toxicity23..        MWeight*LC50 =g= 0.01;

*Joback-Stephanopoulos structural constraints
ni24a ..              sum(i,n(i)) =g= 2;
ni24b ..              sum(i,n(i)) =l= Nmaximum;
rule25..              sum(i,n(i)*P(i,'Val')) =g= 2*(sum(i,n(i))-1);
transitionSDx26a..    n('Ndb') + n('CHdb') + n('Cdb') =l= Nmaximum*Ysdx;
transitionSDx26b..    n('Ndb') + n('CHdb') + n('Cdb') =g= Ysdx;
transitionSDy27a..    n('CH3') + n('CH2') + n('CH') + n('C') + n('F') + n('Cl') + n('Br') + n('I') + n('OH') + n('O') + n('CO') +
                      n('CHO') + n('COOH') + n('COO') + n('NH2') + n('N') + n('NH') + n('CN') + n('SH') + n('S') =l= Nmaximum*Ysdy;
transitionSDy27b..    n('CH3') + n('CH2') + n('CH') + n('C') + n('F') + n('Cl') + n('Br') + n('I') + n('OH') +
                      n('O') + n('CO') + n('CHO') + n('COOH') + n('COO') + n('NH2') + n('N')+ n('NH') + n('CN') + n('SH') + n('S') =g= Ysdy;
transitionSDz28a..    n('CH2db') + n('Odb') =l= Nmaximum*Ysdz;
transitionSDz28b..    n('CH2db') + n('Odb') =g= Ysdz;
Transition29..        Ysdy + Ysdz - 1 =l= Ysdx;
singlebond30..        sum(i,n(i)*P(i,'SB')) =e= 2*Zsb;
doublebond31..        sum(i,n(i)*P(i,'DB')) =e= 2*Zdb;
triplebond32..        sum(i,n(i)*P(i,'TB')) =e= 2*Ztb;

*Octet rule structural constraints (Odele-Macchietto)
octet33..       sum(i,(2-P(i,'Val'))*n(i)) =e= 2;
octet34(i)..    sum(j,n(j)) =g= n(i)*(P(i,'Val')-1)+2;

*Additional constraints based on chemical insights
HalideAmine35..         n('F') + n('Cl') + n('Br') + n('I') + Nmaximum*(n('NH2') + n('NH') + n('N')) =l= Nmaximum;
SatBond36..             n('CH2db') + n('CHdb') + n('Cdb') +n('CHtb') + n('Ctb') =l= 2;
ethertransition37 ..    n("O") =L= 0.99*(n("CH3") + n("CH2") + n("CH") + n("C"));

*New structural constraint
NSC38..     n('CH2') + n('CHDB') + n('Ctb') + n('O') + n('CO') + n('COO') + n('NH') + n('Ndb') + n('S') + n('CH') + n('Cdb') + n('N') + n('C') + n('Cdbdb') =l= Nmaximum*Yh;
NSC39..     n('CH2') + n('CHDB') + n('Ctb') + n('O') + n('CO') + n('COO') + n('NH') + n('Ndb') + n('S') + n('CH') + n('Cdb') + n('N') + n('C') + n('Cdbdb')=g= Yh;
NSC40..     n('CH2')*P('CH2','SB') + n('CHDB')*P('CHDB','SB') + n('Ctb')*P('Ctb','SB') + n('O')*P('O','SB') + n('CO')*P('CO','SB') + n('COO')*P('COO','SB') + n('NH')*P('NH','SB') + n('Ndb')*P('Ndb','SB') + n('S')*P('S','SB') + n('CH')*P('CH','SB') + n('Cdb')*P('Cdb','SB') + n('N')*P('N','SB') + n('C')*P('C','SB') + n('Cdbdb')*P('Cdbdb','SB') + Nmaximum*(1-Yh) =g=
            n('CH3') + n('F') + n('Cl') + n('Br') + n('I') + n('OH') + n('CHO') + n('COOH') + n('NH2') + n('CN') + n('SH');
NSC41..     n('CH2')*P('CH2','DB') + n('CHDB')*P('CHDB','DB') + n('Ctb')*P('Ctb','DB') + n('O')*P('O','DB') + n('CO')*P('CO','DB') + n('COO')*P('COO','DB') + n('NH')*P('NH','DB') + n('Ndb')*P('Ndb','DB') + n('S')*P('S','DB') + n('CH')*P('CH','DB') + n('Cdb')*P('Cdb','DB') + n('N')*P('N','DB') + n('C')*P('C','DB') + n('Cdbdb')*P('Cdbdb','DB') + Nmaximum*(1-Yh) =g=
            n('CH2db') + n('Odb');
NSC42..     n('CH2')*P('CH2','SB') + n('CHDB')*P('CHDB','SB') + n('Ctb')*P('Ctb','SB') + n('O')*P('O','SB') + n('CO')*P('CO','SB') + n('COO')*P('COO','SB') + n('NH')*P('NH','SB') + n('Ndb')*P('Ndb','SB') + n('S')*P('S','SB') + n('CH')*P('CH','SB') + n('Cdb')*P('Cdb','SB') + n('N')*P('N','SB') + n('C')*P('C','SB') + n('Cdbdb')*P('Cdbdb','SB') +
            n('CH2')*P('CH2','DB') + n('CHDB')*P('CHDB','DB') + n('Ctb')*P('Ctb','DB') + n('O')*P('O','DB') + n('CO')*P('CO','DB') + n('COO')*P('COO','DB') + n('NH')*P('NH','DB') + n('Ndb')*P('Ndb','DB') + n('S')*P('S','DB') + n('CH')*P('CH','DB') + n('Cdb')*P('Cdb','DB') + n('N')*P('N','DB') + n('C')*P('C','DB') + n('Cdbdb')*P('Cdbdb','DB') -
            (n('CH3') + n('F') + n('Cl') + n('Br') + n('I') + n('OH') + n('CHO') + n('COOH') + n('NH2') + n('CN') + n('SH') + n('CH2db') + n('Odb')) =e=
            2*(n('CH2') + n('CHDB') + n('Ctb') + n('O') + n('CO') + n('COO') + n('NH') + n('Ndb') + n('S') + n('CH') + n('Cdb') + n('N') + n('C') + n('Cdbdb')-1);

*Process constraints
Process43..     Hvapevap =g= HvapR134a;
Process44..     Cpl =l= CplR134a;
Process45..     Pvpc =l= 14;
Process46..     Pvpe =g= 1.1;
Process47a..    Tcrit =l= 550;
Process47b..    Tcrit =g= 300;

*Objective function
obj.. z*Cpl =e= Hvapevap;

*Integer cut
Set iter /1*10/;
ALIAS (iter,cc);

Parameters
ZOPT(iter)
NOPT(iter,i)
TcritOPT(iter)
intcut(iter,i);

Equation
integercut(cc)
;

integercut(cc).. sum(i,abs(n(i)-intcut(cc,i))) =g= 1;

Model APO_Project_vFinal /all/;

option NLP = conopt;
option MIP = cplex;
option MINLP = BARON;
option optcr  = 0.000001;
option iterlim= 1000000;
option reslim = 1000000;

LOOP( iter, intcut(cc,i) $ (ORD(iter) =1) = no;      
           SOLVE APO_Project_vFinal using MINLP maximising z;
           ZOPT(iter) = z.L;
           NOPT(iter,i) = n.L(i);
           TcritOPT(iter) = Tcrit.L;
           intcut(iter,i)= n.L(i);               
         );

display
ZOPT, NOPT, TcritOPT;