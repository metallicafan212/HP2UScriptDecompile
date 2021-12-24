//================================================================================
// SpiderSpawner.
//================================================================================

class SpiderSpawner extends HiddenHPawn;

const BOOL_DEBUG_AI= true;
struct SpiderSpawnerParams
{
	var() float NormalSpeed;
	var() float attackSpeed;
	var() bool canWander;
	var() bool waitForTrigger;
	var() float forwardDistance;
	var() string GroupName;
	var() int iRotation;
	var() float nextSpiderDelay;
	var() float drawingScale;
	var() float jumpingDistanceFromHarry;
	var() int numSpellsLargeSpider;
	var() float leaveSmallDeadSpider;
};

var int Counter;
var Rotator spiderRotation;
var float spiderYaw;
var() int numSpiders;
var() bool bSmallSpiders;
var SpiderSmall smallSpider;
var SpiderLarge largeSpider;
var() SpiderSpawnerParams theSpiders[5];

function PostBeginPlay()
{
	bCollideWorld = True;
}

function Trigger (Actor Other, Pawn EventInstigator)
{
	GotoState('SpawnSomeSpiders');
}

function Touch (Actor Other)
{
	Super.Touch(Other);
}

function Bump (Actor Other)
{
	Touch(Other);
}

function SpawnRandomSpiders (int ns)
{
	local int randNum;
	local int numberOfSpiders;
	local int Spidercounter;
	local SpiderSmall smSpider;
	local SpiderLarge lgSpider;

	numberOfSpiders 	= ns;
	for(SpiderCounter = 0; SpiderCounter < numberOfSpiders; SpiderCounter++)
	{
		randNum = Rand(numSpiders);
		if ( bSmallSpiders )
		{
			spiderRotation 		= Rotation;
			spiderYaw 			= theSpiders[randNum].iRotation * (16384 / 90.0);
			spiderRotation.Yaw += spiderYaw;
			spiderRotation.Yaw  = spiderRotation.Yaw & 65535;
			
			smSpider 							= Spawn(Class'SpiderSmall',self,,Location,spiderRotation);
			smSpider.NormalSpeed 				= theSpiders[randNum].NormalSpeed;
			smSpider.attackSpeed 				= theSpiders[randNum].attackSpeed;
			smSpider.GroundSpeed 				= theSpiders[randNum].NormalSpeed;
			smSpider.canWander 					= theSpiders[randNum].canWander;
			smSpider.waitForTrigger 			= theSpiders[randNum].waitForTrigger;
			smSpider.forwardDistance 			= theSpiders[randNum].forwardDistance;
			smSpider.DrawScale 					= theSpiders[randNum].drawingScale;
			smSpider.jumpingDistanceFromHarry 	= theSpiders[randNum].jumpingDistanceFromHarry;
			smSpider.GroupName 					= theSpiders[randNum].GroupName;
			smSpider.numSpellsDefault		 	= theSpiders[randNum].numSpellsLargeSpider;
			smSpider.leaveDeadSpider 			= theSpiders[randNum].leaveSmallDeadSpider;
			smSpider.bDespawnable 				= True;
		} 
		else 
		{
			spiderRotation 		= Rotation;
			spiderYaw 			= theSpiders[randNum].iRotation * (16384 / 90.0);
			spiderRotation.Yaw += spiderYaw;
			spiderRotation.Yaw  = spiderRotation.Yaw & 65535;
			
			lgSpider 							= Spawn(Class'SpiderLarge',self,,Location,spiderRotation);
			lgSpider.NormalSpeed 				= theSpiders[randNum].NormalSpeed;
			lgSpider.attackSpeed 				= theSpiders[randNum].attackSpeed;
			lgSpider.GroundSpeed 				= theSpiders[randNum].NormalSpeed;
			lgSpider.canWander 					= theSpiders[randNum].canWander;
			lgSpider.waitForTrigger 			= theSpiders[randNum].waitForTrigger;
			lgSpider.forwardDistance 			= theSpiders[randNum].forwardDistance;
			lgSpider.DrawScale 					= theSpiders[randNum].drawingScale;
			lgSpider.jumpingDistanceFromHarry 	= theSpiders[randNum].jumpingDistanceFromHarry;
			lgSpider.GroupName 					= theSpiders[randNum].GroupName;
			lgSpider.numSpellsDefault 			= theSpiders[randNum].numSpellsLargeSpider;
			lgSpider.leaveDeadSpider 			= theSpiders[randNum].leaveSmallDeadSpider;
			lgSpider.bDespawnable 				= True;
      
			switch (Rand(2))
			{
				case 0:
					lgSpider.ePreAttackAnim = ATTACK_Jump;
					break;
				case 1:
					lgSpider.ePreAttackAnim = ATTACK_Rear;
					break;
        
			}
		}
	}
	GotoState('spiderSpawnerWait');
}

auto state spiderSpawnerWait
{
}

state SpawnSomeSpiders
{
	begin:
	
	Counter = 0;
	while( Counter < numSpiders )
	{
		if ( bSmallSpiders == True )
		{
			spiderRotation 		= Rotation;
			spiderYaw 			= theSpiders[Counter].iRotation * (16384 / 90.0);
			spiderRotation.Yaw += spiderYaw;
			spiderRotation.Yaw  = spiderRotation.Yaw & 65535;
			
			smallSpider 							= Spawn(Class'SpiderSmall',self,,Location,spiderRotation);
			smallSpider.NormalSpeed 				= theSpiders[Counter].NormalSpeed;
			smallSpider.attackSpeed 				= theSpiders[Counter].attackSpeed;
			smallSpider.GroundSpeed 				= theSpiders[Counter].NormalSpeed;
			smallSpider.canWander 					= theSpiders[Counter].canWander;
			smallSpider.waitForTrigger 				= theSpiders[Counter].waitForTrigger;
			smallSpider.forwardDistance 			= theSpiders[Counter].forwardDistance;
			smallSpider.DrawScale 					= theSpiders[Counter].drawingScale;
			smallSpider.jumpingDistanceFromHarry 	= theSpiders[Counter].jumpingDistanceFromHarry;
			smallSpider.GroupName 					= theSpiders[Counter].GroupName;
			smallSpider.numSpellsDefault			= theSpiders[Counter].numSpellsLargeSpider;
			smallSpider.leaveDeadSpider 			= theSpiders[Counter].leaveSmallDeadSpider;
		} 
		else 
		{
			spiderRotation 		= Rotation;
			spiderYaw 			= theSpiders[Counter].iRotation * (16384 / 90.0);
			spiderRotation.Yaw += spiderYaw;
			spiderRotation.Yaw  = spiderRotation.Yaw & 65535;
			
			largeSpider 							= Spawn(Class'SpiderLarge',self,,Location,spiderRotation);
			largeSpider.NormalSpeed 				= theSpiders[Counter].NormalSpeed;
			largeSpider.attackSpeed 				= theSpiders[Counter].attackSpeed;
			largeSpider.GroundSpeed 				= theSpiders[Counter].NormalSpeed;
			largeSpider.canWander 					= theSpiders[Counter].canWander;
			largeSpider.waitForTrigger 				= theSpiders[Counter].waitForTrigger;
			largeSpider.forwardDistance 			= theSpiders[Counter].forwardDistance;
			largeSpider.DrawScale 					= theSpiders[Counter].drawingScale;
			largeSpider.jumpingDistanceFromHarry 	= theSpiders[Counter].jumpingDistanceFromHarry;
			largeSpider.GroupName 					= theSpiders[Counter].GroupName;
			largeSpider.numSpellsDefault 			= theSpiders[Counter].numSpellsLargeSpider;
			largeSpider.leaveDeadSpider 			= theSpiders[Counter].leaveSmallDeadSpider;
		}
		Counter++;
		Sleep(theSpiders[Counter].nextSpiderDelay);
	}
	GotoState('spiderSpawnerWait');
}

defaultproperties
{
    numSpiders=5

    bSmallSpiders=True
	
	// Metallicafan212:	This doesn't seem to have decomped correctly, so I'm writing it by hand.....
	theSpiders(0)=(NormalSpeed=75,attackSpeed=100,canWander=True,waitForTrigger=False,forwardDistance=0,GroupName="",iRotation=0,nextSpiderDelay=0.5,drawingScale=1,jumpingDistanceFromHarry=250,numSpellsLargeSpider=1,leaveSmallDeadSpider=0.2)
	theSpiders(1)=(NormalSpeed=75,attackSpeed=100,canWander=True,waitForTrigger=False,forwardDistance=0,GroupName="",iRotation=0,nextSpiderDelay=0.5,drawingScale=1,jumpingDistanceFromHarry=250,numSpellsLargeSpider=1,leaveSmallDeadSpider=0.2)
	theSpiders(2)=(NormalSpeed=75,attackSpeed=100,canWander=True,waitForTrigger=False,forwardDistance=0,GroupName="",iRotation=0,nextSpiderDelay=0.5,drawingScale=1,jumpingDistanceFromHarry=250,numSpellsLargeSpider=1,leaveSmallDeadSpider=0.2)
	theSpiders(3)=(NormalSpeed=75,attackSpeed=100,canWander=True,waitForTrigger=False,forwardDistance=0,GroupName="",iRotation=0,nextSpiderDelay=0.5,drawingScale=1,jumpingDistanceFromHarry=250,numSpellsLargeSpider=1,leaveSmallDeadSpider=0.2)
	theSpiders(4)=(NormalSpeed=75,attackSpeed=100,canWander=True,waitForTrigger=False,forwardDistance=0,GroupName="",iRotation=0,nextSpiderDelay=0.5,drawingScale=1,jumpingDistanceFromHarry=250,numSpellsLargeSpider=1,leaveSmallDeadSpider=0.2)

    //theSpiders(0)=(attackSpeed=75.00,iRotation=1120403456,drawingScale=0.00,DamageAmount=0.00,offsetFromSpawner=(X=0.00,Y=0.00,Z=0.00),,jumpingDistanceFromHarry=0.00,numSpells=-855638016),,numberOfSpiders=4082892,nextSpiderDelay=0.00),

    //theSpiders(1)=(attackSpeed=75.00,iRotation=1120403456,drawingScale=0.00,DamageAmount=0.00,offsetFromSpawner=(X=0.00,Y=0.00,Z=0.00),,jumpingDistanceFromHarry=0.00,numSpells=-855638016),,numberOfSpiders=4082892,nextSpiderDelay=0.00),

    //theSpiders(2)=(attackSpeed=75.00,iRotation=1120403456,drawingScale=0.00,DamageAmount=0.00,offsetFromSpawner=(X=0.00,Y=0.00,Z=0.00),,jumpingDistanceFromHarry=0.00,numSpells=-855638016),,numberOfSpiders=4082892,nextSpiderDelay=0.00),

    //theSpiders(3)=(attackSpeed=75.00,iRotation=1120403456,drawingScale=0.00,DamageAmount=0.00,offsetFromSpawner=(X=0.00,Y=0.00,Z=0.00),,jumpingDistanceFromHarry=0.00,numSpells=-855638016),,numberOfSpiders=20860108,nextSpiderDelay=0.00),

    //theSpiders(4)=(attackSpeed=75.00,iRotation=1120403456,drawingScale=0.00,DamageAmount=0.00,offsetFromSpawner=(X=0.00,Y=0.00,Z=0.00),,jumpingDistanceFromHarry=0.00,numSpells=-855638016),,numberOfSpiders=4082892,nextSpiderDelay=0.00),

    CollisionRadius=10.00

    CollisionHeight=10.00

    bCollideActors=True

    bCollideWorld=True

    Mass=10.00

}