//================================================================================
// Horklumps.
//================================================================================

class Horklumps extends HChar;

const BOOL_DEBUG_AI= false;
var int randomIdle;
var float waitTime;
var PoisonCloud aCloud;
var() float triggerCloudDistance;
var() float cloudLifetime;
var() float cloudDamage;
var() float cloudRadius;
var() float cloudDamageInterval;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetCollisionSize(CollisionRadius * DrawScale,CollisionHeight * DrawScale);
}

auto state ReadyAndWaiting
{
  function Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    waitTime += DeltaTime;
  }
  
  function ShootPoison()
  {
    if ( waitTime > 2 )
    {
      waitTime = 0.0;
      aCloud = Spawn(Class'PoisonCloud',self,,Location + Vec(0.0,0.0,-10.0),Rotation);
      aCloud.fLifetime = cloudLifetime;
      aCloud.iDamage = cloudDamage;
      aCloud.collideRadius = cloudRadius;
      aCloud.DamageInterval = cloudDamageInterval;
    }
  }
  
  function ShootPoisonCut()
  {
    if ( waitTime > 2 )
    {
      waitTime = 0.0;
      aCloud = Spawn(Class'PoisonCloudCut',self,,Location + Vec(0.0,0.0,0.0),Rotation);
      aCloud.fLifetime = cloudLifetime;
      aCloud.iDamage = cloudDamage;
      aCloud.collideRadius = cloudRadius;
    }
  }
  
  function LoseHead()
  {
    local HorklumpsHead replaceHead;
    local HorklumpsStem replaceStem;
    local Vector replaceLocation;
    local Rotator replaceRotation;
    local float replaceRadius;
    local float replaceHeight;
    local float replaceScale;
  
    replaceLocation = Location;
    replaceRotation = Rotation;
    replaceRadius = CollisionRadius;
    replaceHeight = CollisionHeight;
    replaceScale = DrawScale;
    Destroy();
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    replaceStem = Spawn(Class'HorklumpsStem',,,Location,Rotation);
    replaceHead = Spawn(Class'HorklumpsHead',,,Location + Vec(0.0,0.0,35.0),Rotation);
    if ( (replaceHead == None) || (replaceStem == None) )
    {
      Log("Replace head or stem failed to spawn");
    } else {
      replaceHead.SetCollisionSize(replaceRadius,replaceHeight);
      replaceHead.DrawScale = replaceScale;
      replaceStem.SetCollisionSize(replaceRadius,replaceHeight);
      replaceStem.DrawScale = replaceScale;
    }
    PlaySound(Sound'horklump_mushroom_head_popoff',SLOT_Misc,RandRange(0.6,1.0),,95000.0,RandRange(0.80,1.20),,False);
  }
  
  function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
  {
    ShootPoisonCut();
    LoseHead();
    return True;
  }
  
  function Bump (Actor Other)
  {
    if ( BOOL_DEBUG_AI )
    {
      PlayerHarry.ClientMessage("" $ string(Name) $ " Bump ");
    }
    if ( Other == PlayerHarry )
    {
      Other.Acceleration = vect(0.00,0.00,0.00);
      Other.Velocity = vect(0.00,0.00,0.00);
      ShootPoison();
    }
  }
  
 begin:
 loop:
  Sleep(Rand(2));
  randomIdle = Rand(3);
  switch (randomIdle)
  {
    case 0:
    LoopAnim('idle1');
    break;
    case 1:
    LoopAnim('Idle2');
    break;
    case 2:
    LoopAnim('idle3');
    break;
    default:
    break;
  }
  if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == False )
  {
    if ( Abs(VSize(Location - PlayerHarry.Location)) < triggerCloudDistance )
    {
      ShootPoison();
      PlayAnim('Attack');
      FinishAnim();
    }
  }
  goto ('loop');
}

defaultproperties
{
    triggerCloudDistance=200.00

    cloudLifetime=1.50

    cloudDamage=1.00

    cloudRadius=35.00

    cloudDamageInterval=2.00

    bThrownObjectDamage=True

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    Mesh=SkeletalMesh'HPModels.skhorklumpsMesh'

    DrawScale=1.20

    AmbientGlow=65

    CollisionRadius=10.00

    CollisionHeight=14.00

    bBlockActors=False
}
