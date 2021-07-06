//================================================================================
// Pig.
//================================================================================

class Pig extends HChar;

var float fCurrTime;
var() bool bLessFrequentSquealing;
var SleepingGoyle SlGoyle;

function PostBeginPlay()
{
  local SleepingGoyle sg;

  sg = None;
  foreach AllActors(Class'SleepingGoyle',sg)
  {
    SlGoyle = sg;
  }
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( IsInState('stateSqueal') )
  {
    return;
  }
  if ( IsInState('stateStun') )
  {
    return;
  }
  if ( Rand(30) == 0 )
  {
    PlaySoundSnort();
  }
  fCurrTime += DeltaTime;
  if ( fCurrTime < 1.0 )
  {
    return;
  }
  fCurrTime = 0.0;
  if ( VSize(Location - PlayerHarry.Location) < SightRadius )
  {
    if ( LineOfSightTo(PlayerHarry) && ( !bLessFrequentSquealing || bLessFrequentSquealing && (Rand(7) == 0)) )
    {
      GotoState('stateSqueal');
    }
  }
}

function PlaySoundSnort()
{
  switch (Rand(10))
  {
    case 0:
    PlaySound(Sound'Pig_snort01',SLOT_None);
    break;
    case 1:
    PlaySound(Sound'Pig_snort02',SLOT_None);
    break;
    case 2:
    PlaySound(Sound'Pig_snort03',SLOT_None);
    break;
    case 3:
    PlaySound(Sound'Pig_snort04',SLOT_None);
    break;
    case 4:
    PlaySound(Sound'Pig_snort05',SLOT_None);
    break;
    case 5:
    PlaySound(Sound'Pig_snort06',SLOT_None);
    break;
    case 6:
    PlaySound(Sound'Pig_snort07',SLOT_None);
    break;
    case 7:
    PlaySound(Sound'Pig_snort08',SLOT_None);
    break;
    case 8:
    PlaySound(Sound'Pig_snort09',SLOT_None);
    break;
    case 9:
    PlaySound(Sound'Pig_snort10',SLOT_None);
    break;
    default:
  }
}

function PlaySoundSqueal()
{
  PlaySound(Sound'pig_squeal1',SLOT_None,,,,RandRange(0.81,1.12));
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  GotoState('stateStun');
  return True;
}

state stateSqueal
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  PlaySoundSqueal();
  PlayAnim('Squeal');
  FinishAnim();
  SlGoyle.PigWakeGoyle();
  GotoState('patrol');
}

state stateStun
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  PlaySoundSqueal();
  PlayAnim('React');
  FinishAnim();
  SlGoyle.PigWakeGoyle();
  GotoState('patrol');
}

defaultproperties
{
    GroundSpeed=125.00

    SightRadius=300.00

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra

    Mesh=SkeletalMesh'HPModels.skPigMesh'

    CollisionRadius=40.00

    CollisionHeight=25.00

    RotationRate=(Pitch=4096,Yaw=16384,Roll=3072)
}
