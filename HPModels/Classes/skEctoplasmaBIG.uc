//================================================================================
// skEctoplasmaBIG.
//================================================================================

class skEctoplasmaBIG extends HPMesh
  Abstract;
  
//model import (skEctoplasmaBIGMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skEctoplasmaBIGMesh ModelFile=Models\skEctoplasmaBIGMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skEctoplasmaBIGMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skEctoplasmaBIGAnims) -AdamJD 
#exec Anim Import Anim=skEctoplasmaBIGAnims AnimFile=Models\skEctoplasmaBIGAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skEctoplasmaBIGMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skEctoplasmaBIGMesh Anim=skEctoplasmaBIGAnims
#exec Anim Digest Anim=skEctoplasmaBIGAnims VERBOSE 

//texture import (skEctoplasmaBIGTex0) -AdamJD 
#exec Texture Import File=Textures\skEctoplasmaBIGTex0.png Name=skEctoplasmaBIGTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skEctoplasmaBIGMesh Num=0 Texture=skEctoplasmaBIGTex0

