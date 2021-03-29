//================================================================================
// skBooksTablePedestal.
//================================================================================

class skBooksTablePedestal extends HPMeshActor;

//model import (skBooksTablePedestalMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksTablePedestalMesh ModelFile=Models\skBooksTablePedestalMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksTablePedestalMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksTablePedestalAnims) -AdamJD 
#exec Anim Import Anim=skBooksTablePedestalAnims AnimFile=Models\skBooksTablePedestalAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksTablePedestalMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksTablePedestalMesh Anim=skBooksTablePedestalAnims
#exec Anim Digest Anim=skBooksTablePedestalAnims VERBOSE 

//texture import (skBooksTablePedestalTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksTablePedestalTex0.png Name=skBooksTablePedestalTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksTablePedestalMesh Num=0 Texture=skBooksTablePedestalTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksTablePedestalMesh
}
