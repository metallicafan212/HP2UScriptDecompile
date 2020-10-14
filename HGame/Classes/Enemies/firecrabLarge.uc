//================================================================================
// firecrabLarge.
//================================================================================

class firecrabLarge extends firecrab;

const BOOL_DEBUG_AI= false;
var spellFireLarge largeSpell;
var spellFireSmall smallSpell;
var int Counter;
var Vector spellLocation;
var Vector TempVector;
var Rotator TempRotator;
var Vector spellOrigin;
var int SpellSpraySpreadAmount;
var() float smallSpellDamage;
var() float largeSpellDamage;
var() float GrenadeRadius;
var() float timeBetweenShots;
var() float fLargeIncreaseHitTimeDistance;
var() float fLargeHitTimeIncrement;
var() float fSmallIncreaseHitTimeDistance;
var() float fSmallHitTimeIncrement;
var() int iAccuracyMin;
var() int iAccuracyMax;
var() bool bPlayRoar;
var() float GrenadeBounceInterval;
var() float GrenadeGravity;
var() float GrenadeOnlyDistance;
var() float GrenadeExplosionGravity;

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellFlipendo(spell,vHitLocation);
  GotoState('stateHitBySpell');
  return True;
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  local Vector V;

  Super.HandleSpellRictusempra(spell,vHitLocation);
  if (  !IsInState('stayFlipped') )
  {
    if (  --iNumSpellHitsToFlip <= 0 )
    {
      GotoState('stateHitBySpell');
    }
  }
  return True;
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if (  !IsInState('AttackHarry') &&  !IsInState('throwing') &&  !IsInState('stateHitBySpell') &&  !IsInState('DoFlip') &&  !IsInState('stayFlipped') )
  {
    TimeUntilNextFire -= DeltaTime;
    if ( TimeUntilNextFire < 0 )
    {
      if ( VSize(PlayerHarry.Location - Location) < fAttackRange )
      {
        TimeUntilNextFire = TimeUntilNextFireDefault;
        GotoState('AttackHarry');
      }
    }
  }
}

function PlayRoarSound ()
{
  local int randNum;

  randNum = Rand(4);
  switch (randNum)
  {
    case 0:
    RoarSound = Sound'firecrab_large_roar';
    break;
    case 1:
    RoarSound = Sound'firecrab_large_roar_A';
    break;
    case 2:
    RoarSound = Sound'firecrab_large_roar_B';
    break;
    case 3:
    RoarSound = Sound'firecrab_large_roar_C';
    break;
    default:
  }
  PlaySound(RoarSound,/*0*/SLOT_None,RandRange(0.62,1.0),,10000.0,RandRange(0.81,1.25),,False);
}

state stateHitBySpell
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage(string(Name) $ " : State stateHitBySpell ");
  }
  PlayerHarry.ClientMessage("Velocity: " $ string(Velocity));
  AmbientSound = None;
  fHighestZ = Location.Z;
  GotoState('DoFlip');
}

state DoFlip
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage(string(Name) $ " : State Do Flip ");
  }
  // eVulnerableToSpell = 13;
  eVulnerableToSpell = SPELL_Flipendo;
  RotationRate.Yaw = 50000;
  playHitSound();
  PlayAnim('flip2back');
  Sleep(1.0);
  // if ( bool(Physics) != bool(2) )
  if(Physics != PHYS_Falling)
  {
    PlaySound(Sound'SPI_large_LandOnBack',/*0*/SLOT_None,RandRange(0.89999998,1.0),,200000.0,RandRange(0.81,1.25),,False);
  }
  Sleep(1.0);
  GotoState('stayFlipped');
}

state AttackHarry
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": attackHarry");
  }
  LoopAnim('Idle');
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  AmbientSound = None;
  if ( bPlayRoar == True )
  {
    TurnTo(PlayerHarry.Location);
    PlayRoarSound();
    PlayAnim('roar');
    FinishAnim();
  }
  GotoState('throwing');
}

state throwing
{
  function BeginState ()
  {
    spellLocation = vect(0.00,0.00,0.00);
  }
  
 begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  TurnTo(Location + (Location - PlayerHarry.Location));
  if ( VSize(PlayerHarry.Location - Location) < GrenadeOnlyDistance )
  {
    PlaySound(Sound'firecrab_preattack',/*0*/SLOT_None);
    PlayAnim('preattack');
    FinishAnim();
  }
  // Counter = 0;
  // if ( Counter < 4 )
  for(Counter = 0; Counter < 4; Counter++)
  {
    if ( VSize(PlayerHarry.Location - Location) < GrenadeOnlyDistance )
    {
      DesiredRotation.Yaw = rotator(Location - PlayerHarry.Location).Yaw;
      spellLocation = PlayerHarry.Location - vect(0.00,0.00,5.00) + VRand() * 10;
      TempVector = spellLocation;
      spellOrigin = Location + (-vector(Rotation) * 3);
      spellOrigin = spellOrigin + Vec(0.0,0.0,13.0);
      smallSpell = Spawn(Class'spellFireSmall',,,spellOrigin,Rotation);
      smallSpell.iDamage = smallSpellDamage;
	  smallSpell.hitTarget = spellLocation;
      smallSpell.fIncreaseHitTimeDistance = fSmallIncreaseHitTimeDistance;
      smallSpell.fHitTimeIncrement = fSmallHitTimeIncrement;
      smallSpell.iAccuracyMin = iAccuracyMin;
      smallSpell.iAccuracyMax = iAccuracyMax;
      PlaySound(AttackSound,/*0*/SLOT_None);
      PlayAnim('Attack');
      FinishAnim();
    }
    Sleep(timeBetweenShots);
    // Counter++;
    // goto JL0082;
  }
  PlaySound(Sound'firecrab_preattack',/*0*/SLOT_None);
  PlayAnim('preattack');
  FinishAnim();
  largeSpell = Spawn(Class'spellFireLarge',self,,Location + Vec(0.0,0.0,12.0),Rotation + rot(0,32768,0));
  largeSpell.fIncreaseHitTimeDistance = fLargeIncreaseHitTimeDistance;
  largeSpell.fHitTimeIncrement = fLargeHitTimeIncrement;
  largeSpell.iDamage = largeSpellDamage;
  largeSpell.GrenadeRadius = GrenadeRadius;
  largeSpell.smallDamage = smallSpellDamage;
  largeSpell.GrenadeBounceInterval = GrenadeBounceInterval;
  largeSpell.GrenadeGravity = GrenadeGravity;
  largeSpell.GrenadeExplosionGravity = GrenadeExplosionGravity;
  Sleep(0.81);
  TurnTo(Location + vMoveDir);
  vMoveDirRot = Rotation;
  vMoveDir = vector(vMoveDirRot);
  TurnTo(navP.Location);
  AmbientSound = WalkingSound;
  GotoState('patrol');
}

defaultproperties
{
    SpellSpraySpreadAmount=3000

    smallSpellDamage=5.00

    largeSpellDamage=10.00

    GrenadeRadius=200.00

    timeBetweenShots=0.70

    fLargeIncreaseHitTimeDistance=200.00

    fLargeHitTimeIncrement=0.50

    fSmallIncreaseHitTimeDistance=200.00

    fSmallHitTimeIncrement=0.50

    iAccuracyMin=50

    iAccuracyMax=100

    bPlayRoar=True

    GrenadeBounceInterval=2.00

    GrenadeGravity=-512.00

    GrenadeOnlyDistance=500.00

    GrenadeExplosionGravity=-350.00

    WalkingSound=Sound'HPSounds.Critters_sfx.firecrab_walk'

    RoarSound=Sound'HPSounds.Critters_sfx.firecrab_large_roar'

    AttackSound=Sound'HPSounds.Critters_sfx.firecrab_large_attack'

    fAttackRange=1000.00

    iNumSpellHitsToFlipDefault=3

    bFlipPushable=True

    soundFalling(0)=Sound'HPSounds.Critters_sfx.firecrab_large_falling'

    soundFalling(1)=Sound'HPSounds.Critters_sfx.firecrab_large_falling_A'

    lockSpell=True

    SightRadius=1000.00

    PeripheralVision=0.05

    BaseEyeHeight=30.00

    EyeHeight=30.00

    DrawScale=4.00

    MultiSkins(1)=WetTexture'HPParticle.hp_fx.General.Gem2Wet'

    SoundRadius=25

    CollisionRadius=52.00

    CollisionHeight=44.00

    Mass=200.00

}
