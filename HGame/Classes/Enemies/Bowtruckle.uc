//================================================================================
// Bowtruckle.
//================================================================================

class Bowtruckle extends HChar;

struct DamageParams
{
  var() int ByBowTruckle;
  var() int ByTwig;
};

struct AccuracyParams
{
  var() float Far;
  var() float Close;
};

struct BarkDistParams
{
  var() float Min;
  var() float Max;
};

struct BowtruckleParams
{
  var() Class<ParticleFX> Died;
  var() Class<ParticleFX> Hit;
  var() Class<ParticleFX> Twig;
};

var BowTruckleTwig objectToThrow;
var Vector vHome;
var Vector vNewPos;
var float ftemp;
var float SoundDuration;
var int NumMeshs;
var bool bInCutScene;
var() BowtruckleParams Particles;
var() Mesh Meshs[8];
var() float TauntProbability;
var() float TwigScale;
var() float ThrowDelay;
var() float startAttack;
var() float startExcited;
var() float travelFromHome;
var() float ThrowTime;
var() DamageParams Damage;
var() AccuracyParams Accuracy;
var() BarkDistParams BarkDist;

function PreBeginPlay()
{
  local int I;

  Super.PreBeginPlay();
  vHome = Location;
  if ( ThrowDelay <= 0 )
  {
    ThrowDelay = 0.01;
  }
  NumMeshs = 0;
  // I = 0;
  // if ( I < 8 )
  for(I = 0; I < 8; I++)
  {
    if ( Meshs[I] == None )
    {
      NumMeshs = I;
	  break;
    } //else {
      // I++;
      // goto JL0036;
    //}
  }
  if ( NumMeshs == 0 )
  {
    Meshs[0] = SkeletalMesh'skWiggentreeBarkMesh';
    NumMeshs = 1;
  }
}

function Mesh GetRandomMesh()
{
  local Mesh lMesh;
  //local int Index;
  local int iIndex;

  iIndex = Rand(NumMeshs);
  lMesh = Meshs[iIndex];
  return lMesh;
}

function GetObjectToThrow()
{
  objectToThrow = Spawn(Class'BowTruckleTwig',,,);
  if ( objectToThrow == None )
  {
    return;
  }
  objectToThrow.SetCollision(False,False,False);
  objectToThrow.SetOwner(self);
  objectToThrow.bRotateToDesired = False;
  objectToThrow.AttachToOwner('bip01 R Hand');
  objectToThrow.Mesh = GetRandomMesh();
  objectToThrow.Particles = Particles.Twig;
  objectToThrow.Damage = Damage.ByTwig;
  objectToThrow.DrawScale = TwigScale;
  objectToThrow.MaxLiveTime = ThrowTime + 0.5;
  aHolding = objectToThrow;
}

function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellDiffindo(spell,vHitLocation);
  if (  !IsInState('stateHitBySpell') )
  {
    GotoState('stateHitBySpell');
  }
  return True;
}

function DestroyActor (Actor A)
{
  Spawn(Particles.Died,,,Location,rot(0,0,0));
  // A.eVulnerableToSpell = 0;
  A.eVulnerableToSpell = SPELL_None;
  A.bHidden = True;
  A.Destroy();
}

function Vector RandomPosition (Vector NewPos, float Accuracy)
{
  local Rotator R;
  local Vector D;
  local Vector V;
  local Vector rv;
  local float spread;

  //spread = (1.0 - Accuracy) * 8192; //the bark used to get thrown way too wide -AdamJD
  
  //turned this down more because the bark was still getting thrown a bit too wide -AdamJD
  spread = (1.0 - Accuracy) * 1024; //2048; 
  
  //UTPT original code, this made the Bowtruckle throw bark up in the air instead of at Harry -AdamJD
  /*
  D.X = NewPos.X;
  D.Y = NewPos.Y;
  D.Z = 0.0;
  R = rotator(D);
  R.Yaw += RandRange(-spread,spread);
  rv = V * VSize(D);
  rv.Z = NewPos.Z;
  */
  
  //this makes the Bowtruckle actually throw bark at Harry -AdamJD
  D.X = NewPos.X - Location.X;
  D.Y = NewPos.Y - Location.Y;
  D.Z = 0.0;
  R = rotator(D);
  R.Yaw += RandRange(-spread, spread);
  V = vector(R);
  rv = Location + V * VSize(D);
  rv.Z = NewPos.Z;
  
  return rv;
}

function DropBark (Vector Loc, float Height)
{
  local Class<Actor> classtype;
  local Actor A;
  local Vector sloc;
  local int Num;
  local float angle;
  local float Length;

  sloc = Loc;
  sloc.Z += Height + 30;
  Num = 1;
  // if ( Num > 0 )
  while (Num > 0)
  {
    A = Spawn(Class'WiggentreeBark',,,sloc,RotRand());
    HPawn(A).bDespawnable = False;
    angle = RandRange(0.0,6.28319979);
    Length = RandRange(BarkDist.Min,BarkDist.Max);
    A.Velocity.X = Length * Cos(angle);
    A.Velocity.Y = Length * Sin(angle);
    A.Velocity.Z = 100.0 + FRand() * 100;
    A.DrawScale = TwigScale;
    Num--;
    // goto JL0028;
  }
}

function bool CloseToHome()
{
  if ( VSize(Location - vHome) < travelFromHome )
  {
    return True;
  }
  return False;
}

function bool FarFromHarry()
{
  if ( bInCutScene )
  {
    return True;
  }
  if ( VSize(PlayerHarry.Location - Location) > SightRadius )
  {
    return True;
  }
  return False;
}

function float PlaySoundOuch()
{
  local float duration;
  local Sound snd;

  switch (Rand(7))
  {
    case 0:
    snd = Sound'BOW_ouch_01';
    break;
    case 1:
    snd = Sound'BOW_ouch_02';
    break;
    case 2:
    snd = Sound'BOW_ouch_03';
    break;
    case 3:
    snd = Sound'BOW_ouch_04';
    break;
    case 4:
    snd = Sound'BOW_ouch_05';
    break;
    case 5:
    snd = Sound'BOW_ouch_06';
    break;
    case 6:
    snd = Sound'BOW_ouch_07';
    break;
    default:
    snd = None;
    break;
  }
  duration = GetSoundDuration(snd);
  PlaySound(snd);
  return duration;
}

function PlaySoundTaunt()
{
  switch (Rand(9))
  {
    case 0:
    PlaySound(Sound'BOW_taunt1');
    break;
    case 1:
    PlaySound(Sound'BOW_taunt2');
    break;
    case 2:
    PlaySound(Sound'BOW_taunt3');
    break;
    case 3:
    PlaySound(Sound'BOW_taunt4');
    break;
    case 4:
    PlaySound(Sound'BOW_taunt5');
    break;
    case 5:
    PlaySound(Sound'BOW_taunt6');
    break;
    case 6:
    PlaySound(Sound'BOW_taunt7');
    break;
    case 7:
    PlaySound(Sound'BOW_taunt8');
    break;
    case 8:
    PlaySound(Sound'BOW_taunt9');
    break;
    default:
  }
}

function PlaySoundAttack()
{
  switch (Rand(4))
  {
    case 0:
    PlaySound(Sound'BOW_attack1');
    break;
    case 1:
    PlaySound(Sound'BOW_attack2');
    break;
    case 2:
    PlaySound(Sound'BOW_attack3');
    break;
    case 3:
    PlaySound(Sound'BOW_attack4');
    break;
    default:
  }
}

function PlaySoundSurprise()
{
  switch (Rand(5))
  {
    case 0:
    PlaySound(Sound'BOW_surprise1');
    break;
    case 1:
    PlaySound(Sound'BOW_surprise2');
    break;
    case 2:
    PlaySound(Sound'BOW_surprise3');
    break;
    case 3:
    PlaySound(Sound'BOW_surprise4');
    break;
    case 4:
    PlaySound(Sound'BOW_surprise5');
    break;
    default:
  }
}

function Bump (Actor Other)
{
  if ( harry(Other) == None )
  {
    return;
  }
  if ( GetStateName() == 'stateAttackHarry' )
  {
    return;
  }
  if ( IsInState('stateHitBySpell') )
  {
    return;
  }
  harry(Other).TakeDamage(Damage.ByBowTruckle,None,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
  GotoState('stateAttackHarry');
}

function HitWall (Vector HitNormal, Actor HitWall)
{
  if ( IsInState('stateGoHome') )
  {
    return;
  }
  if ( IsInState('stateHitBySpell') )
  {
    return;
  }
  GotoState('stateGoHome');
}

function PlayerCutCapture()
{
  bInCutScene = True;
}

function PlayerCutRelease()
{
  bInCutScene = False;
}

function Tick (float deltaT)
{
  local float Distance;

  Super.Tick(deltaT);
  if ( IsInState('stateHitBySpell') )
  {
    return;
  }
  if ( bInCutScene )
  {
    return;
  }
  Distance = VSize(vHome - Location);
  if ( Distance > startExcited )
  {
    return;
  }
  Distance = VSize(PlayerHarry.Location - Location);
  if ( Distance > SightRadius )
  {
    return;
  }
  if (  !IsInState('stateIdle') &&  !IsInState('stateGoSomeWhere') )
  {
    return;
  }
  if ( Distance > startExcited )
  {
    if ( FRand() < TauntProbability )
    {
      GotoState('stateTaunt');
    } else {
      GotoState('stateThrow');
    }
    return;
  }
  if ( Distance > startAttack )
  {
    GotoState('stateThrow');
    return;
  }
  GotoState('stateGotoHarry');
}

auto state stateIdle
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  if (  !FarFromHarry() )
  {
    Sleep(0.01);
    if ( VSize(vHome - Location) > startExcited )
    {
      GotoState('stateGoHome');
    }
    goto ('Begin');
  }
  LoopAnim('Idle');
  Sleep(RandRange(2.0,3.0));
  FinishAnim();
  if (  !CloseToHome() )
  {
    GotoState('stateGoHome');
  } else {
    GotoState('stateGoSomeWhere');
  }
}

state stateGoHome
{
begin:
  LoopAnim('Walk');
  TurnTo(vHome);
  DesiredRotation.Yaw = Rotation.Yaw;
  MoveTo(vHome);
  GotoState('stateIdle');
}

state stateGoSomeWhere
{
begin:
  vNewPos = vHome + travelFromHome * VRand();
  vNewPos.Z = vHome.Z;
  LoopAnim('Walk');
  TurnTo(vNewPos);
  DesiredRotation.Yaw = Rotation.Yaw;
  MoveTo(vNewPos);
  GotoState('stateIdle');
}

state stateThrow
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  GetObjectToThrow();
  PlaySoundSurprise();
  PlayAnim('Attack');
  Sleep(0.5);
  vNewPos = ComputeTrajectoryByTime(objectToThrow.Location,PlayerHarry.Location,ThrowTime,-256.0);
  ftemp = VSize(PlayerHarry.Location - Location);
  if ( ftemp > startExcited )
  {
    vNewPos = RandomPosition(vNewPos,FClamp(Accuracy.Far,0.0,1.0));
  } else //{
    if ( ftemp > startAttack )
    {
      vNewPos = RandomPosition(vNewPos,FClamp(Accuracy.Close,0.0,1.0));
    }
  //}
  ObjectThrow(vNewPos,True,True);
  if ( ThrowDelay > 1.5 )
  {
    FinishAnim();
  } else {
    Sleep(ThrowDelay);
    AnimRate = 0.0;
  }
  GotoState('stateIdle');
}

state stateTaunt
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  PlaySoundTaunt();
  PlayAnim('Taunt');
  FinishAnim();
  GotoState('stateIdle');
}

state stateAttackHarry
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  PlaySoundAttack();
  PlayAnim('React');
  FinishAnim();
  vNewPos = Location + 4 * (Location - PlayerHarry.Location) / VSize(Location - PlayerHarry.Location);
  MoveTo(vNewPos);
  GotoState('stateIdle');
}

state stateHitBySpell
{
begin:
  SoundDuration = PlaySoundOuch();
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  // eVulnerableToSpell = 0;
  eVulnerableToSpell = SPELL_None;
  Spawn(Particles.Hit,,,Location,rot(0,0,0));
  DropBark(Location,CollisionHeight);
  if ( aHolding != None )
  {
    aHolding.Destroy();
  }
  bHidden = True;
  Sleep(SoundDuration);
  DestroyActor(self);
  // eVulnerableToSpell = 19;
  eVulnerableToSpell = SPELL_Diffindo;
  GotoState('stateIdle');
}

state stateGotoHarry
{
begin:
  LoopAnim('walkexcited');
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  MoveTo(PlayerHarry.Location);
  GotoState('stateIdle');
}

defaultproperties
{
    Particles=(Died=Class'HPParticle.Sticks3',Hit=Class'HPParticle.Sticks2',Twig=Class'HPParticle.Sticks1'),

    TauntProbability=0.50

    TwigScale=1.00

    ThrowDelay=1.50

    startAttack=128.00

    startExcited=256.00

    travelFromHome=100.00

    ThrowTime=1.50

    Damage=(ByBowTruckle=1,ByTwig=2)

    Accuracy=(Close=0.50,Far=0.50)

    BarkDist=(Min=30.00,Max=60.00)

    bThrownObjectDamage=True

    GroundSpeed=220.00

    SightRadius=512.00

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    Mesh=SkeletalMesh'HPModels.skBowtruckleMesh'

    DrawScale=1.20

    AmbientGlow=65

    CollisionRadius=18.00

    CollisionHeight=42.00
}
