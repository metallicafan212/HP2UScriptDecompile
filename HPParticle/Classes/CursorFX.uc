//================================================================================
// CursorFX.
//================================================================================

class CursorFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=40.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=121,G=255,B=11,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=16.00,Rand=0.00)

    SizeLength=(Base=16.00,Rand=0.00)

    SizeEndScale=(Base=0.00,Rand=0.00)

    SpinRate=(Base=1.00,Rand=8.00)

    SizeDelay=1.00

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_03'

    Physics=PHYS_Rotating

    bFixedRotationDir=True

    RotationRate=(Pitch=100000,Yaw=0,Roll=0)
}
