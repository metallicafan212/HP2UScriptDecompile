//================================================================================
// DiffindoVines.
//================================================================================

class DiffindoVines extends HDiffindo;

defaultproperties
{
    fxExplodeClass0=Class'HPParticle.Diffindo_LeavesFx'

    fxExplodeClass1=Class'HPParticle.DustCloud04_med'

    fxExplodeClass2=Class'HPParticle.Sticks3'

    fxExplodeClass3=Class'HPParticle.Sticks1'

    fSingleCutTimer=0.10

    fDiffindoTimer=0.50

    DiffindoImpactSound=Sound'HPSounds.Magic_sfx.DFO_hit_leaves'

    DiffindoCutSound=Sound'HPSounds.Magic_sfx.DFO_hit_leaves'

    Mesh=SkeletalMesh'HProps.skDiffindoVinesMesh'

    CollisionRadius=95.00

    CollisionWidth=20.00

    CollisionHeight=95.00

    // CollideType=2
	CollideType=CT_Box
}
