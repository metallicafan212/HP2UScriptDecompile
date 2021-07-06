//================================================================================
// FlobberwormMucus.
//================================================================================

class FlobberwormMucus extends PotionIngredients;

event PostBeginPlay()
{
  Super.PostBeginPlay();
  LoopAnim('Idle');
}

defaultproperties
{
    soundPickup=Sound'HPSounds.Magic_sfx.pickup_flob_mucus'

    soundDropOff=Sound'HPSounds.menu_sfx.add_potion_ingredient'

    bPickupOnTouch=True

    // PickupFlyTo=2
	PickupFlyTo=FT_HudPosition

    fMinFlyToHudScale=0.10

    fMaxFlyToHudScale=0.50

    classStatusGroup=Class'StatusGroupPotionIngr'

    classStatusItem=Class'StatusItemFlobberMucus'

    bBounceIntoPlace=True

    soundBounce=Sound'HPSounds.Magic_sfx.bean_bounce'

    // Physics=1
	Physics=PHYS_Walking

    Mesh=SkeletalMesh'HPModels.skFlobberWormMucusMesh'

    DrawScale=0.50

    Fatness=96

    MultiSkins(0)=WetTexture'HPParticle.hp_fx.Particles.FlobberM'

    CollisionRadius=10.00

    CollisionHeight=10.00

    bBlockPlayers=False
}
