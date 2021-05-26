//================================================================================
// skLightRay.
//================================================================================

class skLightRay extends HPMeshActor;

//model import (skLightRayMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLightRayMesh ModelFile=Models\skLightRayMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLightRayMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLightRayAnims) -AdamJD 
#exec Anim Import Anim=skLightRayAnims AnimFile=Models\skLightRayAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLightRayMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLightRayMesh Anim=skLightRayAnims
#exec Anim Digest Anim=skLightRayAnims VERBOSE 

//texture import (skLightRayTex0) -AdamJD 
#exec Texture Import File=Textures\skLightRayTex0.png Name=skLightRayTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLightRayMesh Num=0 Texture=skLightRayTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLightRayMesh
}
