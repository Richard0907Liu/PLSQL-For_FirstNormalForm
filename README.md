# PLSQL-For_FirstNormalForm



1. The last column in Table 1 is not in “First Normal Form” because it really contains several values that just look like one string          value.
2. I want the borough for every neighborhood, not just for the neighborhoods.

Guides: 
1. Import the neighborhoods.csv to the SQL Developer. Right click on the Tables -> Import data.


As a simple EXAMPLE, the NEIGH table contains:
 
Bronx CB 2| 5.54 |52,246 |9,792 |Hunts Point, Longwood

We want to normalize this to:
 
Bronx| Hunts Point
Bronx| Longwood



