
  DROP TABLE IF EXISTS users_n_stuff;
CREATE TABLE users_n_stuff
  SELECT 'myname' AS usern, 'mypw' AS pw UNION 
  SELECT 'yourname', 'yourpw';

DELIMITER $$

DROP PROCEDURE IF EXISTS grantuser$$

CREATE PROCEDURE grantuser()
  SQL SECURITY INVOKER
BEGIN 
	DECLARE v_user	CHAR(255) DEFAULT ''; 
	DECLARE v_pw	CHAR(255) DEFAULT ''; 
  DECLARE v_localhost CHAR(255) DEFAULT ''; 
  DECLARE done1 int; 
  DECLARE cur_merge CURSOR FOR 
SELECT usern,pw FROM users_n_stuff; 
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1=1;
  SET done1 = 0; 

SET v_localhost='%';

  open cur_merge; 
    mergeLoop: loop 
      fetch cur_merge into v_user,v_pw; 
      if done1 = 1 then leave mergeLoop; end if; 


SET @sql=CONCAT("GRANT ALL ON * . * TO '",v_user,"'@'",v_localhost,"' IDENTIFIED BY '",v_pw,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

SET @sql=CONCAT("REVOKE CREATE USER ON *.* FROM '",v_user,"'@'",v_localhost,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

SET @sql=CONCAT("REVOKE GRANT OPTION ON *.* FROM '",v_user,"'@'",v_localhost,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

SET @sql=CONCAT("REVOKE SHUTDOWN ON *.* FROM '",v_user,"'@'",v_localhost,"';");
    PREPARE stmt1 FROM @sql; 
    EXECUTE stmt1; 
    DEALLOCATE PREPARE stmt1; 

FLUSH PRIVILEGES;

  END LOOP mergeLoop; 
  CLOSE cur_merge; 
END
$$

DELIMITER ;

CALL grantuser();

DROP PROCEDURE IF EXISTS grantuser;

DROP TABLE IF EXISTS users_n_stuff;

