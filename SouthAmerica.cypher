//Delete anything already there
MATCH (n)
DETACH DELETE n;

//Create your map of South America
CREATE (Brazil:Country{name:"Brazil"})-[:Borders]->(Peru:Country{name:"Peru"}), 
(Brazil)-[:Borders]->(Bolivia:Country{name:"Bolivia"}), 
(Brazil)-[:Borders]->(Uruguay:Country{name:"Uruguay"}), 
(Brazil)-[:Borders]->(Paraguay:Country{name:"Paraguay"}), 
(Brazil)-[:Borders]->(Argentina:Country{name:"Argentina"}), 
(Brazil)-[:Borders]->(Colombia:Country{name:"Colombia"}), 
(Brazil)-[:Borders]->(Guyana:Country{name:"Guyana"}), 
(Brazil)-[:Borders]->(Venezuela:Country{name:"Venezuela"}), 
(Brazil)-[:Borders]->(Suriname:Country{name:"Suriname"}), 
(Brazil)-[:Borders]->(FrenchGuiana:Country{name:"French Guiana"}), 
(Suriname)-[:Borders]->(FrenchGuiana), 
(Suriname)-[:Borders]->(Guyana), 
(Venezuela)-[:Borders]->(Guyana), 
(Venezuela)-[:Borders]->(Colombia), 
(Ecuador:Country{name:"Ecuador"})-[:Borders]->(Colombia), 
(Ecuador)-[:Borders]->(Peru), 
(Bolivia)-[:Borders]->(Peru), 
(Chile:Country{name:"Chile"})-[:Borders]->(Peru), 
(Bolivia)-[:Borders]->(Chile), 
(Argentina)-[:Borders]->(Chile), 
(Argentina)-[:Borders]->(Bolivia), 
(Argentina)-[:Borders]->(Paraguay), 
(Argentina)-[:Borders]->(Uruguay), 
(Paraguay)-[:Borders]->(Bolivia);

//Find all the borders
MATCH (country1:Country)-[:Borders]-(country2:Country)
WITH country1, count(country2) AS numBorders
RETURN country1.name, numBorders
ORDER BY country1.name;

//Which country has the most borders?
MATCH (country1:Country)-[:Borders]-(country2:Country)
WITH country1, count(country2) AS numBorders
RETURN country1.name, numBorders
ORDER BY numBorders DESC
LIMIT 1;

//Are there any countries in South America not bordering Brazil?
MATCH (c1:Country)-[:Borders*2]-(c2:Country)
WHERE c2.name = "Brazil" AND NOT (c1)-[:Borders*1]-(c2)
RETURN DISTINCT c1.name
ORDER BY c1.name;
//We know from looking at the map that the most you can be is 2 degrees removed from Brazil
