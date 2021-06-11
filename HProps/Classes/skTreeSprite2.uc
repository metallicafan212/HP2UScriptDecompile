//================================================================================
// skTreeSprite2.
//================================================================================

class skTreeSprite2 extends HPMeshActor;

//model import (skTreeSprite2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite2Mesh ModelFile=Models\skTreeSprite2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite2Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite2Anims AnimFile=Models\skTreeSprite2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite2Mesh Anim=skTreeSprite2Anims
#exec Anim Digest Anim=skTreeSprite2Anims VERBOSE 

//texture import (skTreeSprite2Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite2Tex0.png Name=skTreeSprite2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite2Mesh Num=0 Texture=skTreeSprite2Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite2Mesh
}
