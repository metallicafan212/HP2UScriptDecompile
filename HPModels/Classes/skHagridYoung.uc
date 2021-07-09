//================================================================================
// skHagridYoung.
//================================================================================

class skHagridYoung extends HPMesh
  Abstract;
  
//model import (skHagridYoungMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHagridYoungMesh ModelFile=Models\skHagridYoungMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHagridYoungMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHagridYoungAnims) -AdamJD 
#exec Anim Import Anim=skHagridYoungAnims AnimFile=Models\skHagridYoungAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHagridYoungMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHagridYoungMesh Anim=skHagridYoungAnims
#exec Anim Digest Anim=skHagridYoungAnims VERBOSE 

//texture import (skHagridYoungTex0) -AdamJD 
#exec Texture Import File=Textures\skHagridYoungTex0.png Name=skHagridYoungTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHagridYoungMesh Num=0 Texture=skHagridYoungTex0

//texture import (skHagridYoungTex1) -AdamJD 
#exec Texture Import File=Textures\skHagridYoungTex1.png Name=skHagridYoungTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHagridYoungMesh Num=1 Texture=skHagridYoungTex1

