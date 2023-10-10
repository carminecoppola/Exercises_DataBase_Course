CREATE TABLE OGGETTO(
NOME						VARCHAR2(40),
CODICE_OGGETTO	CHAR(10) PRIMARY KEY,
PROVENIENZA 		VARCHAR2(40),
INGOMBRO				NUMBER
);

CREATE TABLE OPERA_D_ARTE(
AUTORE					VARCHAR2(100),
TIPO						VARCHAR2(30),
CODICE_OGGETTO	CHAR(10) PRIMARY KEY,
CONSTRAINT FK_CODICE_OGGETTO FOREIGN KEY (CODICE_OGGETTO) REFERENCES OGGETTO(CODICE_OGGETTO)
);

CREATE TABLE ANTIQUARIATO(
MATERIALE				VARCHAR2(50),
PERIODO_RIF			VARCHAR2(30),
CODICE_OGGETTO	CHAR(10) PRIMARY KEY,
CONSTRAINT FK_CODICE_OGGETTO2 FOREIGN KEY (CODICE_OGGETTO) REFERENCES OGGETTO(CODICE_OGGETTO)
);

CREATE TABLE ASTA(
ID_ASTA         CHAR(10) PRIMARY KEY,
RILANCIO_MIN		NUMBER,
PREZZO_BASE			NUMBER,
DATA_INIZIO			DATE NOT NULL,
DATA_FINE			  DATE NOT NULL,
CODICE_OGGETTO  CHAR(10),
CONSTRAINT FK_CODICE_OGGETTO3 FOREIGN KEY (CODICE_OGGETTO) REFERENCES OGGETTO(CODICE_OGGETTO) ON DELETE SET NULL
);


CREATE TABLE UTENTE(
LOGIN						VARCHAR2(30) PRIMARY KEY,
PASSWORD				VARCHAR2(20) NOT NULL,
NOME						VARCHAR2(30),
COGNOME					VARCHAR2(30)
);


CREATE TABLE RILANCIATA(
ID_ASTA					CHAR(10),
LOGIN						VARCHAR2(30),
PREZZO_RILANCIO NUMBER,
CONSTRAINT RILANCIATA_PK PRIMARY KEY(ID_ASTA,LOGIN,PREZZO_RILANCIO),
CONSTRAINT FK_ID_ASTA FOREIGN KEY (ID_ASTA) REFERENCES ASTA (ID_ASTA),
CONSTRAINT FK_LOGIN FOREIGN KEY (LOGIN) REFERENCES UTENTE(LOGIN)
);

CREATE TABLE VENDITA(
FATTURA					CHAR(10) PRIMARY KEY,
DATA_RICEZ_PAG  DATE,
TIPO_PAGAMENTO	VARCHAR2(20),
PREZZO_FINALE		NUMBER,
CF							VARCHAR2(16) NOT NULL,
VIA							VARCHAR2(30) NOT NULL,
CIVICO					NUMBER NOT NULL,
CAP							CHAR(5) NOT NULL,
CITTA						VARCHAR2(30) NOT NULL,
ID_ASTA					CHAR(10) NOT NULL,
CONSTRAINT FK_ID_ASTA2 FOREIGN KEY (ID_ASTA) REFERENCES ASTA (ID_ASTA)
);