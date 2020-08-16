//================================================================================
// NoFallingDamageTrigger.
//================================================================================

class NoFallingDamageTrigger extends Trigger;

function Activate (Actor Other, Pawn Instigator)
{
  harry(Level.PlayerHarryActor).NoFallingDamageTimer = 1.0;
}

