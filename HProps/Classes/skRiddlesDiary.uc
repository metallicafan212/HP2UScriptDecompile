//================================================================================
// skRiddlesDiary.
//================================================================================

class skRiddlesDiary extends HPMeshActor;

//model import (skRiddlesDiaryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skRiddlesDiaryMesh ModelFile=Models\skRiddlesDiaryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skRiddlesDiaryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skRiddlesDiaryAnims) -AdamJD 
#exec Anim Import Anim=skRiddlesDiaryAnims AnimFile=Models\skRiddlesDiaryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skRiddlesDiaryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skRiddlesDiaryMesh Anim=skRiddlesDiaryAnims
#exec Anim Digest Anim=skRiddlesDiaryAnims VERBOSE 

//texture import (skRiddlesDiaryTex0) -AdamJD 
#exec Texture Import File=Textures\skRiddlesDiaryTex0.png Name=skRiddlesDiaryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skRiddlesDiaryMesh Num=0 Texture=skRiddlesDiaryTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skRiddlesDiaryMesh
}
