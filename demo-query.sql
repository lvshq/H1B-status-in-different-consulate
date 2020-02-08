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
## Joint query

SELECT
    t1.BJ_pending, t1.BJ_clear, 1.0*t1.BJ_pending / (t1.BJ_pending + t1.BJ_clear) AS BJ_check_rate, t1.BJ_avg_wait_days, 
    t1.GZ_pending, t1.GZ_clear, 1.0*t1.GZ_pending / (t1.GZ_pending + t1.GZ_clear) AS GZ_check_rate, t1.GZ_avg_wait_days,
    t1.SH_pending, t1.SH_clear, 1.0*t1.SH_pending / (t1.SH_pending + t1.SH_clear) AS SH_check_rate, t1.SH_avg_wait_days
FROM
(SELECT
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Clear" AND `consulate` = "BeiJing") AS BJ_clear,
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Pending" AND `consulate` = "BeiJing") AS BJ_pending,
    (SELECT AVG(`waiting-days`) FROM `H1B-status` WHERE `visa-type` = "H1" AND `consulate` = "BeiJing") AS BJ_avg_wait_days,
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Clear" AND `consulate` = "GuangZhou") AS GZ_clear,
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Pending" AND `consulate` = "GuangZhou") AS GZ_pending,
    (SELECT AVG(`waiting-days`) FROM `H1B-status` WHERE `visa-type` = "H1" AND `consulate` = "GuangZhou") AS GZ_avg_wait_days,
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Clear" AND `consulate` = "ShangHai") AS SH_clear,
    (SELECT COUNT(*) FROM `H1B-status` WHERE `visa-type` = "H1" AND `status` = "Pending" AND `consulate` = "ShangHai") AS SH_pending,
    (SELECT AVG(`waiting-days`) FROM `H1B-status` WHERE `visa-type` = "H1" AND `consulate` = "ShangHai") AS SH_avg_wait_days) AS t1;

## Separate query
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
