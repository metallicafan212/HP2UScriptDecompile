//================================================================================
// DiffindoWeb3.
//================================================================================

class DiffindoWeb3 extends HDiffindo;

defaultproperties
{
    fxExplodeClass0=Class'HPParticle.WebFx'

    fxExplodeClass1=Class'HPParticle.WebDust'

    fDiffindoTimer=0.25

    DiffindoImpactSound=Sound'HPSounds.Magic_sfx.DFO_hit_web'

    DiffindoCutSound=Sound'HPSounds.Magic_sfx.DFO_hit_web'

    Mesh=SkeletalMesh'HProps.skDiffindoWeb3Mesh'

    AmbientGlow=200

    CollisionRadius=50.00

    CollisionWidth=1.00

    CollisionHeight=50.00

    // CollideType=2
	CollideType=CT_Box
}
