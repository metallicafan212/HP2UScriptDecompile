//================================================================================
// ChessExplo.
//================================================================================

class ChessExplo extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.00,Rand=1000.00)

    SourceWidth=(Base=0.00,Rand=50.00)

    SourceHeight=(Base=0.00,Rand=150.00)

    SourceDepth=(Base=0.00,Rand=50.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=1.00,Rand=400.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=7.00)

    SizeLength=(Base=3.00,Rand=7.00)

    SizeEndScale=(Base=0.00,Rand=25.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    Chaos=1.00

    Damping=4.00

    GravityModifier=-0.05

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Spells.Les_fire_01'
}
