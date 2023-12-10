//================================================================================
// spellDuelMimblewimble.
//================================================================================

class spellDuelMimblewimble extends baseSpell;

function PostBeginPlay()
{
  Super.PostBeginPlay();
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellDuelMimblewimble(self,vHitLocation);
}

function bool OnSpellHitHarry (Actor aHit, Vector vHitLocation)
{
  return harry(aHit).HandleSpellDuelMimblewimble(self,vHitLocation);
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
    // SpellType=26
	SpellType=SPELL_DuelMimblewimble

    SpellIcon=None

    SeekSpeed=0.00

    fxFlyParticleEffectClass=Class'HPParticle.duelMimblewimble_fly'

    fxHitParticleEffectClass=Class'HPParticle.duelMimblewimble_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=400.00

    // DrawType=0
	DrawType=DT_None
}
