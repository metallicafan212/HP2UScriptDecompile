//================================================================================
// TentaculaSpell.
//================================================================================

class TentaculaSpell extends GenericColObj;

auto state stateIdle
{
  function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
  {
    local TentaculaLimb limb;
    local GenericColObj hbox;
    local Rotator Rot;
  
    if ( Owner.GetStateName() == 'stateStun' )
    {
      return False;
    }
    if ( Owner.GetStateName() == 'stateStunned' )
    {
      return False;
    }
    if ( Owner.GetStateName() == 'stateWake' )
    {
      return False;
    }
    if ( Owner.GetStateName() == 'stateDie' )
    {
      // eVulnerableToSpell = 0;
	  eVulnerableToSpell = SPELL_None;
      return False;
    }
    if ( Owner.GetStateName() == 'stateTwitch' )
    {
      // eVulnerableToSpell = 0;
	  eVulnerableToSpell = SPELL_None;
      return False;
    }
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    Rot.Yaw = Owner.Rotation.Yaw;
    Rot.Roll = 0;
    Rot.Pitch = 0;
    Owner.SetRotation(Rot);
    Owner.GotoState('stateDie');
    limb = TentaculaLimb(Owner);
    limb.bGood = False;
    hbox = limb.headBox;
    if ( hbox != None )
    {
      hbox.SetCollision(True,True,True);
    }
    limb.AnimBone = 0;
    limb.SetOwner(None);
    AnimBone = 0;
    SetOwner(None);
    Destroy();
    return True;
  }
  
}

defaultproperties
{
    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    CollisionRadius=10.00

    CollisionHeight=10.00

    bRotateToDesired=False
}
