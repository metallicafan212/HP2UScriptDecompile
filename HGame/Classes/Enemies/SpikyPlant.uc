//================================================================================
// SpikyPlant.
//================================================================================

class SpikyPlant extends HChar;

const BOOL_DEBUG_AI= false;
var SpikyHeadnoSpikes noSpikesBush;
var SpikyPlantSpike aSpike;
var() int SpikeDamage;
var() int SpikeLift;
var() int SpikeSpeed;
var() int NumberOfSpikes;
var() float durationNoSpikes;

function PlayerCutCapture()
{
  GotoState('CutIdle');
}

state CutIdle
{
begin:
}

function PlayerCutRelease()
{
  GotoState('ReadyAndWaiting');
}

auto state ReadyAndWaiting
{
  function ShootSpikes()
  {
    local int I;
    local int NumSpikes;
    local Rotator rotate_spike;
    local Vector spike_locn;
    local Vector harrys_head;
  
    harrys_head = PlayerHarry.Location;
    harrys_head.Z += PlayerHarry.CollisionHeight / 2;
    NumSpikes = NumberOfSpikes;
    rotate_spike = rotator(harrys_head - Location);
    Log("Spike aim" @ string(rotate_spike));
    rotate_spike.Roll = 0;
    rotate_spike.Pitch += (65536 * 3) / 4;
    switch (Rand(2))
    {
      case 0:
      PlaySound(Sound'spiky_bush_shoot1');
      break;
      case 1:
      PlaySound(Sound'spiky_bush_shoot2');
      break;
      default:
    }
	
	for(I = 0; I < NumSpikes; ++I)
    {
      rotate_spike.Yaw = (65536 / NumSpikes) * I;
      spike_locn = Location;
      spike_locn.Z += DrawScale * 3;
      aSpike = Spawn(Class'SpikyPlantSpike',self,,spike_locn,rotate_spike);
      aSpike.iDamage = SpikeDamage;
      aSpike.Lift = SpikeLift;
      aSpike.Speed = SpikeSpeed;
      aSpike.DrawScale = DrawScale;
    }
  }
  
  function KillMaimDestroy()
  {
    local SpikyBushNoThorns replaceBush;
  
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    bHidden = True;
    replaceBush = Spawn(Class'SpikyBushNoThorns',,,Location,Rotation);
    if ( replaceBush == None )
    {
      Log("Replace bush failed to spawn");
    } else {
      replaceBush.SetCollisionSize(CollisionRadius,CollisionHeight);
      replaceBush.DrawScale = DrawScale;
    }
    Destroy();
  }
  
  function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
  {
    ShootSpikes();
    KillMaimDestroy();
    return True;
  }
  
  function Bump (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      Other.Acceleration = vect(0.00,0.00,0.00);
      Other.Velocity = vect(0.00,0.00,0.00);
      ShootSpikes();
      KillMaimDestroy();
    }
  }
  
 begin:
 loop:
  Sleep(Rand(2));
  PlayAnim('Idle');
  FinishAnim();
  if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == False )
  {
    if ( Abs(VSize(Location - PlayerHarry.Location)) < SightRadius )
    {
      ShootSpikes();
      GotoState('GrowBack');
    }
  }
  goto ('Loop');
}

state Wilted
{
  event AnimEnd()
  {
    SetCollision(True,False,False);
    SetCollisionSize(0.0,0.0);
  }
  
 begin:
  bProjTarget = False;
  PlayAnim('wither');
  Sleep(1.0);
}

state GrowBack
{
  function ShowNoThorns()
  {
    SetCollision(False,False,False);
    bHidden = True;
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    noSpikesBush = Spawn(Class'SpikyHeadnoSpikes',,,Location,Rotation);
    if ( noSpikesBush == None )
    {
      Log("Replace bush failed to spawn");
    } else {
      noSpikesBush.SetCollisionSize(CollisionRadius,CollisionHeight);
      noSpikesBush.DrawScale = DrawScale;
    }
  }
  
  function ShowThorns()
  {
    bHidden = False;
    noSpikesBush.Destroy();
    SetCollision(True,True,True);
    // eVulnerableToSpell = 19;
	eVulnerableToSpell = SPELL_Diffindo;
  }
  
 begin:
  ShowNoThorns();
  Sleep(durationNoSpikes);
  ShowThorns();
  Sleep(0.05);
  GotoState('ReadyAndWaiting');
}

defaultproperties
{
    SpikeDamage=1

    SpikeLift=400

    SpikeSpeed=300

    NumberOfSpikes=8

    durationNoSpikes=0.20

    bThrownObjectDamage=True

    SightRadius=200.00

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    SizeModifier=0.90

    CentreOffset=(X=0.00,Y=0.00,Z=25.00)

    Mesh=SkeletalMesh'HPModels.skSpikyPlantMesh'

    AmbientGlow=65

    CollisionRadius=25.00

    CollisionHeight=20.00
}
