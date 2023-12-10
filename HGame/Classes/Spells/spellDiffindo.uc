//================================================================================
// spellDiffindo.
//================================================================================

class spellDiffindo extends baseSpell;

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellDiffindo(self,vHitLocation);
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
    // SpellType=19
	SpellType=SPELL_Diffindo

    SpellIcon=None

    SeekSpeed=6.00

    fxFlyParticleEffectClass=Class'HPParticle.Diffindo_Fly'

    fxHitParticleEffectClass=Class'HPParticle.Diffindo_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    // DrawType=0
	DrawType=DT_None
}
