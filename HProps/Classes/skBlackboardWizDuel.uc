//================================================================================
// skBlackboardWizDuel.
//================================================================================

class skBlackboardWizDuel extends HPMeshActor;

//model import (skBlackboardWizDuelMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBlackboardWizDuelMesh ModelFile=Models\skBlackboardWizDuelMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBlackboardWizDuelMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBlackboardWizDuelAnims) -AdamJD 
#exec Anim Import Anim=skBlackboardWizDuelAnims AnimFile=Models\skBlackboardWizDuelAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBlackboardWizDuelMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBlackboardWizDuelMesh Anim=skBlackboardWizDuelAnims
#exec Anim Digest Anim=skBlackboardWizDuelAnims VERBOSE 

//texture import (skBlackboardWizDuelTex0) -AdamJD 
#exec Texture Import File=Textures\skBlackboardWizDuelTex0.png Name=skBlackboardWizDuelTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBlackboardWizDuelMesh Num=0 Texture=skBlackboardWizDuelTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBlackboardWizDuelMesh
}
