//================================================================================
// skhorklumpchunk.
//================================================================================

class skhorklumpchunk extends HPMesh
  Abstract;
  
//model import (skhorklumpchunkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skhorklumpchunkMesh ModelFile=Models\skhorklumpchunkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skhorklumpchunkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skhorklumpchunkAnims) -AdamJD 
#exec Anim Import Anim=skhorklumpchunkAnims AnimFile=Models\skhorklumpchunkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skhorklumpchunkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skhorklumpchunkMesh Anim=skhorklumpchunkAnims
#exec Anim Digest Anim=skhorklumpchunkAnims VERBOSE 

//texture import (skhorklumpchunkTex0) -AdamJD 
#exec Texture Import File=Textures\skhorklumpchunkTex0.png Name=skhorklumpchunkTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skhorklumpchunkMesh Num=0 Texture=skhorklumpchunkTex0

