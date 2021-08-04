//================================================================================
// skSecretLightRays.
//================================================================================

class skSecretLightRays extends HPMesh
  Abstract;
  
//model import (skSecretLightRaysMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSecretLightRaysMesh ModelFile=Models\skSecretLightRaysMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSecretLightRaysMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSecretLightRaysAnims) -AdamJD 
#exec Anim Import Anim=skSecretLightRaysAnims AnimFile=Models\skSecretLightRaysAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSecretLightRaysMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSecretLightRaysMesh Anim=skSecretLightRaysAnims
#exec Anim Digest Anim=skSecretLightRaysAnims VERBOSE 

//texture import (skSecretLightRaysTex0) -AdamJD 
#exec Texture Import File=Textures\skSecretLightRaysTex0.png Name=skSecretLightRaysTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSecretLightRaysMesh Num=0 Texture=skSecretLightRaysTex0

