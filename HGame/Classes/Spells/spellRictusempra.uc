//================================================================================
// spellRictusempra.
//================================================================================

class spellRictusempra extends baseSpell;

function OnSpellInit()
{
  local float fDistMod;

  CurrentDir = vector(Rotation);
  fDistMod = VSize(TargetActor.Location - Location) / 800;
  if ( fDistMod > 1.0 )
  {
    fDistMod = 1.0;
  }
  SeekSpeed += 1.0 - fDistMod;
  CurrentDir.X += (FRand() - 0.4) * fDistMod;
  CurrentDir.Y += (FRand() - 0.4) * fDistMod;
  CurrentDir.Z += (FRand() * 0.5) * fDistMod;
  PlayerHarry.ClientMessage(" fDistMod = " $ string(fDistMod) $ " curDir = " $ string(CurrentDir));
  SetRotation(rotator(CurrentDir));
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellRictusempra(self,vHitLocation);
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
    Acceleration = vector(Rotation) * 10;
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
    // SpellType=22
	SpellType=SPELL_Rictusempra

    SpellIcon=None

    SeekSpeed=5.00

    fxFlyParticleEffectClass=Class'HPParticle.Rictusempra_fly'

    fxHitParticleEffectClass=Class'HPParticle.Rictusempra_hit'

    SpellIncantation="spells1"

    QuietSpellIncantation="spells10"

    // DrawType=0
	DrawType=DT_None
}
