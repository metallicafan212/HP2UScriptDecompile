//================================================================================
// AragogSpellWeb.
//================================================================================

class AragogSpellWeb extends baseSpell;

function OnSpellShutdown()
{
}

function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
{
  return True;
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
    // SpellType=23
	SpellType=SPELL_Ecto

    SpellIcon=None

    SeekSpeed=3.00

    fxFlyParticleEffectClass=Class'HPParticle.Ecto_fly'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=800.00

    // DrawType=0
	DrawType=DT_None
}
