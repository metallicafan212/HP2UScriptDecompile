//================================================================================
// Boomslang.
//================================================================================

class Boomslang extends PotionIngredients;

state PickupProp
{
  function EndState()
  {
    TriggerEvent(Event,None,None);
    Super.EndState();
  }
  
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup11'

    soundDropOff=Sound'HPSounds.menu_sfx.add_potion_ingredient'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    classStatusGroup=Class'StatusGroupPolyIngr'

    classStatusItem=Class'StatusItemBoomslang'

    attachedParticleClass(0)=Class'HPParticle.BoomslangFX'

    attachedParticleOffset(0)=(X=0.00,Y=0.00,Z=20.00)

    // Physics=1
	Physics=PHYS_Walking

    Mesh=SkeletalMesh'HProps.skBoomSlangMesh'

    CollisionRadius=25.00

    CollisionHeight=10.00

    bBlockActors=False

    bBlockPlayers=False
}
