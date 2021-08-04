//================================================================================
// skHarryHand.
//================================================================================

class skHarryHand extends HPMesh
  Abstract;
  
//model import (skHarryHandMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHarryHandMesh ModelFile=Models\skHarryHandMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHarryHandMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHarryHandAnims) -AdamJD 
#exec Anim Import Anim=skHarryHandAnims AnimFile=Models\skHarryHandAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHarryHandMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHarryHandMesh Anim=skHarryHandAnims
#exec Anim Digest Anim=skHarryHandAnims VERBOSE 

//texture import (skHarryHandTex0) -AdamJD 
#exec Texture Import File=Textures\skHarryHandTex0.png Name=skHarryHandTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHarryHandMesh Num=0 Texture=skHarryHandTex0

