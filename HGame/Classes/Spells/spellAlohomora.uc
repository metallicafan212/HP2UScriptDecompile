//================================================================================
// spellAlohomora.
//================================================================================

class spellAlohomora extends baseSpell;

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  CurrentDir = Normal(vector(Rotation) + Vec(0.0,0.0,0.31));
}

function OnSpellShutdown ()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellAlohomora(self,vHitLocation);
}

auto state stateIdle
{
begin:
  GotoState('StateFlying');
}

state StateFlying
{
  function BeginState ()
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
  begin:
}

defaultproperties
{
    // SpellType=1
	SpellType=SPELL_Alohomora

    SpellIcon=None

    SeekSpeed=5.00

    fxFlyParticleEffectClass=Class'HPParticle.Aloh_Fly'

    fxHitParticleEffectClass=Class'HPParticle.Aloh_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    ImpactSound=Sound'HPSounds.Magic_sfx.ALO_hit'

    // DrawType=0
	DrawType=DT_None
}
