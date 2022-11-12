//================================================================================
// SpiderAttendent.
//================================================================================

class SpiderAttendent extends Spider;

var Vector vDir;
var Vector vTemp;
var Rotator vRot;
var Rotator currentRotation;
var bool bStunned;
var float fStunned;
var Rotator jumpRotation;
var() float timeStunnedWhenHit;
var float savedCollision;
var(VisualFX) ParticleFX fxDestroy1ParticleEffect;
var(VisualFX) ParticleFX fxDestroy2ParticleEffect;
var Sound FootstepSound;
var bool bMoveTowardHarry;
var float menacingTime;
var float moveToHarryTime;
var float randomAttackSfx;
var bool bPlayScreamWhenInView;

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellRictusempra(spell,vHitLocation);
  if (  !IsInState('OutForTheCount') &&  !IsInState('HitBySpell') )
  {
    GroundSpeed = NormalSpeed;
    GotoState('HitBySpell');
    return True;
  } else //{
    if ( IsInState('HitBySpell') )
    {
      GroundSpeed = NormalSpeed;
	  GotoState('OutForTheCount');
      return True;
    }
  //}
  return False;
}

function Landed (Vector HitNormal)
{
  local Rotator landedRotation;

  Super.Landed(HitNormal);
  landedRotation = Rotation;
  landedRotation.Pitch = 0;
  SetRotation(landedRotation);
  if (  !IsInState('OutForTheCount') )
  {
    GotoState('preAttackCheck');
  }
}

function bool PawnCantStandOnMe()
{
  return False;
}

function bool ReadyPosition()
{
  if ( VSize(PlayerHarry.Location - Location) < savedCollision + PlayerHarry.CollisionRadius - 9 * DrawScale )
  {
    return True;
  }
  return False;
}

function Timer()
{
  SetCollision(True,True);
}

state preAttackSetup
{
begin:
  Sleep(FRand());
  SetTimer(2.0,False);
  if ( DrawScale != Default.DrawScale )
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
  }
  SetLocation2(Location);
  savedCollision = CollisionRadius;
  numSpells = numSpellsDefault;
  if ( Location.Z <= PlayerHarry.Location.Z + PlayerHarry.EyeHeight )
  {
    LoopAnim('Walk');
    MoveToward(PlayerHarry);
    GotoState('preAttackCheck');
  } else {
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
  }
}

state stateFlyIn
{
  function Landed (Vector HitNormal)
  {
    GotoState('preAttackSetup');
  }
  
  function Tick (float dtime)
  {
    if ( bPlayScreamWhenInView )
    {
      if ( (Normal(Location - PlayerHarry.Cam.Location) Dot vector(PlayerHarry.Cam.Rotation)) > 0.64999998 )
      {
        bPlayScreamWhenInView = False;
        PlayScream();
      }
    }
    DesiredRotation.Yaw = rotator(PlayerHarry.Location - Location).Yaw;
  }
  
}

function PlayScream()
{
  PlaySound(Sound'snail_falling',SLOT_None,,,,RandRange(0.80,1.20));
  PlaySound(Sound'imp_ouch_03',SLOT_None,,,,RandRange(0.80,1.20));
  PlaySound(Sound'imp_scream',SLOT_None,,,,RandRange(1.29999995,1.5));
  PlaySound(Sound'PIX_attack_04',SLOT_None,,,,RandRange(0.80,1.20));
}

state stateCrawlIn extends patrol
{
  function patrolPlayRunAnim()
  {
    LoopAnim('Walk');
  }
  
  function PawnAtPatrolPoint (PatrolPoint pP)
  {
    if ( pP.NextPatrolPoint == None )
    {
      OnEvent('done');
    }
  }
  
  function OnEvent (name EventName)
  {
    if ( EventName == 'done' )
    {
      // SetPhysics(1);
	  SetPhysics(PHYS_Walking);
      SetLocation2(Location);
      GotoState('preAttackSetup');
    } else //{
      if ( EventName == 'scream' )
      {
        PlayScream();
      }
    //}
  }
  
}

state preAttackCheck
{
begin:
  bAttacking = True;
  GroundSpeed = attackSpeed;
  if ( VSize2D(PlayerHarry.Location - Location) > jumpingDistanceFromHarry )
  {
    GotoState('playPreAttackAnim');
  } else {
    GotoState('AttackHarry');
  }
}

state playPreAttackAnim
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  vTemp = Vec(PlayerHarry.Location.X,PlayerHarry.Location.Y,Location.Z);
  vDir = Normal(vTemp - Location);
  DesiredRotation = rotator(vDir);
  switch (ePreAttackAnim)
  {
    // case 0:
	case ATTACK_NONE:
		Sleep(0.5);
		break;
    // case 1:
	case ATTACK_JUMP:
		PlayAnim('walk2jump');
		FinishAnim();
		PlaySound(Sound'SPI_large_preattack',SLOT_None,RandRange(0.6,1.0),,200000.0,RandRange(3.5,4.4),,False);
		LoopAnim('Jump');
		Sleep(0.3);
		PlayAnim('jump2walk');
		FinishAnim();
		break;
    // case 2:
	case ATTACK_REAR:
		if ( Rand(2) == 0 )
		{
		  PlaySound(Sound'SPI_large_Hiss1',SLOT_None,RandRange(0.6,1.0),,200000.0,RandRange(0.80,1.20),,False);
		} else {
		  PlaySound(Sound'SPI_large_Hiss2',SLOT_None,RandRange(0.6,1.0),,200000.0,RandRange(0.80,1.20),,False);
		}
		PlayAnim('webattack');
		FinishAnim();
		Sleep(0.4);
		break;
		default:
  }
  GotoState('AttackHarry');
}

state AttackHarry
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick; 
  
  function BeginState()
  {
    if ( DrawScale >= 1.0 )
    {
      SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale - (14 * DrawScale),Default.CollisionHeight * DrawScale / Default.DrawScale);
    } else {
      SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale - 17,Default.CollisionHeight * DrawScale / Default.DrawScale);
    }
    moveToHarryTime = Rand(5) + 6;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {	
	Global.Tick(DeltaTime);

	if ( ReadyPosition() == True && (BaseHud(PlayerHarry.myHud).bCutSceneMode == False)  )
	{
		GotoState('stateBiteHarry');
	}
	
	moveToHarryTime -= DeltaTime;
	if ( moveToHarryTime <= 0 )
	{
		GotoState('stateBeMenacing');
	}
	
	randomAttackSfx -= DeltaTime;
	if ( randomAttackSfx <= 0 )
	{
		randomAttackSfx = FRand() * 4 + 1;
		playAttackSound();
	}
  }
  
 begin:
  LoopAnim('Walk',1.0);
  // eVulnerableToSpell = 22;
  eVulnerableToSpell = SPELL_Rictusempra;
  vDir = Normal(PlayerHarry.Location - Location);
  Acceleration = vDir * attackSpeed;
 loop:
  MoveToward(PlayerHarry);
  Sleep(0.1);
  goto ('Loop');
}

state stateBeMenacing
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState()
  {
    menacingTime = Rand(3) + 1;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {	
	Global.Tick(DeltaTime);

	if ( ReadyPosition() == True  && (BaseHud(Playerharry.myHud).bCutSceneMode == False)  )
	{
		GotoState('stateBiteHarry');
	}

	menacingTime -= DeltaTime;
	if ( menacingTime <= 0 )
	{
		GotoState('preAttackCheck');
	}

	vDir = Normal(PlayerHarry.Location - Location);
	vRot = rotator(PlayerHarry.Location - Location);

	DesiredRotation = vRot;
  }
  
 begin:
  LoopAnim('Idle');
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
}

state stateBiteHarry
{
  function EndState()
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
    SetCollision(True,True,True);
    bAttacking = False;
  }
  
 begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlaySound(Sound'SPI_large_jump',SLOT_None,RandRange(0.89999998,1.0),,20000.0,RandRange(0.80,1.20),,False);
  PlayAnim('Attack',2.0);
  Sleep(0.3);
  if ( Rand(2) == 0 )
  {
    PlaySound(Sound'SPI_large_bite1',SLOT_None,RandRange(0.89999998,1.0),,250.0,RandRange(0.80,1.20),,False);
  } else {
    PlaySound(Sound'SPI_large_bite2',SLOT_None,RandRange(0.89999998,1.0),,250.0,RandRange(0.80,1.20),,False);
  }
  Sleep(0.04);
  if ( VSize(PlayerHarry.Location - Location) < savedCollision + PlayerHarry.CollisionRadius )
  {
    PlayerHarry.TakeDamage(fDamageAmount,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'attendentSpider');
  }
  Velocity = Normal(Location - PlayerHarry.Location) * GroundSpeed;
  Acceleration = Normal(Location - PlayerHarry.Location) * GroundSpeed * 2;
  PlayAnim('lungeAttackend',1.29999995);
  FinishAnim();
  Sleep(0.15);
  GotoState('preAttackCheck');
}

state HitBySpell
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState()
  {
    bStunned = False;
    fStunned = timeStunnedWhenHit;
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
    numSpells--;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);
	
	if ( bStunned )
	{
	  fStunned -= DeltaTime;
	  if( fStunned <= 0 )
	  {
		GoToState('preAttackCheck'); 
	  }
	}
  }
  
  function EndState()
  {
    bStunned = False;
  }
  
 begin:
  PlaySound(Sound'SPI_hit',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.80,1.20),,False);
  if ( Rand(2) == 0 )
  {
    PlaySound(Sound'SPI_large_ouch1',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.80,1.20),,False);
  } else {
    PlaySound(Sound'SPI_large_ouch2',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.80,1.20),,False);
  }
  if ( numSpells > 0 )
  {
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    bStunned = True;
    PlayAnim('lungeAttackStart',,0.2);
    FinishAnim();
    LoopAnim('Idle',,0.5);
  } else {
    GotoState('OutForTheCount');
  }
}

state OutForTheCount
{
begin:
  // eVulnerableToSpell = 0;
  eVulnerableToSpell = SPELL_None;
  TriggerEvent('OutForTheCount',self,None);
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlayAnim('flippedOver',1.39999998);
  Sleep(0.72);
  PlaySound(Sound'SPI_large_LandOnBack',SLOT_None,RandRange(0.89999998,1.0),,200000.0,RandRange(0.80,1.20),,False);
  Sleep(0.5);
  LoopAnim('idleOnBack');
  SetCollisionSize(PlayerHarry.CollisionRadius,Default.CollisionHeight);
  Sleep(0.2);
  fxDestroy1ParticleEffect = Spawn(Class'WebFx',,,Location);
  fxDestroy2ParticleEffect = Spawn(Class'WebDust',,,Location);
  Sleep(0.1);
  fxDestroy1ParticleEffect.Shutdown();
  fxDestroy2ParticleEffect.Shutdown();
  Sleep(0.05);
  Destroy();
}

defaultproperties
{
    timeStunnedWhenHit=1.00

    NormalSpeed=95.00

    attackSpeed=95.00

    fDamageAmount=3.00

    bIgnoreZonePainDamage=True

    SightRadius=2500.00

    MenuName="SpiderAttendent"

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra

    bCollideActors=False

    bBlockActors=False
}
