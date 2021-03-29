//================================================================================
// skBroomHoop.
//================================================================================

class skBroomHoop extends HPMeshActor;

//model import (skBroomHoopMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBroomHoopMesh ModelFile=Models\skBroomHoopMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBroomHoopMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBroomHoopAnims) -AdamJD 
#exec Anim Import Anim=skBroomHoopAnims AnimFile=Models\skBroomHoopAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBroomHoopMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBroomHoopMesh Anim=skBroomHoopAnims
#exec Anim Digest Anim=skBroomHoopAnims VERBOSE 

//texture import (skBroomHoopTex0) -AdamJD 
#exec Texture Import File=Textures\skBroomHoopTex0.png Name=skBroomHoopTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBroomHoopMesh Num=0 Texture=skBroomHoopTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBroomHoopMesh
}
