-- Analyysi mind andmebaas
commit;

rollback;

select * from isiku_roll;

ALTER TABLE FIRMA
add kontakt_email varchar(100);

ALTER TABLE FIRMA
drop column kontakt_email;

-- Paringute loomine, igal paringul filtreeriv tingimus

-- yle yhe tabeli
select eesnimi, perenimi, telefoni_nr, email from ISIK where isikukood = 39305053525;

-- yle kahe tabeli

select ISIK.eesnimi, ISIK.perenimi, ISIK.telefoni_nr, ISIK.email, ISIKU_ROLL.nimetus
from ISIK, ISIKU_ROLL
where ISIK.isiku_roll_id = ISIKU_ROLL.isiku_roll_id and ISIKU_ROLL.nimetus = 'Töötaja'
order by perenimi;


-- yle kolme tabeli - leiame, mis lepinguga on seeotud firma ja kes on selle firma esindaja

select KLIENDILEPING.lepingu_nr, KLIENDILEPING.alates, KLIENDILEPING.kuni, ISIK.eesnimi, ISIK.perenimi, ISIK.telefoni_nr, ISIK.email, FIRMA.nimi
from KLIENDILEPING
join ISIK on KLIENDILEPING.isik_id = ISIK.isik_id 
join FIRMA on KLIENDILEPING.firma_ID = FIRMA.firma_ID
where KLIENDILEPING.kuni is NULL or KLIENDILEPING.kuni > TO_DATE('2024-12-31', 'YYYY-MM-DD');





-- Andmete sisestamine

-- ISIKU_ROLL
insert all
into ISIKU_ROLL (isiku_roll_id, nimetus) values (1, 'Töötaja')
into ISIKU_ROLL (isiku_roll_id, nimetus) values (2, 'Eraklient')
into ISIKU_ROLL (isiku_roll_id, nimetus) values (3, 'Firma esindaja')
into ISIKU_ROLL (isiku_roll_id, nimetus) values (4, 'Teadmata')
select * from dual;


-- Tabelisse ISIK
insert all
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (1, 1, 'Mari', 'Maasikas', '60305053524', 'J. Sütiste tee 20, 13411, Tallinn, Eesti', '56394438',  'mari.maasikas@gmail.com', TO_DATE('2003-05-05', 'YYYY-MM-DD'))
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (2, 1,  'Jaan', 'Kask', '39305053525', 'Sõpruse pst 13, 1310615, Tallinn, Eesti', '53032703',  'jaan.kask@gmail.com', TO_DATE('1993-05-05', 'YYYY-MM-DD'))
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (3, 2, 'Liis', 'Lille', '60305053526', NULL, NULL,  'liis.lille@gmail.com', TO_DATE('2003-05-05', 'YYYY-MM-DD'))
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (4, 2, 'Peeter', 'Puu', '50305053527',NULL, NULL,  'peeter.puu@gmail.com', TO_DATE('2003-05-05', 'YYYY-MM-DD'))
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (5, 3, 'Paul', 'Kask', '39605053527',NULL, NULL,  'paul.kask@gmail.com', TO_DATE('1996-05-05', 'YYYY-MM-DD'))
into ISIK (isik_id, isiku_roll_ID, eesnimi, perenimi, isikukood, aadress, telefoni_nr, email, synniaeg) values (6, 3, 'Mia', 'Lepik', '39205053527',NULL, NULL,  'mia.lepik@gmail.com', TO_DATE('1992-05-05', 'YYYY-MM-DD'))
select * from dual;

-- Tabelisse FIRMA

insert all
into FIRMA (firma_id, registri_nr, nimi, lyhinimi, aadress, kontakt_telefon, kontakt_email) values (1, '11165605', 'Vitalong OÜ', NULL, 'Retke tee 20, 13419, Tallinn, Eesti', '6032221', 'info@vitalong.ee')
into FIRMA (firma_id, registri_nr, nimi, lyhinimi, aadress, kontakt_telefon, kontakt_email) values (2, '22265605', 'Ida-Tallinna Keskhaigla', 'ITK', 'Ravi 18, 10119, Tallinn, Eesti', '6402900', 'info@itk.ee')
into FIRMA (firma_id, registri_nr, nimi, lyhinimi, aadress, kontakt_telefon, kontakt_email) values (3, '31185605', 'Osaühing Tallinna Perearstikeskus', NULL, 'Ehitajate tee 27, 14919, Tallinn, Eesti', '6032221', 'info@perearstikeskus.ee')
into FIRMA (firma_id, registri_nr, nimi, lyhinimi, aadress, kontakt_telefon, kontakt_email) values (4, '56165633', 'Paide Perearstikeskus', 'PPK', 'Lai 28b, Paide linn, Eesti', '6662221', 'info@ppk.ee')
select * from dual;


-- Tabelisse KLIENDILEPING

insert all
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (1, 5, 4, '202501041', TO_DATE('2025-01-01', 'YYYY-MM-DD'), NULL)
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (2, 1, NULL, '202201042', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL)
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (3, 2, NULL, '202001041', TO_DATE('2020-01-01', 'YYYY-MM-DD'), NULL)
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (4, 3, NULL, '201901041', TO_DATE('2019-01-01', 'YYYY-MM-DD'), NULL)
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (5, 4, NULL, '202101041', TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'))
into KLIENDILEPING (kliendileping_ID, isik_ID, firma_id, lepingu_nr, alates, kuni) values (6, 6, 3, '252501041', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-30', 'YYYY-MM-DD'))
select * from dual;



-- Loo koik tabelid

CREATE TABLE KLIENDILEPING(
	kliendileping_ID	INTEGER NOT NULL,
	isik_ID	INTEGER NOT NULL,
	firma_ID	INTEGER,
	lepingu_nr	VARCHAR(25) NOT NULL,
	alates	DATE NOT NULL,
	kuni	DATE,
	CONSTRAINT	pk_KLIENDILEPING PRIMARY KEY (kliendileping_ID)
);

CREATE TABLE KASUTAJAKONTO(
	kasutajakonto_ID	INTEGER NOT NULL,
	isik_ID	INTEGER NOT NULL,
	kliendileping_ID	INTEGER NOT NULL,
	kasutajanimi	VARCHAR(25) NOT NULL,
	parool	VARCHAR(25) NOT NULL,
	CONSTRAINT	pk_KASUTAJAKONTO PRIMARY KEY (kasutajakonto_ID)
);

CREATE TABLE ISIK(
	isik_ID	INTEGER NOT NULL,
	isiku_roll_ID	INTEGER NOT NULL  ,
	eesnimi	VARCHAR(25) NOT NULL,
	perenimi	VARCHAR(25) NOT NULL,
	isikukood	VARCHAR(11),
	aadress	VARCHAR(100),
	telefoni_nr	VARCHAR(20),
	email	VARCHAR(40),
	synniaeg	DATE,
	CONSTRAINT	pk_ISIK PRIMARY KEY (isik_ID)
);

CREATE TABLE FIRMA(
	firma_ID	INTEGER NOT NULL,
	registri_nr	VARCHAR(8) NOT NULL,
	nimi	VARCHAR(60) NOT NULL,
	lyhinimi	VARCHAR(8),
	aadress	VARCHAR(100),
	kontakt_telefon	VARCHAR(8) NOT NULL,
	kontakt_email	VARCHAR(8) NOT NULL,
	CONSTRAINT	pk_FIRMA PRIMARY KEY (firma_ID)
);


CREATE TABLE KASUTAJAK_ROLL(
	kasutajak_roll_ID	INTEGER NOT NULL,
	kasutajakonto_ID	INTEGER NOT NULL  ,
	roll_ID	INTEGER NOT NULL  ,
	alates	DATE NOT NULL,
	kuni	DATE NOT NULL,
	CONSTRAINT	pk_KASUTAJAK_ROLL PRIMARY KEY (kasutajak_roll_ID)
);

CREATE TABLE ROLL(
	roll_ID	INTEGER NOT NULL,
	nimetus	VARCHAR(25) NOT NULL,
	CONSTRAINT	pk_ROLL PRIMARY KEY (roll_ID)
);

CREATE TABLE ROLLI_TEGEVUS(
	rolli_tegevus_ID	INTEGER NOT NULL,
	roll_ID	INTEGER NOT NULL  ,
	tegevus_ID	INTEGER NOT NULL  ,
	alates	DATE NOT NULL,
	kuni	DATE,
	CONSTRAINT	pk_ROLLI_TEGEVUS PRIMARY KEY (rolli_tegevus_ID)
);

CREATE TABLE TEGEVUS(
	tegevus_ID	INTEGER NOT NULL,
	tegevus_ID_ylem	INTEGER,
	nimetus	VARCHAR(25) NOT NULL,
	kirjeldus	LONG VARCHAR,
	CONSTRAINT	pk_TEGEVUS PRIMARY KEY (tegevus_ID)
);

CREATE TABLE ERIHIND_KL_LEPINGUS(
	erihind_kl_lepingus_ID	INTEGER NOT NULL,
	kliendileping_ID	INTEGER NOT NULL  ,
	erihind_ID	INTEGER NOT NULL  ,
	alates	DATE NOT NULL,
	kuni	DATE,
	CONSTRAINT	pk_ERIHIND_KL_LEPINGUS PRIMARY KEY (erihind_kl_lepingus_ID)
);

CREATE TABLE ERIHIND(
	erihind_ID	INTEGER NOT NULL,
	kogus_alates	INTEGER NOT NULL,
	kogus_kuni	INTEGER,
	allahindluse_protsent	DECIMAL(8,2) NOT NULL,
	CONSTRAINT	pk_ERIHIND PRIMARY KEY (erihind_ID)
);

CREATE TABLE TELLIMUS(
	tellimuse_ID	INTEGER NOT NULL,
	kliendileping_ID	INTEGER NOT NULL  ,
	tellimuse_nr	VARCHAR(8) NOT NULL,
	summa_kmta	DECIMAL(8,2) NOT NULL,
	kaibemaks_kokku	DECIMAL(8,2) NOT NULL,
	summa_kokku	DECIMAL(8,2) NOT NULL,
	kuupaev	DATE NOT NULL,
	CONSTRAINT	pk_TELLIMUS PRIMARY KEY (tellimuse_ID)
);

CREATE TABLE TELLIMUSE_RIDA(
	tellimuse_rida_ID	INTEGER NOT NULL,
	tellimuse_ID	INTEGER NOT NULL  ,
	test_tellimuses_ID	INTEGER NOT NULL  ,
	kampaania_ID	INTEGER  ,
	erihind_kl_lepingus_ID	INTEGER  ,
	kogus	INTEGER NOT NULL,
	hind_kmta	DECIMAL(8,2),
	kaibemaks	DECIMAL(8,2) NOT NULL,
	hind_kmga	DECIMAL(8,2),
	CONSTRAINT	pk_TELLIMUSE_RIDA PRIMARY KEY (tellimuse_rida_ID)
);

CREATE TABLE TEST_TELLIMUSES(
	test_tellimuses_ID	INTEGER NOT NULL,
	test_ID	INTEGER NOT NULL  ,
	proov_ID	INTEGER NOT NULL  ,
	isik_ID_testi_teostaja	INTEGER  ,
	tulemus_ID	INTEGER  ,
	kuupaev	DATE,
	CONSTRAINT	pk_TEST_TELLIMUSES PRIMARY KEY (test_tellimuses_ID)
);

CREATE TABLE VAHEND(
	vahend_ID	INTEGER NOT NULL,
	vahendi_tyyp_ID	INTEGER NOT NULL  ,
	nimetus	VARCHAR(60) NOT NULL,
	LOT_nr	VARCHAR(20),
	saabumise_aeg	TIMESTAMP(8),
	karbi_nr	INTEGER,
	seadme_kood	VARCHAR(25),
	CONSTRAINT	pk_VAHEND PRIMARY KEY (vahend_ID)
);

CREATE TABLE PROOV(
	proov_ID	INTEGER NOT NULL,
	proovi_tyyp_ID	INTEGER NOT NULL  ,
	isik_ID_proovi_andja	INTEGER NOT NULL  ,
	isik_ID_proovi_votja	INTEGER NOT NULL  ,
	votmise_aeg	TIMESTAMP(8) NOT NULL,
	CONSTRAINT	pk_PROOV PRIMARY KEY (proov_ID)
);

CREATE TABLE TULEMUS(
	tulemus_ID	INTEGER NOT NULL,
	tulemus	VARCHAR(100) NOT NULL,
	CONSTRAINT	pk_TULEMUS PRIMARY KEY (tulemus_ID)
);

CREATE TABLE HIND(
	hind_ID	INTEGER NOT NULL,
	test_ID	INTEGER NOT NULL  ,
	kampaania_ID	INTEGER  ,
	erihind_kl_lepingus_ID	INTEGER  ,
	hind	DECIMAL(8,2) NOT NULL,
	valuuta	VARCHAR(10) NOT NULL,
	CONSTRAINT	pk_HIND PRIMARY KEY (hind_ID)
);

CREATE TABLE VAHENDI_TYYP(
	vahendi_tyyp_ID	INTEGER NOT NULL,
	tyybi_nimetus	VARCHAR(60) NOT NULL,
	CONSTRAINT	pk_VAHENDI_TYYP PRIMARY KEY (vahendi_tyyp_ID)
);

CREATE TABLE KASUTATUD_VAHEND(
	kasutatud_vahend_ID	INTEGER NOT NULL,
	test_tellimuses_ID	INTEGER NOT NULL  ,
	vahend_ID	INTEGER NOT NULL  ,
	kuupaev	DATE NOT NULL,
	CONSTRAINT	pk_KASUTATUD_VAHEND PRIMARY KEY (kasutatud_vahend_ID)
);

CREATE TABLE SEADE_PARANDUSES(
	seade_paranduses_ID	INTEGER NOT NULL,
	vahend_ID	INTEGER NOT NULL  ,
	alates	DATE NOT NULL,
	kuni	DATE,
	CONSTRAINT	pk_SEADE_PARANDUSES PRIMARY KEY (seade_paranduses_ID)
);

CREATE TABLE TEST(
	test_ID	INTEGER NOT NULL,
	nimetus	VARCHAR(60) NOT NULL,
	kirjeldus	LONG VARCHAR,
	CONSTRAINT	pk_TEST PRIMARY KEY (test_ID)
);


CREATE TABLE KAMPAANIA(
	kampaania_ID	INTEGER NOT NULL,
	test_ID	INTEGER NOT NULL  ,
	kampaania_nimi	VARCHAR(8) NOT NULL,
	allahindluse_protsent	DECIMAL(8,2) NOT NULL,
	algus	DATE NOT NULL,
	lopp	DATE NOT NULL,
	CONSTRAINT	pk_KAMPAANIA PRIMARY KEY (kampaania_ID)
);

CREATE TABLE ISIKU_ROLL(
	isiku_roll_ID	INTEGER NOT NULL,
	nimetus	VARCHAR(25) NOT NULL,
	CONSTRAINT	pk_ISIKU_ROLL PRIMARY KEY (isiku_roll_ID)
);

CREATE TABLE PROOVI_TYYP(
	proovi_tyyp_ID	INTEGER NOT NULL,
	nimetus	VARCHAR(25) NOT NULL,
	sailitustngmsd VARCHAR(100) NOT NULL,
	kirjedus	LONG VARCHAR,
	CONSTRAINT	pk_PROOVI_TYYP PRIMARY KEY (proovi_tyyp_ID)
);


-- Foreign key-de määramine

-- KLIENDILEPING
alter table KLIENDILEPING add constraint fk_ISIK_KL foreign key (isik_id) references ISIK (isik_id);
alter table KLIENDILEPING add constraint fk_FIRMA_KL foreign key (firma_ID) references FIRMA (firma_ID);

-- KASUTAJAKONTO
alter table KASUTAJAKONTO add constraint fk_KLIENDILEPING_KONTO foreign key (kliendileping_ID) references KLIENDILEPING (kliendileping_ID);
alter table KASUTAJAKONTO add constraint fk_ISIK_KONTO foreign key (isik_id) references ISIK (isik_id);

-- ISIK
alter table ISIK add constraint fk_ISIKU_ROLL_ISIK foreign key (isiku_roll_ID) references ISIKU_ROLL (isiku_roll_ID);

-- KASUTAJAK_ROLL
alter table KASUTAJAK_ROLL add constraint fk_KASUTAJAKONTO_KROLL foreign key (kasutajakonto_ID) references KASUTAJAKONTO (kasutajakonto_ID);
alter table KASUTAJAK_ROLL add constraint fk_ROLL_KROLL foreign key (roll_ID) references ROLL (roll_ID);

-- ROLLI_TEGEVUS
alter table ROLLI_TEGEVUS add constraint fk_ROLL_RTEGEVUS foreign key (roll_ID) references ROLL (roll_ID);
alter table ROLLI_TEGEVUS add constraint fk_TEGEVUS_RTEGEVUS foreign key (tegevus_ID) references TEGEVUS (tegevus_ID);

-- TEGEVUS
alter table TEGEVUS add constraint fk_YLEM_TEGEVUS_TEGEVUS foreign key (tegevus_ID_ylem) references TEGEVUS (tegevus_ID);

-- ERIHIND_KL_LEPINGUS
alter table ERIHIND_KL_LEPINGUS add constraint fk_KLIENDILEPING_ERIHIND foreign key (kliendileping_ID) references KLIENDILEPING (kliendileping_ID);
alter table ERIHIND_KL_LEPINGUS add constraint fk_ERIHIND_ERIHIND foreign key (erihind_ID) references ERIHIND (erihind_ID);

-- TELLIMUS
alter table TELLIMUS add constraint fk_KLIENDILEPING_TELLIMUS foreign key (kliendileping_ID) references KLIENDILEPING (kliendileping_ID);

-- TELLIMUSE_RIDA
alter table TELLIMUSE_RIDA add constraint fk_TELLIMUS_TRIDA foreign key (tellimuse_ID) references TELLIMUS (tellimuse_ID);
alter table TELLIMUSE_RIDA add constraint fk_TELLIMUS_TRIDA foreign key (tellimuse_ID) references TELLIMUS (tellimuse_ID);
alter table TELLIMUSE_RIDA add constraint fk_KAMPAANIA_TRIDA foreign key (kampaania_ID) references KAMPAANIA (kampaania_ID);
alter table TELLIMUSE_RIDA add constraint fk_ERIHIND_KL_LEPINGUS_TRIDA foreign key (erihind_kl_lepingus_ID) references ERIHIND_KL_LEPINGUS (erihind_kl_lepingus_ID);

-- TEST_TELLIMUSES
alter table TEST_TELLIMUSES add constraint fk_TEST_TTELLIMUS foreign key (test_ID) references TEST (test_ID);
alter table TEST_TELLIMUSES add constraint fk_PROOV_TTELLIMUS foreign key (proov_ID) references PROOV (proov_ID);
alter table TEST_TELLIMUSES add constraint fk_ISIK_TTELLIMUS foreign key (isik_ID_testi_teostaja) references ISIK (isik_ID);
alter table TEST_TELLIMUSES add constraint fk_TULEMUS_TTELLIMUS foreign key (tulemus_ID) references TULEMUS (tulemus_ID);

-- VAHEND
alter table VAHEND add constraint fk_VAHENDI_TYYP_VAHEND foreign key (vahendi_tyyp_ID) references VAHENDI_TYYP (vahendi_tyyp_ID);

-- PROOV
alter table PROOV add constraint fk_PROOVI_TYYP_PROOV foreign key (proovi_tyyp_ID) references PROOVI_TYYP (proovi_tyyp_ID);
alter table PROOV add constraint fk_ISIK_PROOVI_ANDJA_PROOV foreign key (isik_ID_proovi_andja) references ISIK (isik_ID);
alter table PROOV add constraint fk_ISIK_PROOVI_VOTJA_PROOV foreign key (isik_ID_proovi_votja) references ISIK (isik_ID);

-- HIND
alter table HIND add constraint fk_TEST_HIND foreign key (test_ID) references TEST (test_ID);
alter table HIND add constraint fk_KAMPAANIA_HIND foreign key (kampaania_ID) references KAMPAANIA (kampaania_ID);
alter table HIND add constraint fk_ERIHIND_LEPINGUS_HIND foreign key (erihind_kl_lepingus_ID) references ISIK (erihind_kl_lepingus_ID);

-- KASUTATUD_VAHEND
alter table KASUTATUD_VAHEND add constraint fk_TEST_TELLIMUSES_KVAHEND foreign key (test_tellimuses_ID) references TEST_TELLIMUSES (test_tellimuses_ID);
alter table KASUTATUD_VAHEND add constraint fk_VAHEND_KVAHEND foreign key (vahend_ID) references VAHEND (vahend_ID);

-- SEADE_PARANDUSES
alter table SEADE_PARANDUSES add constraint fk_VAHEND_PARANDUSES foreign key (vahend_ID) references VAHEND (vahend_ID);

-- KAMPAANIA
alter table KAMPAANIA add constraint fk_TEST_KAMPAANIA foreign key (test_ID) references TEST (test_ID);














-- Kodune ylesanne - Oracle, kes siis veel
drop table OMAND;

-- Yl 2. luua kolm tabelit
create table ISIK
(
    isik_id integer primary key,
    eesnimi varchar2(20) not null,
    perenimi varchar2(25) not null,
    isikukood char(11) not null,
    vanus char(3),
    sugu varchar(5),
    kommentaar clob 
 ); 
 
create table OMAND
(
    omand_id integer primary key,
    nimetus varchar2(50) not null,
    tyyp varchar2(25) not null,
    vaartus_eur decimal(20, 2) not null,
    kommentaar clob 
 ); 
 
create table ISIKU_OMAND
(
    isiku_omand_id integer primary key,
    isik_id integer not null,
    omand_id integer not null,
    alates date not null,
    kuni date not null,
    kommentaar clob 
 ); 

alter table ISIKU_OMAND add constraint fk_isik foreign key (isik_id) references ISIK (isik_id);
alter table ISIKU_OMAND add constraint fk_omand foreign key (omand_id) references OMAND (omand_id);


-- Yl 3. sisestada tabelitesse andmeid
insert all
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (1, 'Mari', 'Maasikas', '60305053524', '21', 'naine')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (2, 'Jaan', 'Kask', '39305053525', '31', 'mees')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (3, 'Liis', 'Lille', '60305053526', '21', 'naine')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (4, 'Peeter', 'Puu', '50305053527','21',  'mees')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (5, 'Anna', 'Mets', '60305053528', '21', 'naine')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (6, 'Markus', 'Jõe', '35305053529', '71', 'mees')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (7, 'Kati', 'Raba', '48505053530', '34', 'naine')
into ISIK (isik_id, eesnimi, perenimi, isikukood, vanus, sugu) values (8, 'Toomas', 'Tamm', '50705053531', '17', 'mees')
select * from dual;
 
 
insert all
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (1, 'Toyota Corolla', 'auto', 10000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (2, 'Scott Metrix 20', 'jalgratas', 500)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (3, 'Scott Spark 950', 'jalgratas', 2700)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (4, 'Honda Civic', 'auto', 15000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (5, 'Volkswagen Golf', 'auto', 5000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (6, '4-toaline pereelamu', 'maja', 200000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (7, '2-toaline korter', 'korter', 130000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (8, 'Stuudiokorter', 'korter', 100000)
into OMAND (omand_id, nimetus, tyyp, vaartus_eur) values (9, 'Autosuvila', 'auto', 300000)
select * from dual;

insert all
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (1, 3, 5,  TO_DATE('2001-12-12', 'YYYY-MM-DD'), TO_DATE('2024-08-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (2, 1, 2, TO_DATE('2020-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (3, 2, 3, TO_DATE('2020-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (4, 2, 4, TO_DATE('2020-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (5, 3, 5, TO_DATE('2020-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (6, 3, 6, TO_DATE('1970-06-01', 'YYYY-MM-DD'), TO_DATE('2010-06-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (7, 4, 7, TO_DATE('2020-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (8, 4, 8, TO_DATE('2015-08-01', 'YYYY-MM-DD'), TO_DATE('3000-12-31', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (9, 5, 9, TO_DATE('2013-09-01', 'YYYY-MM-DD'), TO_DATE('3000-12-31', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (10, 6, 1, TO_DATE('2020-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (11, 6, 2, TO_DATE('2020-11-01', 'YYYY -MM -DD'), TO_DATE('2023 -11 -01', 'YYYY -MM -DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (12 ,7, 3, TO_DATE('2020-12-01', 'YYYY -MM -DD'), TO_DATE('2023 -12 -01', 'YYYY -MM -DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (13, 7, 4, TO_DATE('2021-01-15', 'YYYY -MM -DD'), TO_DATE('2024 -01 -15', 'YYYY -MM -DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (14, 8, 5, TO_DATE('2021-02-15', 'YYYY -MM -DD'), TO_DATE('2024 -02 -15', 'YYYY -MM -DD'))
into ISIKU_OMAND (isiku_omand_id, isik_id, omand_id, alates, kuni) values (15, 8, 6, TO_DATE('2021-03-15', 'YYYY -MM -DD'), TO_DATE('2024 -03 -15', 'YYYY -MM -DD'))
select * from dual;




-- Yl 4. muutke tabelis olevate kirjete andmeid

update ISIK set perenimi = 'Kask' where isik_id = 3; 

update OMAND set kommentaar = 'Kasutatud' where vaartus_eur <= 5000; 

update OMAND set vaartus_eur = vaartus_eur + 5;


-- Yl 5. Kustutage tabelist kirjeid

delete from ISIKU_OMAND where isiku_omand_id = 1;

delete from ISIKU_OMAND where alates < TO_DATE('2015-01-01', 'YYYY-MM-DD');

delete from ISIKU_OMAND;


-- Yl 7. Päring ühte tabelisse

select * from ISIK where kommentaar is null;

select perenimi, sugu from ISIK where sugu = 'mees' order by perenimi DESC;

select eesnimi, perenimi from ISIK where vanus > 18;


-- Yl 8. Leidke üle väljade maksimume ja miinimume ja loendusandmeid

select min(vaartus_eur) from OMAND where tyyp = 'auto';

select count(*) from OMAND;

select count(*) from OMAND where vaartus_eur > 10000;


-- Yl 9. Tehke päring üle kahe tabeli
select ISIK.*, ISIKU_OMAND.*
from ISIK
full join ISIKU_OMAND on ISIK.isik_id = ISIKU_OMAND.isik_id;

select ISIK.*, ISIKU_OMAND.*
from ISIK
full join ISIKU_OMAND on ISIK.isik_id = ISIKU_OMAND.isik_id
where isiku_omand_id = 8;

select ISIK.*, ISIKU_OMAND.*
from ISIK
full join ISIKU_OMAND on ISIK.isik_id = ISIKU_OMAND.isik_id
where omand_id = 5;


--Yl 10. Tehke päring üle kolme tabeli

select ISIK.*, ISIKU_OMAND.*, OMAND.*
from ISIKU_OMAND
full join ISIK on ISIKU_OMAND.isik_id = ISIK.isik_id
full join OMAND on ISIKU_OMAND.omand_id = OMAND.omand_id;

select ISIK.*, ISIKU_OMAND.*, OMAND.*
from ISIKU_OMAND
full join ISIK on ISIKU_OMAND.isik_id = ISIK.isik_id
full join OMAND on ISIKU_OMAND.omand_id = OMAND.omand_id
where ISIKU_OMAND.isiku_omand_id = 7;

select ISIK.*, ISIKU_OMAND.*, OMAND.*
from ISIKU_OMAND
full join ISIK on ISIKU_OMAND.isik_id = ISIK.isik_id
full join OMAND on ISIKU_OMAND.omand_id = OMAND.omand_id
where OMAND.kommentaar is not null;





select * from ISIK;

select * from OMAND;

select * from ISIKU_OMAND;

commit;

rollback;
