//================================================================================
// skForestBush.
//================================================================================

class skForestBush extends HPMesh
  Abstract;
  
//model import (skForestBushMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skForestBushMesh ModelFile=Models\skForestBushMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skForestBushMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skForestBushAnims) -AdamJD 
#exec Anim Import Anim=skForestBushAnims AnimFile=Models\skForestBushAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skForestBushMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skForestBushMesh Anim=skForestBushAnims
#exec Anim Digest Anim=skForestBushAnims VERBOSE

//texture import (skForestBushTex0) -AdamJD 
#exec Texture Import File=Textures\skForestBushTex0.png Name=skForestBushTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skForestBushMesh Num=0 Texture=skForestBushTex0

