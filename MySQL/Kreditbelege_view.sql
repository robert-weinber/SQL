
-- ----------------------------- --
-- Developed by Róbert Weinber on 2016/12/20 --
-- ----------------------------- --
-- ##BEGIN_VIEW##

Kreditbelege_view;Kreditbelege;1

-- ##TRANSACTION_CODE##

1

-- ##OPTIMIZE##

-- LEVEL_1;MANDT;1

-- ##LANGUAGES##

de

-- ##DICTIONARY##

 LANG_KEY;Sprachschlüssel;0 
 -- MANDT;Mandant;0 
 Kontonummer;Kontonummer;1
 Kontoinhaber1;Kontoinhaber 1;1
 Kontoinhaber2;Kontoinhaber 2;1
 Belegdatum;Belegdatum;1
 Register;Register;1
 Register;Register;1
 SERKEY;SER-KEY;1
 
-- ##KEYS##

-- CREATE INDEX _idx_00001_ ON database_final.seratio (`K-DESKRIPTOREN`,`A-DESKRIPTOREN`,`J-DESKRIPTOREN`,`SER-KEY`);

-- ##REPORT_PARAMETERS## 

in_kontonummer;string;Kontonummer
in_kontoinhaber1;string;Kontoinhaber 1
in_kontoinhaber2;string;Kontoinhaber 2
in_belegdatum;date;Belegdatum
in_register;string;Register 

-- ##REPORT_PARAMETER_REFERENCES## 

in_kontonummer;database_final;Kreditbelege_view;Kontonummer;0;0;0;0;Kontonummer
in_kontoinhaber1;database_final;Kreditbelege_view;Kontoinhaber1;0;0;0;0;Kontoinhaber1
in_kontoinhaber2;database_final;Kreditbelege_view;Kontoinhaber2;0;0;0;0;Kontoinhaber2
in_belegdatum;database_final;Kreditbelege_view;Belegdatum;0;0;0;0;Belegdatum
in_register;database_final;Kreditbelege_view;Register;0;0;0;0;Register

-- ##REPORT_PARAMETER_FILTER## 

(ifnull(in_kontonummer,'') = '' or in_kontonummer = kontonummer) and 
(ifnull(in_kontoinhaber1,'') = '' or in_kontoinhaber1 = kontoinhaber1) and 
(ifnull(in_kontoinhaber2,'') = '' or in_kontoinhaber2 = kontoinhaber2) and 
(ifnull(in_belegdatum,'') = '' or in_belegdatum = belegdatum) and 
(ifnull(in_register,'') = '' or in_register = register)
 
-- ##VIEW##

DROP TABLE IF EXISTS Kreditbelege_view;
CREATE TABLE Kreditbelege_view
CHARACTER SET UTF8
ENGINE MyISAM


SELECT 
binary('D') 												as LANG_KEY,
 if(a.`SPALTE1` like 'K1001%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1001%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1001%',substring(a.`SPALTE3`,6),if(a.`SPALTE4` like 'K1001%',substring(a.`SPALTE4`,6),if(a.`SPALTE5` like 'K1001%',substring(a.`SPALTE5`,6),if(a.`SPALTE6` like 'K1001%',substring(a.`SPALTE6`,6),if(a.`SPALTE7` like 'K1001%',substring(a.`SPALTE7`,6),if(a.`SPALTE8` like 'K1001%',substring(a.`SPALTE8`,6),if(a.`SPALTE9` like 'K1001%',substring(a.`SPALTE9`,6),''))))))))) as Kontonummer
,if(a.`SPALTE1` like 'K1014%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%',substring(a.`SPALTE3`,6),if(a.`SPALTE4` like 'K1014%',substring(a.`SPALTE4`,6),if(a.`SPALTE5` like 'K1014%',substring(a.`SPALTE5`,6),if(a.`SPALTE6` like 'K1014%',substring(a.`SPALTE6`,6),if(a.`SPALTE7` like 'K1014%',substring(a.`SPALTE7`,6),if(a.`SPALTE8` like 'K1014%',substring(a.`SPALTE8`,6),if(a.`SPALTE9` like 'K1014%',substring(a.`SPALTE9`,6),''))))))))) as Kontoinhaber1
,if(a.`SPALTE1` like 'K1014%' and a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%' and a.`SPALTE2` like 'K1014%',substring(a.`SPALTE3`,6),if(a.`SPALTE4` like 'K1014%',substring(a.`SPALTE4`,6),if(a.`SPALTE5` like 'K1014%',substring(a.`SPALTE5`,6),if(a.`SPALTE6` like 'K1014%',substring(a.`SPALTE6`,6),if(a.`SPALTE7` like 'K1014%',substring(a.`SPALTE7`,6),if(a.`SPALTE8` like 'K1014%',substring(a.`SPALTE8`,6),if(a.`SPALTE9` like 'K1014%',substring(a.`SPALTE9`,6),'')))))))) as Kontoinhaber2
, date( if(a.`SPALTE1` like 'A1003%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1003%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1003%',substring(a.`SPALTE3`,6),if(a.`SPALTE4` like 'A1003%',substring(a.`SPALTE4`,6),if(a.`SPALTE5` like 'A1003%',substring(a.`SPALTE5`,6),if(a.`SPALTE6` like 'A1003%',substring(a.`SPALTE6`,6),if(a.`SPALTE7` like 'A1003%',substring(a.`SPALTE7`,6),if(a.`SPALTE8` like 'A1003%',substring(a.`SPALTE8`,6),if(a.`SPALTE9` like 'A1003%',substring(a.`SPALTE9`,6),''))))))))) ) as Belegdatum
,if(a.`SPALTE1` like 'A1015%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1015%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1015%',substring(a.`SPALTE3`,6),if(a.`SPALTE4` like 'A1015%',substring(a.`SPALTE4`,6),if(a.`SPALTE5` like 'A1015%',substring(a.`SPALTE5`,6),if(a.`SPALTE6` like 'A1015%',substring(a.`SPALTE6`,6),if(a.`SPALTE7` like 'A1015%',substring(a.`SPALTE7`,6),if(a.`SPALTE8` like 'A1015%',substring(a.`SPALTE8`,6),if(a.`SPALTE9` like 'A1015%',substring(a.`SPALTE9`,6),''))))))))) as Register
,a.`SER-KEY` as SERKEY

FROM database_final.seratio_rest a 
where (DATENBANK like 'SKPKREDIT' or DATENBANK like 'SKPKREDIT_70') 
and  (a.`SPALTE1` like 'K1001%' or a.`SPALTE2` like 'K1001%' or a.`SPALTE3` like 'K1001%' or a.`SPALTE4` like 'K1001%' or a.`SPALTE5` like 'K1001%' or a.`SPALTE6` like 'K1001%' or a.`SPALTE7` like 'K1001%' or a.`SPALTE8` like 'K1001%' or a.`SPALTE9` like 'K1001%')
and `SER-KEY` like 'I%'

UNION

SELECT 
binary('D') 												as LANG_KEY,
 if(a.`SPALTE1` like 'K01%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K01%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K01%',substring(a.`SPALTE3`,4),if(a.`SPALTE4` like 'K01%',substring(a.`SPALTE4`,4),if(a.`SPALTE5` like 'K01%',substring(a.`SPALTE5`,4),if(a.`SPALTE6` like 'K01%',substring(a.`SPALTE6`,4),if(a.`SPALTE7` like 'K01%',substring(a.`SPALTE7`,4),if(a.`SPALTE8` like 'K01%',substring(a.`SPALTE8`,4),if(a.`SPALTE9` like 'K01%',substring(a.`SPALTE9`,4),''))))))))) as Kontonummer
,if(a.`SPALTE2` like 'K12%',substring(a.`SPALTE2`,4),'') as Kontoinhaber1
,if(a.`SPALTE3` like 'K12%',substring(a.`SPALTE3`,4),'') as Kontoinhaber2
, date( if(a.`SPALTE1` like 'A02%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'A02%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'A02%',substring(a.`SPALTE3`,4),if(a.`SPALTE4` like 'A02%',substring(a.`SPALTE4`,4),if(a.`SPALTE5` like 'A02%',substring(a.`SPALTE5`,4),if(a.`SPALTE6` like 'A02%',substring(a.`SPALTE6`,4),if(a.`SPALTE7` like 'A02%',substring(a.`SPALTE7`,4),if(a.`SPALTE8` like 'A02%',substring(a.`SPALTE8`,4),if(a.`SPALTE9` like 'A02%',substring(a.`SPALTE9`,4),''))))))))) ) as Belegdatum
,if(a.`SPALTE1` like 'A07%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'A07%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'A07%',substring(a.`SPALTE3`,4),if(a.`SPALTE4` like 'A07%',substring(a.`SPALTE4`,4),if(a.`SPALTE5` like 'A07%',substring(a.`SPALTE5`,4),if(a.`SPALTE6` like 'A07%',substring(a.`SPALTE6`,4),if(a.`SPALTE7` like 'A07%',substring(a.`SPALTE7`,4),if(a.`SPALTE8` like 'A07%',substring(a.`SPALTE8`,4),if(a.`SPALTE9` like 'A07%',substring(a.`SPALTE9`,4),''))))))))) as Register
,a.`SER-KEY` as SERKEY

FROM database_final.seratio_rest a 
where (DATENBANK like 'SKPKREDIT' or DATENBANK like 'SKPKREDIT_70') 
and  (a.`SPALTE1` like 'K01%' or a.`SPALTE2` like 'K01%' or a.`SPALTE3` like 'K01%' or a.`SPALTE4` like 'K01%' or a.`SPALTE5` like 'K01%' or a.`SPALTE6` like 'K01%' or a.`SPALTE7` like 'K01%' or a.`SPALTE8` like 'K01%' or a.`SPALTE9` like 'K01%')
and `SER-KEY` not like 'I%'

UNION

Select
binary('D') 												as LANG_KEY,
if(a.`K-DESKRIPTOREN` like 'K1001%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K1001%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'K1001%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1001%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1001%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1001%',substring(a.`SPALTE3`,6),'')))))) as Kontonummer
,if(a.`K-DESKRIPTOREN` like 'K1014%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K1014%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'K1014%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1014%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%',substring(a.`SPALTE3`,6),'')))))) as Kontoinhaber1
,if(a.`K-DESKRIPTOREN` like 'K1014%' and a.`A-DESKRIPTOREN` like 'K1014%',substring(a.`A-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K1014%' and a.`J-DESKRIPTOREN` like 'K1014%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1014%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%',substring(a.`SPALTE3`,6),''))))) as Kontoinhaber2
, date( if(a.`K-DESKRIPTOREN` like 'A1003%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'A1003%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'A1003%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'A1003%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1003%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1003%',substring(a.`SPALTE3`,6),'')))))) ) as Belegdatum
,if(a.`K-DESKRIPTOREN` like 'A1015%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'A1015%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'A1015%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'A1015%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1015%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1015%',substring(a.`SPALTE3`,6),'')))))) as Register
 ,a.`SER-KEY` as SERKEY

FROM database_final.seratio a 
where (DATENBANK like 'SKPKREDIT' or DATENBANK like 'SKPKREDIT_70')
and  (a.`K-DESKRIPTOREN` like 'K1001%' or a.`A-DESKRIPTOREN` like 'K1001%' or a.`J-DESKRIPTOREN` like 'K1001%' or a.`SPALTE1` like 'K1001%' or a.`SPALTE2` like 'K1001%' or a.`SPALTE3` like 'K1001%')
and `SER-KEY` like 'I%'

UNION

Select
binary('D') 												as LANG_KEY,
if(a.`K-DESKRIPTOREN` like 'K01%',substring(a.`K-DESKRIPTOREN`,4),if(a.`A-DESKRIPTOREN` like 'K01%',substring(a.`A-DESKRIPTOREN`,4),if(a.`J-DESKRIPTOREN` like 'K01%',substring(a.`J-DESKRIPTOREN`,4),if(a.`SPALTE1` like 'K01%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K01%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K01%',substring(a.`SPALTE3`,4),if(a.`K-DESKRIPTOREN` like 'K1001%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K1001%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'K1001%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1001%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1001%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1001%',substring(a.`SPALTE3`,6),'')))))))))))) as Kontonummer
,if(a.`K-DESKRIPTOREN` like 'K12%',substring(a.`K-DESKRIPTOREN`,4),if(a.`A-DESKRIPTOREN` like 'K12%',substring(a.`A-DESKRIPTOREN`,4),if(a.`J-DESKRIPTOREN` like 'K12%',substring(a.`J-DESKRIPTOREN`,4),if(a.`SPALTE1` like 'K12%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K12%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K12%',substring(a.`SPALTE3`,4),if(a.`K-DESKRIPTOREN` like 'K1014%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K1014%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'K1014%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1014%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%',substring(a.`SPALTE3`,6),'')))))))))))) as Kontoinhaber1
,if(a.`A-DESKRIPTOREN` like 'K12%' and a.`K-DESKRIPTOREN` like 'K12%',substring(a.`A-DESKRIPTOREN`,4),if(a.`A-DESKRIPTOREN` like 'K12%' and a.`J-DESKRIPTOREN` like 'K12%',substring(a.`J-DESKRIPTOREN`,4),if(a.`SPALTE1` like 'K12%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K12%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K12%',substring(a.`SPALTE3`,4),if(a.`A-DESKRIPTOREN` like 'K1014%' and a.`K-DESKRIPTOREN` like 'K1014%',substring(a.`A-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'K12%' and a.`J-DESKRIPTOREN` like 'K1014%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'K1014%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'K1014%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'K1014%',substring(a.`SPALTE3`,6),'')))))))))) as Kontoinhaber2
, date( if(a.`K-DESKRIPTOREN` like 'K02%',substring(a.`K-DESKRIPTOREN`,4),if(a.`A-DESKRIPTOREN` like 'K02%',substring(a.`A-DESKRIPTOREN`,4),if(a.`J-DESKRIPTOREN` like 'K02%',substring(a.`J-DESKRIPTOREN`,4),if(a.`SPALTE1` like 'K02%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K02%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K02%',substring(a.`SPALTE3`,4),if(a.`K-DESKRIPTOREN` like 'A1003%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'A1003%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'A1003%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'A1003%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1003%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1003%',substring(a.`SPALTE3`,6),'')))))))))))) ) as Belegdatum
,if(a.`K-DESKRIPTOREN` like 'K07%',substring(a.`K-DESKRIPTOREN`,4),if(a.`A-DESKRIPTOREN` like 'K07%',substring(a.`A-DESKRIPTOREN`,4),if(a.`J-DESKRIPTOREN` like 'K07%',substring(a.`J-DESKRIPTOREN`,4),if(a.`SPALTE1` like 'K07%',substring(a.`SPALTE1`,4),if(a.`SPALTE2` like 'K07%',substring(a.`SPALTE2`,4),if(a.`SPALTE3` like 'K07%',substring(a.`SPALTE3`,4),if(a.`K-DESKRIPTOREN` like 'A1015%',substring(a.`K-DESKRIPTOREN`,6),if(a.`A-DESKRIPTOREN` like 'A1015%',substring(a.`A-DESKRIPTOREN`,6),if(a.`J-DESKRIPTOREN` like 'A1015%',substring(a.`J-DESKRIPTOREN`,6),if(a.`SPALTE1` like 'A1015%',substring(a.`SPALTE1`,6),if(a.`SPALTE2` like 'A1015%',substring(a.`SPALTE2`,6),if(a.`SPALTE3` like 'A1015%',substring(a.`SPALTE3`,6),'')))))))))))) as Register
,a.`SER-KEY` as SERKEY

FROM database_final.seratio a 
where (DATENBANK like 'SKPKREDIT' or DATENBANK like 'SKPKREDIT_70')
and  (a.`K-DESKRIPTOREN` like 'K1001%' or a.`A-DESKRIPTOREN` like 'K1001%' or a.`J-DESKRIPTOREN` like 'K1001%' or a.`SPALTE1` like 'K1001%' or a.`SPALTE2` like 'K1001%' or a.`SPALTE3` like 'K1001%')
and `SER-KEY` not like 'I%';
  
 -- ##END_VIEW##