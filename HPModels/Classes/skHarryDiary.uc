//================================================================================
// skHarryDiary.
//================================================================================

class skHarryDiary extends HPMeshActor;

//model import (skHarryDiaryMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryDiaryMesh ModelFile=Models\skHarryDiaryMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryDiaryMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarryDiaryAnims) -AdamJD 
#exec Anim Import Anim=skHarryDiaryAnims AnimFile=Models\skHarryDiaryAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryDiaryMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryDiaryMesh Anim=skHarryDiaryAnims
#exec Anim Digest Anim=skHarryDiaryAnims VERBOSE 

//texture import (skHarryDiaryTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryDiaryTex0.png Name=skHarryDiaryTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryDiaryMesh Num=0 Texture=skHarryDiaryTex0

//texture import (skHarryDiaryTex1) -AdamJD 
#exec Texture Import File=Textures\skHarryDiaryTex1.png Name=skHarryDiaryTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryDiaryMesh Num=1 Texture=skHarryDiaryTex1

//texture import (skHarryDiaryTex2) -AdamJD 
#exec Texture Import File=Textures\skHarryDiaryTex2.png Name=skHarryDiaryTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryDiaryMesh Num=2 Texture=skHarryDiaryTex2

//texture import (skHarryDiaryTex3) -AdamJD 
#exec Texture Import File=Textures\skHarryDiaryTex3.png Name=skHarryDiaryTex3 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryDiaryMesh Num=3 Texture=skHarryDiaryTex3

//texture import (skHarryDiaryTex4) -AdamJD 
#exec Texture Import File=Textures\skHarryDiaryTex4.png Name=skHarryDiaryTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryDiaryMesh Num=4 Texture=skHarryDiaryTex4

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skHarryDiaryMesh
}
