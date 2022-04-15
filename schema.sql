use DB122;
DROP TABLE estimation;
DROP TABLE homes;
DROP TABLE offices;
DROP TABLE categories;
DROP TABLE properties;
DROP TABLE area;
DROP TABLE connections;
DROP TABLE estimator;



CREATE TABLE estimator
				(eage INTEGER,
				sex VARCHAR(10),
				elname VARCHAR(20),
				ecode INTEGER,
				efname VARCHAR(20),
				eadress VARCHAR(20),
				PRIMARY KEY(ecode));

CREATE TABLE connections
				(connectionumber INTEGER,
				ctimedate DATETIME,
				cduration INTEGER,
				ecode INTEGER,
				PRIMARY KEY(ecode,connectionumber));
				
CREATE TABLE area
				(acode CHAR(10),
				 PRIMARY KEY(acode),
				 aname VARCHAR(20),
				 populationn INTEGER,
				 avincome INTEGER,
				 wregioncode CHAR(10) FOREIGN KEY REFERENCES area);

CREATE TABLE properties
				(floorr INTEGER,
				pcode CHAR(10),
				padress VARCHAR(20),
				sqm INTEGER,
				constryear VARCHAR(4),
				acode CHAR(10) FOREIGN KEY REFERENCES area,
				PRIMARY KEY(pcode));

CREATE TABLE categories
				(catcode CHAR(10),
				 PRIMARY KEY(catcode),
				 catname VARCHAR(20));


CREATE TABLE offices
				(tax_code CHAR(10),
				PRIMARY KEY(pcode),
				pcode CHAR(10) FOREIGN KEY REFERENCES properties);

CREATE TABLE homes
				(eid INTEGER,
				PRIMARY KEY(pcode),
				pcode  CHAR(10) FOREIGN KEY REFERENCES properties,
				catcode CHAR(10) FOREIGN KEY REFERENCES categories
				);

CREATE TABLE estimation
				(since DATETIME,
				 estcode VARCHAR(10),
				 price INTEGER,	
				 PRIMARY KEY(estcode),
				 pcode CHAR(10) FOREIGN KEY REFERENCES properties,
				 ecode INTEGER FOREIGN KEY REFERENCES estimator); 
