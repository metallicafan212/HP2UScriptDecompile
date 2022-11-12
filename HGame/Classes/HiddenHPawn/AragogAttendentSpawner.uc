//================================================================================
// AragogAttendentSpawner.
//================================================================================

class AragogAttendentSpawner extends HiddenHPawn;

const BOOL_DEBUG_AI= true;

struct AragogAttendentParams
{
	var() float attackSpeed;
	var() int iRotation;
	var() float drawingScale;
	var() float DamageAmount;
	var() Vector offsetFromSpawner;
	var() float jumpingDistanceFromHarry;
	var() int numSpells;
};

struct SpiderSpawnerParams
{
	var() AragogAttendentParams theSpiders[4];
	var() int numberOfSpiders;
	var() float nextSpiderDelay;
};



var int Counter;
var Rotator spiderRotation;
var float spiderYaw;
var int Spidercounter;
var int numberOfSpiders;
var int numberOfAnchors;
var SpiderAttendent atSpider;
var Vector vRight;
var Vector vTempOffset;
var Vector vOffset;
var Vector vOffsetSide;
var Vector vOffsetFront;
var Vector vOffsetUp;
var() SpiderSpawnerParams theAnchors[8];
var AragogCenterWeb _AragogCenterWeb;

function PostBeginPlay()
{
	bCollideWorld = True;
	foreach AllActors(Class'AragogCenterWeb',_AragogCenterWeb)
	{
		break;
	}
}

function Trigger (Actor Other, Pawn EventInstigator)
{
	GotoState('SpawnSomeSpiders');
}

function SpawnSpiders (int A)
{
	numberOfAnchors = A;
	numberOfSpiders = theAnchors[numberOfAnchors].numberOfSpiders;
	vRight = Vector(Rotation) Cross vect(0.00,0.00,1.00);
	GotoState('SpawnSomeSpiders');
}

state SpawnSomeSpiders
{
	begin:
		cm("Number of spiders: " $ string(numberOfSpiders));
		for(SpiderCounter = 0; SpiderCounter < numberOfSpiders; SpiderCounter++)
		{
			if ( _AragogCenterWeb != None )
			{
				TosssSpiderUpFromHole2(Spidercounter == 0);
			} 
			else 
			{
				spiderRotation 		= Rotation;
				spiderYaw 			= theAnchors[numberOfAnchors].theSpiders[Spidercounter].iRotation * (16384 / 90.0);
				spiderRotation.Yaw += spiderYaw;
				spiderRotation.Yaw  = spiderRotation.Yaw & 65535;
				vTempOffset 		= theAnchors[numberOfAnchors].theSpiders[Spidercounter].offsetFromSpawner;
				vOffsetSide 		= vRight * vTempOffset.X;
				vOffsetFront 		= Vector(Rotation) * vTempOffset.Y;
				vOffsetUp 			= Vec(0.0,0.0,vTempOffset.Z);
				vOffset 			= vOffsetSide + vOffsetFront + vOffsetUp;
				atSpider 			= Spawn(Class'SpiderAttendent',self,,Location + vOffset,spiderRotation);
				cm("Spawning a spiders at offset : " $ string(vTempOffset));
				SetupSpider(atSpider);
			}
			Sleep(theAnchors[numberOfAnchors].nextSpiderDelay);
		}
}

function TosssSpiderUpFromHole (bool bPlayShriek)
{
	local Rotator rToDest;
	local int YawOffset;
	local Vector V;
	local Vector vStart;
	local Vector vDest;
	local Rotator R;

	V 			= PlayerHarry.Location - _AragogCenterWeb.Location;
	rToDest.Yaw = rotator(V).Yaw;
	YawOffset 	= 5000 + 4000 * VSize2D(PlayerHarry.Velocity) / 200;
	
	if ( (V * vect(1.00,1.00,0.00) Cross Vector(PlayerHarry.Rotation)).Z > 0 )
	{
		rToDest.Yaw += YawOffset;
	} 
	else 
	{
		rToDest.Yaw -= YawOffset;
	}
	vDest 		= _AragogCenterWeb.Location + Vector(rToDest) * 650;
	vDest.Z 	= PlayerHarry.Location.Z;
	vDest 	   += Vec(RandRange(-125.0,125.0),RandRange(-125.0,125.0),0.0);
	vStart 		= _AragogCenterWeb.Location;
	vStart.Z 	= PlayerHarry.Location.Z - 500;
	R 			= rotator(vStart - vDest);
	R.Pitch 	= 0;
	atSpider 	= Spawn(Class'SpiderAttendent',self,,vStart,R);
	
	
	SetupSpider(atSpider);
	atSpider.SetPhysics(PHYS_Falling);
	atSpider.Velocity 				= ComputeTrajectoryByTime(vStart,vDest,2.0);
	atSpider.bIgnoreZonePainDamage 	= True;
	atSpider.bDespawnable 			= False;
	atSpider.bPlayScreamWhenInView 	= bPlayShriek;
	atSpider.GotoState('stateFlyIn');
}

function TosssSpiderUpFromHole2 (bool bPlayShriek)
{
	local Rotator rToDest;
	local int YawOffset;
	local Vector V;
	local Vector vStart;
	local Vector vDest;
	local Rotator R;
	local PatrolPoint ppStart;

	V 			= PlayerHarry.Location - _AragogCenterWeb.Location;
	rToDest.Yaw = rotator(V).Yaw;
	YawOffset 	= 5000 + 4000 * VSize2D(PlayerHarry.Velocity) / 200;
	
	if ( (V * vect(1.00,1.00,0.00) Cross Vector(PlayerHarry.Rotation)).Z > 0 )
	{
		rToDest.Yaw += YawOffset;
	} 
	else 
	{
		rToDest.Yaw -= YawOffset;
	}
  
	vStart 		= _AragogCenterWeb.Location + Vector(rToDest) * 400;
	ppStart 	= FindClosestStartPoint(vStart);
	vStart 		= ppStart.Location;
	R.Yaw 		= rotator(ppStart.Location - _AragogCenterWeb.Location).Yaw;
	R.Pitch 	= -32000;
	atSpider 	= SpiderAttendent(FancySpawn(Class'SpiderAttendent',self,,vStart,R));
	
	SetupSpider(atSpider);
	atSpider.SetPhysics(PHYS_Flying);
	atSpider.bIgnoreZonePainDamage 	= True;
	atSpider.bDespawnable 			= False;
	atSpider.bPlayScreamWhenInView 	= bPlayShriek;
	atSpider.FollowPatrolPoints(ppStart.Name);
	atSpider.GotoState('stateCrawlIn');
}

function PatrolPoint FindClosestStartPoint (Vector V)
{
	local PatrolPoint cpp;
	local PatrolPoint pP;
	local float cd;
	local float D;

	cd = 999999.0;
	foreach AllActors(Class'PatrolPoint',pP,'PP_StartPoint')
	{
		D = VSize2D(V - pP.Location);
		if ( D < cd )
		{
			cd = D;
			cpp = pP;
		}
	}
	return cpp;
}

function SetupSpider (SpiderAttendent atSpider)
{
	atSpider.attackSpeed 				= theAnchors[numberOfAnchors].theSpiders[Spidercounter].attackSpeed;
	atSpider.DrawScale 					= theAnchors[numberOfAnchors].theSpiders[Spidercounter].drawingScale;
	atSpider.fDamageAmount 				= theAnchors[numberOfAnchors].theSpiders[Spidercounter].DamageAmount;
	atSpider.jumpingDistanceFromHarry 	= theAnchors[numberOfAnchors].theSpiders[Spidercounter].jumpingDistanceFromHarry;
	atSpider.numSpellsDefault 			= theAnchors[numberOfAnchors].theSpiders[Spidercounter].numSpells;
	atSpider.bDespawnable 				= True;
	switch (Rand(2))
	{
		case 0:
			atSpider.ePreAttackAnim = ATTACK_JUMP;
			break;
		case 1:
			atSpider.ePreAttackAnim = ATTACK_REAR;
		break;
	}
}

defaultproperties
{
    CollisionRadius=10.00

    CollisionHeight=10.00

    Mass=10.00

}