//================================================================================
// skAragogAttack.
//================================================================================

class skAragogAttack extends HPMesh
  Abstract;
  
//model import (skAragogAttackMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skAragogAttackMesh ModelFile=Models\skAragogAttackMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skAragogAttackMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skAragogAttackAnims) -AdamJD 
#exec Anim Import Anim=skAragogAttackAnims AnimFile=Models\skAragogAttackAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skAragogAttackMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skAragogAttackMesh Anim=skAragogAttackAnims
#exec Anim Digest Anim=skAragogAttackAnims VERBOSE 

//texture import (skAragogAttackTex0) -AdamJD 
#exec Texture Import File=Textures\skAragogAttackTex0.png Name=skAragogAttackTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skAragogAttackMesh Num=0 Texture=skAragogAttackTex0

