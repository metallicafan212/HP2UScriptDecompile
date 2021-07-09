//================================================================================
// skFordFlying.
//================================================================================

class skFordFlying extends HPMesh
  Abstract;
  
//model import (skFordFlyingMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFordFlyingMesh ModelFile=Models\skFordFlyingMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFordFlyingMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFordFlyingAnims) -AdamJD 
#exec Anim Import Anim=skFordFlyingAnims AnimFile=Models\skFordFlyingAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFordFlyingMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFordFlyingMesh Anim=skFordFlyingAnims
#exec Anim Digest Anim=skFordFlyingAnims VERBOSE 

//texture import (skFordFlyingTex0) -AdamJD 
#exec Texture Import File=Textures\skFordFlyingTex0.png Name=skFordFlyingTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordFlyingMesh Num=0 Texture=skFordFlyingTex0

//texture import (skFordFlyingTex1) -AdamJD 
#exec Texture Import File=Textures\skFordFlyingTex1.png Name=skFordFlyingTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordFlyingMesh Num=1 Texture=skFordFlyingTex1

//texture import (skFordFlyingTex2) -AdamJD 
#exec Texture Import File=Textures\skFordFlyingTex2.png Name=skFordFlyingTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordFlyingMesh Num=2 Texture=skFordFlyingTex2


