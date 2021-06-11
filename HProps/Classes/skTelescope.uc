//================================================================================
// skTelescope.
//================================================================================

class skTelescope extends HPMeshActor;

//model import (skTelescopeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTelescopeMesh ModelFile=Models\skTelescopeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTelescopeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTelescopeAnims) -AdamJD 
#exec Anim Import Anim=skTelescopeAnims AnimFile=Models\skTelescopeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTelescopeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTelescopeMesh Anim=skTelescopeAnims
#exec Anim Digest Anim=skTelescopeAnims VERBOSE 

//texture import (skTelescopeTex0) -AdamJD 
#exec Texture Import File=Textures\skTelescopeTex0.png Name=skTelescopeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTelescopeMesh Num=0 Texture=skTelescopeTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTelescopeMesh
}
