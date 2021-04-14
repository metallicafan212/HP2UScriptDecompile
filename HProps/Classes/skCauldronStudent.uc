//================================================================================
// skCauldronStudent.
//================================================================================

class skCauldronStudent extends HPMeshActor;

//model import (skCauldronStudentMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCauldronStudentMesh ModelFile=Models\skCauldronStudentMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCauldronStudentMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCauldronStudentAnims) -AdamJD 
#exec Anim Import Anim=skCauldronStudentAnims AnimFile=Models\skCauldronStudentAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCauldronStudentMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCauldronStudentMesh Anim=skCauldronStudentAnims
#exec Anim Digest Anim=skCauldronStudentAnims VERBOSE 

//texture import (skCauldronStudentTex0) -AdamJD 
#exec Texture Import File=Textures\skCauldronStudentTex0.png Name=skCauldronStudentTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCauldronStudentMesh Num=0 Texture=skCauldronStudentTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCauldronStudentMesh
}
