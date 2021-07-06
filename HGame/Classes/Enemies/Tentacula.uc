//================================================================================
// Tentacula.
//================================================================================

class Tentacula extends HChar;

const FORTY_FIVE_DEGREES= 8192;
struct LimitsParams
{
  var() float Max;
  var() float Min;
};

var() LimitsParams LimbTimeIdle;
var() LimitsParams LimbTimeStunned;
var() int BulbDamageToHarry;
var() int LimbDamageToHarry;
var() int AttachRaduis;
var() int NumLimbs;
var() float Scale;
var() bool bCouldMove;
var float HarryDamageTimer;
var int TooClose;
var int firstLimb;
var Vector vTargetDir;
var Vector vNewLoc;
var Rotator rNewRot;
var TentaculaLimb limbs[4];
var TentaculaLimb AttackLimb;
var BaseCam Camera;
var bool bHasGoodLimbs;
var name bName[4];
var float rYaw[4];

function name GetBoneName (int Index)
{
  local string sName;
  //local name bName;
  local name boName;

  sName = "Attach_0" $Index;
  boName = name(sName);
  return boName;
}

function MyAttachActor (Actor A, Actor aOwner, name Bone)
{
  A.SetOwner(aOwner);
  A.AttachToOwner(Bone);
}

function MyDeattachActor (Actor A)
{
  // A.SetPhysics(0);
  A.SetPhysics(PHYS_None);
  A.AnimBone = 0;
  A.SetOwner(None);
}

function AttachLimb (int I)
{
  if ( limbs[I] == None )
  {
    return;
  }
  if (  !limbs[I].bGood )
  {
    return;
  }
  SetCollision(False,False,False);
  limbs[I].DamageToHarry = LimbDamageToHarry;
  // limbs[I].SetPhysics(2);
  limbs[I].SetPhysics(PHYS_Falling);
  limbs[I].SetCollision(False,False,False);
  MyAttachActor(limbs[I],self,bName[I]);
  if ( limbs[I].spellBox != None )
  {
    limbs[I].spellBox.SetCollision(False,False,False);
    MyAttachActor(limbs[I].spellBox,limbs[I],'Bone_Tent04');
  }
  if ( limbs[I].headBox != None )
  {
    MyAttachActor(limbs[I].headBox,limbs[I],'Head');
  }
  SetCollision(True,True,True);
  if ( limbs[I].spellBox != None )
  {
    limbs[I].spellBox.SetCollision(True,True,True);
  }
  if ( limbs[I].headBox != None )
  {
    limbs[I].headBox.SetCollisionSize(18.0 * Scale,8.0 * Scale);
    limbs[I].headBox.bCollideWorld = True;
  }
}

function AttachAllLimbs()
{
  local int I;

  // I = 0;
  // if ( I < NumLimbs ) 
  for(I = 0; I < NumLimbs; I++)
  {
    AttachLimb(I);
    // I++;
    // goto JL0007;
  }
  PlayerHarry.ClientMessage("Attach...............................");
  bHasGoodLimbs = True;
}

function DeAttachLimb (int I)
{
  if ( limbs[I] == None )
  {
    return;
  }
  if (  !limbs[I].bGood )
  {
    return;
  }
  MyDeattachActor(limbs[I]);
  if ( limbs[I].spellBox != None )
  {
    MyDeattachActor(limbs[I].spellBox);
  }
  if ( limbs[I].headBox != None )
  {
    MyDeattachActor(limbs[I].headBox);
  }
}

function DeAttachAllLimbs()
{
  local int I;

  // I = 0;
  // if ( I < NumLimbs )
  for(I = 0; I < NumLimbs; I++)
  {
    DeAttachLimb(I);
    // I++;
    // goto JL0007;
  }
  PlayerHarry.ClientMessage("Deattach...............................");
  bHasGoodLimbs = False;
}

function PostBeginPlay()
{
  local int I;
  local BaseCam Cam;

  Super.PostBeginPlay();
  SetCollisionSize(CollisionRadius * Scale,CollisionHeight * Scale);
  GroundSpeed *= Scale;
  SightRadius *= Scale;
  DrawScale *= Scale;
  foreach AllActors(Class'BaseCam',Cam)
  {
    Camera = Cam;
  }
  if ( NumLimbs < 0 )
  {
    NumLimbs = 1;
  }
  if ( NumLimbs > 4 )
  {
    NumLimbs = 4;
  }
  bName[0] = GetBoneName(0);
  rYaw[0] = 0.0;
  switch (NumLimbs)
  {
    case 1:
		break;
    case 2:
		bName[1] = GetBoneName(4);
		rYaw[1] = 8192.0 * 4;
		break;
    case 3:
		bName[1] = GetBoneName(3);
		bName[2] = GetBoneName(5);
		rYaw[1] = 8192.0 * 5;
		rYaw[2] = 8192.0 * 3;
		break;
    case 4:
    default:
		bName[1] = GetBoneName(2);
		bName[2] = GetBoneName(4);
		bName[3] = GetBoneName(6);
		rYaw[1] = 8192.0 * 6;
		rYaw[2] = 8192.0 * 4;
		rYaw[3] = 8192.0 * 2;
		break;
  }
  // I = 0;
  // if ( I < NumLimbs )
  for(I = 0; I < NumLimbs; I++)
  {
    limbs[I] = Spawn(Class'TentaculaLimb',,,);
    limbs[I].SightRadius *= Scale;
    limbs[I].DrawScale *= Scale;
    limbs[I].TooClose = TooClose * Scale;
    limbs[I].relYaw = rYaw[I];
    // limbs[I].SetPhysics(0);
    limbs[I].SetPhysics(PHYS_None);
    limbs[I].SetCollision(False,False,False);
    limbs[I].spellBox = Spawn(Class'TentaculaSpell',,,);
    if ( limbs[I].spellBox != None )
    {
      limbs[I].MinIdleTime = LimbTimeIdle.Min;
      limbs[I].MaxIdleTime = LimbTimeIdle.Max;
      limbs[I].MinStunnedTime = LimbTimeStunned.Min;
      limbs[I].MaxStunnedTime = LimbTimeStunned.Max;
      limbs[I].spellBox.SetCollision(False,False,False);
    }
    limbs[I].headBox = Spawn(Class'GenericColObj',self);
    // I++;
    // goto JL01A6;
  }
}

function bool HasLimbs()
{
  local int I;

  // I = 0;
  // if ( I < NumLimbs )
  for(I = 0; I < NumLimbs; I++)
  {
    if ( (limbs[I].GetStateName() != 'stateTwitch') && (limbs[I].GetStateName() != 'stateDie') )
    {
      return True;
    }
    // I++;
    // goto JL0007;
  }
  return False;
}

function int ClosestLimb()
{
  local int I;
  local int maxi;
  //local float Cos;
  local float fCos;
  local float maxcos;
  local Vector V;
  local Vector v1;
  local Rotator R;

  v1 = PlayerHarry.Location - Location;
  v1.Z = 0.0;
  maxcos = -2.0;
  maxi = -1;
  // I = 0;
  // if ( I < NumLimbs )
  for(I = 0; I < NumLimbs; I++)
  {
    if ( (limbs[I].GetStateName() != 'stateTwitch') && (limbs[I].GetStateName() != 'stateDie') )
    {
      R.Yaw = Rotation.Yaw + limbs[I].relYaw;
	  R.Roll = 0;
      R.Pitch = 0;
      V = vector(R);
      fCos = V Dot v1 / VSize(v1);
      if ( fCos > maxcos )
      {
        maxcos = fCos;
        maxi = I;
      }
    }
    // I++;
    // goto JL0048;
  }
  if ( maxi >= 0 )
  {
    AttackLimb = limbs[maxi];
  } else {
    AttackLimb = None;
  }
  return maxi;
}

function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
{
  local int I;

  PlaySoundOuch();
  // I = 0;
  // if ( I < NumLimbs )
  for(I = 0; I < NumLimbs; I++)
  {
    if ( limbs[I].GetStateName() == 'stateStun' )
    {
      // goto JL00CD;
	  continue;
    }
    if ( limbs[I].GetStateName() == 'stateStunned' )
    {
      // goto JL00CD;
	  continue;
    }
    if ( limbs[I].GetStateName() == 'stateWake' )
    {
      // goto JL00CD;
	  continue;
    }
    if ( limbs[I].GetStateName() == 'stateDie' )
    {
      // goto JL00CD;
	  continue;
    }
    if ( limbs[I].GetStateName() == 'stateTwitch' )
    {
      // goto JL00CD;
	  continue;
    }
    limbs[I].GotoState('stateStun');
    // I++;
    // goto JL000D;
  }
  GotoState('stateStun');
  return True;
}

function PlaySoundAngry()
{
  switch (Rand(5))
  {
    case 0:
    PlaySound(Sound'VT_big_idle_angry');
    break;
    default:
    break;
  }
}

function PlaySoundOuch()
{
  switch (Rand(3))
  {
    case 0:
    PlaySound(Sound'VT_big_ouch1');
    break;
    case 1:
    PlaySound(Sound'VT_big_ouch2');
    break;
    case 2:
    PlaySound(Sound'VT_big_ouch3');
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
  if ( GetStateName() == 'stateStun' )
  {
    return;
  }
  if ( HarryDamageTimer > 0.2 )
  {
    HarryDamageTimer = 0.0;
    harry(Other).TakeDamage(BulbDamageToHarry,None,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
  }
}

function Tick (float dtime)
{
  Super.Tick(dtime);
  HarryDamageTimer += dtime;
}

auto state stateIdle
{
begin:
  PlaySoundAngry();
  LoopAnim('idlemad');
  Sleep(0.01);
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  GotoState('statePatrol');
}

state stateStun
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  LoopAnim('Idle');
  Sleep(2.0);
  FinishAnim();
  GotoState('stateIdle');
}

state statePatrol
{
begin:
  vTargetDir = PlayerHarry.Location - Location;
  if ( VSize(vTargetDir) > AttachRaduis )
  {
    if ( bHasGoodLimbs )
    {
      DeAttachAllLimbs();
    }
    Sleep(0.1);
    GotoState('statePatrol');
  }
  if ( (VSize(vTargetDir) <= AttachRaduis) &&  !bHasGoodLimbs )
  {
    AttachAllLimbs();
  }
  if ( VSize(vTargetDir) <= TooClose * Scale )
  {
    rNewRot = rotator(vTargetDir);
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
    firstLimb = ClosestLimb();
    if ( firstLimb >= 0 )
    {
      DesiredRotation.Yaw = rNewRot.Yaw - limbs[firstLimb].relYaw;
	  //GotoState('stateIdle');
    }
	GotoState('stateIdle'); //this should be here -AdamJD 
  } else //{
    if ( VSize(vTargetDir) < SightRadius )
    {
      if ( bCouldMove && LineOfSightTo(PlayerHarry) && HasLimbs() )
      {
        vNewLoc = Location + 2 * GroundSpeed * vTargetDir / VSize(vTargetDir);
        GotoState('stateGotoHarry');
      } else {
        GotoState('stateIdle');
      }
    } else {
      GotoState('stateIdle');
    }
  //}
}

state stateGotoHarry
{
begin:
  LoopAnim('Walk');
  bRotateToDesired = False;
  MoveTo(vNewLoc);
  bRotateToDesired = True;
  GotoState('statePatrol');
}

defaultproperties
{
    LimbTimeIdle=(Max=2.00,Min=1.00)

    LimbTimeStunned=(Max=6.00,Min=4.00)

    BulbDamageToHarry=1

    LimbDamageToHarry=5

    AttachRaduis=512

    NumLimbs=2

    Scale=1.00

    TooClose=125

    GroundSpeed=20.00

    SightRadius=250.00

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    Mesh=SkeletalMesh'HPModels.skvenomous1Mesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=20.00

    bCollideActors=False

    RotationRate=(Pitch=4096,Yaw=16384,Roll=3072)
}
