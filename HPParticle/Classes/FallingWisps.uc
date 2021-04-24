//================================================================================
// FallingWisps.
//================================================================================

class FallingWisps extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceDepth=(Base=15.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=20.00)

    AngularSpreadHeight=(Base=90.00,Rand=20.00)

    Speed=(Base=5.00,Rand=15.00)

    Lifetime=(Base=2.00,Rand=5.00)

    ColorStart=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=1.00,Rand=15.00)

    SizeLength=(Base=1.00,Rand=15.00)

    SizeEndScale=(Base=-1.00,Rand=0.00)

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Dot_2'

    Rotation=(Pitch=-16352,Yaw=0,Roll=0)

    DesiredRotation=(Pitch=-16352,Yaw=0,Roll=0)
}
