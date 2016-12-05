RBAC
====

  access
  ------
  https://10.0.7.55:8445/


NAMING SERVICE
==============

  access
  ------
  http://10.0.7.55:8080/names/

  discs_names dump
  ----------------
  - ssh lnls82-linux
  - docker -exec -it naming-service-postgres bash
  - FNAME=discs_names_$(date "+%Y%m%d").sql
  - pg_dump --username postgres discs_names > ${FNAME}
  - echo "nameserver 10.0.0.71" >> /etc/resolv.conf
  - apt-get update; apt-get install openssh-client
  - scp -p ${FNAME} ximenes@10.0.21.122:


CCDB
====

access: http://10.0.7.55:8083/

a site for abbriviation suggestions:

http://www.abbreviations.com/abbreviation/sample

Abbreviation Tables

Device Names

3PW     3-Pole Wiggler 
Anode   anode
AcStr   Accelerator Structure
B       Electron beam
BAKJ    bakeout heating jackets
Bend    Dipole (magnet)
BLW     non-rf bellows
BLWR    rf shielded bellows
BMPS    Bending Magnet Photon Shutter
BPM     Beam Position Monitor
CCG     Old cathode vacuum gauge
CRL     Compound Refractive Lens
Dig     Digitizer
Door    Door
DW      Damping Wiggler
EPU     Elliptically Polarizing Undulator
FOFB    Fast Orbit Feedback
EGun    Electron gun
GV      gate valve (may be used for FE and
H       Horizontal...
CH      Horizontal corrector magnet
CHF     Fast horizontal corrector magnet
IOC     EPICS IOC
IP      sputter ion pump
IPC     ion pump controller
IVU     In-Vacuum Undulator
Li      Linac
Mark    Placeholder position for calculations
Modltr  Modulator
Mtr     Motor
NEG     non-evaporable getter pump
NEGC    NEG pump controller
NSW     Network Switch
Panel   HMI Panel
PLC     Programmable Logic Controller
PRV     Pressure relief valve
PS      Power supply
QD      Defocusing Quadrupole
QF      Focusing Quadrupole
RGA     residual gas analyzer / partial
Scan    Scan (for experiment control)
Scrap   Scrapper
Solnd   Solenoid
SQuad   Skew quadrupole
Sext    Sextupole magnet
SOFB    Slow Orbit Feedback
TCG     thermal conductivity vacuum gauge
TMP     turbomolecular pump and
TSP     titanium sublimation pump
TSPC    titanium sublimation pump
TSrv    Terminal server
V       Vertical...
CV      Vertical corrector magnet
CVF     Fast Vertical corrector magnet
VF      Visual Flag
VFD     Variable Frequency Drive
VGC     vacuum gauge controller


Signal Elements

Addr    Address
Alrm    Alarm
Alpha   Alpha (physics calc)
Ampl    Amplitude
Beta    Beta (physics calc)
Btn     Button
Chan    Channel
Cmd     Command
Cnt     Count/number
DI      Digital input
Dir     Direction
Div     Divider
DO      Digital output
Dsbl    Disable
Dose    Accumulated Radiation Dose
E       Voltage
EG      Electron Gun
Emit    Emittance (physics calc)
Enbl    Enable
EStop   Emergency Stop
EU      Engineering Units
Evt     Event
Excit   Excitation
F       Flow
Fld     Field (magnetic)
Flt     Fault
Freq    Frequency
Gen     Generator
ID      Indentifier (e.g. serial number)
In      Input (e.g., from PLC)
Ind     Indicator (e.g. lamp, light, LED)
Inh     Inhibit
Intlck  Interlock
L       Level
Lck     Lock
Lim     Limit
Mark    Mark (position indicatore)
Mode    Mode
Monit   Monitor
Offset  Offset
Out     Output (e.g., from PLC)
P       Pressure
Permit  Permit
Phs     Phase
Pol     Polarity
Pos     Position
Pwr     Power
Rdy     Ready
Rx      Receiver
RB      Readback
Req     Request
Res     Resolution
RH      Relative humidity
Rslt    Result
Rslv    Resolver
Rsrv    Reserved
Rst     Reset
S       Speed
SP      Setpoint
Src     Source
Sig     Signal
Siren   Alarm siren
Size    Size
Slope   Slope
Slot    Slot
Step    Step
Sw      Switch
T       Temperature
Tbl     Table
Time    Time
Tx      Transmitter
Trig    Trigger
Trip    Interlock trip
Type    Type (of device)
Undo    Undo
Ver     Version
Volt    Voltage
W       Weight or Force
Wfm     Waveform
X       Horizontal
Y       Vertical
Z       Longitudinal

General

Acc     Accelerator
BbB     bunch-by-bunch
Dev     Device
Eje     Ejection | Extraction
Err     Error
Fam     Family
Glob    Global
Inj     Injection
Kicker  Kicker
MultB   Multi bunch
Nr      Number
Resp    Response
Sept    Septum
SingB   Single bunch
Struct  Structure
Op      Operation
Ref     Reference
Spl     Sample(s)
Strth   Strength
Tn      Thin
Tk      Thick

Tactic rules:

- Devices should use H/V for Horizontal/Vertical prefix (HCor), while signals should use X/Y
postgres
========

- psql --username postgres
- \list
- \q




REST interface to NS
====================
http://10.0.7.55:8080/names/rest/deviceNames
http://10.0.7.55:8080/names/rest/deviceNames/2f37d00a-49c0-4f85-9d7b-d8dba49422a1


REST interface to CCDB
======================
http://10.0.7.55:8083/rest/deviceTypes
http://10.0.7.55:8083/rest/deviceTypes/RFLLAmpLC
http://10.0.7.55:8083/rest/slots
http://10.0.7.55:8083/rest/slots/SI-02C1:PS-Q1

http://server/ccdb/rest/slot/<slotName>/download/<fileName>
http://10.0.7.55:8083/rest/slots?deviceType=QuadrupolePS
http://10.0.7.55:8083/rest/slotNames
http://10.0.7.55:8083/rest/slotNames?deviceType=QuadrupolePS



How to backup DISCS databases
=============================

01. ssh linux82-linux
02. cd /home/fac_files/discs-management
03. ./discs-run.sh backup
04. scp -rp  backup-discs/*$(date "+%Y%m%d").gz fernando-linux:/home/fac_files/backup-discs/
