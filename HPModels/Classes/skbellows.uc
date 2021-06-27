//================================================================================
// skbellows.
//================================================================================

class skbellows extends HPMesh
  Abstract;
  
//model import (skbellowsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbellowsMesh ModelFile=Models\skbellowsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbellowsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbellowsAnims) -AdamJD 
#exec Anim Import Anim=skbellowsAnims AnimFile=Models\skbellowsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbellowsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbellowsMesh Anim=skbellowsAnims
#exec Anim Digest Anim=skbellowsAnims VERBOSE 

//texture import (skbellowsTex0) -AdamJD 
#exec Texture Import File=Textures\skbellowsTex0.png Name=skbellowsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbellowsMesh Num=0 Texture=skbellowsTex0

