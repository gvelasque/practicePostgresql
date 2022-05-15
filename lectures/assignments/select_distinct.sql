-- TABLE

readonly=# \d+ taxdata
  Column  |          Type          |
----------+------------------------+
 id       | integer                |
 ein      | integer                |
 name     | character varying(255) |
 year     | integer                |
 revenue  | bigint                 |
 expenses | bigint                 |
 purpose  | text                   |
 ptid     | character varying(255) |
 ptname   | character varying(255) |
 city     | character varying(255) |
 state    | character varying(255) |
 url      | character varying(255) |
 
 -- DATA
 
id      |    ein   |                        name                         | year | revenue | expenses 
| purpose 
|ptid       |         ptname         |   city    | state | url                                 
--------+-----------+-----------------------------------------------------+------+---------+----------+---------------------------------------------

287950 | 980000121 | Transatlantic Council Boy Scouts ofAmerica Inc #802 | 2015 | 1836016 |  1547915 
| The mission of the Boy Scouts of America is to prepare young people to make ehtical & moral decisions over their life 
BYinstilling in them the values of the Scout Oath and Law. 
| P00521196 | Catherine Bendall      | APO       | AE    | https://s3.amazonaws.com/irs-form-990/201601819349301300_public.xml

188477 | 920143311 | Alcoholic Beverage Retailers Assoc - Juneau CHARR   | 2015 | 1165122 |    51670 | 
Prevention of drunk driving and provide a safe ride program 
|           | Andrew Meiners         | JUNEAU    | AK    | https://s3.amazonaws.com/irs-form-990/201630969349300738_public.xml

187693 | 920120417 | KETCHIKAN GYMNASTICS CLUB INC                       | 2015 |  174895 |   155970 | 
YOUTH GYMNASTIC PROGRAM TEACHING THE FUNDAMENTALS OF GYMNASTICS TO KETCHIKAN AND SURROUNDING AREA YOUTH AND ORGANIZING MEETS.00
| P01593080 | KAREN STYLES           | KETCHIKAN | AK    | https://s3.amazonaws.com/irs-form-990/201630469349201313_public.xml 

187800 | 926002588 | ANCHORAGE INTERNATIONAL ROTARY CLUB                 | 2014 |   81692 |    90977 
| COMMUNITY SERVICE TO PROVIDE CONTRIBUTIONS TO ORGANIZATIONS AND INDIVIDUALS IN THE COMMUNITY OF ANCHORAGE, ALASKA AND OTHER 
AREAS TO AID IN ALL ASPECTS OF IMPROVING THE QUALITY OF LIFE WORLDWIDE..12440                                                        
| P00090943 | ELIZABETH L CRONIN CPA | ANCHORAGE | AK    | https://s3.amazonaws.com/irs-form-990/201601379349205960_public.xml 

188013 | 943096775 | INTERIOR ALASKA AIRBOAT ASSOCIATION INC             | 2015 | 2211559 |   185709 
| PROMOTE BOATING SAFETY,SUPPORT LOCAL SEARCHAND RESCUE EFFORTS,PRESERVE AND PROTECT ACCESS TO PUBLIC WATERS, ENCOURAGE RESPONSIBLE 
MANAGEMENT OF WILDLIFE, ENHANCE AIRBOATERS PUBLIC IMAGE BY GIVING SUPPORT TO LOCAL CHARITIES AND PUBLIC SERVICE ORGANIZATIONS 
| P00841521 | BETHE DAVIS            | FAIRBANKS | AK    | https://s3.amazonaws.com/irs-form-990/201640839349301019_public.xml

-- Question: In this assignment you are to find the distinct values in the state column of the taxdata table in ascending order. Your query should only return these five rows (i.e. inclide a LIMIT clause):
-- Expect result: AE, AK, AL, AP, AR

SELECT DISTINCT state FROM taxdata ORDER BY state LIMIT 5; 