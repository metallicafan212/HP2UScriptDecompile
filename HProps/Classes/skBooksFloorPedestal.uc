//================================================================================
// skBooksFloorPedestal.
//================================================================================

class skBooksFloorPedestal extends HPMeshActor;

//model import (skBooksFloorPedestalMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksFloorPedestalMesh ModelFile=Models\skBooksFloorPedestalMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksFloorPedestalMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksFloorPedestalAnims) -AdamJD 
#exec Anim Import Anim=skBooksFloorPedestalAnims AnimFile=Models\skBooksFloorPedestalAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksFloorPedestalMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksFloorPedestalMesh Anim=skBooksFloorPedestalAnims
#exec Anim Digest Anim=skBooksFloorPedestalAnims VERBOSE 

//texture import (skBooksFloorPedestalTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksFloorPedestalTex0.png Name=skBooksFloorPedestalTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksFloorPedestalMesh Num=0 Texture=skBooksFloorPedestalTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksFloorPedestalMesh
}
