---
-- Name: AID-061 - AI_A2A - Takeoff From Ship Runway Test
-- Author: FlightControl
-- Date Created: 21 Sep 2017


-- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
-- Here we build the network with all the groups that have a name starting with DF CCCP AWACS and DF CCCP EWR.
DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "DF CCCP AWACS", "DF CCCP EWR" } )
DetectionSetGroup:FilterStart()

Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )

-- Setup the A2A dispatcher, and initialize it.
A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )

-- Enable the tactical display panel.
A2ADispatcher:SetTacticalDisplay( true )

-- Initialize the dispatcher, setting up a radius of 100km where any airborne friendly 
-- without an assignment within 100km radius from a detected target, will engage that target.
A2ADispatcher:SetEngageRadius( 250000 )

-- Setup the squadrons.
A2ADispatcher:SetSquadron( "Kuznetsov", "Kuznetsov", { "SQ CCCP SU-33" }, 20 )

-- Setup the overhead
A2ADispatcher:SetSquadronOverhead( "Kuznetsov", 1.2 )

-- Setup the Grouping
A2ADispatcher:SetSquadronGrouping( "Kuznetsov", 1 )

-- Setup the Takeoff methods
A2ADispatcher:SetSquadronTakeoff( "Kuznetsov", AI_A2A_DISPATCHER.Takeoff.Runway )

-- Setup the Landing methods
A2ADispatcher:SetSquadronLandingAtRunway( "Kuznetsov" )


-- CAP Squadron execution.
--CAPZoneEast = ZONE_POLYGON:New( "CAP Zone East", GROUP:FindByName( "CAP Zone East" ) )
--A2ADispatcher:SetSquadronCap( "Mineralnye", CAPZoneEast, 4000, 10000, 500, 600, 800, 900 )
--A2ADispatcher:SetSquadronCapInterval( "Mineralnye", 2, 30, 60, 1 )

-- GCI Squadron execution.
A2ADispatcher:SetSquadronGci( "Kuznetsov", 900, 1200 )

CleanUp = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Novorossiysk } )


-- Blue attack simulation
local Frequency = 60

BlueSpawn1 = SPAWN
  :New( "RT NATO 1" )
  :InitLimit( 2, 10 )
  :InitRandomizeTemplate( { "SQ NATO A-10C", "SQ NATO F-15C", "SQ NATO F-16A", "SQ NATO F/A-18", "SQ NATO F-16C" } )
  :InitRandomizeRoute( 0, 0, 30000 )
  --:InitDelayOn()
  :SpawnScheduled( Frequency, 0.4 )
