//================================================================================
// skWand.
//================================================================================

class skWand extends HPMesh
  Abstract;
  
//model import (WandMesh) -AdamJD 
#exec Mesh ModelImport Mesh=WandMesh ModelFile=Models\WandMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=WandMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (WandAnims) -AdamJD 
#exec Anim Import Anim=WandAnims AnimFile=Models\WandAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=WandMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=WandMesh Anim=WandAnims
#exec Anim Digest Anim=WandAnims VERBOSE 

//texture import (WandTex0) -AdamJD 
#exec Texture Import File=Textures\WandTex0.png Name=WandTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=WandMesh Num=0 Texture=WandTex0

