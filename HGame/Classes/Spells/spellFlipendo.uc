//================================================================================
// spellFlipendo.
//================================================================================

class spellFlipendo extends baseSpell;

event BeginEvent()
{
}

event EndEvent()
{
}

event KilledBy (Pawn EventInstigator)
{
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellFlipendo(self,vHitLocation);
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

function bool IsRelevantToMover()
{
  return True;
}

defaultproperties
{
    // SpellType=13
	SpellType=SPELL_Flipendo

    SpellIcon=None

    SeekSpeed=8.00

    fxFlyParticleEffectClass=Class'HPParticle.Flip_fly'

    fxHitParticleEffectClass=Class'HPParticle.Flip_hit'

    SpellIncantation="spells1"

    QuietSpellIncantation="spells10"

    // DrawType=0
	DrawType=DT_None
}
