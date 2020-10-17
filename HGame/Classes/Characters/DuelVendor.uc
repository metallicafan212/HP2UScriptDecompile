//================================================================================
// DuelVendor.
//================================================================================

class DuelVendor extends Characters;

defaultproperties
{
    // CharacterSells=6
	CharacterSells=Sells_Duel

    // VendorDialogSet=6
	VendorDialogSet=VDialog_DuelVendor

    bHidden=True

    Mesh=SkeletalMesh'HPModels.skhp2_genmale1Mesh'

    AmbientGlow=75

    CollisionRadius=15.00

    CollisionHeight=42.00

    bCollideActors=False

    bBlockActors=False

    bBlockPlayers=False
}
