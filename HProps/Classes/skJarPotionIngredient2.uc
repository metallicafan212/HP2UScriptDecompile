//================================================================================
// skJarPotionIngredient2.
//================================================================================

class skJarPotionIngredient2 extends HPMeshActor;

//model import (skJarPotionIngredient2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarPotionIngredient2Mesh ModelFile=Models\skJarPotionIngredient2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarPotionIngredient2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJarPotionIngredient2Anims) -AdamJD 
#exec Anim Import Anim=skJarPotionIngredient2Anims AnimFile=Models\skJarPotionIngredient2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarPotionIngredient2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarPotionIngredient2Mesh Anim=skJarPotionIngredient2Anims
#exec Anim Digest Anim=skJarPotionIngredient2Anims VERBOSE 

//texture import (skJarPotionIngredient2Tex0) -AdamJD 
#exec Texture Import File=Textures\skJarPotionIngredient2Tex0.png Name=skJarPotionIngredient2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarPotionIngredient2Mesh Num=0 Texture=skJarPotionIngredient2Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarPotionIngredient2Mesh
}
