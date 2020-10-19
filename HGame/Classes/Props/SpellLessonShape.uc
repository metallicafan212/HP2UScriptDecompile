//================================================================================
// SpellLessonShape.
//================================================================================

class SpellLessonShape extends HProp;

defaultproperties
{
    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSheetTestMesh'

    bUnlit=True

    CollisionRadius=10.00

    CollisionHeight=5.00

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
