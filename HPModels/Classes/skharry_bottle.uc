//================================================================================
// skharry_bottle.
//================================================================================

class skharry_bottle extends HPMesh
  Abstract;
  
//model import (skharry_bottleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skharry_bottleMesh ModelFile=Models\skharry_bottleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skharry_bottleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skharry_bottleAnims) -AdamJD 
#exec Anim Import Anim=skharry_bottleAnims AnimFile=Models\skharry_bottleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skharry_bottleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skharry_bottleMesh Anim=skharry_bottleAnims
#exec Anim Digest Anim=skharry_bottleAnims VERBOSE 

//texture import (skharry_bottleTex0) -AdamJD 
#exec Texture Import File=Textures\skharry_bottleTex0.png Name=skharry_bottleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skharry_bottleMesh Num=0 Texture=skharry_bottleTex0

