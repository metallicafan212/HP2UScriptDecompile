//================================================================================
// skLightRayBig.
//================================================================================

class skLightRayBig extends HPMeshActor;

//model import (skLightRayBigMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLightRayBigMesh ModelFile=Models\skLightRayBigMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLightRayBigMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLightRayBigAnims) -AdamJD 
#exec Anim Import Anim=skLightRayBigAnims AnimFile=Models\skLightRayBigAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLightRayBigMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLightRayBigMesh Anim=skLightRayBigAnims
#exec Anim Digest Anim=skLightRayBigAnims VERBOSE 

//texture import (skLightRayBigTex0) -AdamJD 
#exec Texture Import File=Textures\skLightRayBigTex0.png Name=skLightRayBigTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLightRayBigMesh Num=0 Texture=skLightRayBigTex0

//texture import (skLightRayBigTex1) -AdamJD 
#exec Texture Import File=Textures\skLightRayBigTex1.png Name=skLightRayBigTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLightRayBigMesh Num=1 Texture=skLightRayBigTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLightRayBigMesh
}
