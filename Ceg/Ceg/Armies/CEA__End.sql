--

--UPDATE UnitPromotions
--SET CargoChange = CargoChange + 2 WHERE CargoChange > 0;

--
-- Gold Costs
--

UPDATE Units
SET HurryCostModifier = 50
WHERE (Combat > 0 OR RangedCombat > 0) AND HurryCostModifier >= 0;

UPDATE Units
SET HurryCostModifier = -1
WHERE Special = 'SPECIALUNIT_PEOPLE'
AND NOT CombatClass = 'UNITCOMBAT_DIPLOMACY';
/*
UPDATE Units
SET ExtraMaintenanceCost = 3
WHERE Cost > 0 AND (Combat = 0 AND RangedCombat = 0);

UPDATE Units
SET ExtraMaintenanceCost = Cost / 50
WHERE Cost > 0 AND (Combat > 0 OR RangedCombat > 0);

UPDATE Units
SET ExtraMaintenanceCost = 0.5 * ExtraMaintenanceCost
WHERE Type IN (
	SELECT UnitType FROM Civilization_UnitClassOverrides
	WHERE CivilizationType = 'CIVILIZATION_BARBARIAN'
) AND Domain = 'DOMAIN_SEA';

UPDATE Units
SET ExtraMaintenanceCost = 0.75 * ExtraMaintenanceCost
WHERE ExtraMaintenanceCost > 0 AND (
	Domain = 'DOMAIN_AIR'
	OR CombatClass = 'UNITCOMBAT_NAVALRANGED'
	OR CombatClass = 'UNITCOMBAT_NAVALMELEE'
);

UPDATE Units
SET ExtraMaintenanceCost = 0.5 * ExtraMaintenanceCost
WHERE ExtraMaintenanceCost > 0 AND (
	Class = 'UNITCLASS_GATLINGGUN'
	OR Class = 'UNITCLASS_MACHINE_GUN'
	OR Type = 'UNIT_AZTEC_JAGUAR'
	OR Type = 'UNIT_POLYNESIAN_MAORI_WARRIOR'
);

UPDATE Units SET ExtraMaintenanceCost = MAX(1, ROUND(ExtraMaintenanceCost, 0)) WHERE ExtraMaintenanceCost <> 0;

UPDATE Units SET ExtraMaintenanceCost = 0 WHERE NoMaintenance = 1;

UPDATE Units SET ExtraMaintenanceCost = 55 WHERE Class = 'UNITCLASS_ATOMIC_BOMB';
UPDATE Units SET ExtraMaintenanceCost = 90 WHERE Class = 'UNITCLASS_NUCLEAR_MISSILE';
UPDATE Units SET ExtraMaintenanceCost = 12 WHERE Class = 'UNITCLASS_GUIDED_MISSILE';

UPDATE Units SET Cost =  50, HurryCostModifier =  0 WHERE Class = 'UNITCLASS_MESSENGER';
UPDATE Units SET Cost =  75, HurryCostModifier =  25 WHERE Class = 'UNITCLASS_ENVOY';
UPDATE Units SET Cost = 100, HurryCostModifier =  50 WHERE Class = 'UNITCLASS_EMISSARY';
UPDATE Units SET Cost = 150, HurryCostModifier =  75 WHERE Class = 'UNITCLASS_DIPLOMAT';
UPDATE Units SET Cost = 200, HurryCostModifier = 100 WHERE Class = 'UNITCLASS_AMBASSADOR';
*/

--
-- Faith Costs
--

UPDATE Units SET FaithCost = 1 * Cost WHERE FaithCost > 0 AND Cost > 0;


--
-- Conquest
--

UPDATE Improvements SET PillageGold = PillageGold * 4 WHERE PillageGold <> 0;

UPDATE Buildings
SET ConquestProb = 100
WHERE HurryCostModifier != -1;

UPDATE Buildings
SET ConquestProb = 0
WHERE BuildingClass IN (
	'BUILDINGCLASS_COURTHOUSE',
	'BUILDINGCLASS_WALLS',
	'BUILDINGCLASS_CASTLE',
	'BUILDINGCLASS_ARSENAL',
	'BUILDINGCLASS_MILITARY_BASE',
	'BUILDINGCLASS_COLOSSEUM',
	'BUILDINGCLASS_THEATRE',
	'BUILDINGCLASS_STADIUM'
);

/*
UPDATE Buildings
SET ConquestProb = 50
WHERE BuildingClass IN (
	'BUILDINGCLASS_LIBRARY',
	'BUILDINGCLASS_MARKET',
	'BUILDINGCLASS_BANK',
	'BUILDINGCLASS_STOCK_EXCHANGE',
	'BUILDINGCLASS_MINT',
	'BUILDINGCLASS_HARBOR',
	'BUILDINGCLASS_WAREHOUSE'
);
*/


--
-- Merge units
--

/*
INSERT INTO Unit_AITypes(UnitType, UnitAIType)
SELECT UnitType, 'UNITAI_PARADROP'
FROM Civilization_UnitClassOverrides
WHERE UnitClassType IN (
	'UNITCLASS_GREAT_WAR_INFANTRY'	,
	'UNITCLASS_INFANTRY'			,
	'UNITCLASS_MECHANIZED_INFANTRY'	
);

UPDATE Units SET UnitArtInfo = 'ART_DEF_UNIT_PARATROOPER'
WHERE Class = 'UNITCLASS_INFANTRY';
*/

UPDATE Units SET Cost = -1, ShowInPedia = 0, PrereqTech = 'TECH_FUTURE_TECH' WHERE Class IN (
	'UNITCLASS_ANTI_TANK_GUN'		,
	--'UNITCLASS_PARATROOPER'			,
	'UNITCLASS_MARINE'				
);


UPDATE LoadedFile SET Value=1 WHERE Type='CEA_End.sql';