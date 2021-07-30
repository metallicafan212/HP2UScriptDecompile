//================================================================================
// sksnake.
//================================================================================

class sksnake extends HPMesh
  Abstract;
  
//model import (sksnakeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=sksnakeMesh ModelFile=Models\sksnakeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=sksnakeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (sksnakeAnims) -AdamJD 
#exec Anim Import Anim=sksnakeAnims AnimFile=Models\sksnakeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=sksnakeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=sksnakeMesh Anim=sksnakeAnims
#exec Anim Digest Anim=sksnakeAnims VERBOSE 

//texture import (sksnakeTex0) -AdamJD 
#exec Texture Import File=Textures\sksnakeTex0.png Name=sksnakeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=sksnakeMesh Num=0 Texture=sksnakeTex0

