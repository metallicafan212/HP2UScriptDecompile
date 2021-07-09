//================================================================================
// skectosplat.
//================================================================================

class skectosplat extends HPMesh
  Abstract;
  
//model import (skectosplatMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skectosplatMesh ModelFile=Models\skectosplatMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skectosplatMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skectosplatAnims) -AdamJD 
#exec Anim Import Anim=skectosplatAnims AnimFile=Models\skectosplatAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skectosplatMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skectosplatMesh Anim=skectosplatAnims
#exec Anim Digest Anim=skectosplatAnims VERBOSE 

//texture import (skectosplatTex0) -AdamJD 
#exec Texture Import File=Textures\skectosplatTex0.png Name=skectosplatTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins
#exec MeshMap SetTexture MeshMap=skectosplatMesh Num=0 Texture=skectosplatTex0

