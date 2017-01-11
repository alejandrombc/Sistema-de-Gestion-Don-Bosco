CREATE DATABASE don_bosco
drop table if exists anos_escolares;

CREATE TABLE anos_escolares (ID int NOT NULL AUTO_INCREMENT, inicial VARCHAR(4), final VARCHAR(4), eliminada BOOL NOT NULL DEFAULT '0', PRIMARY KEY (ID));