-- Create the database
CREATE DATABASE smart_planting_system;

USE smart_planting_system;

CREATE TABLE IF NOT EXISTS user_table(
    userID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
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
