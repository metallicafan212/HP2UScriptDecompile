//================================================================================
// SpiderLarge.
//================================================================================

class SpiderLarge extends Spider;

var Vector vDir;
var Vector vTemp;
var Rotator currentRotation;
var bool bStunned;
var float fStunned;
var Rotator jumpRotation;
var int iterationCheck;
var() float timeStunnedWhenHit;
var float savedCollision;
var() bool bDoEvent;
var Sound FootstepSound;
var float randomAttackSfx;
var(VisualFX) ParticleFX fxDestroy1ParticleEffect;
var(VisualFX) ParticleFX fxDestroy2ParticleEffect;
var Aragog Spider;

event KilledBy (Pawn EventInstigator)
{
  cm("We have received a KilledBy event");
  GotoState('stateCrushSpider');
}

state stateCrushSpider
{
begin:
  Sleep(0.1);
  fxDestroy1ParticleEffect = Spawn(Class'WebFx',,,Location);
  fxDestroy2ParticleEffect = Spawn(Class'WebDust',,,Location);
  Sleep(0.1);
  fxDestroy1ParticleEffect.Shutdown();
  fxDestroy2ParticleEffect.Shutdown();
  Sleep(0.05);
  Destroy();
}

function AddWebs()
{
}

function SubWebs()
{
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellRictusempra(spell,vHitLocation);
  PlayerHarry.ClientMessage(string(self.Name) $ " : In state HandleSpellRictusempra : StateName : " $ string(GetStateName()));
  if (  !IsInState('OutForTheCount') &&  !IsInState('HitBySpell') )
  {
    GroundSpeed = NormalSpeed;
    GotoState('HitBySpell');
    return True;
  } else //{
    if ( IsInState('HitBySpell') )
    {
      GroundSpeed = NormalSpeed;
      GotoState('preHitBySpell');
      return True;
    }
  //}
  cm(string(Name) $ " is in state " $ string(GetStateName()) $ " return false from HandleSpellRictusempra");
  return False;
}

function Landed (Vector HitNormal)
{
  local Rotator landedRotation;

  Super.Landed(HitNormal);
  landedRotation = Rotation;
  landedRotation.Pitch = 0;
  SetRotation(landedRotation);
}

function UnTouch (Actor Other)
{
  Super.UnTouch(Other);
  if (  !IsInState('OutForTheCount') )
  {
    if ( Other.IsA('SpiderMarker') )
    {
      if ( SpiderMarker(Other) == currentMarker )
      {
        Velocity = vect(0.00,0.00,0.00);
        Acceleration = vect(0.00,0.00,0.00);
        atTheEdge = True;
        GroundSpeed = NormalSpeed;
        GotoState('RandomWait');
      }
    }
  }
}

function bool ReadyPosition()
{
  if ( VSize(PlayerHarry.Location - Location) < savedCollision + PlayerHarry.CollisionRadius - (9 * DrawScale) )
  {
    return True;
  }
  return False;
}

state preAttackCheck
{
begin:
  bAttacking = True;
  GroundSpeed = attackSpeed;
  savedCollision = CollisionRadius;
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
		PlaySound(Sound'SPI_large_preattack',SLOT_None,RandRange(0.62,1.0),,200000.0,RandRange(3.5,4.41),,False);
		LoopAnim('Jump');
		Sleep(0.31);
		PlayAnim('jump2walk');
		FinishAnim();
		break;
    // case 2:
	case ATTACK_REAR:
		if ( Rand(2) == 0 )
		{
		  PlaySound(Sound'SPI_large_Hiss1',SLOT_None,RandRange(0.62,1.0),,200000.0,RandRange(0.81,1.25),,False);
		} else {
		  PlaySound(Sound'SPI_large_Hiss2',SLOT_None,RandRange(0.62,1.0),,200000.0,RandRange(0.81,1.25),,False);
		}
		PlayAnim('webattack');
		FinishAnim();
		Sleep(0.41);
		break;
    default:
  }
  GotoState('AttackHarry');
}

state AttackHarry
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  function BeginState()
  {
    if ( DrawScale >= 1.0 )
    {
      SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale - (14 * DrawScale),Default.CollisionHeight * DrawScale / Default.DrawScale);
    } else {
      SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale - (17),Default.CollisionHeight * DrawScale / Default.DrawScale);
    }
    iterationCheck = 0;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {	
	Global.Tick(DeltaTime);

	if ( ReadyPosition() ==  true  && (baseHud(playerharry.myHud).bCutSceneMode == false)  )
	{
	  GotoState('stateBiteHarry');
	}
	
	randomAttackSfx -= DeltaTime;
	if ( randomAttackSfx <= 0 )
	{
	  randomAttackSfx = FRand() * 5 + 1;
	  playAttackSound();
	}
  }
  
 begin:
  LoopAnim('Walk',1.0);
  // eVulnerableToSpell = 22;
  eVulnerableToSpell = SPELL_Rictusempra;
 loop:
  MoveToward(PlayerHarry);
  Sleep(0.1);
  goto ('Loop');
}

state stateBiteHarry
{
  function BeginState()
  {
  }
  
  function EndState()
  {
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
    SetCollision(True,True,True);
    bAttacking = False;
  }
  
 begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlaySound(Sound'SPI_large_jump',SLOT_None,RandRange(0.89999998,1.0),,20000.0,RandRange(0.81,1.25),,False);
  PlayAnim('Attack',2.0);
  Sleep(0.31);
  if ( Rand(2) == 0 )
  {
    PlaySound(Sound'SPI_large_bite1',SLOT_None,RandRange(0.89999998,1.0),,250.0,RandRange(0.81,1.25),,False);
  } else {
    PlaySound(Sound'SPI_large_bite2',SLOT_None,RandRange(0.89999998,1.0),,250.0,RandRange(0.81,1.25),,False);
  }
  Sleep(0.04);
  if ( VSize(PlayerHarry.Location - Location) < savedCollision + PlayerHarry.CollisionRadius )
  {
    PlayerHarry.TakeDamage(fDamageAmount,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'largeSpider');
  }
  Velocity = Normal(Location - PlayerHarry.Location) * GroundSpeed;
  Acceleration = Normal(Location - PlayerHarry.Location) * GroundSpeed * 2;
  PlayAnim('lungeAttackend',1.29999995);
  FinishAnim();
  Sleep(0.151);
  GotoState('Wander');
}

state preHitBySpell
{
begin:
  GotoState('HitBySpell');
}

state HitBySpell
{
  // ignores  Tick; //UTPT added this for some reason -AdamJD
  
  function BeginState()
  {
    fStunned = timeStunnedWhenHit;
    SetCollisionSize(Default.CollisionRadius * DrawScale / Default.DrawScale,Default.CollisionHeight * DrawScale / Default.DrawScale);
    numSpells--;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float DeltaTime)
  {
	Global.Tick(DeltaTime);
	
	if( bStunned )
	{
	  fStunned -= DeltaTime;
	  if( fStunned <= 0 )
	  {
		GotoState('Wander'); 
      }
	}
  }
  
  function EndState()
  {
    bStunned = False;
  }
  
 begin:
  PlaySound(Sound'SPI_hit',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.81,1.25),,False);
  if ( Rand(2) == 0 )
  {
    PlaySound(Sound'SPI_large_ouch1',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.81,1.25),,False);
  } else {
    PlaySound(Sound'SPI_large_ouch2',SLOT_None,RandRange(0.89999998,1.0),,2000.0,RandRange(0.81,1.25),,False);
  }
  if ( numSpells > 0 )
  {
    Velocity = vect(0.00,0.00,0.00);
    Acceleration = vect(0.00,0.00,0.00);
    PlayAnim('jump2walk',2.5);
    FinishAnim();
    bStunned = True;
    LoopAnim('Idle');
  } else {
    GotoState('OutForTheCount');
  }
}

state OutForTheCount
{
  function BeginState()
  {
    if ( Rotation.Pitch != PlayerHarry.Rotation.Pitch )
    {
      cm(string(self.Name) $ "  Pitch is not the same as Harry's : " $ string(Rotation.Pitch));
      currentRotation = Rotation;
      currentRotation.Pitch = PlayerHarry.Rotation.Pitch;
      DesiredRotation = currentRotation;
    }
  }
  
 begin:
  // eVulnerableToSpell = 0;
  eVulnerableToSpell = SPELL_None;
  SetCollisionSize(15.0,20.0);
  if ( bDoEvent == True )
  {
    TriggerEvent('OutForTheCount',self,None);
  }
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  PlayAnim('flippedOver',1.39999998);
  Sleep(0.723);
  PlaySound(Sound'SPI_large_LandOnBack',SLOT_None,RandRange(0.89999998,1.0),,200000.0,RandRange(0.81,1.25),,False);
  Sleep(0.5);
  LoopAnim('idleOnBack');
  foreach AllActors(Class'Aragog',Spider)
  {
    // goto JL00B9;
	break;
  }
// JL00B9:
  if ( Spider != None )
  {
    Sleep(0.2);
    fxDestroy1ParticleEffect = Spawn(Class'WebFx',,,Location);
    fxDestroy2ParticleEffect = Spawn(Class'WebDust',,,Location);
    Sleep(0.1);
    fxDestroy1ParticleEffect.Shutdown();
    fxDestroy2ParticleEffect.Shutdown();
    Sleep(0.05);
    Destroy();
  }
}

defaultproperties
{
    timeStunnedWhenHit=1.00

    NormalSpeed=85.00

    attackSpeed=95.00

    fDamageAmount=3.00

    SightRadius=500.00

    MenuName="SpiderLarge"

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra
}
