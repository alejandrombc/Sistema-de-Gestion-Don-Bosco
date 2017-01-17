CREATE DATABASE don_bosco
drop table if exists anos_escolares;

CREATE TABLE anos_escolares (ID int NOT NULL AUTO_INCREMENT, inicial VARCHAR(4), final VARCHAR(4), eliminada BOOL NOT NULL DEFAULT '0', PRIMARY KEY (ID));

CREATE TABLE secciones (ID int NOT NULL AUTO_INCREMENT, ano VARCHAR(6), curso VARCHAR(20), ano_escolar VARCHAR(10), secciones VARCHAR(2), PRIMARY KEY (ID));
