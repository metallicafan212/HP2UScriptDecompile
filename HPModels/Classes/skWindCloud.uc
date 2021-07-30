//================================================================================
// skWindCloud.
//================================================================================

class skWindCloud extends HPMesh
  Abstract;
  
//model import (skWindCloudMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWindCloudMesh ModelFile=Models\skWindCloudMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWindCloudMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWindCloudAnims) -AdamJD 
#exec Anim Import Anim=skWindCloudAnims AnimFile=Models\skWindCloudAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWindCloudMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWindCloudMesh Anim=skWindCloudAnims
#exec Anim Digest Anim=skWindCloudAnims VERBOSE 

//texture import (skWindCloudTex0) -AdamJD 
#exec Texture Import File=Textures\skWindCloudTex0.png Name=skWindCloudTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWindCloudMesh Num=0 Texture=skWindCloudTex0

