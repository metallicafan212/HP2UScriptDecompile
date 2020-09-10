//================================================================================
// CornishPixie.
//================================================================================

class CornishPixie extends HChar;

const BOOL_DEBUG_AI= false;
var Vector vHome;
var Vector vOriginalHome;
var Vector vTargetDir;
var Rotator rHitRotation;
var float DistanceHome;
var(VisualFX) ParticleFX fxFlyParticleEffect;
var(VisualFX) Class<ParticleFX> fxFlyParticleEffectClass;
var ParticleFX fxBlowUp;
var ParticleFX fxHit;
var baseWand wand;
var Sound pixieLoopSound;
var Vector vTemp;
var CornishPixie myFriends[3];
var int numFriends;
var int Counter;
var bool bAttacking;
var Vector vHarryAttackPosition;
var float randomTalk;
var() int numAttacksDefault;
var int numAttacks;
var() float fDamageAmount;
var() name GroupName;
var() float timeStunned;
var bool bStunned;
var() float encroachRadius;
var() name patrolPointTag;
var() bool waitForTrigger;
var() bool goToPatrolPoint;
var PatrolPoint pP;
var() float StayOnSplineDefault;
var float StayOnSpline;
var() float StopAttackDistance;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  vHome = Location;
  vOriginalHome = Location;
  lockSpell = True;
  LoopAnim('Idle');
}

function PostBeginPlay ()
{
  local CornishPixie tempPixie;
  local PixieMarker Marker;

  Super.PostBeginPlay();
  if ( DrawScale != Default.DrawScale )
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  }
  numAttacks = numAttacksDefault;
  SetCollision(True,False,True);
  foreach AllActors(Class'CornishPixie',tempPixie)
  {
    if ( tempPixie != self )
    {
      if ( tempPixie.GroupName == GroupName )
      {
        myFriends[numFriends] = tempPixie;
        numFriends++;
      }
    }
  }
}

function PlayerCutCapture ()
{
  GotoState('CutIdle');
}

state CutIdle
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  GotoState('waitingForTrigger');
}

function PlayerCutRelease ()
{
  LoopAnim('Fly');
  GotoState('stateLoopSplinePath');
}

function Timer ()
{
  GotoState('BlowUpAndDie');
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellRictusempra(spell,vHitLocation);
  GotoState('stateHitByRictusempra');
  return True;
}

function Landed (Vector HitNormal)
{
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": In function Landed");
  }
  SetTimer(0.0,False);
  Super.Landed(HitNormal);
  GotoState('HitGround');
}

function bool GoAfterHarry ()
{
  local bool bRet;
  local Vector vVectorToHarry;

  bRet = False;
  vVectorToHarry = PlayerHarry.Location - Location;
  if ( VSize(vVectorToHarry) < SightRadius &&  !IsInState('CutIdle') )
  {
    bRet = True;
  }
  return bRet;
}

function playTalkSound ()
{
  local Sound talkSound;
  local int randNum;

  randNum = Rand(6);
  switch (randNum)
  {
    case 0:
    talkSound = Sound'PIX_talk_01';
    break;
    case 1:
    talkSound = Sound'PIX_talk_02';
    break;
    case 2:
    talkSound = Sound'PIX_talk_03';
    break;
    case 3:
    talkSound = Sound'PIX_talk_04';
    break;
    case 4:
    talkSound = Sound'PIX_talk_05';
    break;
    case 5:
    talkSound = Sound'PIX_talk_06';
    break;
    default:
    talkSound = Sound'PIX_talk_06';
    break;
  }
  PlaySound(talkSound,/*0*/SLOT_None,RandRange(0.81,1.0),,1000.0,RandRange(0.81,1.25),,False);
}

function playAttackSound ()
{
  local Sound AttackSound;
  local int randNum;

  randNum = Rand(5);
  switch (randNum)
  {
    case 0:
    AttackSound = Sound'PIX_attack_01';
    break;
    case 1:
    AttackSound = Sound'PIX_attack_02';
    break;
    case 2:
    AttackSound = Sound'PIX_attack_03';
    break;
    case 3:
    AttackSound = Sound'PIX_attack_04';
    break;
    case 4:
    AttackSound = Sound'PIX_attack_05';
    break;
    default:
    AttackSound = Sound'PIX_attack_05';
    break;
  }
  PlaySound(AttackSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

function playHitSound ()
{
  local Sound HitSound;
  local int randNum;

  randNum = Rand(6);
  switch (randNum)
  {
    case 0:
    HitSound = Sound'pixie_ouch1';
    break;
    case 1:
    HitSound = Sound'pixie_ouch2';
    break;
    case 2:
    HitSound = Sound'pixie_ouch3';
    break;
    case 3:
    HitSound = Sound'pixie_ouch4';
    break;
    case 4:
    HitSound = Sound'pixie_ouch5';
    break;
    case 5:
    HitSound = Sound'pixie_ouch6';
    break;
    default:
    HitSound = Sound'pixie_ouch1';
    break;
  }
  PlaySound(HitSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

function playBiteSound ()
{
  local Sound HitSound;
  local int randNum;

  randNum = Rand(5);
  switch (randNum)
  {
    case 0:
    HitSound = Sound'PIX_bite1';
    break;
    case 1:
    HitSound = Sound'PIX_bite2';
    break;
    case 2:
    HitSound = Sound'PIX_bite3';
    break;
    case 3:
    HitSound = Sound'PIX_bite4';
    break;
    case 4:
    HitSound = Sound'PIX_bite5';
    break;
    default:
    HitSound = Sound'PIX_bite1';
    break;
  }
  PlaySound(HitSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

auto state stateIdle //extends stateIdle
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": auto stateIdle");
  }
  LoopAnim('Fly');
  if ( waitForTrigger == True )
  {
    GotoState('waitingForTrigger');
  } else {
    Sleep(FRand() * 2);
    GotoState('stateLoopSplinePath');
  }
}

state stateLoopSplinePath
{
  function BeginState ()
  {
    LoopAnim('Fly');
    AmbientSound = pixieLoopSound;
    StayOnSpline = StayOnSplineDefault;
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    fxFlyParticleEffect = Spawn(fxFlyParticleEffectClass,,,Location);
  }
  
  function EndState ()
  {
    if ( False )
    {
      PlayerHarry.ClientMessage("" $ string(Name) $ ": EndState : stateLoopSplinePath");
    }
    DestroyControllers();
    AmbientSound = None;
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    bCollideWorld = True;
    bAlignBottom = False;
    fxFlyParticleEffect.Shutdown();
  }
  
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    StayOnSpline -= DeltaTime;
    if ( StayOnSpline < 0 )
    {
      // eVulnerableToSpell = 22;
	  eVulnerableToSpell = SPELL_Rictusempra;
      if ( GoAfterHarry() )
      {
        GotoState('stateMoveTowardHarry');
      } else {
        randomTalk -= DeltaTime;
        if ( randomTalk < 0 )
        {
          randomTalk = FRand() * 5 + 1;
          playTalkSound();
        }
      }
    }
    if ( VSize(PlayerHarry.Location - Location) < encroachRadius )
    {
      GotoState('stateAttackHarry');
    }
    fxFlyParticleEffect.SetLocation(Location);
  }
  
 begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateLoopSplinePath");
  }
  FollowSplinePath();
}

state stateMoveTowardHarry
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": state MoveTowardHarry");
  }
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  vHome = Location;
  playAttackSound();
  GotoState('stateAttackHarry');
}

state stateAttackHarry
{
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    if ( VSize(Location - PlayerHarry.Location) <= PlayerHarry.CollisionRadius + CollisionRadius + 5 )
    {
      if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == False )
      {
        GotoState('DamageHarry');
      }
    }
    if ( VSize(vHome - PlayerHarry.Location) > StopAttackDistance )
    {
      Velocity = vect(0.00,0.00,0.00);
      Acceleration = vect(0.00,0.00,0.00);
      GotoState('HarryGotAway');
    }
  }
  
 begin:
  LoopAnim('Fly');
 loop:
  vHarryAttackPosition = PlayerHarry.Location + (vector(PlayerHarry.Rotation) * (PlayerHarry.CollisionRadius + CollisionRadius + 5)) + Vec(0.0,0.0,-25.0);
  MoveTo(vHarryAttackPosition);
  Sleep(0.1);
  goto ('Loop');
}

state DamageHarry
{
begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlayAnim('Attack',3.0);
  Sleep(0.31);
  playBiteSound();
  Sleep(0.1);
  PlayerHarry.TakeDamage(fDamageAmount,Pawn(Owner),Location,Velocity * 1,'Pixie');
  GotoState('stateRunAway');
}

state stateRunAway
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateRunAway");
  }
  LoopAnim('Fly');
  // if ( VSize(Location - vHome) > 35 )
  while ( VSize(Location - vHome) > 35 )
  {
    DistanceHome = VSize(Location - vHome);
    MoveTo(vHome);
    Sleep(0.2);
    if ( DistanceHome - VSize(Location - vHome) < 5 )
    {
      if ( vHome != vOriginalHome )
      {
        vHome = vOriginalHome;
      } else {
        MoveTo(PlayerHarry.Location);
        Sleep(0.2);
      }
    }
    // goto JL0037;
  }
  GotoState('stateLoopSplinePath');
}

state stateHitByRictusempra
{
begin:
  DestroyControllers();
  PlaySound(Sound'SPI_hit',/*0*/SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(1.62,2.25),,False);
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateHitByRictusempra");
  }
  if (  --numAttacks <= 0 )
  {
    SetTimer(timeStunned,False);
    bStunned = True;
    fxFlyParticleEffect.Shutdown();
    SetCollision(False,False,False);
    SetCollisionSize(Default.CollisionRadius / 5, Default.CollisionHeight - Default.CollisionHeight - 1);
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    rHitRotation = Rotation;
    rHitRotation.Pitch = 0;
    DesiredRotation = rHitRotation;
    SetRotation(rHitRotation);
    playHitSound();
    fxHit = Spawn(Class'PixieHit',self,,Location,Rotation);
    LoopAnim('stunspin');
    Sleep(0.151);
    bCollideWorld = True;
    fxHit.Shutdown();
    playAttackSound();
    // SetPhysics(1);
	SetPhysics(PHYS_Walking);
  } else {
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    playHitSound();
    PlayAnim('stun');
    FinishAnim();
    LoopAnim('Idle');
    Sleep(0.1);
    GotoState('stateRunAway');
  }
}

state HitGround
{
begin:
  playHitSound();
  GotoState('BlowUpAndDie');
}

state HarryGotAway
{
begin:
  vTemp = Vec(PlayerHarry.Location.X,PlayerHarry.Location.Y,Location.Z);
  vTargetDir = Normal(vTemp - Location);
  DesiredRotation = rotator(vTargetDir);
  LoopAnim('Taunt');
  playAttackSound();
  Sleep(1.5);
  GotoState('stateRunAway');
}

state waitingForTrigger
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    GotoState('Triggered');
  }
  
 begin:
  LoopAnim('Fly');
}

state Triggered
{
begin:
  playTalkSound();
  if ( goToPatrolPoint == True )
  {
    foreach AllActors(Class'PatrolPoint',pP,patrolPointTag)
    {
      // goto JL002B;
	  break;
    }
    LoopAnim('Fly');
// JL003C:
    MoveToward(pP);
    // if ( VSize(Location - pP.Location) > 10 )
	while ( VSize(Location - pP.Location) > 10 )
    {
      Sleep(0.05);
      // goto JL003C;
    }
    if ( GoAfterHarry() )
    {
      GotoState('stateMoveTowardHarry');
    } else {
      GotoState('stateLoopSplinePath');
    }
  } else {
    GotoState('stateLoopSplinePath');
  }
}

state BlowUpAndDie
{
begin:
  PlaySound(Sound'horklump_mushroom_head_explode',/*0*/SLOT_None,RandRange(0.62,1.0),,70000.0,RandRange(0.81,1.25),,False);
  fxBlowUp = Spawn(Class'PixieExplode',self,,Location,Rotation);
  Sleep(0.1);
  if ( fxBlowUp != None )
  {
    fxBlowUp.Shutdown();
  }
  Destroy();
}

defaultproperties
{
    fxFlyParticleEffectClass=Class'HPParticle.PixieFlying'

    pixieLoopSound=Sound'HPSounds.Critters_sfx.PIX_wingflap_loop'

    numAttacksDefault=2

    fDamageAmount=2.00

    timeStunned=2.00

    encroachRadius=50.00

    StayOnSplineDefault=3.00

    StopAttackDistance=800.00

    bThrownObjectDamage=True

    GroundSpeed=75.00

    AirSpeed=120.00

    SightRadius=400.00

    PeripheralVision=1.00

    WalkAnimName=Fly

    RunAnimName=Fly

    // Physics=4
	Physics=PHYS_Flying

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra
	
    Mesh=SkeletalMesh'HPModels.skcornishpixieMesh'

    DrawScale=2.00

    AmbientGlow=200

    SoundRadius=75

    CollisionRadius=30.00

    CollisionHeight=20.00

    bBlockActors=False

    RotationRate=(Pitch=50000,Yaw=50000,Roll=50000),=
}
