//================================================================================
// skThunderClouds.
//================================================================================

class skThunderClouds extends HPMesh
  Abstract;
  
//model import (skThunderCloudsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skThunderCloudsMesh ModelFile=Models\skThunderCloudsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skThunderCloudsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skThunderCloudsAnims) -AdamJD 
#exec Anim Import Anim=skThunderCloudsAnims AnimFile=Models\skThunderCloudsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skThunderCloudsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skThunderCloudsMesh Anim=skThunderCloudsAnims
#exec Anim Digest Anim=skThunderCloudsAnims VERBOSE 

//texture import (skThunderCloudsTex0) -AdamJD 
#exec Texture Import File=Textures\skThunderCloudsTex0.png Name=skThunderCloudsTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skThunderCloudsMesh Num=0 Texture=skThunderCloudsTex0

//texture import (skThunderCloudsTex1) -AdamJD 
#exec Texture Import File=Textures\skThunderCloudsTex1.png Name=skThunderCloudsTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skThunderCloudsMesh Num=1 Texture=skThunderCloudsTex1

