use DB122;

INSERT INTO estimator(eage,sex,elname,ecode,efname,eadress)
			VALUES('19','male','stelios','12304','Petrakis','adress2');

INSERT INTO connections(connectionumber,ctimedate,cduration,ecode)
			values('12305',Convert(datetime,'18-03-14 9:20:09 PM',5),'12','1523331');

INSERT INTO area(acode,aname,populationn,avincome)
			VALUES('030221','chalandri','74192','2000')

INSERT INTO properties(floorr,pcode,padress,sqm,constryear,acode)
			VALUES('3','03223','Adress2','30','2000','030221')

INSERT INTO categories(catcode,catname)
			VALUES('032230','office')

INSERT INTO offices(tax_code,pcode)
			VALUES('03322','03223')

INSERT INTO estimation(since,estcode,price)
			VALUES(Convert(datetime,'18-03-14 10:20:09 PM',5),'03123','50000')



INSERT INTO estimator(eage,sex,elname,ecode,efname,eadress)
			VALUES('19','female','Maria','12305','Papadopoulou','adress3');

INSERT INTO connections(connectionumber,ctimedate,cduration,ecode)
			values('12306',Convert(datetime,'18-03-14 9:20:09 PM',5),'15','1523332');

INSERT INTO area(acode,aname,populationn,avincome)
			VALUES('030222','Mosxato','12903','1500')

INSERT INTO properties(floorr,pcode,padress,sqm,constryear,acode)
			VALUES('2','03022','Adress3','50','2001','030222')

INSERT INTO categories(catcode,catname)
			VALUES('032231','home')

INSERT INTO homes(eid,pcode,catcode)
			VALUES('123524','03022','032231')

INSERT INTO estimation(since,estcode,price)
			VALUES(Convert(datetime,'18-03-14 11:20:09 PM',5),'12305','30000')




		