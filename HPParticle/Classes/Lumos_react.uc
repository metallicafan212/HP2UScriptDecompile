//================================================================================
// Lumos_react.
//================================================================================

class Lumos_react extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceWidth=(Base=128.00,Rand=0.00)

    SourceHeight=(Base=128.00,Rand=0.00)

    SourceDepth=(Base=128.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=-10.00,Rand=20.00)

    Lifetime=(Base=2.00,Rand=2.00)

    ColorStart=(Base=(R=236,G=220,B=17,A=0),Rand=(R=211,G=202,B=12,A=0))

    ColorEnd=(Base=(R=254,G=254,B=1,A=0),Rand=(R=243,G=189,B=1,A=0))

    SizeWidth=(Base=3.00,Rand=6.00)

    SizeLength=(Base=3.00,Rand=6.00)

    Chaos=0.50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare4'
}
