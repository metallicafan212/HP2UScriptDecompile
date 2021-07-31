//================================================================================
// skCauldronTeacher.
//================================================================================

class skCauldronTeacher extends HPMeshActor;

//model import (skCauldronTeacherMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCauldronTeacherMesh ModelFile=Models\skCauldronTeacherMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCauldronTeacherMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCauldronTeacherAnims) -AdamJD 
#exec Anim Import Anim=skCauldronTeacherAnims AnimFile=Models\skCauldronTeacherAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCauldronTeacherMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCauldronTeacherMesh Anim=skCauldronTeacherAnims
#exec Anim Digest Anim=skCauldronTeacherAnims VERBOSE 

//texture import (skCauldronTeacherTex0) -AdamJD 
#exec Texture Import File=Textures\skCauldronTeacherTex0.png Name=skCauldronTeacherTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCauldronTeacherMesh Num=0 Texture=skCauldronTeacherTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCauldronTeacherMesh
}
