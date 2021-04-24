//================================================================================
// FireHP2Sepia.
//================================================================================

class FireHP2Sepia extends FireHP2;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ColorStart=(Base=(R=168,G=118,B=77,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=127,G=105,B=79,A=0),Rand=(R=0,G=0,B=0,A=0))

    Textures(0)=Texture'HPParticle.hp_fx.Particles.SepiaFlamefx'
}
