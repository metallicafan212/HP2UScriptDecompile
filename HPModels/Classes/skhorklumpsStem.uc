//================================================================================
// skhorklumpsStem.
//================================================================================

class skhorklumpsStem extends HPMesh
  Abstract;
  
//model import (skhorklumpsStemMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhorklumpsStemMesh ModelFile=Models\skhorklumpsStemMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhorklumpsStemMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhorklumpsStemAnims) -AdamJD 
#exec Anim Import Anim=skhorklumpsStemAnims AnimFile=Models\skhorklumpsStemAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhorklumpsStemMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhorklumpsStemMesh Anim=skhorklumpsStemAnims
#exec Anim Digest Anim=skhorklumpsStemAnims VERBOSE 

//texture import (skhorklumpsStemTex0) -AdamJD 
#exec Texture Import File=Textures\skhorklumpsStemTex0.png Name=skhorklumpsStemTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhorklumpsStemMesh Num=0 Texture=skhorklumpsStemTex0

