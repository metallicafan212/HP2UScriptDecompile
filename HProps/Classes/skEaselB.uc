//================================================================================
// skEaselB.
//================================================================================

class skEaselB extends HPMeshActor;

//model import (skEaselBMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skEaselBMesh ModelFile=Models\skEaselBMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skEaselBMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skEaselBAnims) -AdamJD 
#exec Anim Import Anim=skEaselBAnims AnimFile=Models\skEaselBAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skEaselBMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skEaselBMesh Anim=skEaselBAnims
#exec Anim Digest Anim=skEaselBAnims VERBOSE 

//texture import (skEaselBTex0) -AdamJD 
#exec Texture Import File=Textures\skEaselBTex0.png Name=skEaselBTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skEaselBMesh Num=0 Texture=skEaselBTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skEaselBMesh
}
