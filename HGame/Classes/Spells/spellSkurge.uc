//================================================================================
// spellSkurge.
//================================================================================

class spellSkurge extends baseSpell;

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
  return HPawn(aHit).HandleSpellSkurge(self,vHitLocation);
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
  begin:
}

defaultproperties
{
    // SpellType=20
	SpellType=SPELL_Skurge

    SpellIcon=None

    SeekSpeed=4.00

    fxFlyParticleEffectClass=Class'HPParticle.Skurge_fly'

    fxHitParticleEffectClass=Class'HPParticle.SkurgeSpell_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=400.00

    // DrawType=0
	DrawType=DT_None
}
