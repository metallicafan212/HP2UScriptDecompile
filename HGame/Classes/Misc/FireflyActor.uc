//================================================================================
// FireflyActor.
//================================================================================

class FireflyActor extends HChar;

defaultproperties
{
    attachedParticleClass(0)=Class'HPParticle.Firefly2'

    SplineSpeed=10.00

    bHidden=True

    // Physics=4
	Physics=PHYS_Flying

    InitialState=patrolFollowSpline

    // DrawType=1
	DrawType=DT_Sprite

    Mesh=None

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=15.00

    bCollideActors=False

    bBlockActors=False

    bBlockPlayers=False
}
