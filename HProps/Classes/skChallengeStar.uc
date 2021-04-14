//================================================================================
// skChallengeStar.
//================================================================================

class skChallengeStar extends HPMeshActor;

//model import (skChallengeStarMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChallengeStarMesh ModelFile=Models\skChallengeStarMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChallengeStarMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChallengeStarAnims) -AdamJD 
#exec Anim Import Anim=skChallengeStarAnims AnimFile=Models\skChallengeStarAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChallengeStarMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChallengeStarMesh Anim=skChallengeStarAnims
#exec Anim Digest Anim=skChallengeStarAnims VERBOSE 

//texture import (skChallengeStarTex0) -AdamJD 
#exec Texture Import File=Textures\skChallengeStarTex0.png Name=skChallengeStarTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChallengeStarMesh Num=0 Texture=skChallengeStarTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChallengeStarMesh
}
