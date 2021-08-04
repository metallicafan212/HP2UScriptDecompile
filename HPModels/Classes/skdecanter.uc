//================================================================================
// skdecanter.
//================================================================================

class skdecanter extends HPMesh
  Abstract;
  
//model import (skdecanterMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skdecanterMesh ModelFile=Models\skdecanterMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skdecanterMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skdecanterAnims) -AdamJD 
#exec Anim Import Anim=skdecanterAnims AnimFile=Models\skdecanterAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skdecanterMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skdecanterMesh Anim=skdecanterAnims
#exec Anim Digest Anim=skdecanterAnims VERBOSE 

//texture import (skdecanterTex0) -AdamJD 
#exec Texture Import File=Textures\skdecanterTex0.png Name=skdecanterTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdecanterMesh Num=0 Texture=skdecanterTex0

//texture import (skdecanterTex1) -AdamJD 
#exec Texture Import File=Textures\skdecanterTex1.png Name=skdecanterTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skdecanterMesh Num=1 Texture=skdecanterTex1

