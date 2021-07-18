//================================================================================
// skjewelbox.
//================================================================================

class skjewelbox extends HPMesh
  Abstract;
  
//model import (skjewelboxMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skjewelboxMesh ModelFile=Models\skjewelboxMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skjewelboxMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skjewelboxAnims) -AdamJD 
#exec Anim Import Anim=skjewelboxAnims AnimFile=Models\skjewelboxAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skjewelboxMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skjewelboxMesh Anim=skjewelboxAnims
#exec Anim Digest Anim=skjewelboxAnims VERBOSE 

//texture import (skjewelboxTex0) -AdamJD 
#exec Texture Import File=Textures\skjewelboxTex0.png Name=skjewelboxTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skjewelboxMesh Num=0 Texture=skjewelboxTex0

//texture import (skjewelboxTex1) -AdamJD 
#exec Texture Import File=Textures\skjewelboxTex1.png Name=skjewelboxTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skjewelboxMesh Num=1 Texture=skjewelboxTex1

