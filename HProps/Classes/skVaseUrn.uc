//================================================================================
// skVaseUrn.
//================================================================================

class skVaseUrn extends HPMeshActor;

//model import (skVaseUrnMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skVaseUrnMesh ModelFile=Models\skVaseUrnMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skVaseUrnMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skVaseUrnAnims) -AdamJD 
#exec Anim Import Anim=skVaseUrnAnims AnimFile=Models\skVaseUrnAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skVaseUrnMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skVaseUrnMesh Anim=skVaseUrnAnims
#exec Anim Digest Anim=skVaseUrnAnims VERBOSE 

//texture import (skVaseUrnTex0) -AdamJD 
#exec Texture Import File=Textures\skVaseUrnTex0.png Name=skVaseUrnTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skVaseUrnMesh Num=0 Texture=skVaseUrnTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skVaseUrnMesh
}
