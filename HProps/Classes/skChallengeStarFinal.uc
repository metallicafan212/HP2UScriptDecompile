//================================================================================
// skChallengeStarFinal.
//================================================================================

class skChallengeStarFinal extends HPMeshActor;

//model import (skChallengeStarFinalMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChallengeStarFinalMesh ModelFile=Models\skChallengeStarFinalMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChallengeStarFinalMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChallengeStarFinalAnims) -AdamJD 
#exec Anim Import Anim=skChallengeStarFinalAnims AnimFile=Models\skChallengeStarFinalAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChallengeStarFinalMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChallengeStarFinalMesh Anim=skChallengeStarFinalAnims
#exec Anim Digest Anim=skChallengeStarFinalAnims VERBOSE 

//texture import (skChallengeStarFinalTex0) -AdamJD 
#exec Texture Import File=Textures\skChallengeStarFinalTex0.png Name=skChallengeStarFinalTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChallengeStarFinalMesh Num=0 Texture=skChallengeStarFinalTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChallengeStarFinalMesh
}
