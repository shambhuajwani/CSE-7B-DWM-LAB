 



Q1. Find the total sales by country_id and channel_desc for the US and GB through the Internet and direct sales in September 2000 and October 2000 using ROLL-UP Extension. The query should return the following: 
 
    The aggregation rows that would be produced by GROUP BY , 
 The First-level subtotals aggregating across country_id for each combination of channel_desc and calendar_month. 
    Second-level subtotals aggregating across calendar_month_desc and country_id for each channel_desc value. 
    A grand total row. 



SELECT channels.channel_desc, countries.country_iso_code, 
 TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES 
 FROM sales, customers, times, channels, countries 
 WHERE sales.time_id=times.time_id 
 AND sales.cust_id=customers.cust_id 
 AND customers.country_id = countries.country_id 
 AND sales.channel_id = channels.channel_id 
 AND channels.channel_desc IN ('Direct Sales', 'Internet') 
 AND times.calendar_month_desc IN ('2000-09', '2000-10') 
 AND countries.country_iso_code IN ('GB', 'US') 
 GROUP BY 
 ROLLUP(channels.channel_desc, calendar_month_desc, countries.country_iso_code); 



CHANNEL_DESC         CO SALES
-------------------- -- --------------
Internet             GB         16,569
Internet             US        124,224
Internet                       140,793
Internet             GB         14,539
Internet             US        137,054
Internet                       151,593
Internet                       292,387
Direct Sales         GB         85,223
Direct Sales         US        638,201
Direct Sales                   723,424
Direct Sales         GB         91,925

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Direct Sales         US        682,297
Direct Sales                   774,222
Direct Sales                 1,497,646
                             1,790,032

15 rows selected.



Q2. Find the total sales by country_id and channel_desc for the US and GB through the Internet and direct sales in September 2000 and October 2009 using CUBE aggregation across three dimensions- channel_desc, calendar_month_desc, countries.country_iso_code. 


  select  channels.channel_desc, countries.country_iso_code, 
  TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES 
  FROM sales, customers, times, channels, countries 
  WHERE sales.time_id=times.time_id 
  AND sales.cust_id=customers.cust_id 
  AND customers.country_id = countries.country_id 
  AND sales.channel_id = channels.channel_id 
  AND channels.channel_desc IN ('Direct Sales', 'Internet') 
  AND times.calendar_month_desc IN ('2000-09','2000-10') 
  AND countries.country_iso_code IN ('GB', 'US')
  GROUP BY 
  CUBE(channels.channel_desc, calendar_month_desc,    countries.country_iso_code);   
  


CHANNEL_DESC         CO SALES
-------------------- -- --------------
                             1,790,032
                     GB        208,257
                     US      1,581,775
                               864,217
                     GB        101,792
                     US        762,425
                               925,815
                     GB        106,465
                     US        819,351
Internet                       292,387
Internet             GB         31,109

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Internet             US        261,278
Internet                       140,793
Internet             GB         16,569
Internet             US        124,224
Internet                       151,593
Internet             GB         14,539
Internet             US        137,054
Direct Sales                 1,497,646
Direct Sales         GB        177,148
Direct Sales         US      1,320,497
Direct Sales                   723,424

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Direct Sales         GB         85,223
Direct Sales         US        638,201
Direct Sales                   774,222
Direct Sales         GB         91,925
Direct Sales         US        682,297

27 rows selected.


Q3. Find the total sales by country_iso and channel_desc for the US and France through the Internet and direct sales in September 2000 

  select  channels.channel_desc, countries.country_iso_code,
  TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES
  FROM sales, customers, times, channels, countries
  WHERE sales.time_id=times.time_id
  AND sales.cust_id=customers.cust_id
  AND customers.country_id = countries.country_id
  AND sales.channel_id = channels.channel_id
  AND channels.channel_desc IN ('Direct Sales', 'Internet')
  AND times.calendar_month_desc IN ('2000-09')
  AND countries.country_iso_code IN ('US','FR')
  GROUP BY
  ROLLUP(channels.channel_desc, calendar_month_desc,    countries.country_iso_code);

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Internet             FR          9,597
Internet             US        124,224
Internet                       133,821
Internet                       133,821
Direct Sales         FR         61,202
Direct Sales         US        638,201
Direct Sales                   699,403
Direct Sales                   699,403
                               833,224

9 rows selected.


Q4. Find the total sales by country_id and channel_desc for the US and GB through the Internet and direct sales in September 2000 and October 2000 using PARTIAL ROLL-UP. The query should return the following: 
 
  Regular aggregation rows that would be produced by GROUP BY without using ROLLUP. 
  First-level subtotals aggregating across country_id for each combination of channel_desc and calendar_month_desc. 
  Second-level subtotals aggregating across calendar_month_desc and country_id for each channel_desc value. 
  It does not produce a grand total row. 

 
   
  select  channels.channel_desc,countries.country_iso_code,
  TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES
  FROM sales, customers, times, channels, countries
  WHERE sales.time_id=times.time_id
  AND sales.cust_id=customers.cust_id
  AND customers.country_id = countries.country_id
  AND sales.channel_id = channels.channel_id
  AND channels.channel_desc IN ('Direct Sales', 'Internet')
  AND times.calendar_month_desc IN ('2000-09','2000-10')
  AND countries.country_iso_code IN ('US','GB')
  GROUP BY
  ROLLUP(channels.channel_desc, calendar_month_desc,    countries.country_iso_code);




Q5. Find the total sales by country_id and channel_desc for the US and GB through the Internet and direct sales in September 2000 and October 2000 using PARTIAL CUBE aggregation on month and country code and GROUP BY on channel_desc. 
    
   select  channels.channel_desc,countries.country_iso_code,
   TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES
   FROM sales, customers, times, channels, countries
   WHERE sales.time_id=times.time_id
   AND sales.cust_id=customers.cust_id
   AND customers.country_id = countries.country_id
   AND sales.channel_id = channels.channel_id
   AND channels.channel_desc IN ('Direct Sales', 'Internet')
   AND times.calendar_month_desc IN ('2000-09','2000-10')
   AND countries.country_iso_code IN ('US','GB')
   GROUP BY  channels.channel_desc,
   CUBE( calendar_month_desc,    countries.country_iso_code);

    

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Internet                       292,387
Internet             GB         31,109
Internet             US        261,278
Internet                       140,793
Internet             GB         16,569
Internet             US        124,224
Internet                       151,593
Internet             GB         14,539
Internet             US        137,054
Direct Sales                 1,497,646
Direct Sales         GB        177,148

CHANNEL_DESC         CO SALES
-------------------- -- --------------
Direct Sales         US      1,320,497
Direct Sales                   723,424
Direct Sales         GB         85,223
Direct Sales         US        638,201
Direct Sales                   774,222
Direct Sales         GB         91,925
Direct Sales         US        682,297

18 rows selected.






Q6. Use GROUPING to create a set of mask columns for the result set of Q1. 
 
    Create grouping on  channel_desc and name it as CH 
    Create grouping calendar_month_desc and name it as MO 
    Create grouping on  country_iso_code and name it as CO

 SELECT channels.channel_desc, countries.country_iso_code, 
 TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES, 
 GROUPING(channel_desc) AS CH,   GROUPING(calendar_month_desc) AS MO,
 GROUPING(country_iso_code) AS CO
 FROM sales, customers, times, channels, countries 
 WHERE sales.time_id=times.time_id 
 AND sales.cust_id=customers.cust_id 
 AND customers.country_id = countries.country_id 
 AND sales.channel_id = channels.channel_id 
 AND channels.channel_desc IN ('Direct Sales', 'Internet') 
 AND times.calendar_month_desc IN ('2000-09', '2000-10') 
 AND countries.country_iso_code IN ('GB', 'US') 
 GROUP BY 
 ROLLUP(channels.channel_desc, calendar_month_desc, countries.country_iso_code);


CHANNEL_DESC         CO SALES                  CH         MO         CO
-------------------- -- -------------- ---------- ---------- ----------
Internet             GB         16,569          0          0          0
Internet             US        124,224          0          0          0
Internet                       140,793          0          0          1
Internet             GB         14,539          0          0          0
Internet             US        137,054          0          0          0
Internet                       151,593          0          0          1
Internet                       292,387          0          1          1
Direct Sales         GB         85,223          0          0          0
Direct Sales         US        638,201          0          0          0
Direct Sales                   723,424          0          0          1
Direct Sales         GB         91,925          0          0          0

CHANNEL_DESC         CO SALES                  CH         MO         CO
-------------------- -- -------------- ---------- ---------- ----------
Direct Sales         US        682,297          0          0          0
Direct Sales                   774,222          0          0          1
Direct Sales                 1,497,646          0          1          1
                             1,790,032          1          1          1

15 rows selected.



Q7.  Find the total sales by country_id and channel_desc for the US and GB through the Internet and direct sales in September 2000 and October 2009 using GROUPING SETS. 
 
Calculate aggregates over three groupings: 
     (channel_desc, calendar_month_desc, country_iso_code) 
     (channel_desc, country_iso_code) 
     (calendar_month_desc, country_iso_code) 


Q: 8 Perform aggregation on amount sold. It should get aggregated by month first, then by all the months in each quarter, and then across all months and quarters in the year. 



 
 
 SELECT  times.calendar_month_desc  "MONTH", times.calendar_quarter_desc  "QUARTER" ,times.calendar_year as "YEAR",  
 TO_CHAR(SUM(amount_sold), '9,999,999,999') SUM_AMOUNT_SOLD
 FROM sales, customers, times, channels, countries 
 WHERE sales.time_id=times.time_id 
 AND sales.cust_id=customers.cust_id 
 AND customers.country_id = countries.country_id 
 AND sales.channel_id = channels.channel_id 
 AND channels.channel_desc IN ('Direct Sales', 'Internet') 
 AND times.calendar_year IN ('1999') 
 AND countries.country_iso_code IN ('GB', 'US') 
 GROUP BY 
 ROLLUP(times.calendar_month_desc,times.calendar_quarter_desc,times.calendar_year);


MONTH    QUARTER       YEAR SUM_AMOUNT_SOL
-------- ------- ---------- --------------
1999-01  1999-01       1999        974,628
1999-01  1999-01                   974,628
1999-01                            974,628
1999-02  1999-01       1999      1,089,256
1999-02  1999-01                 1,089,256
1999-02                          1,089,256
1999-03  1999-01       1999        754,027
1999-03  1999-01                   754,027
1999-03                            754,027
1999-04  1999-02       1999        708,061
1999-04  1999-02                   708,061

MONTH    QUARTER       YEAR SUM_AMOUNT_SOL
-------- ------- ---------- --------------
1999-04                            708,061
1999-05  1999-02       1999        818,056
1999-05  1999-02                   818,056
1999-05                            818,056
1999-06  1999-02       1999        729,678
1999-06  1999-02                   729,678
1999-06                            729,678
1999-07  1999-03       1999        893,452
1999-07  1999-03                   893,452
1999-07                            893,452
1999-08  1999-03       1999        883,461

MONTH    QUARTER       YEAR SUM_AMOUNT_SOL
-------- ------- ---------- --------------
1999-08  1999-03                   883,461
1999-08                            883,461
1999-09  1999-03       1999        923,577
1999-09  1999-03                   923,577
1999-09                            923,577
1999-10  1999-04       1999        715,831
1999-10  1999-04                   715,831
1999-10                            715,831
1999-11  1999-04       1999        742,248
1999-11  1999-04                   742,248
1999-11                            742,248

MONTH    QUARTER       YEAR SUM_AMOUNT_SOL
-------- ------- ---------- --------------
1999-12  1999-04       1999        841,572
1999-12  1999-04                   841,572
1999-12                            841,572
                                10,073,847

37 rows selected.



Q: 9 Implement concatenated rollup. First roll up on (channel_total, channel_class) and second roll up on(country_region and country_iso_code) 




Q11. Find the total sales by country name and channel_desc for the country name starting from U through the Internet and direct sales in September 2000 and October. 

SELECT ch.channel_desc, 
    t.calendar_month_desc, 
    co.country_name, 
    SUM(s.amount_sold) 
    sum_amount_sold, 
    GROUPING_ID( ch.channel_desc, t.calendar_month_desc, co.country_name) grouping_id 
    FROM sales s, customers cu, times t, channels ch, countries co 
    WHERE   s.time_id=t.time_id AND 
s.cust_id=cu.cust_id AND 
cu.country_id = co.country_id AND 
s.channel_id = ch.channel_id AND 
ch.channel_desc IN ('Direct Sales', 'Internet') AND 
t.calendar_month_desc IN ('2001-09', '2001-10') AND 
co.country_iso_code IN ('GB', 'US') 
GROUP  BY 
ROLLUP( ch.channel_desc, t.calendar_month_desc, co.country_name); 



CHANNEL_DESC         CALENDAR COUNTRY_NAME                             SUM_AMOUNT_SOLD GROUPING_ID
-------------------- -------- ---------------------------------------- --------------- -----------
Internet             2001-09  United Kingdom                                  36806.73           0
Internet             2001-09  United States of America                       299621.96           0
Internet             2001-09                                                 336428.69           1
Internet             2001-10  United Kingdom                                  39010.76           0
Internet             2001-10  United States of America                       386326.55           0
Internet             2001-10                                                 425337.31           1
Internet                                                                        761766           3
Direct Sales         2001-09  United Kingdom                                  92865.04           0
Direct Sales         2001-09  United States of America                       621197.94           0
Direct Sales         2001-09                                                 714062.98           1
Direct Sales         2001-10  United Kingdom                                  75296.44           0

CHANNEL_DESC         CALENDAR COUNTRY_NAME                             SUM_AMOUNT_SOLD GROUPING_ID
-------------------- -------- ---------------------------------------- --------------- -----------
Direct Sales         2001-10  United States of America                        566719.8           0
Direct Sales         2001-10                                                 642016.24           1
Direct Sales                                                                1356079.22           3
                                                                            2117845.22           7

15 rows selected.



Q12. Analyze the output 
 
SELECT ch.channel_desc, t.calendar_month_desc, co.country_iso_code, SUM(s.amount_sold) sum_amount_sold, GROUPING_ID( ch.channel_desc, t.calendar_month_desc, co.country_iso_code) grouping_id FROM sales s, customers cu, times t, channels ch, countries co WHERE   s.time_id=t.time_id AND s.cust_id=cu.cust_id AND cu.country_id = co.country_id AND s.channel_id = ch.channel_id AND ch.channel_desc IN ('Direct Sales', 'Internet') AND t.calendar_month_desc IN ('2001-09', '2001-10') AND co.country_iso_code IN ('GB', 'US') GROUP BY ROLLUP( ch.channel_desc, t.calendar_month_desc, co.country_iso_code); 