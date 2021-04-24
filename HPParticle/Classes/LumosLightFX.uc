//================================================================================
// LumosLightFX.
//================================================================================

class LumosLightFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

event FellOutOfWorld ()
{
}

defaultproperties
{
    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=231,B=62,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=177,B=100,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=36.00,Rand=0.00)

    SizeLength=(Base=36.00,Rand=0.00)

    SpinRate=(Base=0.50,Rand=0.00)

    bSystemRelative=True

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
}
