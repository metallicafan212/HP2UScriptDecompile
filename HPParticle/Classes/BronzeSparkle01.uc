//================================================================================
// BronzeSparkle01.
//================================================================================

class BronzeSparkle01 extends TemplateSparkle01;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ColorStart=(Base=(R=128,G=64,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=64,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    Textures=FireTexture'HPParticle.hp_fx.Spells.BronzeSparkle01'
}
