use DB122;

/*1 */
SELECT estcode,since,ecode,price
FROM estimation

/*2 */
use DB122;
SELECT elname , efname
FROM estimator
Where  sex='female'and eage>30

/*3 */
use DB122;
SELECT  elname , efname  , padress ,estimation.price
FROM estimator,estimation,properties
WHERE estimation.ecode=estimator.ecode and estimation.pcode = properties.pcode

/*4*/
use DB122;
UPDATE estimation
SET estimation.price = estimation.price + (estimation.price*10/100)

/*5*/
use DB122;
SELECT p.pcode,p.padress 
FROM properties p , area a , estimation est
WHERE  est.since  >= '2020-12-24 'AND est.since <='2020-12-31 ' and a.avincome>40000 and est.pcode=p.pcode

/*6 */
use DB122
SELECT est.ecode, est.sex , est.eage , COUNT(est.ecode) AS totalestimation
FROM estimator est , estimation 
WHERE year(since) = 2020 AND est.ecode=estimation.ecode 
GROUP BY est.sex , est.eage,est.ecode


/*7 */
SELECT P.pcode
FROM properties P,estimation EST 
WHERE year(since) = 2020  AND P.pcode= EST.pcode 
GROUP BY P.pcode
HAVING  COUNT(EST.estcode)>2


/*8*/
SELECT estcode 
from estimation 
where pcode in ( select properties.pcode 
				from properties	
				where properties.acode in ( select area.acode 
											from area 
											where avincome>25000))

/*9*/
use DB122;
SELECT COUNT(estimation.estcode)populat_count
FROM estimation , area ar , properties prop
WHERE year(since)=2020 AND estimation.pcode=prop.pcode AND prop.acode=ar.acode AND populationn>50.000

/*10*/
use DB122;
SELECT  properties.acode , estimator.sex,COUNT (estimation.estcode)plithos
FROM estimation,estimator,properties
WHERE estimation.pcode=properties.pcode and estimator.ecode = estimation.ecode
GROUP BY properties.acode , estimator.sex

/*11*/
use DB122;
SELECT  properties.pcode , avg(estimation.price/sqm)price_per_tm
FROM properties,estimation 
WHERE  properties.pcode = estimation.pcode
GROUP BY properties.pcode,estimation.price 
order by  estimation.price asc 



/*12*/

DROP VIEW TOTALHOMES,TOTALOFFICES ,CODES

GO
CREATE VIEW TOTALHOMES(ecode,counthomes) as
SELECT Es.ecode, count(est.estcode)
FROM estimator as Es, estimation as Est , homes hom
WHERE Est.ecode = Es.ecode AND Est.pcode = hom.pcode AND Year(since) = 2020
GROUP BY Es.ecode

GO
CREATE VIEW TOTALOFFICES(ecode,countoffices) as 
SELECT Es.ecode, count(est.estcode) 
FROM estimator as Es, estimation as est, offices as offi
WHERE Es.ecode = Est.ecode AND Est.pcode = offi.pcode AND Year(est.since) = 2020
GROUP BY Es.ecode

GO
CREATE VIEW CODES(ecode) as
SELECT DISTINCT ecode
FROM estimator

SELECT CODES.ecode, TOTALHOMES.counthomes, TOTALOFFICES.countoffices
FROM CODES
LEFT OUTER JOIN TOTALHOMES ON CODES.ecode = TOTALHOMES.ecode
LEFT OUTER JOIN TOTALOFFICES ON CODES.ecode = TOTALOFFICES.ecode


/*13*/
go
DROP VIEW v2
DROP VIEW v1

GO
CREATE VIEW v2(acode ,price2020)
 as 
SELECT a.acode , est.price/prop.sqm
from area a , estimation est  , properties prop
WHERE year(since)=2020 and est.pcode = prop.pcode and prop.acode=a.acode
GROUP BY a.acode , est.price , prop.sqm

GO
CREATE VIEW v1(acode ,price2019)
 as 
SELECT  a.acode , est.price/prop.sqm
from area a , estimation est , properties prop
WHERE year(since)=2019 and est.pcode = prop.pcode and prop.acode=a.acode
GROUP BY a.acode , est.price , prop.sqm


SELECT DISTINCT v1.acode ,AVG(v1.price2019)-AVG(v2.price2020) AS DIF
FROM v1,v2
WHERE v1.acode=v2.acode 
group by v1.acode , v2.acode

/*14*/
/* Πρώτος τρόπος */
SELECT area.acode,count(estimator.ecode)acode_count
FROM area , estimation , properties , estimator 
WHERE area.acode = properties.acode and properties.pcode = estimation.pcode and estimation.ecode=estimator.ecode
GROUP BY area.acode 
HAVING count(estimator.ecode)>=1

/* Δεύτερος τρόπος */
select area.acode ,count(ecode)acode_count
from area , estimator 
where exists((select estimation.estcode 
				from estimation 
				where estimation.ecode=estimator.ecode 
				intersect 
				select estimation.estcode 
					from properties , estimation 
					where properties.pcode = estimation.pcode and area.acode=properties.acode))
GROUP BY area.acode


/*15*/

drop view A15a ,A15b , A15c,a15d
GO
CREATE VIEW A15a(acode,more_than_two_thousand_less_than_twenty_twentione) AS 
SELECT a.acode , avg(est.price/prop.sqm)
FROM area a , estimation est , properties prop
WHERE prop.constryear>='2000' and prop.constryear<'2021' and prop.pcode=est.pcode and prop.acode = a.acode
GROUP BY a.acode 

GO
CREATE VIEW A15b(acode,more_than_nineteen_eighty_less_than_two_thousand) AS
SELECT a.acode , avg(est.price/prop.sqm)
FROM area a , estimation est , properties prop
WHERE prop.constryear>='1980' and prop.constryear<'2000' and prop.pcode=est.pcode and prop.acode = a.acode
GROUP BY a.acode 

GO
CREATE VIEW A15c(acode,more_than_nineteen_sixty_less_than_nineteen_eighty) AS
SELECT a.acode , avg(est.price/prop.sqm)
FROM area a , estimation est , properties prop
WHERE prop.constryear>='1960' and prop.constryear<'1980' and prop.pcode=est.pcode and prop.acode = a.acode
GROUP BY a.acode 

GO
CREATE VIEW A15d(acode,less_than_nineteen_sixty) AS
SELECT a.acode , avg(est.price/prop.sqm)
FROM area a , estimation est , properties prop
WHERE prop.constryear<'1960' and prop.pcode=est.pcode and prop.acode = a.acode
GROUP BY a.acode 

USE DB122;

SELECT area.acode ,A15d.less_than_nineteen_sixty,A15c.more_than_nineteen_sixty_less_than_nineteen_eighty,A15b.more_than_nineteen_eighty_less_than_two_thousand,A15a.more_than_two_thousand_less_than_twenty_twentione
from area 
LEFT OUTER JOIN A15d ON A15d.acode=area.acode
LEFT OUTER JOIN A15c on A15c.acode=area.acode
LEFT OUTER JOIN A15b on A15b.acode=area.acode
LEFT OUTER JOIN A15a on A15a.acode=area.acode


/*16*/
USE DB122;
GO
DROP VIEW A16a
DROP VIEW A16B
DROP VIEW A16c
DROP VIEW A16d
DROP VIEW A16e
DROP VIEW A16f

GO
CREATE VIEW A16a( acode , totalestim) AS 
SELECT a.acode,count(estcode)
FROM area a,estimation est,properties prop 
WHERE a.acode = prop.acode and prop.pcode=est.pcode and year(since)=2020
GROUP BY a.acode

GO
CREATE VIEW A16b(TOTAL2020) AS 
SELECT count(est.estcode)
FROM estimation est
WHERE year(since)=2020

GO
CREATE VIEW A16c(TOTALPOPULATION)  AS 
SELECT sum(a.populationn)
FROM area a

GO 
CREATE VIEW A16d(acode) AS
SELECT distinct acode 
FROM area 

GO 
CREATE VIEW A16e(acode,total_est_percentage) AS
SELECT  area.acode  , (A16a.totalestim*100/A16b.TOTAL2020) as total_est_percentage
FROM area ,A16a , A16b
WHERE A16a.acode=area.acode

GO 
CREATE VIEW A16f(acode,total_pop_percentage) AS
SELECT  area.acode  , (area.populationn*100/A16c.TOTALPOPULATION) as total_pop_persentage
FROM area , A16c

SELECT distinct A16d.acode , A16e.total_est_percentage , A16f.total_pop_percentage
from A16d
LEFT OUTER JOIN A16e on A16e.acode=A16d.acode
LEFT OUTER JOIN A16f on A16f.acode=A16d.acode


