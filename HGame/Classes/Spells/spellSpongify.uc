//================================================================================
// spellSpongify.
//================================================================================

class spellSpongify extends baseSpell;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  CurrentDir = Normal(vector(Rotation) + Vec(0.0,0.0,0.25));
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellSpongify(self,vHitLocation);
}

auto state stateIdle
{
begin:
  GotoState('StateFlying');
}

state StateFlying
{
  function BeginState()
  {
    Velocity = vector(Rotation) * Speed;
    Acceleration = Velocity;
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    UpdateRotationWithSeeking(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
  begin:
}

defaultproperties
{
    // SpellType=21
	SpellType=SPELL_Spongify

    SpellIcon=None

    SeekSpeed=8.00

    fxFlyParticleEffectClass=Class'HPParticle.Spongify_Fly'

    fxHitParticleEffectClass=Class'HPParticle.Spongify_Hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=800.00

    // DrawType=0
	DrawType=DT_None
}
