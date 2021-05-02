//================================================================================
// skFoodPeevesApple.
//================================================================================

class skFoodPeevesApple extends HPMeshActor;

//model import (skFoodPeevesAppleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFoodPeevesAppleMesh ModelFile=Models\skFoodPeevesAppleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFoodPeevesAppleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skFoodPeevesAppleAnims) -AdamJD 
#exec Anim Import Anim=skFoodPeevesAppleAnims AnimFile=Models\skFoodPeevesAppleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFoodPeevesAppleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFoodPeevesAppleMesh Anim=skFoodPeevesAppleAnims
#exec Anim Digest Anim=skFoodPeevesAppleAnims VERBOSE 

//texture import (skFoodPeevesAppleTex0) -AdamJD 
#exec Texture Import File=Textures\skFoodPeevesAppleTex0.png Name=skFoodPeevesAppleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFoodPeevesAppleMesh Num=0 Texture=skFoodPeevesAppleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFoodPeevesAppleMesh
}
