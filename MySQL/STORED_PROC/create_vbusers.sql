
  DROP TABLE IF EXISTS users_n_stuff;
CREATE TABLE users_n_stuff
  SELECT 'My Name' as fullname,'mn' as usern,'nm@company.com' as mail, 'AN4N8aWFETxa/R7C++eGaRbkBbq5oEHmVjfVzNx/isr2Ff32/OEHdEQ1RKRREq4lHw==' AS pwh UNION 
  SELECT 'Your Name','yn','yn@company.com','ACNrEyBAR53KcJbLUkKdWdxtUHNFJ4arJYY11z3E9PKFPf2c9vd4Qd8ksCVoDGAyLA==' ;

DELIMITER $$

DROP PROCEDURE IF EXISTS makeusers$$

CREATE PROCEDURE makeusers()
  SQL SECURITY INVOKER
BEGIN 
	DECLARE v_fullname	CHAR(255) DEFAULT ''; 
	DECLARE v_user	CHAR(255) DEFAULT ''; 
	DECLARE v_pwh	CHAR(255) DEFAULT ''; 
	DECLARE v_mail	CHAR(255) DEFAULT '' COLLATE utf8_german2_ci; 
  DECLARE v_newid int; 
  DECLARE done1 int; 
  DECLARE cur_merge CURSOR FOR 
SELECT fullname,usern, mail, pwh FROM users_n_stuff; 
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done1=1;
  SET done1 = 0; 


SET v_newid=(SELECT MAX(id) from viewbox.users);

  open cur_merge; 
    mergeLoop: loop 
      fetch cur_merge into v_fullname,v_user,v_mail,v_pwh; 
      if done1 = 1 then leave mergeLoop; end if; 

SET v_newid=v_newid+1;

INSERT IGNORE INTO viewbox.users
SELECT 
v_newid,
v_fullname,
  NOW(),
v_mail,
  	1	,
  v_pwh,
    'f5e4146d-bca4-4237-9ef6-9c49f76446fd',
  	NULL,0,0,NULL,0,0,
v_user,
  	NOW(),
	0,0,NULL,NULL,0;


  

  END LOOP mergeLoop; 
  CLOSE cur_merge; 

INSERT INTO viewbox.user_roles
  SELECT u.id,(SELECT id FROM viewbox.roles WHERE name='Admin'),null
    FROM viewbox.users u 
	JOIN users_n_stuff x on usern=user_name
	WHERE id NOT IN (SELECT user_id FROM viewbox.user_roles)
;
END
$$

DELIMITER ;

CALL makeusers();

DROP PROCEDURE IF EXISTS makeusers;

DROP TABLE IF EXISTS users_n_stuff;