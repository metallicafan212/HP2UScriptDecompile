//================================================================================
// skProfSnape.
//================================================================================

class skProfSnape extends HPMesh
  Abstract;
  
//model import (skProfSnapeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skProfSnapeMesh ModelFile=Models\skProfSnapeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skProfSnapeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skProfSnapeAnims) -AdamJD 
#exec Anim Import Anim=skProfSnapeAnims AnimFile=Models\skProfSnapeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skProfSnapeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skProfSnapeMesh Anim=skProfSnapeAnims
#exec Anim Digest Anim=skProfSnapeAnims VERBOSE 

//texture import (skProfSnapeTex0) -AdamJD 
#exec Texture Import File=Textures\skProfSnapeTex0.png Name=skProfSnapeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfSnapeMesh Num=0 Texture=skProfSnapeTex0

//texture import (skProfSnapeTex1) -AdamJD 
#exec Texture Import File=Textures\skProfSnapeTex1.png Name=skProfSnapeTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skProfSnapeMesh Num=1 Texture=skProfSnapeTex1

