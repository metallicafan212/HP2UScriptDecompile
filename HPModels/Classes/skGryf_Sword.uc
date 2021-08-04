//================================================================================
// skGryf_Sword.
//================================================================================

class skGryf_Sword extends HPMesh
  Abstract;
  
//model import (skGryf_SwordMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGryf_SwordMesh ModelFile=Models\skGryf_SwordMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGryf_SwordMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skGryf_SwordAnims) -AdamJD 
#exec Anim Import Anim=skGryf_SwordAnims AnimFile=Models\skGryf_SwordAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGryf_SwordMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGryf_SwordMesh Anim=skGryf_SwordAnims
#exec Anim Digest Anim=skGryf_SwordAnims VERBOSE 

//texture import (skGryf_SwordTex0) -AdamJD 
#exec Texture Import File=Textures\skGryf_SwordTex0.png Name=skGryf_SwordTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGryf_SwordMesh Num=0 Texture=skGryf_SwordTex0

