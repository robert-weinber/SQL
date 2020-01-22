USE database_viewbuilding;

DELIMITER $$


DROP PROCEDURE IF EXISTS MANDT_MERGER$$

CREATE PROCEDURE MANDT_MERGER()
  SQL SECURITY INVOKER
BEGIN 
	DECLARE v_tab	CHAR(100) DEFAULT ''; 
  DECLARE done1 int; 
  DECLARE cur_merge CURSOR FOR SELECT TABLE_NAME FROM database_viewbuilding.table_list GROUP BY TABLE_NAME; 
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1=1; 
  SET done1 = 0; 
  
  CREATE TABLE IF NOT EXISTS database_viewbuilding.MANDT_MERGER_LOG
(
	TABLE_N			VARCHAR(100),
  COMMAND			TEXT,
	TIMEST			timestamp
) ENGINE = MyISAM;


  open cur_merge; 
    mergeLoop: loop 
      fetch cur_merge into v_tab; 
      if done1 = 1 then leave mergeLoop; end if; 
      SET @sql=(SELECT CONCAT(
  'CREATE TABLE IF NOT EXISTS database_final.',TABLE_NAME,'
    ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci
  ',
  GROUP_CONCAT( CONCAT('SELECT *, "',
CASE TABLE_SCHEMA
  WHEN 'database_001_final' THEN '001'
  WHEN 'database_002_final' THEN '002'
  WHEN 'database_004_final' THEN '004'
  END
,'" AS MANDT_MERGED FROM ',TABLE_SCHEMA,'.',TABLE_NAME,'
') SEPARATOR ' UNION 
') ,';'
) FROM database_viewbuilding.table_list WHERE TABLE_NAME=v_tab
    ); 

      IF((SELECT COUNT(*) FROM database_viewbuilding.MANDT_MERGER_LOG WHERE COMMAND=@sql)=0) THEN
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

      INSERT INTO database_viewbuilding.MANDT_MERGER_LOG SELECT v_tab,@sql,NOW();
      END IF;

      SET @sql=CONCAT('ALTER TABLE database_final.',v_tab,' DROP COLUMN _row_no_;'); 

      IF((SELECT COUNT(*) FROM database_viewbuilding.MANDT_MERGER_LOG WHERE COMMAND=@sql)=0) THEN

    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

      INSERT INTO database_viewbuilding.MANDT_MERGER_LOG SELECT v_tab,@sql,NOW();
      END IF;

      SET @sql=CONCAT('ALTER TABLE database_final.',v_tab,' ADD COLUMN _row_no_ bigint AUTO_INCREMENT PRIMARY KEY NOT NULL;'); 

      IF((SELECT COUNT(*) FROM database_viewbuilding.MANDT_MERGER_LOG WHERE COMMAND=@sql)=0) THEN

    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

      INSERT INTO database_viewbuilding.MANDT_MERGER_LOG SELECT v_tab,@sql,NOW();
      END IF;

  END LOOP mergeLoop; 
  CLOSE cur_merge; 
END
$$

DELIMITER ;




  CREATE TABLE IF NOT EXISTS database_viewbuilding.MANDT_MERGER_LOG
(
	TABLE_N			VARCHAR(100),
  COMMAND			TEXT,
	TIMEST			timestamp
) ENGINE = MYISAM CHARACTER SET utf8 COLLATE utf8_general_ci;