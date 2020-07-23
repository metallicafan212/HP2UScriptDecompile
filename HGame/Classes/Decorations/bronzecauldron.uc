//===============================================================================
//  [bronzecauldron] 
//===============================================================================

//added from the proto because the game used to lag for a few seconds when a cauldron spawned beans -AdamJD

class bronzecauldron extends hprop;

const nMAX_EJECTED_OBJECTS = 3;

var()	int				iNumberOfBeans;
var()	class<Actor>	EjectedObjects[3];	// Make sure matches nMAX_EJECTED_OBJECTS  
                                            // Up to 3 new objects can appear
                                            
var()	vector			ObjectStartPoint[3];
var()	vector			ObjectStartVelocity[3];
var()   bool            bRandomBean;

// Persistence support
var     bool			bOpened;		// set to true once the chest has been opened.
 

function int GetMaxEjectedObjects()
{
	return (nMAX_EJECTED_OBJECTS);
}

function SetupRandomBeans()
{
	local int	iBean;

	if (iNumberOfBeans > 3)
		iNumberOfBeans = 3;

	for( iBean = 0; iBean < iNumberOfBeans; iBean++ )
	{
		if( rand(100) < (30 - (playerHarry.GetHealth() * 30)) && iBean == 0)
			EjectedObjects[iBean] = Class'ChocolateFrog';
		else
			EjectedObjects[iBean] = Class'JellyBean';
	}
}

// Persistence support
state stillOpen
{
begin:
	//DEBUG
//	Level.playerHarryActor.ClientMessage(" State StillOpen for cauldron " $self );
	bProjTarget = false;
	eVulnerableToSpell = SPELL_None;
	loopanim('end');
}

auto state waitforspell
{
	function BeginState()
	{
		//DEBUG
//		Level.playerHarryActor.ClientMessage(" cauldron " $self $" is wainting for spell with bOpened = " $bOpened );
		if( bOpened )
			gotostate( 'stillOpen' );
	}
	
	function bool HandleSpellFlipendo( optional baseSpell spell, optional vector vHitLocation )
	{
		gotostate('turnover');
		return true;
	}
}

state turnover
{
	function generateobject()
	{
		local vector dir, vel;
		local actor newspawn;
		local rotator	SpawnDirection;
		local int  iBean;
		local bool bPlayBeanSound;

		bPlayBeanSound = true;

		if (bRandomBean)
			SetupRandomBeans();
		//else
		//if (TransformInto != none)
		//	EjectedObjects[0] = TransformInto;

		for (iBean = 0; iBean < iNumberOfBeans; iBean ++)
		{
			vel = ObjectStartVelocity[iBean];
			vel.x +=  (rand(64));

			SpawnDirection = rotation;
			SpawnDirection.yaw += 5000;

			vel = vel >> SpawnDirection;

			dir = ObjectStartPoint[iBean];

			dir = dir >> SpawnDirection;
			dir = dir + location;

			newspawn=spawn(class'Spawn_flash_2',,,dir,rot(0,0,0));
			newSpawn=Spawn(EjectedObjects[iBean],,, dir);

			if (newspawn.isa('chocolatefrog')) //|| newspawn.isa('wizardcardicon'))
			{
				// Special case with frogs, let them jump
				vel.z *= 1.5;
				newSpawn.Velocity = vel * 1.5;
			}
			else //if (newspawn.isa('jellybean'))
			{
				// Special case with beans, let them spill out		
				newSpawn.Velocity = vel;
				newSpawn.SetPhysics( PHYS_Falling );
			}
		}

		//Play appropriate sound

		if( bPlayBeanSound )
		{
			switch( Rand(3) )
			{
				case 0:   	PlaySound( sound'HPSounds.Magic_sfx.spawn_bean01');   break;
				case 1:   	PlaySound( sound'HPSounds.Magic_sfx.spawn_bean02');   break;
				case 2:   	PlaySound( sound'HPSounds.Magic_sfx.spawn_bean03');   break;
			}
		}
	}

  begin:
	bProjTarget = false;  //Seems as though this isn't really being used anymore
	eVulnerableToSpell = SPELL_None;

	playsound(sound'HPSounds.General.cauldron_flip');

	playanim('tipover',[RootBone] 'move');
	finishanim();
	generateobject();
	loopanim('tipped',[RootBone] 'move');
}

defaultproperties
{
     iNumberOfBeans=3
     EjectedObjects(0)=Class'HGame.Jellybean'
     EjectedObjects(1)=Class'HGame.Jellybean'
     EjectedObjects(2)=Class'HGame.Jellybean'
     ObjectStartPoint(0)=(X=64,Z=-20)
     ObjectStartPoint(1)=(X=64,Y=-20,Z=20)
     ObjectStartPoint(2)=(X=64,Y=20,Z=20)
     ObjectStartVelocity(0)=(X=64,Z=40)
     ObjectStartVelocity(1)=(X=64,Y=40,Z=40)
     ObjectStartVelocity(2)=(X=64,Y=-40,Z=40)
     bRandomBean=True
     eVulnerableToSpell=SPELL_Flipendo
     CentreOffset=(Z=20)
     Mesh=SkeletalMesh'HPModels.skbronzecauldronMesh'
     DrawScale=1.0
     AmbientGlow=200
     CollisionRadius=28
     CollisionHeight=50
}
