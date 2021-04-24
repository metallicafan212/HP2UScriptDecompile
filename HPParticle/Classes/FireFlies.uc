//================================================================================
// FireFlies.
//================================================================================

class FireFlies extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.25,Rand=0.01)

    SourceWidth=(Base=100.00,Rand=64.00)

    SourceHeight=(Base=100.00,Rand=64.00)

    SourceDepth=(Base=100.00,Rand=20.00)

    AngularSpreadWidth=(Base=90.00,Rand=90.00)

    AngularSpreadHeight=(Base=90.00,Rand=90.00)

    bSteadyState=True

    Speed=(Base=3.00,Rand=3.00)

    Lifetime=(Base=4.00,Rand=6.00)

    ColorStart=(Base=(R=253,G=253,B=66,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=34,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=2.00)

    SizeLength=(Base=4.00,Rand=2.00)

    SizeEndScale=(Base=1.50,Rand=0.00)

    Chaos=1.00

    Textures(0)=Texture'HPParticle.hp_fx.General.CandleF'
}
