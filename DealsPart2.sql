#Michael Gurliacci
#DealsPart2.sql
#2017-11-04

#companies with inc
select * from companies where companyname like "%Inc."

#3
select * from companies order by companyid;

#4
#5
SELECT DealName, PartNumber, DollarValue
from Deals, DealParts
WHERE deals.dealID=dealparts.dealid;

#6
SELECT DealName, PartNumber, Dollarvalue
from Deals
join DealParts on (Deals.DealID=DealParts.DealID);

#7
#8
#create a view that matches companies to deals
CREATE view CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM COmpanies
	Join Players ON (Companies.companyID = Players.CompanyID)
    Join Deals ON (Players.DealID = Deals.DealID)
Order BY DealName;

#test the view created above
select * from companydeals;

#9 create view for DealValues that lists DealID, total dolar vallue,
#number of parts for each deal

Create View DealValues AS
SELECT deals.dealID as dealID,
		dealparts.partnumber as partnumber,
        dealparts.dollarvalue as dollarvalue,
		from deals
        join Deals on dealparts (deals.dealid = dealparts.dealid);
        
#9 Create a view eamed DealValues that lists the DealID, total dollar value and number of parts for each deal.

#SELECT DealID, SUM(DollarValue), Count(PartNumber)
#DROP view IF EXISTS 'DealValues';
create view DealValues AS
SELECT Deals.DealID, sum(DollarValue) AS totdollarvalue, count(PartNumber) as numparts
FROM Deals JOIN DealParts on (Deals.dealID = dealparts.dealid)
group by deals.dealid
order by deals.dealID;

Select * from DealValues;


#10 Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and 
	#number of parts for each deal.
	#Bonus: use a subquery to construct a comma-separated list of deal types for each deal. 
    #(Don't forget the comment and the select query.)
    

create view DealSummary AS
select Deals.DealID, DealName, count(PlayerID) as numplayers, totdollarvalue, numparts
from deals 
join dealvalues on (deals.dealid = dealvalues.dealid)
join players on (deals.dealid = players.dealid)
GROUP BY Deals.DealID;

#11 Create a view called DealsByType that lists TypeCode, number of deals, 
# 		and total value of deals for each deal type.
#	Each deal type should be listed, even if there are no deals of that type.
#	 	(Don't forget the comment and the select query.)

	#class version
CREATE VIEW DealsByType AS
SELECT DISTINCT DealTypes.TypeCode AS TypeCode, count(deals.dealid) as NumDeals, sum(DealParts.DollarValue) AS DollarValue
FROM DealTypes 
JOIN Deals ON (DealTypes.DealID = Deals.DealID) 
JOIN DealParts on (DealParts.DealID = Deals.DealID)
GROUP BY TypeCode;

#12 Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal.
#   Sort the players by the RoleSortOrder.

CREATE VIEW DealsPlayers
SELECT DealID, CompanyID, CompanyName, RoleCode
From Players 
Join Deals USING (DealID)
Join Companies USING (CompanyID)
Join RoleCodes USING (RoleCode)
order by RoleSortOrder;

#USING assumes named same; how diff from ON

#13 Create a view called DealsByFirm that lists the FirmID, Name, 
#    number of deals, and total value of deals for each firm.

SELECT FirmID, Firms.Name, COUNT(Players.DealID) AS numberDeals, SUM(totdollarvalue) as totvalue
FROM firms 
LEFT JOIN playersupports using (FirmID)
LEFT JOIN players using (PlayerID)
LEFT JOIN DealValues USING (DealID)
group by firmid, firms.name;


