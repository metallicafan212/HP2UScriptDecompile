//================================================================================
// skboulder.
//================================================================================

class skboulder extends HPMesh
  Abstract;
  
//model import (skboulderMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skboulderMesh ModelFile=Models\skboulderMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skboulderMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skboulderAnims) -AdamJD 
#exec Anim Import Anim=skboulderAnims AnimFile=Models\skboulderAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skboulderMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skboulderMesh Anim=skboulderAnims
#exec Anim Digest Anim=skboulderAnims VERBOSE 

//texture import (skboulderTex0) -AdamJD 
#exec Texture Import File=Textures\skboulderTex0.png Name=skboulderTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skboulderMesh Num=0 Texture=skboulderTex0

