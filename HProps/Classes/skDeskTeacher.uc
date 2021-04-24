//================================================================================
// skDeskTeacher.
//================================================================================

class skDeskTeacher extends HPMeshActor;

//model import (skDeskTeacherMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDeskTeacherMesh ModelFile=Models\skDeskTeacherMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDeskTeacherMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDeskTeacherAnims) -AdamJD 
#exec Anim Import Anim=skDeskTeacherAnims AnimFile=Models\skDeskTeacherAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDeskTeacherMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDeskTeacherMesh Anim=skDeskTeacherAnims
#exec Anim Digest Anim=skDeskTeacherAnims VERBOSE 

//texture import (skDeskTeacherTex0) -AdamJD 
#exec Texture Import File=Textures\skDeskTeacherTex0.png Name=skDeskTeacherTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDeskTeacherMesh Num=0 Texture=skDeskTeacherTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDeskTeacherMesh
}
