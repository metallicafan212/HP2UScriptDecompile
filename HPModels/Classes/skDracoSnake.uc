//================================================================================
// skDracoSnake.
//================================================================================

class skDracoSnake extends HPMesh
  Abstract;
  
//model import (skdracosnakeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skdracosnakeMesh ModelFile=Models\skdracosnakeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skdracosnakeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skdracosnakeAnims) -AdamJD 
#exec Anim Import Anim=skdracosnakeAnims AnimFile=Models\skdracosnakeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skdracosnakeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skdracosnakeMesh Anim=skdracosnakeAnims
#exec Anim Digest Anim=skdracosnakeAnims VERBOSE 

//texture import (skdracosnakeTex0) -AdamJD 
#exec Texture Import File=Textures\skdracosnakeTex0.png Name=skdracosnakeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdracosnakeMesh Num=0 Texture=skdracosnakeTex0

//texture import (skdracosnakeTex1) -AdamJD 
#exec Texture Import File=Textures\skdracosnakeTex1.png Name=skdracosnakeTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdracosnakeMesh Num=1 Texture=skdracosnakeTex1

//texture import (skdracosnakeTex2) -AdamJD 
#exec Texture Import File=Textures\skdracosnakeTex2.png Name=skdracosnakeTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdracosnakeMesh Num=2 Texture=skdracosnakeTex2

