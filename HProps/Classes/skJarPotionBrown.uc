//================================================================================
// skJarPotionBrown.
//================================================================================

class skJarPotionBrown extends HPMeshActor;

//model import (skJarPotionBrownMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarPotionBrownMesh ModelFile=Models\skJarPotionBrownMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarPotionBrownMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJarPotionBrownAnims) -AdamJD 
#exec Anim Import Anim=skJarPotionBrownAnims AnimFile=Models\skJarPotionBrownAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarPotionBrownMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarPotionBrownMesh Anim=skJarPotionBrownAnims
#exec Anim Digest Anim=skJarPotionBrownAnims VERBOSE 

//texture import (skJarPotionBrownTex0) -AdamJD 
#exec Texture Import File=Textures\skJarPotionBrownTex0.png Name=skJarPotionBrownTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarPotionBrownMesh Num=0 Texture=skJarPotionBrownTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarPotionBrownMesh
}
