//================================================================================
// SignsArrowFlipendo.
//================================================================================

class SignsArrowFlipendo extends HSigns;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skSignsArrowFlipendoMesh'

    CollisionRadius=25.00

    CollisionWidth=4.00

    CollisionHeight=40.00

    // CollideType=2
	CollideType=CT_Box
}
