//================================================================================
// spellEcto.
//================================================================================

class spellEcto extends baseSpell;

var(VisualFX) ParticleFX fxHitHarryParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitHarryParticleEffectClass;

function OnSpellInit()
{
  if ( TargetActor.IsA('harry') )
  {
    SeekSpeed = 0.5;
  }
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellEcto(self,vHitLocation);
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
  
  function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
  {
    aHit.TakeDamage(15,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
    fxHitHarryParticleEffect = Spawn(fxHitHarryParticleEffectClass);
    return True;
  }
  begin:
}

defaultproperties
{
    fxHitHarryParticleEffectClass=Class'HPParticle.Skurge_hitHarry'

    // SpellType=23
	SpellType=SPELL_Ecto

    SpellIcon=None

    SeekSpeed=2.50

    fxFlyParticleEffectClass=Class'HPParticle.Ecto_fly'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=400.00

    // DrawType=0
	DrawType=DT_None
}
