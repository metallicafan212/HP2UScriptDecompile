//================================================================================
// FlyingFordWind.
//================================================================================

class FlyingFordWind extends HiddenHPawn;

const BOOL_DEBUG_AI= false;
var bool bTouch;
var() float violence;
var() float triggerRadius;
var() float triggerHeight;
var FlyingFordDirector Director;
var FlyingFordWindTrigger windTrigger;
var(VisualFX) ParticleFX fxWindParticleEffect;
var(VisualFX) Class<ParticleFX> fxWindParticleEffectClass;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	foreach AllActors(Class'FlyingFordDirector',Director)
	{
		break;
	}
	windTrigger = Spawn(Class'FlyingFordWindTrigger',self,,Location + Vec(0.0,0.0,10.0),Rotation);
	windTrigger.SetCollisionSize(triggerRadius,triggerHeight);
}

function Tick (float DeltaTime)
{
	Super.Tick(DeltaTime);
	if ( fxWindParticleEffect != None )
	{
		fxWindParticleEffect.SetLocation(Location);
	}
}

function Touch (Actor Other)
{
	Super.Touch(Other);
	if ( Other.IsA('harry') )
	{
		if ( !bTouch )
		{
			bTouch = True;
			Director.OnTouchEvent(self,Other);
			Director.StartTurbulence(violence,Vector(Rotation));
		}
	}
}

function UnTouch (Actor Other)
{
	Super.UnTouch(Other);
	if ( Other.IsA('harry') )
	{
		Director.OnUnTouchEvent(self,Other);
	}
}

function Bump (Actor Other)
{
	if ( BOOL_DEBUG_AI )
	{
		PlayerHarry.ClientMessage("I have been bumped ");
	}
	Touch(Other);
}

function StartWind()
{
	fxWindParticleEffect = Spawn(fxWindParticleEffectClass,,,Location);
}

function StopWind()
{
	if ( fxWindParticleEffect != None )
	{
		fxWindParticleEffect.Shutdown();
		fxWindParticleEffect.Destroy();
		fxWindParticleEffect = None;
	}
}

defaultproperties
{
    violence=100.00

    triggerRadius=800.00

    triggerHeight=300.00

    fxWindParticleEffectClass=Class'HPParticle.CloudWind'

    Tag=''

    CollisionRadius=200.00

    CollisionWidth=55.00

    CollisionHeight=150.00

    bCollideActors=True

    bCollideWorld=True

}