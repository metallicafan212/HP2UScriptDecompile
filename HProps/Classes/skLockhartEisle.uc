//================================================================================
// skLockhartEisle.
//================================================================================

class skLockhartEisle extends HPMeshActor;

//model import (skLockhartEisleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartEisleMesh ModelFile=Models\skLockhartEisleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartEisleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skLockhartEisleAnims) -AdamJD 
#exec Anim Import Anim=skLockhartEisleAnims AnimFile=Models\skLockhartEisleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartEisleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartEisleMesh Anim=skLockhartEisleAnims
#exec Anim Digest Anim=skLockhartEisleAnims VERBOSE

//texture import (skLockhartEisleTex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartEisleTex0.png Name=skLockhartEisleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartEisleMesh Num=0 Texture=skLockhartEisleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartEisleMesh
}
