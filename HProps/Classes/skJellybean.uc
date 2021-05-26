//================================================================================
// skJellybean.
//================================================================================

class skJellybean extends HPMeshActor;

//model import (skJellybeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJellybeanMesh ModelFile=Models\skJellybeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJellybeanMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJellybeanAnims) -AdamJD 
#exec Anim Import Anim=skJellybeanAnims AnimFile=Models\skJellybeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJellybeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJellybeanMesh Anim=skJellybeanAnims
#exec Anim Digest Anim=skJellybeanAnims VERBOSE 

//texture import (skBeanBlackTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanBlackTex0.png Name=skBeanBlackTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeanBlueSpotTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanBlueSpotTex0.png Name=skBeanBlueSpotTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins

//texture import (skBeanBogieTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanBogieTex0.png Name=skBeanBogieTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins

//texture import (skBeanDarkGreenTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanDarkGreenTex0.png Name=skBeanDarkGreenTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeanPurpleTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanPurpleTex0.png Name=skBeanPurpleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skBeanRedTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanRedTex0.png Name=skBeanRedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 

//texture import (skJellybeanTex0) -AdamJD 
#exec Texture Import File=Textures\skJellybeanTex0.png Name=skJellybeanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
//KW didn't add a meshmap for skJellybean -AdamJD

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJellybeanMesh
}
