//================================================================================
// skMrsNorris.
//================================================================================

class skMrsNorris extends HPMesh
  Abstract;
  
//model import (skMrsNorrisMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skMrsNorrisMesh ModelFile=Models\skMrsNorrisMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skMrsNorrisMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skMrsNorrisAnims) -AdamJD 
#exec Anim Import Anim=skMrsNorrisAnims AnimFile=Models\skMrsNorrisAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skMrsNorrisMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skMrsNorrisMesh Anim=skMrsNorrisAnims
#exec Anim Digest Anim=skMrsNorrisAnims VERBOSE 

//texture import (skMrsNorrisTex0) -AdamJD 
#exec Texture Import File=Textures\skMrsNorrisTex0.png Name=skMrsNorrisTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skMrsNorrisMesh Num=0 Texture=skMrsNorrisTex0

