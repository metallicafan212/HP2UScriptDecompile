//================================================================================
// skDeskStudentWSeat.
//================================================================================

class skDeskStudentWSeat extends HPMeshActor;

//model import (skDeskStudentWSeatMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDeskStudentWSeatMesh ModelFile=Models\skDeskStudentWSeatMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDeskStudentWSeatMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDeskStudentWSeatAnims) -AdamJD 
#exec Anim Import Anim=skDeskStudentWSeatAnims AnimFile=Models\skDeskStudentWSeatAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDeskStudentWSeatMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDeskStudentWSeatMesh Anim=skDeskStudentWSeatAnims
#exec Anim Digest Anim=skDeskStudentWSeatAnims VERBOSE 

//texture import (skDeskStudentWSeatTex0) -AdamJD 
#exec Texture Import File=Textures\skDeskStudentWSeatTex0.png Name=skDeskStudentWSeatTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDeskStudentWSeatMesh Num=0 Texture=skDeskStudentWSeatTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDeskStudentWSeatMesh
}
