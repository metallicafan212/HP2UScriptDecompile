//================================================================================
// skJarPotionIngredient1.
//================================================================================

class skJarPotionIngredient1 extends HPMeshActor;

//model import (skJarPotionIngredient1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarPotionIngredient1Mesh ModelFile=Models\skJarPotionIngredient1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarPotionIngredient1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skJarPotionIngredient1Anims) -AdamJD 
#exec Anim Import Anim=skJarPotionIngredient1Anims AnimFile=Models\skJarPotionIngredient1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarPotionIngredient1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarPotionIngredient1Mesh Anim=skJarPotionIngredient1Anims
#exec Anim Digest Anim=skJarPotionIngredient1Anims VERBOSE 

//texture import (skJarPotionIngredient1Tex0) -AdamJD 
#exec Texture Import File=Textures\skJarPotionIngredient1Tex0.png Name=skJarPotionIngredient1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarPotionIngredient1Mesh Num=0 Texture=skJarPotionIngredient1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarPotionIngredient1Mesh
}
