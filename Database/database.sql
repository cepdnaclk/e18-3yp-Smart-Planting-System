
-- Create the database
CREATE DATABASE smart_planting_system;

USE smart_planting_system;

CREATE TABLE IF NOT EXISTS user_table(
    userID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    mobileNo INT,
    joinDate DATETIME,
    profileImg LONGBLOB
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS password_table(
    userID INT NOT NULL PRIMARY KEY,
    userPassword VARCHAR(100) NOT NULL,
    createDate DATETIME
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS plant_owner_table(
    plantID INT NOT NULL PRIMARY KEY,
    userID INT NOT NULL,
    plantTypeID VARCHAR(20),
    addedDate DATETIME
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS plants_database_table(
    plantTypeID VARCHAR(20) NOT NULL PRIMARY KEY,
    commonName VARCHAR(150),
    sciencetificName VARCHAR(200),
    height DECIMAL(5, 3),
    habit VARCHAR(50),
    growth VARCHAR(1),
    shade VARCHAR(3),
    soil VARCHAR(3),
    soilMoisture VARCHAR(4),
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

-- Populate tables
