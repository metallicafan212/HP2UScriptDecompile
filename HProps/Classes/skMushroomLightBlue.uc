//================================================================================
// skMushroomLightBlue.
//================================================================================

class skMushroomLightBlue extends HPMeshActor;

//model import (skMushroomLightBlueMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skMushroomLightBlueMesh ModelFile=Models\skMushroomLightBlueMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skMushroomLightBlueMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skMushroomLightBlueAnims) -AdamJD 
#exec Anim Import Anim=skMushroomLightBlueAnims AnimFile=Models\skMushroomLightBlueAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skMushroomLightBlueMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skMushroomLightBlueMesh Anim=skMushroomLightBlueAnims
#exec Anim Digest Anim=skMushroomLightBlueAnims VERBOSE 

//texture import (skMushroomLightBlueTex0) -AdamJD 
#exec Texture Import File=Textures\skMushroomLightBlueTex0.png Name=skMushroomLightBlueTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMushroomLightBlueMesh Num=0 Texture=skMushroomLightBlueTex0

//texture import (skMushroomLightBlueTex1) -AdamJD 
#exec Texture Import File=Textures\skMushroomLightBlueTex1.png Name=skMushroomLightBlueTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMushroomLightBlueMesh Num=1 Texture=skMushroomLightBlueTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skMushroomLightBlueMesh
}
