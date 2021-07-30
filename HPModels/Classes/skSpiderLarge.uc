//================================================================================
// skSpiderLarge.
//================================================================================

class skSpiderLarge extends HPMesh
  Abstract;
  
//model import (skSpiderLargeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpiderLargeMesh ModelFile=Models\skSpiderLargeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpiderLargeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpiderLargeAnims) -AdamJD 
#exec Anim Import Anim=skSpiderLargeAnims AnimFile=Models\skSpiderLargeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpiderLargeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpiderLargeMesh Anim=skSpiderLargeAnims
#exec Anim Digest Anim=skSpiderLargeAnims VERBOSE 

//texture import (skSpiderLargeTex0) -AdamJD 
#exec Texture Import File=Textures\skSpiderLargeTex0.png Name=skSpiderLargeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpiderLargeMesh Num=0 Texture=skSpiderLargeTex0

//texture import (skSpiderLargeTex1) -AdamJD 
#exec Texture Import File=Textures\skSpiderLargeTex1.png Name=skSpiderLargeTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpiderLargeMesh Num=1 Texture=skSpiderLargeTex1

//texture import (skSpiderLargeTex2) -AdamJD 
#exec Texture Import File=Textures\skSpiderLargeTex2.png Name=skSpiderLargeTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpiderLargeMesh Num=2 Texture=skSpiderLargeTex2

