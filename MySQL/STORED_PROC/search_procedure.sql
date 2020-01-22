DELIMITER $$


DROP PROCEDURE IF EXISTS search_proc$$

CREATE PROCEDURE search_proc(  
	in_searchtext text  CHARACTER SET utf8 COLLATE utf8_general_ci
  ,in_schema varchar(255)
  ,in_table varchar(255)
  ,in_column varchar(255)
)
  SQL SECURITY INVOKER
BEGIN 
   DECLARE v_text varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci;
   DECLARE v_searchcomment text; 
   DECLARE v_searcount text;  
   DECLARE v_temptablename varchar(255); 
   DECLARE v_sch varchar(255); 
   DECLARE v_tab varchar(255); 
   DECLARE v_counter int; 
   DECLARE leng int; 
   DECLARE done int; 
  DECLARE cur_search CURSOR FOR 
   SELECT CONCAT("SELECT * FROM `",TABLE_SCHEMA,'`.`',TABLE_NAME,'` WHERE ',GROUP_CONCAT(CONCAT('`',COLUMN_NAME,'` LIKE "',v_text,'"') SEPARATOR ' OR '),';') AS searchcomment ,
  CONCAT("SELECT COUNT(*) INTO @counter",v_temptablename," FROM `",TABLE_SCHEMA,'`.`',TABLE_NAME,'` WHERE ',GROUP_CONCAT(CONCAT('`',COLUMN_NAME,'` LIKE "',v_text,'"') SEPARATOR ' OR '),';') AS searcount   ,
    TABLE_SCHEMA,TABLE_NAME
  FROM information_schema.COLUMNS WHERE 
  IF(in_schema!='',TABLE_SCHEMA LIKE in_schema,TRUE) AND 
  IF(in_table!='',TABLE_NAME LIKE in_table,TRUE) AND 
  IF(in_column!='',COLUMN_NAME LIKE in_column,TRUE) AND COLUMN_NAME!='_row_no_' AND CHARACTER_MAXIMUM_LENGTH>=leng
GROUP BY TABLE_SCHEMA,TABLE_NAME;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  SET done = 0; 
  SET v_text=in_searchtext;
SET leng = LENGTH(REPLACE(v_text,'%',''));

SET SESSION group_concat_max_len = 99999999;

  SET v_temptablename=CONCAT('searchresults_',(SELECT REPLACE(CURRENT_USER(),'@%','')),'_',DATE_FORMAT(NOW(),'%Y_%m_%d_%h_%i_%s'));
  SET @sql=CONCAT('DROP TABLE IF EXISTS ',v_temptablename,';');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;


  SET @sql=CONCAT('CREATE TABLE ',v_temptablename,'
  (
	SCHEMA_NAME			CHAR(255),
	TABLE_NAME			CHAR(255),
	counter			    int,
	select_script 	text
) ENGINE = MyISAM
  ;');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;


    SET @sql=CONCAT('INSERT INTO ',v_temptablename,' 
  SELECT "',in_schema,'","',in_table,'",','NULL',",'",v_text,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;
  
  open cur_search; 
    searchLoop: loop 
      fetch cur_search into v_searchcomment,v_searcount,v_sch,v_tab; 
      if done = 1 then leave searchLoop; end if; 

      SET @qry=CONCAT('SET @counter',v_temptablename,' =0;');
            PREPARE statement FROM @qry;
            EXECUTE statement;

            SET @qry = v_searcount;
            PREPARE statement FROM @qry;
            EXECUTE statement;


  SET @sql=CONCAT('INSERT INTO ',v_temptablename,' 
  SELECT "',v_sch,'","',v_tab,'",@counter',v_temptablename,",'",v_searchcomment,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;


 SET @sql=CONCAT('DELETE FROM ',v_temptablename,' WHERE counter=0;');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;
   
  END LOOP searchLoop; 
  CLOSE cur_search; 

  

  END
$$

DELIMITER ;
