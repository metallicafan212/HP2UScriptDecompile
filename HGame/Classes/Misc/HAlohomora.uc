//================================================================================
// HAlohomora.
//================================================================================

class HAlohomora extends HProp;

var ParticleFX fxExplode;
var() Class<ParticleFX> fxExplodeClass;

function PreBeginPlay()
{
  PlayerHarry = harry(Level.PlayerHarryActor);
}

event Destroyed()
{
  if ( fxExplode != None )
  {
    fxExplode.Shutdown();
  }
  Super.Destroyed();
}

function bool HandleSpellAlohomora (optional baseSpell spell, optional Vector vHitLocation)
{
  OnAlohomoraExplode();
  return True;
}

function OnAlohomoraExplode()
{
  TriggerEvent(Event,None,None);
  Destroy();
}

defaultproperties
{
    fxExplodeClass=Class'HPParticle.Aloh_hit'

    // eVulnerableToSpell=1
	eVulnerableToSpell=SPELL_Alohomora

    CollisionRadius=10.00

    CollisionHeight=10.00
}
