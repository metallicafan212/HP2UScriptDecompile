//================================================================================
// bronzecauldron.
//================================================================================

class bronzecauldron extends HProp;

const nMAX_EJECTED_OBJECTS= 3;
var() int iNumberOfBeans;
var() Class<Actor> EjectedObjects[3];
var() Vector ObjectStartPoint[3];
var() Vector ObjectStartVelocity[3];
var() bool bRandomBean;
var() bool bMakeSpawnPersistent;
var bool bOpened;

function int GetMaxEjectedObjects()
{
  // return 3;
  return nMAX_EJECTED_OBJECTS;
}

function SetupRandomBeans()
{
  local int iBean;

  if ( iNumberOfBeans > 3 )
  {
    iNumberOfBeans = 3;
  }
  // iBean = 0;
  // if ( iBean < iNumberOfBeans )
  for(iBean = 0; iBean < iNumberOfBeans; iBean++)
  {
    if ( Rand(100) < (30 - (PlayerHarry.GetHealth() * 30)) && iBean == 0 )
    {
      EjectedObjects[iBean] = Class'ChocolateFrog';
    } else {
      EjectedObjects[iBean] = Class'Jellybean';
    }
    // iBean++;
    // goto JL001B;
  }
}

state stillOpen
{
 begin:
  bProjTarget = False;
  eVulnerableToSpell =  SPELL_None; 
  LoopAnim('End');
}

auto state waitforspell
{
  function BeginState()
  {
    if ( bOpened )
    {
      GotoState('stillOpen');
    }
  }
  
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    GotoState('turnover');
    return True;
  }
}

state turnover
{
  function generateobject()
  {
    local Vector Dir;
    local Vector Vel;
    local Actor newSpawn;
    local Rotator SpawnDirection;
    local int iBean;
    local bool bPlayBeanSound;
  
    bPlayBeanSound = True;
    if ( bRandomBean )
    {
      SetupRandomBeans();
    }
    // iBean = 0;
    // if ( iBean < iNumberOfBeans )
	for(iBean = 0; iBean < iNumberOfBeans; iBean++)
    {
      Vel = ObjectStartVelocity[iBean];
      Vel.X += (Rand(64));
      SpawnDirection = Rotation;
      SpawnDirection.Yaw += 5000;
      Vel = Vel >> SpawnDirection;
      Dir = ObjectStartPoint[iBean];
      Dir = Dir >> SpawnDirection;
      Dir = Dir + Location;
      newSpawn = Spawn(Class'Spawn_flash_2',,,Dir,rot(0,0,0));
      //newSpawn = FancySpawn(EjectedObjects[iBean],,,Dir);
	  newSpawn = Spawn(EjectedObjects[iBean],,,Dir); //using spawn instead of fancyspawn stops the game lagging (to be compatible with the new engine) -AdamJD
      if ( newSpawn == None )
      {
        cm("* ERROR: cauldron spawn failed.");
      }
      if ( newSpawn.IsA('ChocolateFrog') || newSpawn.IsA('WizardCardIcon') )
      {
        Vel.Z *= 2;
        newSpawn.Velocity = Vel * 2;
      } else {
        newSpawn.Velocity = Vel;
        newSpawn.SetPhysics(PHYS_Falling);
      }
      newSpawn.bPersistent = bMakeSpawnPersistent;
      // iBean++;
      // goto JL001E;
    }
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
  }
  
 begin:
  bProjTarget = False;
  eVulnerableToSpell =  SPELL_None;
  PlaySound(Sound'cauldron_flip');
  PlayAnim('tipover'); 
  FinishAnim();
  generateobject();
  LoopAnim('tipped');
}

defaultproperties
{
    iNumberOfBeans=3

    EjectedObjects(0)=Class'Jellybean'

    EjectedObjects(1)=Class'Jellybean'

    EjectedObjects(2)=Class'Jellybean'

    //ObjectStartPoint(0)=(X=64.00,Y=0.00,Z=-20.00) 
	ObjectStartPoint(0)=(X=64.00,Y=0.00,Z=20.00) //now that spawn is used instead of fancyspawn we need to set the Z start point of the first ObjectStartPoint 
												//to +20 otherwise beans/frogs fall through the floor when being spawned (to be compatible with the new engine) -AdamJD

    ObjectStartPoint(1)=(X=64.00,Y=-20.00,Z=20.00)

    ObjectStartPoint(2)=(X=64.00,Y=20.00,Z=20.00)

    ObjectStartVelocity(0)=(X=64.00,Y=0.00,Z=40.00) 

    ObjectStartVelocity(1)=(X=64.00,Y=40.00,Z=40.00)

    ObjectStartVelocity(2)=(X=64.00,Y=-40.00,Z=40.00) 

    bRandomBean=True

    bMakeSpawnPersistent=True

    // eVulnerableToSpell=13
	eVulnerableToSpell=SPELL_Flipendo

    CentreOffset=(X=0.00,Y=0.00,Z=20.00) 

    Mesh=SkeletalMesh'HPModels.skbronzecauldronMesh'
	
    AmbientGlow=200

    CollisionRadius=28.00

    CollisionHeight=50.00
}
