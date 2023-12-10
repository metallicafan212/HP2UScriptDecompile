//================================================================================
// Peeves.
//================================================================================

class Peeves extends baseBoss;

const BOOL_DEBUG_AI= false;
enum PeevesType 
{
	Annoyance,
	MiniBoss
};

var Vector vHome;
var float fParticleTrailLife;
var ParticleFX ParticleFXActor;
var Sound peevesVoice;
var string sSoundID;
var Vector vTargetDir;
var int spellCount;
var int randSpells;
var float sleepTime;
var BossEncounterTrigger peevesTrigger;
var() float HitDamage;
var bool bGameOver;
var Vector vDir;
var() name DeathPatrolPoint;
var() PeevesType Type;
var Sound throwSound;
var PatrolPoint CurrentPoint;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	bFlipPushable = True;
	lockSpell = True;
	vHome = Location;
	SetCollision(True,False,False);
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if ( Type == Annoyance )
	{
		DeathPatrolPoint = 'DeathPatrolPoint';
		AirSpeed = 190.0;
		FindClosestDeathPoint();
	} 
	else 
	{
		GotoFirstPoint();
		foreach AllActors(Class'BossEncounterTrigger',peevesTrigger,'BossPeevesTrigger')
		{
			// goto JL0052;
			break;
		}
	}
	ParticleFXActor = Spawn(Class'GhostTrail',,,Location);
	ParticleFXActor.Lifetime.Base = fParticleTrailLife;
}

static function Vector GetFacing (Actor A)
{
	return Vec(1.0,0.0,0.0) >> A.Rotation;
}

function bool HandleSpellSkurge (optional baseSpell spell, optional Vector vHitLocation)
{
	if ( Type == Annoyance )
	{
		GotoState('DontAnnoyHarry');
	} 
	else 
	{
		GotoState('stateHitBySpell');
	}
	return True;
}

function float GetHealth()
{
	return float(Health) / 100;
}

function Tick (float DeltaTime)
{
	Super.Tick(DeltaTime);
	ParticleFXActor.SetLocation(Location + vect(0.00,0.00,-15.00));
}

function PeevesOuch()
{
	switch (Rand(3))
	{
		case 0:
			sSoundID = "peeves_ow01";
			break;
		case 1:
			sSoundID = "peeves_ow02";
			break;
		case 2:
			sSoundID = "peeves_ow03";
			break;
	}
	Localize("all",sSoundID,"HPdialog");
	peevesVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
	// PlaySound(peevesVoice,5);
	PlaySound(peevesVoice, SLOT_Talk);
}

function PeevesYell()
{
	sSoundID = "peeves_ow_long";
	Localize("all",sSoundID,"HPdialog");
	peevesVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
	// PlaySound(peevesVoice,5);
	PlaySound(peevesVoice, SLOT_Talk);
}

function PeevesLaughing()
{
	switch (Rand(3))
	{
		case 0:
			sSoundID = "PC_PVS_happy01fx";
			break;
		case 1:
			sSoundID = "PC_PVS_happy02fx";
			break;
		case 2:
			sSoundID = "PC_PVS_happy03fx";
			break;
	}
	Localize("all",sSoundID,"HPdialog");
	peevesVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
	// PlaySound(peevesVoice,5);
	PlaySound(peevesVoice, SLOT_Talk);
}

function PeevesTaunting()
{
	switch (Rand(2))
	{
		case 0:
			sSoundID = "PC_PVS_Chal2Skurge_23";
			break;
		case 1:
			sSoundID = "PC_PVS_Chal2Skurge_24";
			break;
	}
	Localize("all",sSoundID,"HPdialog");
	peevesVoice = Sound(DynamicLoadObject("AllDialog." $ sSoundID,Class'Sound'));
	// PlaySound(peevesVoice,5);
	PlaySound(peevesVoice, SLOT_Talk);
}

function StopPeevesDialog()
{
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("Stopping Dialog");
	}
	// StopSound(peevesVoice,5);
	StopSound(peevesVoice, SLOT_Talk);
}

function Trigger (Actor Other, Pawn EventInstigator)
{
	if ( Type == Annoyance )
	{
		// goto JL0025;
		//KW left this empty? -AdamJD
	}
	else
	{
		TriggerEvent('BossPeevesTrigger',self,None);
		GotoState('MoveToPoint');
	}
}

function GotoFirstPoint()
{
	local PatrolPoint tempPatrolPoint;
	local float fDist;
	local float fClosestDist;
	local PatrolPoint ClosestPoint;
	local int Count;

	fClosestDist = 1000000.0;
	foreach AllActors(Class'PatrolPoint',tempPatrolPoint)
	{
		fDist = VSize(Location - tempPatrolPoint.Location);
		if ( fDist < fClosestDist )
		{
			fClosestDist = fDist;
			ClosestPoint = tempPatrolPoint;
		}
	}
	CurrentPoint = ClosestPoint;
}

function GotoNextPoint()
{
	CurrentPoint = CurrentPoint.NextPatrolPoint;
}

function FindClosestDeathPoint()
{
	local PatrolPoint tempPatrolPoint;
	local float fDist;
	local float fClosestDist;
	local PatrolPoint ClosestPoint;
	local int Count;

	fClosestDist = 1000000.0;
	foreach AllActors(Class'PatrolPoint',tempPatrolPoint,DeathPatrolPoint)
	{
		fDist = VSize(Location - tempPatrolPoint.Location);
		if ( fDist < fClosestDist )
		{
			fClosestDist = fDist;
			ClosestPoint = tempPatrolPoint;
		}
	}
	CurrentPoint = ClosestPoint;
	if ( CurrentPoint == None )
	{
		Log(string(self.Name) $ " has no patrol point to go to. Please see properties!!");
	}
}

function PlayerCutCapture()
{
	if ( Type == Annoyance )
	{
		GotoState('GoAway');
	} 
	else 
	{
		GotoState('CutIdle');
	}
}

function PlayerCutRelease()
{
	if ( Type != Annoyance )
	{
		if ( !bGameOver )
		{
			GotoState('stateWaitForTrigger');
		} 
		else 
		{
			GotoState('stateDestroyPeeves');
		}
	}
}

function Vector GetCamTargetLoc()
{
	local Vector V;
	local Vector v1;
	local Vector v2;
	local Vector vH;
	local Vector vLoc;

	vLoc = Location;
	return vLoc;
}

function Vector GetTargetLocation()
{
	return Location;
}

function Vector GetHarryFaceLocation()
{
	return peevesTrigger.Location;
}

function Vector GetHarryMovementCenter()
{
	return peevesTrigger.Location;
}

auto state stateIdle
{
begin:
	if ( Type == Annoyance )
	{
		GotoState('stateAnnoyHarry');
	} 
	else 
	{
		LoopAnim('Idle');
		GotoState('stateWaitForTrigger');
	}
}

state CutIdle
{
begin:
	LoopAnim('Idle');
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
}

state MoveToPoint
{
	function Tick (float DeltaTime)
	{
		Super.Tick(DeltaTime);
		MoveSmooth(vDir * AirSpeed * DeltaTime);
		if ( VSize2D(Location - CurrentPoint.Location) < 10 )
		{
			GotoState('stateTormentHarry');
		}
		vTargetDir = Normal(PlayerHarry.Location - Location);
		DesiredRotation = rotator(vTargetDir);
	}
  
begin:
	vDir = Normal(CurrentPoint.Location - Location);
	LoopAnim('Flying');
}

state stateTormentHarry
{
begin:
	Sleep(0.69999999);
	LoopAnim('Idle');
	vTargetDir = Normal(PlayerHarry.Location - Location);
	DesiredRotation = rotator(vTargetDir);
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
	switch (Rand(3))
	{
		case 0:
			PeevesTaunting();
			PlayAnim('Taunt');
			break;
		default:
			PeevesLaughing();
			if ( Rand(2) == 0 )
			{
				PlayAnim('taunt_2');
			} 
			else 
			{
				PlayAnim('taunt_3');
			}
			Sleep(1.0);
			break;
	}
	sleepTime = GetSoundDuration(peevesVoice);
	Sleep(sleepTime - 2.0);
	LoopAnim('Flying');
	GotoState('stateHitHarryLots');
}

state stateHitHarryLots
{
begin:
	randSpells = Rand(2) + 1;
	// spellCount = 0;
	for ( spellCount = 0; spellCount <= randSpells; spellCount++ )
	{
		vTargetDir = Normal(PlayerHarry.Location - Location);
		DesiredRotation = rotator(vTargetDir);
		PlayAnim('throw',1.2);
		Sleep(0.68);
		if ( Rand(2) == 0 )
		{
			throwSound = Sound'peeves_throw';
		} 
		else 
		{
			throwSound = Sound'peeves_throw2';
		}
		// PlaySound(throwSound,0,RandRange(0.62,1.0),,95000.0,RandRange(0.81,1.25),,False);
		PlaySound( throwSound, SLOT_None, [Volume]RandRange(0.6, 1.0),, [Radius]95000, [Pitch]RandRange(0.80, 1.20),, false );
		SpawnSpell(Class'spellEcto',PlayerHarry);
		Sleep(0.3);
		// spellCount++;
		// goto JL0014;
	}
	LoopAnim('Flying');
	GotoNextPoint();
	GotoState('MoveToPoint');
}

state stateWaitForTrigger
{
begin:
	LoopAnim('Idle');
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
}

state stateRunAway
{
begin:
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
}

state stateGoHome
{
begin:
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
}

state stateHitBySpell
{
begin:
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("In state HIT BY SPELL");
	}
	Health -= HitDamage;
	// eVulnerableToSpell = 0;
	if ( Health <= 0 )
	{
		eVulnerableToSpell=SPELL_None;
	}
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
	StopPeevesDialog();
	PeevesOuch();
	PlayAnim('prefly');
	FinishAnim();
	if ( Health <= 0 )
	{
		bGameOver = True;
		PeevesYell();
		SendDefeatedTrigger();
		PlayerHarry.StopBossEncounter();
	} 
	else
	{
		GotoNextPoint();
		GotoState('MoveToPoint');
	}
}

state stateAnnoyHarry
{
  function BeginState()
  {
		LoopAnim('Flying');
  }
  
begin:
	PlayAnim('taunt_2');
	PeevesLaughing();
	Sleep(1.0);
	// SetPhysics(4);
	SetPhysics(PHYS_Flying);
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
	Sleep(0.5);
	vTargetDir = Normal(PlayerHarry.Location - Location);
	DesiredRotation = rotator(vTargetDir);
	randSpells = Rand(1) + 1;
	if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == False )
	{
		// spellCount = 0;
		for( spellCount = 0; spellCount <= randSpells; spellCount++ )
		{
			vTargetDir = Normal(PlayerHarry.Location - Location);
			DesiredRotation = rotator(vTargetDir);
			PlayAnim('throw',1.2);
			Sleep(0.68);
			if ( Rand(2) == 0 )
			{
				throwSound = Sound'peeves_throw';
			} 
			else 
			{
				throwSound = Sound'peeves_throw2';
		}
		// PlaySound(throwSound,0,RandRange(0.62,1.0),,95000.0,RandRange(0.81,1.25),,False);
		PlaySound( throwSound, SLOT_None, [Volume]RandRange(0.6, 1.0),, [Radius]95000, [Pitch]RandRange(0.80, 1.20),, false );
		SpawnSpell(Class'spellEcto',PlayerHarry);
		Sleep(0.3);
		// spellCount++;
		// goto JL00A8;
		}
	}
	GotoState('GoAway');
}

state DontAnnoyHarry
{
begin:
	PlayAnim('prefly');
	FinishAnim();
	PeevesOuch();
	GotoState('GoAway');
}

state GoAway
{
begin:
	LoopAnim('Flying');
	MoveTo(CurrentPoint.Location);
	if ( CurrentPoint.NextPatrolPoint == None )
	{
		GotoState('stateDestroyPeeves');
	} 
	else 
	{
		CurrentPoint = CurrentPoint.NextPatrolPoint;
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		vTargetDir = Normal(PlayerHarry.Location - Location);
		DesiredRotation = rotator(vTargetDir);
		PeevesLaughing();
		PlayAnim('taunt_3');
		FinishAnim();
		GotoState('GoAway');
	}
}

state stateDestroyPeeves
{
begin:
	ParticleFXActor.Shutdown();
	Sleep(0.2);
	Destroy();
}

defaultproperties
{
    fParticleTrailLife=1.00

    HitDamage=20.00

    // EnemyHealthBar=3
	EnemyHealthBar=EnemyBar_Peeves

    AirSpeed=150.00

    SightRadius=4000.00

    PeripheralVision=0.00

    MenuName="Peeves"

    // Physics=4
	Physics=PHYS_FLYING

    // eVulnerableToSpell=20
	eVulnerableToSpell=SPELL_Skurge

    Mesh=SkeletalMesh'HPModels.skpeevesMesh'
	
	DrawType=DT_Mesh

    AmbientGlow=65

    CollisionRadius=40.00

    CollisionHeight=40.00

    bCollideWorld=False
	
	bCollideActors=True

    bBlockActors=False
	
	bProjTarget=True
	
	bGameOver=False

    RotationRate=(Pitch=80000,Yaw=80000,Roll=80000)
}
