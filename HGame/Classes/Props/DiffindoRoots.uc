//================================================================================
// DiffindoRoots.
//================================================================================

class DiffindoRoots extends HDiffindo;

defaultproperties
{
    fxExplodeClass0=Class'HPParticle.DustCloud03_med'

    fxExplodeClass1=Class'HPParticle.Sticks1'

    fxExplodeClass2=Class'HPParticle.Sticks2'

    fxExplodeClass3=Class'HPParticle.Sticks3'

    fSingleCutTimer=0.10

    fDiffindoTimer=0.50

    DiffindoImpactSound=Sound'HPSounds.Magic_sfx.DFO_hit_branches'

    DiffindoCutSound=Sound'HPSounds.Magic_sfx.DFO_hit_branches'

    Mesh=SkeletalMesh'HProps.skDiffindoRootsMesh'

    CollisionRadius=95.00

    CollisionWidth=20.00

    CollisionHeight=95.00

    // CollideType=2
	CollideType=CT_Box
}
