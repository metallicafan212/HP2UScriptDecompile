//================================================================================
// skBooksBookRow1.
//================================================================================

class skBooksBookRow1 extends HPMeshActor;

//model import (skBooksBookRow1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksBookRow1Mesh ModelFile=Models\skBooksBookRow1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksBookRow1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksBookRow1Anims) -AdamJD 
#exec Anim Import Anim=skBooksBookRow1Anims AnimFile=Models\skBooksBookRow1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksBookRow1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksBookRow1Mesh Anim=skBooksBookRow1Anims
#exec Anim Digest Anim=skBooksBookRow1Anims VERBOSE 

//texture import (skBooksBookRow1Tex0) -AdamJD 
#exec Texture Import File=Textures\skBooksBookRow1Tex0.png Name=skBooksBookRow1Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksBookRow1Mesh Num=0 Texture=skBooksBookRow1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksBookRow1Mesh
}
