//================================================================================
// skhorklumpsHead.
//================================================================================

class skhorklumpsHead extends HPMesh
  Abstract;
  
//model import (skhorklumpsHeadMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhorklumpsHeadMesh ModelFile=Models\skhorklumpsHeadMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhorklumpsHeadMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhorklumpsHeadAnims) -AdamJD 
#exec Anim Import Anim=skhorklumpsHeadAnims AnimFile=Models\skhorklumpsHeadAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhorklumpsHeadMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhorklumpsHeadMesh Anim=skhorklumpsHeadAnims
#exec Anim Digest Anim=skhorklumpsHeadAnims VERBOSE 

//texture import (skhorklumpsHeadTex0) -AdamJD 
#exec Texture Import File=Textures\skhorklumpsHeadTex0.png Name=skhorklumpsHeadTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhorklumpsHeadMesh Num=0 Texture=skhorklumpsHeadTex0

