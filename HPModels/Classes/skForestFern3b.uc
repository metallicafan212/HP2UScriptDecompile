//================================================================================
// skForestFern3b.
//================================================================================

class skForestFern3b extends HPMesh
  Abstract;
  
//model import (skForestFern3bMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestFern3bMesh ModelFile=Models\skForestFern3bMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestFern3bMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestFern3bAnims) -AdamJD 
#exec Anim Import Anim=skForestFern3bAnims AnimFile=Models\skForestFern3bAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestFern3bMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestFern3bMesh Anim=skForestFern3bAnims
#exec Anim Digest Anim=skForestFern3bAnims VERBOSE 

//texture import (skForestFern3bTex0) -AdamJD 
#exec Texture Import File=Textures\skForestFern3bTex0.png Name=skForestFern3bTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestFern3bMesh Num=0 Texture=skForestFern3bTex0

