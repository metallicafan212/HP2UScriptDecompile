//================================================================================
// skChairsWood1.
//================================================================================

class skChairsWood1 extends HPMeshActor;

//model import (skChairsWood1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsWood1Mesh ModelFile=Models\skChairsWood1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsWood1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsWood1Anims) -AdamJD 
#exec Anim Import Anim=skChairsWood1Anims AnimFile=Models\skChairsWood1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsWood1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsWood1Mesh Anim=skChairsWood1Anims
#exec Anim Digest Anim=skChairsWood1Anims VERBOSE 

//texture import (skChairsWood1Tex0) -AdamJD 
#exec Texture Import File=Textures\skChairsWood1Tex0.png Name=skChairsWood1Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsWood1Mesh Num=0 Texture=skChairsWood1Tex0

//texture import (skChairsWood1Tex1) -AdamJD 
#exec Texture Import File=Textures\skChairsWood1Tex1.png Name=skChairsWood1Tex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsWood1Mesh Num=1 Texture=skChairsWood1Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsWood1Mesh
}
