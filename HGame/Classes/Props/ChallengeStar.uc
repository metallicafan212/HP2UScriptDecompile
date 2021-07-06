//================================================================================
// ChallengeStar.
//================================================================================

class ChallengeStar extends HProp;

state PickupProp
{
  function EndState()
  {
    local ChallengeScoreManager managerChallenge;
  
  // JL0014:
    foreach AllActors(Class'ChallengeScoreManager',managerChallenge)
    {
      // goto JL0014;
	  break;
    }
    managerChallenge.PickedUpStar();
  }
  
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup_star'

    soundPickup2=Sound'HPSounds.Magic_sfx.pickup_star1'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupStars'

    classStatusItem=Class'StatusItemStars'

    attachedParticleClass(0)=Class'HPParticle.Goldstar01'

    // Physics=5
	Physics=PHYS_Rotating

    Mesh=SkeletalMesh'HProps.skChallengeStarMesh'

    DrawScale=1.25

    AmbientGlow=200

    CollisionRadius=10.00

    CollisionHeight=16.00

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False

    bFixedRotationDir=True

    bRotateToDesired=False

    RotationRate=(Pitch=0,Yaw=20000,Roll=0)
}
