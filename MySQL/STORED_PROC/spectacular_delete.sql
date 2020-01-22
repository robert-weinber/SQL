CREATE DATABASE IF NOT EXISTS test;
DELIMITER $$


DROP PROCEDURE IF EXISTS test.spectacular_delete$$

CREATE PROCEDURE test.spectacular_delete()
BEGIN 
  

    CREATE TABLE IF NOT EXISTS test.DEL_LOG
(
	
  COMMAND			TEXT
) ENGINE = MyISAM;
  TRUNCATE test.DEL_LOG;


    DROP TABLE IF EXISTS test.SCHTMP;
    CREATE TABLE IF NOT EXISTS test.SCHTMP SELECT SCHEMA_NAME
      FROM information_schema.SCHEMATA t WHERE SCHEMA_NAME NOT IN ('information_schema','_instance','mysql','performance_schema','hashes');
  ALTER TABLE test.SCHTMP ADD COLUMN num bigint NOT NULL PRIMARY KEY AUTO_INCREMENT;



      INSERT into test.DEL_LOG SELECT 'SET foreign_key_checks = 0;';

      INSERT into test.DEL_LOG SELECT 'CREATE DATABASE IF NOT EXISTS hashes;';

      
      INSERT into test.DEL_LOG SELECT CONCAT('RENAME TABLE `',TABLE_SCHEMA,'`.`',TABLE_NAME,'` TO `hashes`.`',CONCAT(TABLE_NAME,'_',t2.num),'`;')
      FROM information_schema.TABLES t 
  LEFT JOIN test.SCHTMP t2 ON t.TABLE_SCHEMA=t2.SCHEMA_NAME
  WHERE t.TABLE_SCHEMA  LIKE '%hash%' OR t.TABLE_NAME  LIKE '%hash%' AND TABLE_SCHEMA NOT IN ('information_schema','_instance','mysql','performance_schema','hashes');



      
      INSERT into test.DEL_LOG SELECT CONCAT('DROP TABLE `',TABLE_SCHEMA,'`.`',TABLE_NAME,'`;')
      FROM information_schema.TABLES t WHERE t.TABLE_SCHEMA NOT LIKE '%hash%' AND t.TABLE_NAME NOT LIKE '%hash%' AND TABLE_SCHEMA NOT IN ('information_schema','_instance','mysql','performance_schema','hashes');



      
      INSERT into test.DEL_LOG SELECT CONCAT('DROP DATABASE IF EXISTS `',SCHEMA_NAME,'`;')
      FROM test.SCHTMP;


      INSERT into test.DEL_LOG SELECT 'SET foreign_key_checks = 1;';




END
$$

DELIMITER ;

CALL test.spectacular_delete();

SELECT * FROM test.DEL_LOG;
