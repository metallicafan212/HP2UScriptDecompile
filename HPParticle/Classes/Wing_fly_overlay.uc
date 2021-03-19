//================================================================================
// Wing_fly_overlay.
//================================================================================

class Wing_fly_overlay extends Wing_fly;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=40.00,Rand=40.00)

    SourceWidth=(Base=0.00,Rand=30.00)

    SourceHeight=(Base=0.00,Rand=30.00)

    SourceDepth=(Base=0.00,Rand=30.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=10.00,Rand=0.00)

    SizeWidth=(Base=2.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=4.00)

    SpinRate=(Base=0.00,Rand=0.00)

    Damping=0.00

    GravityModifier=0.00

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_01'
}
