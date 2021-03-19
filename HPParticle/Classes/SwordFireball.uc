//================================================================================
// SwordFireball.
//================================================================================

class SwordFireball extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

defaultproperties
{
    SourceWidth=(Base=5.00,Rand=3.00)

    SourceHeight=(Base=5.00,Rand=3.00)

    SourceDepth=(Base=5.00,Rand=3.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.50,Rand=0.20)

    ColorStart=(Base=(R=255,G=121,B=64,A=0),Rand=(R=254,G=155,B=7,A=0))

    ColorEnd=(Base=(R=249,G=255,B=0,A=0),Rand=(R=255,G=187,B=47,A=0))

    SizeWidth=(Base=16.00,Rand=8.00)

    SizeLength=(Base=16.00,Rand=8.00)

    SizeEndScale=(Base=2.00,Rand=2.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    bSystemRelative=True

    Chaos=1.00

    Textures=Texture'HPParticle.particle_fx.ember00'
}
