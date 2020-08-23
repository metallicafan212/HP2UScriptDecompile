//================================================================================
// chestbronze.
//================================================================================

class chestbronze extends HProp;

const nMAX_EJECTED_OBJECTS= 8;
var() int iNumberOfBeans;
var() Class<Actor> EjectedObjects[8];
var() Vector ObjectStartPoint[8];
var() Vector ObjectStartVelocity[8];
var() bool bRandomBeans;
var() bool bMakeSpawnPersistent;
var bool bOpened;
var int iBean;

function int GetMaxEjectedObjects ()
{
  // return 8;
  return nMAX_EJECTED_OBJECTS;
}

function SetupRandomBeans ()
{
  local int iBean;

  // iBean = 0;
  // if ( iBean < iNumberOfBeans )
  for(iBean = 0; iBean < iNumberOfBeans; iBean++)
  {
    if ( Rand(100) < (30 - PlayerHarry.GetHealth() * 30) && iBean == 0 )
    {
      EjectedObjects[iBean] = Class'ChocolateFrog';
    } else {
      switch (Rand(5))
      {
        case 0:
        EjectedObjects[iBean] = Class'BlueJellyBean';
        break;
        case 1:
        EjectedObjects[iBean] = Class'GreenJellyBean';
        break;
        case 2:
        EjectedObjects[iBean] = Class'SpottedJellyBean';
        break;
        case 3:
        EjectedObjects[iBean] = Class'GreenPurpleCheckerBean';
        break;
        case 4:
        EjectedObjects[iBean] = Class'RedBlackStripeBean';
        break;
        default:
      }
    }
    // iBean++;
    // goto JL0007;
  }
}

state stillOpen
{
begin:
  bProjTarget = False;
  eVulnerableToSpell = /*0*/ SPELL_None;
  LoopAnim('End');
}

auto state waitforspell
{
  function BeginState ()
  {
    if ( bOpened )
    {
      GotoState('stillOpen');
    }
  }
  
  function bool HandleSpellAlohomora (optional baseSpell spell, optional Vector vHitLocation)
  {
    local Vector spawnLoc;
    local Actor newSpawn;
  
    GotoState('turnover');
    return True;
  }
  
 begin:
  if (  !bOpened )
  {
    LoopAnim('Start');
  }
}

state turnover
{
  function BeginState ()
  {
    bOpened = True;
    Level.PlayerHarryActor.ClientMessage(" Chest " $ string(self) $ " is opening so bOpened = " $ string(bOpened));
  }
  
  function generateobject ()
  {
    local Vector Dir;
    local Vector Vel;
    local Actor newSpawn;
    local Rotator SpawnDirection;
    local Rotator HarryDirection;
    local Rotator DifRotation;
    local bool bPlayBeanSound;
    local bool bPlayWCardSound;
  
    Vel = ObjectStartVelocity[iBean];
    Vel.X +=  -16 + Rand(96);
    if ( Vel.X < 0 )
    {
      Vel.X = 0.0;
    }
    SpawnDirection = Rotation;
    Vel = Vel >> SpawnDirection;
    Dir = ObjectStartPoint[iBean];
    Dir = Dir >> SpawnDirection;
    Dir = Dir + Location;
    newSpawn = Spawn(Class'Spawn_flash_1',,,Dir,rot(0,0,0));
    newSpawn = FancySpawn(EjectedObjects[iBean],,,Dir,Rotation); 
    if ( newSpawn.IsA('ChocolateFrog') )
    {
      newSpawn.Velocity = Vel * 2;
      bPlayBeanSound = True;
    } else //{
      if ( newSpawn.IsA('WizardCardIcon') )
      {
        Vel = ObjectStartVelocity[iBean];
        Vel.X += 20;
        SpawnDirection = Rotation;
        Vel = Vel >> SpawnDirection;
        newSpawn.Velocity = Vel;
        HarryDirection = rotator(PlayerHarry.Location - Dir);
        DifRotation = HarryDirection - SpawnDirection;
        DifRotation.Yaw = DifRotation.Yaw & 65535;
        if ( DifRotation.Yaw > 32767 )
        {
          DifRotation.Yaw -= 65536;
        }
        if ( (Abs(DifRotation.Yaw) < 8192) && (VSize(PlayerHarry.Location - Dir) < 50) )
        {
          if ( DifRotation.Yaw > 0 )
          {
            newSpawn.Velocity = newSpawn.Velocity << rot(0,14336,0);
          } else {
            newSpawn.Velocity = newSpawn.Velocity >> rot(0,14336,0);
          }
        }
        newSpawn.SetLocation(Location + newSpawn.Velocity);
        bPlayWCardSound = True;
      } else {
        newSpawn.Velocity = Vel;
        bPlayBeanSound = True;
        newSpawn.SetPhysics(/*2*/PHYS_Falling);
      }
    //}
    newSpawn.bPersistent = bMakeSpawnPersistent;
    if ( bPlayWCardSound )
    {
      PlaySound(Sound'vendor_spawn_WC');
    } else //{
      if ( bPlayBeanSound )
      {
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
      }
    //}
  }
 begin:
  bProjTarget = False;
  eVulnerableToSpell = /*0*/ SPELL_None;
  PlaySound(Sound'wood_chest_open');
  PlayAnim('Open');
  FinishAnim();
  if ( bRandomBeans )
  {
// JL0039:
    SetupRandomBeans();
  }
  // iBean = 0;
  // if ( iBean < iNumberOfBeans )
  for(iBean = 0; iBean < iNumberOfBeans; iBean++)
  {
    generateobject();
    Sleep(RandRange(0.31,0.62));
    // iBean++;
    // goto JL0039;
  }
  LoopAnim('End');
}

defaultproperties
{
    iNumberOfBeans=4

    EjectedObjects(0)=Class'Jellybean'

    EjectedObjects(1)=Class'Jellybean'

    EjectedObjects(2)=Class'Jellybean'

    EjectedObjects(3)=Class'Jellybean'

    EjectedObjects(4)=Class'Jellybean'

    EjectedObjects(5)=Class'Jellybean'

    EjectedObjects(6)=Class'Jellybean'

    EjectedObjects(7)=Class'Jellybean'

    ObjectStartPoint(0)=(X=0.00,Y=0.00,Z=40.00)

    ObjectStartPoint(1)=(X=17.00,Y=-3.00,Z=40.00)

    ObjectStartPoint(2)=(X=2.00,Y=22.00,Z=40.00)

    ObjectStartPoint(3)=(X=-4.00,Y=-18.00,Z=40.00)

    ObjectStartPoint(4)=(X=22.00,Y=19.00,Z=40.00)

    ObjectStartPoint(5)=(X=16.00,Y=-23.00,Z=40.00)

    ObjectStartPoint(6)=(X=8.00,Y=36.00,Z=40.00)

    ObjectStartPoint(7)=(X=12.00,Y=-42.00,Z=40.00)

    ObjectStartVelocity(0)=(X=48.00,Y=0.00,Z=120.00)

    ObjectStartVelocity(1)=(X=64.00,Y=0.00,Z=200.00)

    ObjectStartVelocity(2)=(X=48.00,Y=24.00,Z=120.00)

    ObjectStartVelocity(3)=(X=48.00,Y=-24.00,Z=120.00)

    ObjectStartVelocity(4)=(X=64.00,Y=24.00,Z=200.00)

    ObjectStartVelocity(5)=(X=64.00,Y=-24.00,Z=200.00)

    ObjectStartVelocity(6)=(X=48.00,Y=48.00,Z=150.00)

    ObjectStartVelocity(7)=(X=48.00,Y=-48.00,Z=150.00)

    bRandomBeans=True

    bMakeSpawnPersistent=True

    // Physics=2
	Physics=PHYS_Falling

    // eVulnerableToSpell=1
	eVulnerableToSpell=SPELL_Alohomora

    CentreOffset=(X=0.00,Y=0.00,Z=20.00),

    Mesh=SkeletalMesh'HPModels.skbronzechestMesh'

    DrawScale=2.00

    CollisionRadius=24.00

    CollisionWidth=32.00

    CollisionHeight=24.00

    // CollideType=2
	CollideType=CT_Box
}
