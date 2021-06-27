//================================================================================
// skbloodybaron.
//================================================================================

class skbloodybaron extends HPMesh
  Abstract;
  
//model import (skbloodybaronMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbloodybaronMesh ModelFile=Models\skbloodybaronMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbloodybaronMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbloodybaronAnims) -AdamJD 
#exec Anim Import Anim=skbloodybaronAnims AnimFile=Models\skbloodybaronAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbloodybaronMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbloodybaronMesh Anim=skbloodybaronAnims
#exec Anim Digest Anim=skbloodybaronAnims VERBOSE 

//texture import (skbloodybaronTex0) -AdamJD 
#exec Texture Import File=Textures\skbloodybaronTex0.png Name=skbloodybaronTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbloodybaronMesh Num=0 Texture=skbloodybaronTex0

