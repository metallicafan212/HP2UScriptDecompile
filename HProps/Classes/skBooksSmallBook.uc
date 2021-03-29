//================================================================================
// skBooksSmallBook.
//================================================================================

class skBooksSmallBook extends HPMeshActor;

//model import (skBooksSmallBookMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksSmallBookMesh ModelFile=Models\skBooksSmallBookMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksSmallBookMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksSmallBookAnims) -AdamJD 
#exec Anim Import Anim=skBooksSmallBookAnims AnimFile=Models\skBooksSmallBookAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksSmallBookMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksSmallBookMesh Anim=skBooksSmallBookAnims
#exec Anim Digest Anim=skBooksSmallBookAnims VERBOSE 

//texture import (skBooksSmallBookTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksSmallBookTex0.png Name=skBooksSmallBookTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksSmallBookMesh Num=0 Texture=skBooksSmallBookTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksSmallBookMesh
}
