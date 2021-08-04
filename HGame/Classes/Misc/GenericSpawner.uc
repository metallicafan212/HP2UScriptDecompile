//================================================================================
// GenericSpawner.
//================================================================================

class GenericSpawner extends HPawn;

const MAX_SPAWNED_GOODIES= 8;
struct MaxMin
{
  var() int Max;
  var() int Min;
};
struct Sounds
{
  var() Sound Opening;
  var() Sound Closing;
  var() Sound Spawning;
};

struct Animations
{
  var() name Opening;
  var() name Closing;
  var() name Start;
  var() name End;
};

var() Class<Actor> GoodieToSpawn[8];
var() int GoodiesNumber[8];
var() name EventName;
var() Animations Anims;
var() Sounds Snds;
var() MaxMin Limits;
var() name StartBone;
var() Vector StartPos;
var() Vector StartVel;
var() Class<ParticleFX> BaseParticles;
var() float BaseDelay;
var() float GoodieDelay;
var() int Lives;
var() bool bDestroable;
var() bool bMakeSpawnPersistent;
var bool bInitialized;
var Vector BaseParticlePos;
var bool bSpawnExactNumbers;
var int HowManyObjectsToSpawn;
var int RandomNums;
var int CurrentNum;
var int CurrentNum1;
var ESpellType eVulnerableToSpellSaved;


auto state stateStart
{
begin:
  if ( Lives <= 0 )
  {
    if ( Anims.End != 'None' )
    {
      LoopAnim(Anims.End);
    }
  } else //{
    if ( Anims.Start != 'None' )
    {
      LoopAnim(Anims.Start);
    }
  //}
}

state stateEnd
{
begin:
  if ( bDestroable )
  {
    Destroy();
  }
  if ( Anims.End != 'None' )
  {
    LoopAnim(Anims.End);
  }
}

state stateHitBySpell
{
begin:
  // eVulnerableToSpell = 0;
  eVulnerableToSpell = SPELL_None;
  if ( Lives > 0 )
  {
    Lives--;
  }
  FinishAnim();
  if ( Anims.Opening != 'None' )
  {
    if ( Snds.Opening != None )
    {
      PlaySound(Snds.Opening,SLOT_None);
    }
    PlayAnim(Anims.Opening);
    Sleep(BaseDelay);
    FinishAnim();
  }
  if ( BaseParticles != None )
  {
    FindBaseParticlePos();
    Spawn(BaseParticles,,,BaseParticlePos);
  }
  if ( Limits.Min >= Limits.Max )
  {
    RandomNums = Limits.Min;
  } else {
    RandomNums = RandRange(Limits.Min,Limits.Max);
	}
	if (  !bSpawnExactNumbers )
    {
      // CurrentNum = 0;
      // if ( CurrentNum < RandomNums )
	  for(CurrentNum = 0; CurrentNum < RandomNums; CurrentNum++)
      {
        Sleep(GoodieDelay);
        SpawnObject(-1);
        // CurrentNum++;
        // goto JL00E6;
      }
    } else {
      // CurrentNum = 0;
// JL00E6:
      // if ( CurrentNum < 8 )
	  for(CurrentNum = 0; CurrentNum < 8; CurrentNum++)
      {
        // CurrentNum1 = 0;
        // if ( CurrentNum1 < GoodiesNumber[CurrentNum] )
		for(CurrentNum1 = 0; CurrentNum1 < GoodiesNumber[CurrentNum]; CurrentNum1++)
        {
          Sleep(GoodieDelay);
          SpawnObject(CurrentNum);
          // CurrentNum1++;
          // goto JL012F;
        }
        // CurrentNum++;
        // goto JL011C;
      }
    }
  // }
  if ( Snds.Spawning != None )
  {
    PlaySound(Snds.Spawning,SLOT_Misc);
  }
  if ( Lives > 0 )
  {
    if ( Anims.Closing != 'None' )
    {
      if ( Snds.Closing != None )
      {
        PlaySound(Snds.Closing,SLOT_None);
      }
      PlayAnim(Anims.Closing);
      FinishAnim();
    }
    eVulnerableToSpell = eVulnerableToSpellSaved;
    GotoState('stateStart');
  } else {
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    if ( EventName != 'None' )
    {
      TriggerEvent(EventName,None,None);
    }
    GotoState('stateEnd');
  }
}

function PostBeginPlay()
{
  local int I;

  Super.PostBeginPlay();
  if (  !bInitialized )
  {
    eVulnerableToSpellSaved = eVulnerableToSpell;
    bInitialized = True;
  }
  HowManyObjectsToSpawn = 0;

  for(I = 0; I < 8; I++)
  {
    if ( GoodieToSpawn[I] == None )
    {
	  break;
    }
  }
  HowManyObjectsToSpawn = I;
  if ( Lives <= 0 )
  {
    HowManyObjectsToSpawn = 0;
  }
  bSpawnExactNumbers = False;

  for(I = 0; I < 8; I++)
  {
    if ( GoodiesNumber[I] != 0 )
    {
      bSpawnExactNumbers = True;
    }
  }
  if ( HowManyObjectsToSpawn <= 0 )
  {
	eVulnerableToSpell = SPELL_None;
  }
}

function FindBaseParticlePos()
{
  local Vector Dir;
  local int bNum;

  Dir = StartPos;
  Dir = Dir >> Rotation;
  if ( StartBone != 'None' )
  {
    bNum = BoneNumber(StartBone);
    if ( bNum >= 0 )
    {
      Dir = BonePos(StartBone);
      Dir = Dir - Location;
    }
  }
  BaseParticlePos = Dir + Location;
}

function SpawnObject (int Index)
{
  local Vector Dir;
  local Vector Vel;
  local Actor newSpawn;
  local int bNum;
  local Vector V;
  local Vector N;
  local float Length;
  local float angle;

  if ( HowManyObjectsToSpawn <= 0 )
  {
    return;
  }
  N = vector(Rotation);
  N.Z = 0.0;
  // if ( True )
  while(True)
  {
    angle = RandRange(0.0,6.28319979);
    V.X = Cos(angle);
    V.Y = Sin(angle);
    V.Z = 0.0;
    if ( (N.X == 0.0) && (N.Y == 0.0) )
    {
      // goto JL00CA;
	  break;
    }
    if ( V Dot N / VSize2D(N) > 0.69999999 )
    {
      // goto JL00CA;
	  break;
    }
    // goto JL0029;
  }
  Length = RandRange(50.0,100.0);
  Vel.X = Length * Cos(angle);
  Vel.Y = Length * Sin(angle);
  Vel.Z = 100.0 + FRand() * 100;
  Dir = StartPos;
  Dir = Dir >> Rotation;
  if ( StartBone != 'None' )
  {
    bNum = BoneNumber(StartBone);
    if ( bNum >= 0 )
    {
      Dir = BonePos(StartBone);
      Dir = Dir - Location;
    }
  }
  Dir = Dir + Location;
  if ( Index < 0 )
  {
    newSpawn = Spawn(GoodieToSpawn[Rand(HowManyObjectsToSpawn)],,,Dir);
  } else {
    newSpawn = Spawn(GoodieToSpawn[Index],,,Dir);
  }
  if ( (StartVel.X == 0) && (StartVel.Y == 0) && (StartVel.Z == 0) )
  {
    newSpawn.Velocity = Vel;
  } else {
    newSpawn.Velocity = StartVel;
  }
  newSpawn.SetPhysics(PHYS_Falling);
  switch (Rand(3))
  {
    case 0:
    Spawn(Class'Spawn_flash_1',,,Dir);
    break;
    case 1:
    Spawn(Class'Spawn_flash_2',,,Dir);
    break;
    case 2:
    Spawn(Class'Spawn_flash_3',,,Dir);
    break;
    default:
  }
  switch (Rand(3))
  {
    case 0:
    PlaySound(Sound'spawn_bean01');
    break;
    case 1:
    PlaySound(Sound'spawn_bean02');
    break;
    case 2:
    PlaySound(Sound'spawn_bean03');
    break;
    default:
  }
  newSpawn.bPersistent = bMakeSpawnPersistent;
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellFlipendo(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellAlohomora (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellAlohomora(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellDiffindo(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellEcto (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellEcto(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellLumos (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellLumos(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellRictusempra(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellSkurge (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellSkurge(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellSpongify (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellSpongify(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

defaultproperties
{
    Anims=(Opening=Open,Closing=Close,Start=Start,End=End)

    Limits=(Max=6,Min=2)

    StartPos=(X=0.00,Y=0.00,Z=40.00)

    Lives=1

    bMakeSpawnPersistent=True

    // Physics=2
	Physics=PHYS_Falling

    // eVulnerableToSpell=13
	eVulnerableToSpell=SPELL_Flipendo

    bPersistent=True

    Mesh=SkeletalMesh'HPModels.skcigarboxMesh'

    // CollideType=3
	CollideType=CT_Shape
}
