7even things we need to know about the domain
Class
Domain
Label
Topic
Structure
Purpose
Location

DM domain- Demographic Domain *most imp
Class			: special purpose domain
Domain			: DM
Label			: Demographics 
Topic			: SUBJID
Structure		: one record per subject
Purpose			: tabulation
Location		: dm.xpt

Variables :

StudyID : study identifier
			Char REQ identifier from protocol
Domain: Domain Abbreviation "DM"
		Char REQ Identifier from CT===>Assign(i shd)
USUBJID: Unique Subject Identifier
		Char REQ Identifier
USUBJID=STRIP(STUDY)||"-"||STRIP(SITE)||"-"||STRIP(PUT(SUBJECT,8.));			

RFSTDTC  : Treatment start date
RFENTDTC :Treatment end date

SiteID:	 Study Site Identifier
		Char REQ variable REcord from CRF

INVID : Investigator ID
		Char permissable variable Record
site id is nothing but investigator id, if both are same then no need to take
invid as variable

INVNAM : Name of the Investigator
		Char Perm Synonym

BRTHDTC : Date/Time Of Birth
			Char Record Permissable

AGE: Age
	num record expected variable

AGEU: Age Units
	Years  Char variable Exp


DMDTC **very imp

DMDTC is date from or before of RFSTDTC i.e permissiable variable
	-2 	-1		1		2 	3	4
----20---21------23-----24--25---26
				RFSTDTC(23)
				TRT startdate
					
if DMDTC GE(greater thanequal) RFSTDTC then DMDY=(DMDTC-RFSTDTC)+1;
else if DMDTC Less than RFSTDTC then DMDY=(DMDTC-RFSTDTC);

data check;
RFSTDTC="01JAN2022"D;
DMDTC="30MAY2022"D;
if DMDTC GE RFSTDTC then DMDY=(DMDTC-RFSTDTC)+1;
else if DMDTC le RFSTDTC then DMDY=(DMDTC-RFSTDTC);
format RFSTDTC DMDTC date9.;
run;

proc print data=check;run;

page62-DM 

DM Domain

Special purpose
DM
Demographic
Subjid
One Record Per Subject


StudyID Char 	Req 	Ident
Domain 	CHar	Req 	Identi
UsubjID Char 	Req 	ident
Subjid 	Char 	Req 	Topic

RFSTDTC Char Req Record
RFENDTC Char Req Record

SiteID 	Char 	Req 	Record
INVID	Char 	Perm 	Record
Invnam 	Char 	Perm 	Synonym

Brthdtc Char 	Perm 	Record
Age 	Num 	Exp 	Record
AGEU 	Char 	Exp 	Variable
Sex 	Char 	Req 	Record
Race 	Char 	Exp 	Record
Ethnic 	Char 	Perm 	Record
ARMCD 	Char 	Req 	Record
ARM 	Char 	Req 	SYnonym
Country Char 	Req 	Record IS03166
DMDTC	Char	Perm	Timing
DMDY	NUM		Perm	Timing
SV	Char	Exp		Record
Note: Only, In Oncology study these values will be different, rest of the
domains it's same'.
RFXSTDTC/RFXENDTC:Start date of treament/end date of treament
RFSTDTC/RFSENDTC: Before the treament date/after the treatment date. 

SV	Char	Exp		Record
DTHDTC-----Date time of death
DTHFL=X(some date)
ACTARMCD
ACTARM


