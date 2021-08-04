//================================================================================
// skChairsTeacher.
//================================================================================

class skChairsTeacher extends HPMeshActor;

//model import (skChairsTeacherMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsTeacherMesh ModelFile=Models\skChairsTeacherMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsTeacherMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsTeacherAnims) -AdamJD 
#exec Anim Import Anim=skChairsTeacherAnims AnimFile=Models\skChairsTeacherAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsTeacherMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsTeacherMesh Anim=skChairsTeacherAnims
#exec Anim Digest Anim=skChairsTeacherAnims VERBOSE 

//texture import (skChairsTeacherTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsTeacherTex0.png Name=skChairsTeacherTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsTeacherMesh Num=0 Texture=skChairsTeacherTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsTeacherMesh
}
