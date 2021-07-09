//================================================================================
// skfatfriar.
//================================================================================

class skfatfriar extends HPMesh
  Abstract;
  
//model import (skfatfriarMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skfatfriarMesh ModelFile=Models\skfatfriarMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skfatfriarMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skfatfriarAnims) -AdamJD 
#exec Anim Import Anim=skfatfriarAnims AnimFile=Models\skfatfriarAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skfatfriarMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skfatfriarMesh Anim=skfatfriarAnims
#exec Anim Digest Anim=skfatfriarAnims VERBOSE 

//texture import (skfatfriarTex0) -AdamJD 
#exec Texture Import File=Textures\skfatfriarTex0.png Name=skfatfriarTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skfatfriarMesh Num=0 Texture=skfatfriarTex0

//texture import (skfatfriarTex1) -AdamJD 
#exec Texture Import File=Textures\skfatfriarTex1.png Name=skfatfriarTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skfatfriarMesh Num=1 Texture=skfatfriarTex1

