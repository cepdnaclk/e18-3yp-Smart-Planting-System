-- Create the database
DROP DATABASE smart_planting_system;

CREATE DATABASE smart_planting_system;

USE smart_planting_system;

CREATE TABLE IF NOT EXISTS user_table(
    userID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    mobileNo VARCHAR(15),
    joinDate DATETIME,
    profileImg LONGBLOB
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS password_table(
    userID INT NOT NULL PRIMARY KEY,
    userPassword VARCHAR(100) NOT NULL,
    createDate DATETIME
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS plant_owner_table(
    plantID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    plantTypeID VARCHAR(5),
    addedDate DATETIME
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS plants_database_table(
    plantTypeID VARCHAR(5) NOT NULL PRIMARY KEY,
    commonName VARCHAR(150),
    scientificName VARCHAR(200),
    height INT,
    habit VARCHAR(20),
    growth VARCHAR(1),
    shade VARCHAR(3),
    soil VARCHAR(3),
    soilMoisture VARCHAR(4),
    minTemp INT,
    maxTemp INT,
    minPH DECIMAL(2,1),
    maxPH DECIMAL(2,1),
    edible BOOLEAN
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS plants_status_table(
    dataID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    plantID INT,
    readTime DATETIME,
    temperature DECIMAL(3, 2),
    soilMoisture DECIMAL(3, 2),
    waterLevel DECIMAL(3, 2),
    lightIntensity DECIMAL(3, 2)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

/* Add foreign keys */
ALTER TABLE password_table
ADD FOREIGN KEY (userID) REFERENCES user_table(userID);

ALTER TABLE plant_owner_table
ADD FOREIGN KEY (userID) REFERENCES user_table(userID);

ALTER TABLE plant_owner_table
ADD FOREIGN KEY (plantTypeID) REFERENCES plants_database_table(plantTypeID);

ALTER TABLE plants_status_table
ADD FOREIGN KEY (plantID) REFERENCES plant_owner_table(plantID);

ALTER TABLE password_table
ADD FOREIGN KEY (userID) REFERENCES user_table(userID);

-- Auto increment values
ALTER TABLE user_table AUTO_INCREMENT = 1001;
ALTER TABLE plant_owner_table AUTO_INCREMENT = 10001;
ALTER TABLE plants_status_table AUTO_INCREMENT = 1;


/* Stored procedures for add data into tables. */

-- Stored procedure to add data into user table password
-- If user exists, return -1, if a new user: return new userID
DELIMITER //

CREATE PROCEDURE AddUser(IN uName VARCHAR(100), IN uEmail VARCHAR(100), IN uMobile VARCHAR(15), IN uPassword VARCHAR(100), IN jDate DATETIME)

BEGIN
    DECLARE newUserID INT;
    DECLARE entryCount INT;

    SELECT COUNT(*) INTO entryCount FROM user_table WHERE user_table.email = uEmail;

    IF entryCount > 0 THEN
        SELECT -1 AS userID;
    ELSE 
        BEGIN
            INSERT INTO user_table (userName, email, mobileNo, joinDate)
            VALUES (uName, uEmail, uMobile, jDate);

            SELECT userID INTO newUserID FROM user_table WHERE user_table.email = uEmail;

            INSERT INTO password_table(userID, userPassword, createDate)
            VALUES (newUserID, uPassword, jDate);

            SELECT userID FROM user_table WHERE user_table.email = uEmail;
        END;

    END IF;

END//

DELIMITER ;

-- Update Password. Return userID
DELIMITER //

CREATE PROCEDURE UpdatePassword(IN uEmail VARCHAR(100), IN uPassword VARCHAR(100), IN newDate DATETIME)

BEGIN
    DECLARE newUserID INT;
    DECLARE entryCount INT;

    SELECT userID INTO newUserID FROM user_table WHERE user_table.email = uEmail;

    SELECT COUNT(*) INTO entryCount FROM password_table WHERE password_table.userID = newUserID;

    IF entryCount = 0 THEN
        INSERT INTO password_table(userID, userPassword, createDate) VALUES (newUserID, uPassword, joinDate);
    ELSEIF entryCount = 1 THEN
        UPDATE password_table SET password_table.userPassword = uPassword, password_table.createDate = newDate WHERE password_table.userID = newUserID;
    END IF;

    SELECT userID FROM user_table WHERE user_table.email = uEmail;

END//

DELIMITER ;

-- Add Plant to a user
DELIMITER //

CREATE PROCEDURE AddPlantUser(IN uEmail VARCHAR(100), IN pTypeID VARCHAR(5), IN addDate DATETIME)

BEGIN
    DECLARE newUserID INT;
    DECLARE entryCount INT;

    SELECT COUNT(*) INTO entryCount FROM user_table WHERE user_table.email = uEmail;

    IF entryCount = 0 THEN
        SELECT -1 AS plantID;
    ELSE 
        BEGIN

            SELECT userID INTO newUserID FROM user_table WHERE user_table.email = uEmail;

            INSERT INTO plant_owner_table(userID, plantTypeID, addedDate)
            VALUES (newUserID, pTypeID, addDate);

            SELECT plantID FROM plant_owner_table ORDER BY userID DESC LIMIT 1;

        END;

    END IF;

END//

DELIMITER ;

-- Get next plant ID from plant database table
DELIMITER //

CREATE PROCEDURE NextPlantID()

BEGIN
    DECLARE plantID VARCHAR(5);
    DECLARE lastID VARCHAR(5);
    DECLARE nextID VARCHAR(5);
    DECLARE lastIDInt INT;
    DECLARE entryCount INT;

    SELECT COUNT(*) INTO entryCount FROM plants_database_table;

    IF entryCount = 0 THEN
        SELECT 'P0001' AS plantID;
    ELSE 
        BEGIN
            SELECT plantTypeID INTO lastID FROM plants_database_table ORDER BY plantTypeID DESC LIMIT 1;
            SELECT SUBSTR(lastID, 2) INTO lastID;
            SELECT CAST(lastID AS SIGNED) INTO lastIDInt;
            SET lastIDInt = lastIDInt + 1;
            SELECT RIGHT(CONCAT('0000', CAST(lastIDInt AS CHAR)), 4) INTO nextID;
            SELECT CONCAT('P', nextID) INTO nextID;
            SELECT nextID;
        END;

    END IF;

END//

DELIMITER ;

-- Add new plant to plants database table
DELIMITER //

CREATE PROCEDURE AddPlantToDB(IN cName VARCHAR(150), IN sciName VARCHAR(200), IN pHeight INT,
 IN pHabit VARCHAR(20), IN pGrowth VARCHAR(1), IN pShade VARCHAR(3), IN pSoil VARCHAR(3), IN pSoilMoist VARCHAR(4),
 IN pMinTemp INT, IN pMaxTemp INT, IN pMinPH DECIMAL(2, 1), IN pMaxPH DECIMAL(2, 1), IN pEdible BOOLEAN)

BEGIN
    DECLARE plantID VARCHAR(5);
    DECLARE lastID VARCHAR(5);
    DECLARE nextID VARCHAR(5);
    DECLARE lastIDInt INT;
    DECLARE entryCount INT;

    SELECT COUNT(*) INTO entryCount FROM plants_database_table;

    IF entryCount = 0 THEN
        SELECT 'P0001' INTO nextID;
    ELSE 
        BEGIN
            SELECT plantTypeID INTO lastID FROM plants_database_table ORDER BY plantTypeID DESC LIMIT 1;
            SELECT SUBSTR(lastID, 2) INTO lastID;
            SELECT CAST(lastID AS SIGNED) INTO lastIDInt;
            SET lastIDInt = lastIDInt + 1;
            SELECT RIGHT(CONCAT('0000', CAST(lastIDInt AS CHAR)), 4) INTO nextID;
            SELECT CONCAT('P', nextID) INTO nextID;
        END;

    END IF;

    INSERT INTO plants_database_table(plantTypeID, commonName, scientificName, height, habit, growth, shade, soil, soilMoisture, minTemp, maxTemp, minPH, maxPH, edible)
    VALUES(nextID, cName, sciName, pHeight,pHabit, pGrowth, pShade, pSoil, pSoilMoist, pMinTemp, pMaxTemp, pMinPH, pMaxPH, pEdible);
    
    SELECT nextID;

END//

DELIMITER ;

-- Populate tables
CALL AddUser('Osmond Platt','osm.plat@acusage.net', '+942946008', 'abc123', '2022-12-01 08:22:13');
CALL AddUser('Walmer Hageman','walme-ha@arvinmeritor.info', '+6774368358', 'abcd1234', '2022-11-20 13:00:13');
CALL AddUser('Tavish Cruce','tavish.cru@egl-inc.info', '+5549549421', 'tavish999', '2022-12-05 00:55:10');
CALL AddUser('Girija Aron','giriaro@acusage.net', '+66963116836', '9876', '2022-11-30 05:20:45');
CALL AddUser('Ismena Boehme','ismen-bo@arketm(ay.com', '+914749490', '123456abcdef', '2022-12-02 15:35:10');
