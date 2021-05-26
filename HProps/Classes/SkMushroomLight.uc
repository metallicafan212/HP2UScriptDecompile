//================================================================================
// SkMushroomLight.
//================================================================================

class SkMushroomLight extends HPMeshActor;

//model import (SkMushroomLightMesh) -AdamJD 
#exec Mesh ModelImport Mesh=SkMushroomLightMesh ModelFile=Models\SkMushroomLightMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=SkMushroomLightMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (SkMushroomLightAnims) -AdamJD 
#exec Anim Import Anim=SkMushroomLightAnims AnimFile=Models\SkMushroomLightAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=SkMushroomLightMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=SkMushroomLightMesh Anim=SkMushroomLightAnims
#exec Anim Digest Anim=SkMushroomLightAnims VERBOSE 

//texture import (SkMushroomLightTex0) -AdamJD 
#exec Texture Import File=Textures\SkMushroomLightTex0.png Name=SkMushroomLightTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=SkMushroomLightMesh Num=0 Texture=SkMushroomLightTex0

//texture import (SkMushroomLightTex1) -AdamJD 
#exec Texture Import File=Textures\SkMushroomLightTex1.png Name=SkMushroomLightTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=SkMushroomLightMesh Num=1 Texture=SkMushroomLightTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=SkMushroomLightMesh
}
