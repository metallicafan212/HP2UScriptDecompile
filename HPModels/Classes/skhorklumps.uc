//================================================================================
// skhorklumps.
//================================================================================

class skhorklumps extends HPMesh
  Abstract;
  
//model import (skhorklumpsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhorklumpsMesh ModelFile=Models\skhorklumpsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhorklumpsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhorklumpsAnims) -AdamJD 
#exec Anim Import Anim=skhorklumpsAnims AnimFile=Models\skhorklumpsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhorklumpsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhorklumpsMesh Anim=skhorklumpsAnims
#exec Anim Digest Anim=skhorklumpsAnims VERBOSE 

//texture import (skhorklumpsTex0) -AdamJD 
#exec Texture Import File=Textures\skhorklumpsTex0.png Name=skhorklumpsTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhorklumpsMesh Num=0 Texture=skhorklumpsTex0

