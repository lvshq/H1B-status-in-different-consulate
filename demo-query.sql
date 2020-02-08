# 1. Create table
CREATE TABLE `H1B-status` (
    `visa-type` TEXT,
    `visa-entry` TEXT,
    `consulate` TEXT,
    `major` TEXT,
    `status` TEXT,
    `check-date` TEXT,
    `complete-date` TEXT,
    `waiting-days` INT
) CHARACTER SET utf8mb4;

# 2. Do query
# Clear H1 visa in Beijing
SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Clear" AND `consulate` = "BeiJing";
# Pending H1 visa in Beijing
SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Pending" AND `consulate` = "BeiJing";
# Clear H1 visa in Guangzhou
SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Clear" AND `consulate` = "GuangZhou";
# Pending H1 visa in Beijing
SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Pending" AND `consulate` = "GuangZhou";
# Waiting days
SELECT AVG(`waiting-days`) FROM `H1B-status` WHERE `visa-type` = "H1" AND `consulate` = "BeiJing";
SELECT AVG(`waiting-days`) FROM `H1B-status` WHERE `visa-type` = "H1" AND `consulate` = "GuangZhou";
