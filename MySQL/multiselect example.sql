USE database_final;

DELIMITER $$


DROP PROCEDURE IF EXISTS all_deal_proc$$

CREATE PROCEDURE all_deal_proc(  
in_markettype varchar(65535),
in_comments varchar(65535),
in_CounterPartyShortName varchar(65535),
in_CounterPartyLongName varchar(65535),
in_dealstatus varchar(65535),
in_TypeOfDeal varchar(65535),
in_TypeOfEvent varchar(65535),
in_DealType varchar(65535),
in_BlockNumber varchar(65535),
in_Amount1Min decimal(50,5),
in_Amount1Max decimal(50,5),
in_Amount2Min decimal(50,20),
in_Amount2Max decimal(50,20),
in_Rate_PriceMin decimal(50,20),
in_Rate_PriceMax decimal(50,20),
in_Strike varchar(65535),
in_Cl_Rate varchar(65535),
in_Cl_Margin varchar(65535),
in_TradeDateBegin date,
in_TradeDateEnd date,
in_ValueDateBegin date,
in_ValueDateEnd date,
in_MaturityDateBegin date,
in_MaturityDateEnd date,
in_LiquidationDateBegin datetime,
in_LiquidationDateEnd datetime,
in_QuantityMin varchar(65535),
in_QuantityMax varchar(65535),
in_Broker varchar(65535),
in_Folders_ShortName varchar(65535),
in_Users_ShortName varchar(65535),
in_Lastuser varchar(65535),
in_LastDateBegin date,
in_LastDateEnd date,
in_DownloadKey varchar(65535),
in_OptionType varchar(65535),
in_Security varchar(65535),
in_SecurityDesc varchar(65535),
in_deal_id_new varchar(65535),
in_inputmode varchar(65535),
in_UsersGrp_ShortName varchar(65535),
in_Branches_ShortName varchar(65535),
in_Portfolios_ShortName varchar(65535),
in_FolderGroup varchar(65535),
in_brokername varchar(65535),
in_lang varbinary(1)
 )
  SQL SECURITY INVOKER
BEGIN	 
DECLARE row_min bigint;
DECLARE row_max bigint;
   
	TRUNCATE TABLE all_deal_search_view_dyn;
 DROP TABLE IF EXISTS database_viewbuilding.aldealparams;
 CREATE TABLE IF NOT EXISTS database_viewbuilding.aldealparams
 SELECT in_markettype,in_comments,in_CounterPartyShortName,in_CounterPartyLongName,in_dealstatus,in_TypeOfDeal,in_TypeOfEvent,in_DealType,in_BlockNumber,in_Amount1Min ,in_Amount1Max ,
in_Amount2Min,in_Amount2Max ,in_Rate_PriceMin, in_Rate_PriceMax ,in_Strike ,in_Cl_Rate ,in_Cl_Margin ,in_TradeDateBegin,in_TradeDateEnd  ,in_ValueDateBegin ,in_ValueDateEnd  ,in_MaturityDateBegin  ,in_MaturityDateEnd  ,
in_LiquidationDateBegin, in_LiquidationDateEnd ,in_QuantityMin, in_QuantityMax ,in_Broker ,in_Folders_ShortName ,in_Users_ShortName ,in_Lastuser ,in_LastDateBegin ,in_LastDateEnd  ,in_DownloadKey,in_OptionType ,in_Security ,in_SecurityDesc ,
in_deal_id_new ,in_inputmode ,in_UsersGrp_ShortName ,in_Branches_ShortName ,in_Portfolios_ShortName ,in_FolderGroup ,in_brokername
  
,IF(TRIM(SUBSTRING_INDEX(in_Strike,',',1))='',NULL,CAST(TRIM(SUBSTRING_INDEX(in_Strike,',',1)) AS DECIMAL(30,17))) AS c1,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',2),LENGTH(SUBSTRING_INDEX(in_Strike,',',1))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',2),LENGTH(SUBSTRING_INDEX(in_Strike,',',1))+2)) AS DECIMAL(30,17))) AS c2,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',3),LENGTH(SUBSTRING_INDEX(in_Strike,',',2))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',3),LENGTH(SUBSTRING_INDEX(in_Strike,',',2))+2)) AS DECIMAL(30,17))) AS c3,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',4),LENGTH(SUBSTRING_INDEX(in_Strike,',',3))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',4),LENGTH(SUBSTRING_INDEX(in_Strike,',',3))+2)) AS DECIMAL(30,17))) AS c4,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',5),LENGTH(SUBSTRING_INDEX(in_Strike,',',4))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',5),LENGTH(SUBSTRING_INDEX(in_Strike,',',4))+2)) AS DECIMAL(30,17))) AS c5,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',6),LENGTH(SUBSTRING_INDEX(in_Strike,',',5))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',6),LENGTH(SUBSTRING_INDEX(in_Strike,',',5))+2)) AS DECIMAL(30,17))) AS c6,
  IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',7),LENGTH(SUBSTRING_INDEX(in_Strike,',',6))+2))='',NULL,CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',7),LENGTH(SUBSTRING_INDEX(in_Strike,',',6))+2)) AS DECIMAL(30,17))) AS c7
  
  ; 

IF(
  in_markettype='' and
in_comments ='' and
in_CounterPartyShortName ='' and
in_CounterPartyLongName ='' and
in_dealstatus ='' and
in_TypeOfDeal ='' and
in_TypeOfEvent ='' and
in_DealType ='' and
in_BlockNumber ='' and
in_Amount1Min =0 and
in_Amount1Max =0 and
in_Amount2Min =0 and
in_Amount2Max =0 and
in_Rate_PriceMin =0 and
in_Rate_PriceMax =0 and
in_Strike ='' and
in_Cl_Rate ='' and
in_Cl_Margin ='' and
in_TradeDateBegin  is null and
in_TradeDateEnd  is null and
in_ValueDateBegin  is null and
in_ValueDateEnd  is null and
in_MaturityDateBegin  is null and
in_MaturityDateEnd  is null and
in_LiquidationDateBegin  is null and
in_LiquidationDateEnd  is null and
in_QuantityMin =''and
in_QuantityMax ='' and
in_Broker ='' and
in_Folders_ShortName ='' and
in_Users_ShortName ='' and
in_Lastuser ='' and
in_LastDateBegin  is null and
in_LastDateEnd  is null and
in_DownloadKey ='' and
in_OptionType ='' and
in_Security ='' and
in_SecurityDesc ='' and
in_deal_id_new ='' and
in_inputmode ='' and
in_UsersGrp_ShortName ='' and
in_Branches_ShortName ='' and
in_Portfolios_ShortName ='' and
in_FolderGroup ='' and
in_brokername ='' ) THEN

INSERT INTO all_deal_search_view_dyn  
SELECT  
in_lang, DealTypeBonds, DealTypeEquity, DealTypeWarrant, DealTypeIAM, DealTypeRepo, DealTypeSecu, DealTypeCashFlow, DealTypeLoanDepo, DealTypeCallAcc, DealTypeFXSwap, DealTypeSpot, DealTypeForward,
      DealTypeIndexOp, DealTypeEquityOp, DealTypeCurrencyOp, DealTypeFutureOp, DealTypeFuture, Deal_Id, deal_id_new, dealstatus, inputmode, TypeOfDeal, DealType, OptionType, TypeOfEvent, BlockNumber, Amount1, Amount2,
      Rate_Price, Strike, Cl_Rate, Cl_Margin, Security, SecurityDesc, TradeDate, ValueDate, MaturityDate, LiquidationDate, CAST(Quantity AS DECIMAL(20,8)), Broker, CounterPartyShortName, CounterPartyLongName, Users_ShortName, usergroupsid,
      UsersGrp_ShortName, Lastuser, Folders_ShortName, Comments, LastDate, a.DownloadKey, markettype, instruments, Branches_ShortName, Portfolios_ShortName, FolderGroup,b.Brokers_Name, NULL
      FROM database_dynamic.alldeal_Temp a force index (_relevant_idx)
      left join database_final.kplusglobal_brokersdeft b on a.Broker=b.Brokers_ShortName;

ELSE 

  IF(
  ifnull(in_markettype,'')='' and
ifnull(in_comments,'') ='' and
ifnull(in_CounterPartyShortName,'') ='' and
ifnull(in_CounterPartyLongName,'') ='' and
ifnull(in_dealstatus,'') ='' and
ifnull(in_TypeOfDeal,'') ='' and
ifnull(in_TypeOfEvent,'') ='' and
ifnull(in_DealType,'') ='' and
ifnull(in_BlockNumber,'') ='' and
ifnull(in_Amount1Min,0) =0 and
ifnull(in_Amount1Max,0) =0 and
ifnull(in_Amount2Min,0) =0 and
ifnull(in_Amount2Max,0) =0 and
ifnull(in_Rate_PriceMin,0) =0 and
ifnull(in_Rate_PriceMax,0) =0 and
ifnull(in_Strike,'') ='' and
ifnull(in_Cl_Rate,'') ='' and
ifnull(in_Cl_Margin,'') ='' and
in_TradeDateBegin  is null and
in_TradeDateEnd  is null and
in_ValueDateBegin  is null and
in_ValueDateEnd  is null and
in_MaturityDateBegin  is null and
in_MaturityDateEnd  is null and
in_LiquidationDateBegin  is null and
in_LiquidationDateEnd  is null and
ifnull(in_QuantityMin,0) =0 and
ifnull(in_QuantityMax,0) =0 and
ifnull(in_Broker,'') ='' and
ifnull(in_Folders_ShortName,'') ='' and
ifnull(in_Users_ShortName,'') ='' and
ifnull(in_Lastuser,'') ='' and
in_LastDateBegin  is null and
in_LastDateEnd  is null and
ifnull(in_DownloadKey,'') ='' and
ifnull(in_OptionType,'') ='' and
ifnull(in_Security,'') ='' and
ifnull(in_SecurityDesc,'') ='' and
ifnull(in_deal_id_new,'') ='' and
ifnull(in_inputmode,'') ='' and
ifnull(in_UsersGrp_ShortName,'') ='' and
ifnull(in_Branches_ShortName,'') ='' and
ifnull(in_Portfolios_ShortName,'') ='' and
ifnull(in_FolderGroup,'') !='' AND   --    ONLY FOLDERGRP
ifnull(in_brokername,'') ='' ) THEN

INSERT INTO all_deal_search_view_dyn  
SELECT  
in_lang, DealTypeBonds, DealTypeEquity, DealTypeWarrant, DealTypeIAM, DealTypeRepo, DealTypeSecu, DealTypeCashFlow, DealTypeLoanDepo, DealTypeCallAcc, DealTypeFXSwap, DealTypeSpot, DealTypeForward,
      DealTypeIndexOp, DealTypeEquityOp, DealTypeCurrencyOp, DealTypeFutureOp, DealTypeFuture, Deal_Id, a.deal_id_new, dealstatus, inputmode, TypeOfDeal, DealType, OptionType, TypeOfEvent, BlockNumber, Amount1, Amount2,
      Rate_Price, Strike, Cl_Rate, Cl_Margin, Security, SecurityDesc, TradeDate, ValueDate, MaturityDate, LiquidationDate, CAST(Quantity AS DECIMAL(20,8)), Broker, CounterPartyShortName, CounterPartyLongName, Users_ShortName, usergroupsid,
      UsersGrp_ShortName, Lastuser, Folders_ShortName, Comments, LastDate, a.DownloadKey, markettype, instruments, Branches_ShortName, Portfolios_ShortName, f5.FolderGroup,b.Brokers_Name, NULL
      FROM database_dynamic.alldeal_Temp a force index (_relevant_idx)
      left join database_final.kplusglobal_brokersdeft b on a.Broker=b.Brokers_ShortName  
  JOIN database_dynamic.all_deals_FOLDER_SEARCH f5 ON a.deal_id_new=f5.deal_id_new AND a.TypeOfDeal=f5.TypeOfDeal
  WHERE-- f5.FolderGroup=in_FolderGroup
       (ifnull(in_FolderGroup,'') = '' or (ifnull(f5.FolderGroup,'')!='' AND  f5.FolderGroup IN (TRIM(SUBSTRING_INDEX(in_FolderGroup,',',1)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',2),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',1))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',3),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',2))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',4),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',3))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',5),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',4))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',6),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',5))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',7),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',6))+2)))));

ELSE




  SET in_TypeOfDeal=TRIM(in_TypeOfDeal);
  SET @rownofilter='';
IF(in_TypeOfDeal !=''  ) THEN


SET @rownofilter=CONCAT_WS('',@rownofilter,'AND ((a._row_no_ BETWEEN  ');

    SET row_min=
CASE TRIM(SUBSTRING_INDEX(in_TypeOfDeal,',',1))
when 'Bond'  then 	1
when 'Call Account'  then 	1247065
when 'Cash Flow'  then 	1719209
when 'Equity/Commodity'  then 	1748454
when 'Futures'  then 	3652737
when 'FX Swap'  then 	4541014
when 'IAM & Discounted L&D'  then 	5331232
when 'Loan & Deposit'  then 	6429371
when 'Options'  then 	6529112
when 'Outright Forward'  then 	6571635
when 'Repo'  then 	6834638
when 'Securities Lending'  then 	6893370
when 'Spot'  then 	6906546
when 'Warrants'  then 	11118476
  END;
SET @rownofilter=CONCAT_WS('',@rownofilter,row_min,' AND ');
SET row_max=
  CASE TRIM(SUBSTRING_INDEX(in_TypeOfDeal,',',1))
  when 'Bond'  then 	1247064
when 'Call Account'  then 	1719208
when 'Cash Flow'  then 	1748453
when 'Equity/Commodity'  then 	3652736
when 'Futures'  then 	4541013
when 'FX Swap'  then 	5331231
when 'IAM & Discounted L&D'  then 	6429370
when 'Loan & Deposit'  then 	6529111
when 'Options'  then 	6571634
when 'Outright Forward'  then 	6834637
when 'Repo'  then 	6893369
when 'Securities Lending'  then 	6906545
when 'Spot'  then 	11118475
when 'Warrants'  then 	11120314
  END;
SET @rownofilter=CONCAT_WS('',@rownofilter,row_max,') ');

  SET @count= 
            LENGTH(in_TypeOfDeal) - LENGTH( REPLACE ( in_TypeOfDeal, ",", "") ) 
  ;
  

  while @count!= 0 DO

SET @rownofilter=CONCAT_WS('',@rownofilter,' OR (a._row_no_ BETWEEN ');
    SET row_min=
CASE TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfDeal,',',@count+1),LENGTH(SUBSTRING_INDEX(in_TypeOfDeal,',',@count))+2))
when 'Bond'  then 	1
when 'Call Account'  then 	1247065
when 'Cash Flow'  then 	1719209
when 'Equity/Commodity'  then 	1748454
when 'Futures'  then 	3652737
when 'FX Swap'  then 	4541014
when 'IAM & Discounted L&D'  then 	5331232
when 'Loan & Deposit'  then 	6429371
when 'Options'  then 	6529112
when 'Outright Forward'  then 	6571635
when 'Repo'  then 	6834638
when 'Securities Lending'  then 	6893370
when 'Spot'  then 	6906546
when 'Warrants'  then 	11118476
  END;
SET @rownofilter=CONCAT_WS('',@rownofilter,row_min,' AND ');
SET row_max=
  CASE TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfDeal,',',@count+1),LENGTH(SUBSTRING_INDEX(in_TypeOfDeal,',',@count))+2))
  when 'Bond'  then 	1247064
when 'Call Account'  then 	1719208
when 'Cash Flow'  then 	1748453
when 'Equity/Commodity'  then 	3652736
when 'Futures'  then 	4541013
when 'FX Swap'  then 	5331231
when 'IAM & Discounted L&D'  then 	6429370
when 'Loan & Deposit'  then 	6529111
when 'Options'  then 	6571634
when 'Outright Forward'  then 	6834637
when 'Repo'  then 	6893369
when 'Securities Lending'  then 	6906545
when 'Spot'  then 	11118475
when 'Warrants'  then 	11120314
  END;
SET @rownofilter=CONCAT_WS('',@rownofilter,row_max,') ');                

set  @count =  @count-1;
end while;
SET @rownofilter=CONCAT_WS('',@rownofilter,' ) ');

END IF;

  DROP TABLE IF EXISTS database_dynamic.all_deals_temp_FILTER; 
  SET @query_FILTER='';
    IF(ifnull(in_FolderGroup,'')!='')   THEN
     SET @query_FILTER="CREATE TABLE database_dynamic.all_deals_temp_FILTER";
    ELSE
      SET @query_FILTER="INSERT INTO all_deal_search_view_dyn";
      END IF;
  SET @query_FILTER=CONCAT_WS('',@query_FILTER,"
  
SELECT  
'",in_lang,"', DealTypeBonds, DealTypeEquity, DealTypeWarrant, DealTypeIAM, DealTypeRepo, DealTypeSecu, DealTypeCashFlow, DealTypeLoanDepo, DealTypeCallAcc, DealTypeFXSwap, DealTypeSpot, DealTypeForward,
      DealTypeIndexOp, DealTypeEquityOp, DealTypeCurrencyOp, DealTypeFutureOp, DealTypeFuture, Deal_Id, deal_id_new, dealstatus, inputmode, TypeOfDeal, DealType, OptionType, TypeOfEvent, BlockNumber, Amount1, Amount2,
      Rate_Price, Strike, Cl_Rate, Cl_Margin, Security, SecurityDesc, TradeDate, ValueDate, MaturityDate, LiquidationDate, CAST(REPLACE(Quantity,',','.') AS DECIMAL(50,20)), Broker, CounterPartyShortName, CounterPartyLongName, Users_ShortName, usergroupsid,
      UsersGrp_ShortName, Lastuser, Folders_ShortName, Comments, LastDate, a.DownloadKey, markettype, instruments, Branches_ShortName, Portfolios_ShortName, FolderGroup,b.Brokers_Name",IF(ifnull(in_FolderGroup,'')!='','',',NULL'),"
      FROM database_dynamic.alldeal_Temp a force index (_relevant_idx)
      left join database_final.kplusglobal_brokersdeft b on a.Broker=b.Brokers_ShortName WHERE  TRUE 
   ",@rownofilter,"
	AND ",IF(ifnull(in_markettype,'') = '','',CONCAT_WS(''," (ifnull(markettype,'')!='' AND  markettype IN ('",TRIM(SUBSTRING_INDEX(in_markettype,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',2),LENGTH(SUBSTRING_INDEX(in_markettype,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',3),LENGTH(SUBSTRING_INDEX(in_markettype,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',4),LENGTH(SUBSTRING_INDEX(in_markettype,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',5),LENGTH(SUBSTRING_INDEX(in_markettype,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',6),LENGTH(SUBSTRING_INDEX(in_markettype,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_markettype,',',7),LENGTH(SUBSTRING_INDEX(in_markettype,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_comments,'') = '','',CONCAT_WS(''," (ifnull(comments,'')!='' AND  comments IN ('",TRIM(SUBSTRING_INDEX(in_comments,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',2),LENGTH(SUBSTRING_INDEX(in_comments,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',3),LENGTH(SUBSTRING_INDEX(in_comments,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',4),LENGTH(SUBSTRING_INDEX(in_comments,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',5),LENGTH(SUBSTRING_INDEX(in_comments,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',6),LENGTH(SUBSTRING_INDEX(in_comments,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_comments,',',7),LENGTH(SUBSTRING_INDEX(in_comments,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_CounterPartyShortName,'') = '','',CONCAT_WS(''," (ifnull(CounterPartyShortName,'')!='' AND  CounterPartyShortName IN ('",TRIM(SUBSTRING_INDEX(in_CounterPartyShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',2),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',3),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',4),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',5),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',6),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyShortName,',',7),LENGTH(SUBSTRING_INDEX(in_CounterPartyShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_CounterPartyLongName,'') = '','',CONCAT_WS(''," (ifnull(CounterPartyLongName,'')!='' AND  CounterPartyLongName IN ('",TRIM(SUBSTRING_INDEX(in_CounterPartyLongName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',2),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',3),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',4),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',5),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',6),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_CounterPartyLongName,',',7),LENGTH(SUBSTRING_INDEX(in_CounterPartyLongName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_dealstatus,'') = '','',CONCAT_WS(''," (ifnull(dealstatus,'')!='' AND  dealstatus IN ('",TRIM(SUBSTRING_INDEX(in_dealstatus,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',2),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',3),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',4),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',5),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',6),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_dealstatus,',',7),LENGTH(SUBSTRING_INDEX(in_dealstatus,',',6))+2)),"')) and ")),"   
      ",IF(ifnull(in_TypeOfEvent,'') = '','',CONCAT_WS(''," (ifnull(TypeOfEvent,'')!='' AND  TypeOfEvent IN ('",TRIM(SUBSTRING_INDEX(in_TypeOfEvent,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',2),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',3),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',4),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',5),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',6),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_TypeOfEvent,',',7),LENGTH(SUBSTRING_INDEX(in_TypeOfEvent,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_DealType,'') = '','',CONCAT_WS(''," (ifnull(DealType,'')!='' AND  DealType IN ('",TRIM(SUBSTRING_INDEX(in_DealType,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',2),LENGTH(SUBSTRING_INDEX(in_DealType,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',3),LENGTH(SUBSTRING_INDEX(in_DealType,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',4),LENGTH(SUBSTRING_INDEX(in_DealType,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',5),LENGTH(SUBSTRING_INDEX(in_DealType,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',6),LENGTH(SUBSTRING_INDEX(in_DealType,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DealType,',',7),LENGTH(SUBSTRING_INDEX(in_DealType,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_BlockNumber,'') = '','',CONCAT_WS(''," (ifnull(BlockNumber,'')!='' AND   BlockNumber IN ('",TRIM(SUBSTRING_INDEX(in_BlockNumber,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',2),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',3),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',4),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',5),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',6),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_BlockNumber,',',7),LENGTH(SUBSTRING_INDEX(in_BlockNumber,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Amount1Min,'') = '','',CONCAT_WS('',"(",in_Amount1Min," <= Amount1) and ")),"
      ",IF(ifnull(in_Amount1Max,'') = '','',CONCAT_WS('',"(",in_Amount1Max," >= Amount1) and ")),"
      ",IF(ifnull(in_Amount2Min,'') = '','',CONCAT_WS('',"(",in_Amount2Min," <= Amount2) and ")),"
      ",IF(ifnull(in_Amount2Max,'') = '','',CONCAT_WS('',"(",in_Amount2Max," >= Amount2) and ")),"
      ",IF(ifnull(in_Rate_PriceMin,0) = 0,'',CONCAT_WS('',"(",in_Rate_PriceMin," <= Rate_Price) and ")),"
      ",IF(ifnull(in_Rate_PriceMax,0) = 0,'',CONCAT_WS('',"(",in_Rate_PriceMax," >= Rate_Price) and ")),"
      ",IF(ifnull(in_QuantityMin,'') = '','',CONCAT_WS('',"(",CAST(REPLACE(in_QuantityMin,',','.') AS DECIMAL(50,20))," <= CAST(REPLACE(Quantity,',','.') AS DECIMAL(50,20))) and ")),"
      ",IF(ifnull(in_QuantityMax,'') = '','',CONCAT_WS('',"(",CAST(REPLACE(in_QuantityMax,',','.') AS DECIMAL(50,20))," >= CAST(REPLACE(Quantity,',','.') AS DECIMAL(50,20))) and ")),"
      ",IF(ifNULL(in_Strike,'') = '','',CONCAT_WS(''," (ifNULL(Strike,'')!='' AND   Strike IN (",IF(TRIM(SUBSTRING_INDEX(in_Strike,',',1))='','NULL',CAST(TRIM(SUBSTRING_INDEX(in_Strike,',',1)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',2),LENGTH(SUBSTRING_INDEX(in_Strike,',',1))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',2),LENGTH(SUBSTRING_INDEX(in_Strike,',',1))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',3),LENGTH(SUBSTRING_INDEX(in_Strike,',',2))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',3),LENGTH(SUBSTRING_INDEX(in_Strike,',',2))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',4),LENGTH(SUBSTRING_INDEX(in_Strike,',',3))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',4),LENGTH(SUBSTRING_INDEX(in_Strike,',',3))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',5),LENGTH(SUBSTRING_INDEX(in_Strike,',',4))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',5),LENGTH(SUBSTRING_INDEX(in_Strike,',',4))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',6),LENGTH(SUBSTRING_INDEX(in_Strike,',',5))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',6),LENGTH(SUBSTRING_INDEX(in_Strike,',',5))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',7),LENGTH(SUBSTRING_INDEX(in_Strike,',',6))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Strike,',',7),LENGTH(SUBSTRING_INDEX(in_Strike,',',6))+2)) AS DECIMAL(30,17))),")) and ")),"
      ",IF(ifNULL(in_Cl_Rate,'') = '','',CONCAT_WS(''," (ifNULL(Cl_Rate,'')!='' AND   Cl_Rate IN (",IF(TRIM(SUBSTRING_INDEX(in_Cl_Rate,',',1))='','NULL',CAST(TRIM(SUBSTRING_INDEX(in_Cl_Rate,',',1)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',2),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',1))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',2),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',1))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',3),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',2))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',3),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',2))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',4),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',3))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',4),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',3))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',5),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',4))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',5),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',4))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',6),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',5))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',6),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',5))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',7),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',6))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Rate,',',7),LENGTH(SUBSTRING_INDEX(in_Cl_Rate,',',6))+2)) AS DECIMAL(30,17))),")) and ")),"
      ",IF(ifNULL(in_Cl_Margin,'') = '','',CONCAT_WS(''," (ifNULL(Cl_Margin,'')!='' AND   Cl_Margin IN (",IF(TRIM(SUBSTRING_INDEX(in_Cl_Margin,',',1))='','NULL',CAST(TRIM(SUBSTRING_INDEX(in_Cl_Margin,',',1)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',2),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',1))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',2),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',1))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',3),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',2))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',3),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',2))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',4),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',3))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',4),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',3))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',5),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',4))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',5),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',4))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',6),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',5))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',6),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',5))+2)) AS DECIMAL(30,17))),",
  ",IF(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',7),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',6))+2))='','NULL',CAST(TRIM(SUBSTR(SUBSTRING_INDEX(in_Cl_Margin,',',7),LENGTH(SUBSTRING_INDEX(in_Cl_Margin,',',6))+2)) AS DECIMAL(30,17))),")) and ")),"
      ",IF(ifNULL(in_TradeDateBegin,'') = '','',CONCAT_WS('',"('",in_TradeDateBegin,"' <= TradeDate) and ")),"
      ",IF(ifNULL(in_TradeDateEnd,'') = '','',CONCAT_WS('',"('",in_TradeDateEnd,"' >= TradeDate) and ")),"
      ",IF(ifNULL(in_ValueDateBegin,'') = '','',CONCAT_WS('',"('",in_ValueDateBegin,"' <= ValueDate) and ")),"
      ",IF(ifnull(in_ValueDateEnd,'') = '','',CONCAT_WS('',"('",in_ValueDateEnd,"' >= ValueDate) and ")),"
      ",IF(ifnull(in_MaturityDateBegin,'') = '','',CONCAT_WS('',"('",in_MaturityDateBegin,"' <= date(MaturityDate)) and ")),"
      ",IF(ifnull(in_MaturityDateEnd,'') = '','',CONCAT_WS('',"('",in_MaturityDateEnd,"' >= date(MaturityDate)) and ")),"
      ",IF(ifNULL(in_LiquidationDateBegin,'') = '','',CONCAT_WS('',"('",in_LiquidationDateBegin,"' <= LiquidationDate) and ")),"
      ",IF(ifnull(in_LiquidationDateEnd,'') = '','',CONCAT_WS('',"('",in_LiquidationDateEnd,"' >= LiquidationDate) and ")),"
      ",IF(ifnull(in_Broker,'') = '','',CONCAT_WS(''," (ifnull(Broker,'')!='' AND   Broker IN ('",TRIM(SUBSTRING_INDEX(in_Broker,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',2),LENGTH(SUBSTRING_INDEX(in_Broker,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',3),LENGTH(SUBSTRING_INDEX(in_Broker,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',4),LENGTH(SUBSTRING_INDEX(in_Broker,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',5),LENGTH(SUBSTRING_INDEX(in_Broker,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',6),LENGTH(SUBSTRING_INDEX(in_Broker,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Broker,',',7),LENGTH(SUBSTRING_INDEX(in_Broker,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Folders_ShortName,'') = '','',CONCAT_WS(''," (ifnull(Folders_ShortName,'')!='' AND  Folders_ShortName IN ('",TRIM(SUBSTRING_INDEX(in_Folders_ShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',2),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',3),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',4),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',5),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',6),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Folders_ShortName,',',7),LENGTH(SUBSTRING_INDEX(in_Folders_ShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Users_ShortName,'') = '','',CONCAT_WS(''," (ifnull(Users_ShortName,'')!='' AND  Users_ShortName IN ('",TRIM(SUBSTRING_INDEX(in_Users_ShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',2),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',3),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',4),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',5),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',6),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Users_ShortName,',',7),LENGTH(SUBSTRING_INDEX(in_Users_ShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Lastuser,'') = '','',CONCAT_WS(''," (ifnull(Lastuser,'')!='' AND   Lastuser IN ('",TRIM(SUBSTRING_INDEX(in_Lastuser,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',2),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',3),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',4),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',5),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',6),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Lastuser,',',7),LENGTH(SUBSTRING_INDEX(in_Lastuser,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_LastDateBegin,'') = '','',CONCAT_WS('',"('",in_LastDateBegin,"' <= LastDate) and ")),"
      ",IF(ifnull(in_LastDateEnd,'') = '','',CONCAT_WS('',"('",in_LastDateEnd,"' >= LastDate) and ")),"
      ",IF(ifnull(in_DownloadKey,'') = '','',CONCAT_WS(''," (ifnull(a.DownloadKey,'')!='' AND  a.DownloadKey IN ('",TRIM(SUBSTRING_INDEX(in_DownloadKey,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',2),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',3),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',4),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',5),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',6),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_DownloadKey,',',7),LENGTH(SUBSTRING_INDEX(in_DownloadKey,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_OptionType,'') = '','',CONCAT_WS(''," (ifnull(OptionType,'')!='' AND   OptionType IN ('",TRIM(SUBSTRING_INDEX(in_OptionType,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',2),LENGTH(SUBSTRING_INDEX(in_OptionType,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',3),LENGTH(SUBSTRING_INDEX(in_OptionType,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',4),LENGTH(SUBSTRING_INDEX(in_OptionType,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',5),LENGTH(SUBSTRING_INDEX(in_OptionType,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',6),LENGTH(SUBSTRING_INDEX(in_OptionType,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_OptionType,',',7),LENGTH(SUBSTRING_INDEX(in_OptionType,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Security,'') = '','',CONCAT_WS(''," (ifnull(Security,'')!='' AND   Security IN ('",TRIM(SUBSTRING_INDEX(in_Security,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',2),LENGTH(SUBSTRING_INDEX(in_Security,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',3),LENGTH(SUBSTRING_INDEX(in_Security,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',4),LENGTH(SUBSTRING_INDEX(in_Security,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',5),LENGTH(SUBSTRING_INDEX(in_Security,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',6),LENGTH(SUBSTRING_INDEX(in_Security,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Security,',',7),LENGTH(SUBSTRING_INDEX(in_Security,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_SecurityDesc,'') = '','',CONCAT_WS(''," (ifnull(SecurityDesc,'')!='' AND   SecurityDesc IN ('",TRIM(SUBSTRING_INDEX(in_SecurityDesc,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',2),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',3),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',4),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',5),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',6),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_SecurityDesc,',',7),LENGTH(SUBSTRING_INDEX(in_SecurityDesc,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_deal_id_new,'') = '','',CONCAT_WS(''," (ifnull(deal_id_new,'')!='' AND  deal_id_new IN ('",TRIM(SUBSTRING_INDEX(in_deal_id_new,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',2),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',3),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',4),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',5),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',6),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_deal_id_new,',',7),LENGTH(SUBSTRING_INDEX(in_deal_id_new,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_inputmode,'') = '','',CONCAT_WS(''," (ifnull(inputmode,'')!='' AND  inputmode IN ('",TRIM(SUBSTRING_INDEX(in_inputmode,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',2),LENGTH(SUBSTRING_INDEX(in_inputmode,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',3),LENGTH(SUBSTRING_INDEX(in_inputmode,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',4),LENGTH(SUBSTRING_INDEX(in_inputmode,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',5),LENGTH(SUBSTRING_INDEX(in_inputmode,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',6),LENGTH(SUBSTRING_INDEX(in_inputmode,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_inputmode,',',7),LENGTH(SUBSTRING_INDEX(in_inputmode,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_UsersGrp_ShortName,'') = '','',CONCAT_WS(''," (ifnull(UsersGrp_ShortName,'')!='' AND  UsersGrp_ShortName IN ('",TRIM(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',2),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',3),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',4),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',5),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',6),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',7),LENGTH(SUBSTRING_INDEX(in_UsersGrp_ShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Branches_ShortName,'') = '','',CONCAT_WS(''," (ifnull(Branches_ShortName,'')!='' AND  Branches_ShortName IN ('",TRIM(SUBSTRING_INDEX(in_Branches_ShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',2),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',3),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',4),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',5),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',6),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Branches_ShortName,',',7),LENGTH(SUBSTRING_INDEX(in_Branches_ShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_Portfolios_ShortName,'') = '','',CONCAT_WS(''," (ifnull(Portfolios_ShortName,'')!='' AND  Portfolios_ShortName IN ('",TRIM(SUBSTRING_INDEX(in_Portfolios_ShortName,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',2),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',3),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',4),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',5),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',6),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_Portfolios_ShortName,',',7),LENGTH(SUBSTRING_INDEX(in_Portfolios_ShortName,',',6))+2)),"')) and ")),"
      ",IF(ifnull(in_brokername,'') = '','',CONCAT_WS(''," (ifnull(b.Brokers_Name,'')!='' AND   b.Brokers_Name IN ('",TRIM(SUBSTRING_INDEX(in_brokername,',',1)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',2),LENGTH(SUBSTRING_INDEX(in_brokername,',',1))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',3),LENGTH(SUBSTRING_INDEX(in_brokername,',',2))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',4),LENGTH(SUBSTRING_INDEX(in_brokername,',',3))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',5),LENGTH(SUBSTRING_INDEX(in_brokername,',',4))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',6),LENGTH(SUBSTRING_INDEX(in_brokername,',',5))+2)),"',
  '",TRIM(SUBSTR(SUBSTRING_INDEX(in_brokername,',',7),LENGTH(SUBSTRING_INDEX(in_brokername,',',6))+2)),"')) and "))," TRUE;")
      ;  

DROP TABLE IF EXISTS database_viewbuilding.all_param_tmp;
CREATE TABLE IF NOT  EXISTS database_viewbuilding.all_param_tmp select @query_FILTER;
			PREPARE stmt FROM @query_FILTER;
						EXECUTE stmt;
						DEALLOCATE PREPARE stmt;


SET in_FolderGroup=TRIM(in_FolderGroup);
	IF(ifnull(in_FolderGroup,'')!='')   
	THEN	  
INSERT INTO all_deal_search_view_dyn 
SELECT in_lang, DealTypeBonds, DealTypeEquity, DealTypeWarrant, DealTypeIAM, DealTypeRepo, DealTypeSecu, DealTypeCashFlow, DealTypeLoanDepo, DealTypeCallAcc, DealTypeFXSwap, DealTypeSpot, DealTypeForward,
      DealTypeIndexOp, DealTypeEquityOp, DealTypeCurrencyOp, DealTypeFutureOp, DealTypeFuture, Deal_Id, t.deal_id_new, dealstatus, inputmode, t.TypeOfDeal, DealType, OptionType, TypeOfEvent, BlockNumber, Amount1, Amount2,
      Rate_Price, Strike, Cl_Rate, Cl_Margin, Security, SecurityDesc, TradeDate, ValueDate, MaturityDate, LiquidationDate, CAST(Quantity AS DECIMAL(20,8)), Broker, CounterPartyShortName, CounterPartyLongName, Users_ShortName, usergroupsid,
      UsersGrp_ShortName, Lastuser, Folders_ShortName, Comments, LastDate, t.DownloadKey, markettype, instruments, Branches_ShortName, Portfolios_ShortName, f5.FolderGroup,Brokers_Name ,NULL
  FROM database_dynamic.all_deals_temp_FILTER t   
  JOIN database_dynamic.all_deals_FOLDER_SEARCH f5 ON t.deal_id_new=f5.deal_id_new AND t.TypeOfDeal=f5.TypeOfDeal
  WHERE
       (ifnull(in_FolderGroup,'') = '' or (ifnull(f5.FolderGroup,'')!='' AND  f5.FolderGroup IN (TRIM(SUBSTRING_INDEX(in_FolderGroup,',',1)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',2),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',1))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',3),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',2))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',4),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',3))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',5),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',4))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',6),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',5))+2)),
  TRIM(SUBSTR(SUBSTRING_INDEX(in_FolderGroup,',',7),LENGTH(SUBSTRING_INDEX(in_FolderGroup,',',6))+2)))))
    ;  

 
 END IF;   
  END IF;
  END IF;
	DROP TABLE IF EXISTS database_dynamic.all_deals_temp_FILTER; 
END
$$

DELIMITER ;