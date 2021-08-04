//================================================================================
// skBooksLargeGroup1.
//================================================================================

class skBooksLargeGroup1 extends HPMeshActor;

//model import (skBooksLargeGroup1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksLargeGroup1Mesh ModelFile=Models\skBooksLargeGroup1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksLargeGroup1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksLargeGroup1Anims) -AdamJD 
#exec Anim Import Anim=skBooksLargeGroup1Anims AnimFile=Models\skBooksLargeGroup1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksLargeGroup1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksLargeGroup1Mesh Anim=skBooksLargeGroup1Anims
#exec Anim Digest Anim=skBooksLargeGroup1Anims VERBOSE 

//texture import (skBooksLargeGroup1Tex0) -AdamJD 
#exec Texture Import File=Textures\skBooksLargeGroup1Tex0.png Name=skBooksLargeGroup1Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksLargeGroup1Mesh Num=0 Texture=skBooksLargeGroup1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksLargeGroup1Mesh
}
