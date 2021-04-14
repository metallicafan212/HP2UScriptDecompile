//================================================================================
// skChLightRay.
//================================================================================

class skChLightRay extends HPMeshActor;

//model import (skChLightRayMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChLightRayMesh ModelFile=Models\skChLightRayMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChLightRayMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChLightRayAnims) -AdamJD 
#exec Anim Import Anim=skChLightRayAnims AnimFile=Models\skChLightRayAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChLightRayMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChLightRayMesh Anim=skChLightRayAnims
#exec Anim Digest Anim=skChLightRayAnims VERBOSE 

//texture import (skChLightRayTex0) -AdamJD 
#exec Texture Import File=Textures\skChLightRayTex0.png Name=skChLightRayTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChLightRayMesh Num=0 Texture=skChLightRayTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChLightRayMesh
}
