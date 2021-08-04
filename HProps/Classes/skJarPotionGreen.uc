//================================================================================
// skJarPotionGreen.
//================================================================================

class skJarPotionGreen extends HPMeshActor;

//model import (skJarPotionGreenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarPotionGreenMesh ModelFile=Models\skJarPotionGreenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarPotionGreenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJarPotionGreenAnims) -AdamJD 
#exec Anim Import Anim=skJarPotionGreenAnims AnimFile=Models\skJarPotionGreenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarPotionGreenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarPotionGreenMesh Anim=skJarPotionGreenAnims
#exec Anim Digest Anim=skJarPotionGreenAnims VERBOSE 

//texture import (skJarPotionGreenTex0) -AdamJD 
#exec Texture Import File=Textures\skJarPotionGreenTex0.png Name=skJarPotionGreenTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarPotionGreenMesh Num=0 Texture=skJarPotionGreenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarPotionGreenMesh
}
