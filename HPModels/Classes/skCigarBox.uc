//================================================================================
// skCigarBox.
//================================================================================

class skCigarBox extends HPMesh
  Abstract;
  
//model import (skcigarboxMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skcigarboxMesh ModelFile=Models\skcigarboxMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skcigarboxMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skcigarboxAnims) -AdamJD 
#exec Anim Import Anim=skcigarboxAnims AnimFile=Models\skcigarboxAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skcigarboxMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skcigarboxMesh Anim=skcigarboxAnims
#exec Anim Digest Anim=skcigarboxAnims VERBOSE 

//texture import (skcigarboxTex0) -AdamJD 
#exec Texture Import File=Textures\skcigarboxTex0.png Name=skcigarboxTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcigarboxMesh Num=0 Texture=skcigarboxTex0

//texture import (skcigarboxTex1) -AdamJD 
#exec Texture Import File=Textures\skcigarboxTex1.png Name=skcigarboxTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcigarboxMesh Num=1 Texture=skcigarboxTex1

