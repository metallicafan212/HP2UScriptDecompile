//================================================================================
// skBooksSaveBook.
//================================================================================

class skBooksSaveBook extends HPMeshActor;

//model import (skBooksSaveBookMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksSaveBookMesh ModelFile=Models\skBooksSaveBookMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksSaveBookMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksSaveBookAnims) -AdamJD 
#exec Anim Import Anim=skBooksSaveBookAnims AnimFile=Models\skBooksSaveBookAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksSaveBookMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksSaveBookMesh Anim=skBooksSaveBookAnims
#exec Anim Digest Anim=skBooksSaveBookAnims VERBOSE 

//texture import (skBooksSaveBookTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksSaveBookTex0.png Name=skBooksSaveBookTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksSaveBookMesh Num=0 Texture=skBooksSaveBookTex0

//texture import (skBooksSaveBookTex1) -AdamJD 
#exec Texture Import File=Textures\skBooksSaveBookTex1.png Name=skBooksSaveBookTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksSaveBookMesh Num=1 Texture=skBooksSaveBookTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksSaveBookMesh
}
