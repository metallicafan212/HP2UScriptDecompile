//================================================================================
// FinalStar.
//================================================================================

class FinalStar extends HProp;

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
    managerChallenge.PickedUpFinalStar();
    TriggerEvent(Event,None,None);
  }
  
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup_star'

    bPickupOnTouch=True

    attachedParticleClass(0)=Class'HPParticle.GoldstarFinal'

    // Physics=5
	Physics=PHYS_Rotating

    Mesh=SkeletalMesh'HProps.skChallengeStarFinalMesh'

    AmbientGlow=125

    CollisionRadius=48.00

    CollisionWidth=20.00

    CollisionHeight=64.00

    bBlockActors=False

    bBlockPlayers=False

    bFixedRotationDir=True

    bRotateToDesired=False

    RotationRate=(Pitch=0,Yaw=20000,Roll=0)
}
