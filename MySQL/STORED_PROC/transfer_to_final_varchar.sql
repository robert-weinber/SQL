DELIMITER $$


DROP PROCEDURE IF EXISTS transferasvarchar$$

CREATE PROCEDURE transferasvarchar( 
  in_table varchar(255),
  in_trans varchar(255),
  in_final varchar(255)
)
  SQL SECURITY INVOKER
BEGIN 
   DECLARE col_name varchar(255); 
   DECLARE v_text varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci;
   DECLARE done int; 
  DECLARE cur_search CURSOR FOR 
   SELECT COLUMN_NAME
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = in_trans AND TABLE_NAME = in_table;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  SET done = 0; 

SET SESSION group_concat_max_len = 99999999;

  SET @sql=CONCAT('DROP TABLE IF EXISTS ',in_final,'.',in_table,';');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;


  SET v_text=CONCAT('CREATE TABLE ',in_final,'.',in_table,'  (');
  
  open cur_search; 
    searchLoop: loop 
      fetch cur_search into col_name; 
      if done = 1 then leave searchLoop; end if; 
	SET @colmax :=0;
 SET @command=CONCAT('SELECT MAX(LENGTH(',col_name,')) INTO @colmax FROM ',in_trans,'.',in_table,';');
PREPARE stmt1 FROM @command; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;
			
      IF RIGHT(v_text,1)='(' THEN 
      SET v_text = CONCAT(v_text,'  ',col_name,' varchar(',@colmax,')');
      ELSE
      SET v_text = CONCAT(v_text,' , ',col_name,' varchar(',@colmax,')');
	    END IF;
   
  END LOOP searchLoop; 
  CLOSE cur_search; 

  SET v_text = CONCAT(v_text,') ENGINE = MyISAM;');

SELECT v_text;
    SET @sql=v_text;
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;

  
    SET @sql=CONCAT('INSERT INTO ',in_final,'',in_table,' 
  SELECT * FROM ',in_trans,'.',in_table,';');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;

    SET @sql=CONCAT('ALTER TABLE ',in_final,'',in_table,' ADD COLUMN _row_no_ bigint PRIMARY KEY NOT NULL AUTO_INCREMENT;');
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1;

  END
$$

DELIMITER ;

/*
CALL transferasvarchar('davsql_sb_sb2600','deinzer_weyland_sangross_17022020_transfer','deinzer_weyland_sangross_final');
CALL transferasvarchar('davsql_sd_sd151''deinzer_weyland_sangross_17022020_transfer','deinzer_weyland_sangross_final',);
CALL transferasvarchar('davsql_sd_sd601''deinzer_weyland_sangross_17022020_transfer','deinzer_weyland_sangross_final');
*/
