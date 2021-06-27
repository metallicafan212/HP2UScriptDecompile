//================================================================================
// skbronzecauldron.
//================================================================================

class skbronzecauldron extends HPMesh
  Abstract;
  
//model import (skbronzecauldronMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbronzecauldronMesh ModelFile=Models\skbronzecauldronMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbronzecauldronMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbronzecauldronAnims) -AdamJD 
#exec Anim Import Anim=skbronzecauldronAnims AnimFile=Models\skbronzecauldronAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbronzecauldronMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbronzecauldronMesh Anim=skbronzecauldronAnims
#exec Anim Digest Anim=skbronzecauldronAnims VERBOSE 

//texture import (skbronzecauldronTex0) -AdamJD 
#exec Texture Import File=Textures\skbronzecauldronTex0.png Name=skbronzecauldronTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbronzecauldronMesh Num=0 Texture=skbronzecauldronTex0

