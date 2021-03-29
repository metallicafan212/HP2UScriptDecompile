//================================================================================
// skBicorn.
//================================================================================

class skBicorn extends HPMeshActor;

//model import (skBicornMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBicornMesh ModelFile=Models\skBicornMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBicornMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBicornAnims) -AdamJD 
#exec Anim Import Anim=skBicornAnims AnimFile=Models\skBicornAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBicornMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBicornMesh Anim=skBicornAnims
#exec Anim Digest Anim=skBicornAnims VERBOSE 

//texture import (skBicornTex0) -AdamJD 
#exec Texture Import File=Textures\skBicornTex0.png Name=skBicornTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBicornMesh Num=0 Texture=skBicornTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBicornMesh
}
