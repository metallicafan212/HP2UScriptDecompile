//================================================================================
// skTreeSprite01.
//================================================================================

class skTreeSprite01 extends HPMeshActor;

//model import (skTreeSprite01Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite01Mesh ModelFile=Models\skTreeSprite01Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite01Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite01Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite01Anims AnimFile=Models\skTreeSprite01Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite01Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite01Mesh Anim=skTreeSprite01Anims
#exec Anim Digest Anim=skTreeSprite01Anims VERBOSE 

//texture import (skTreeSprite01Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite01Tex0.png Name=skTreeSprite01Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite01Mesh Num=0 Texture=skTreeSprite01Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite01Mesh
}
