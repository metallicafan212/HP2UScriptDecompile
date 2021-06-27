//================================================================================
// skCHgrate.
//================================================================================

class skCHgrate extends HPMesh
  Abstract;
  
//model import (skCHgrateMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCHgrateMesh ModelFile=Models\skCHgrateMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCHgrateMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCHgrateAnims) -AdamJD 
#exec Anim Import Anim=skCHgrateAnims AnimFile=Models\skCHgrateAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCHgrateMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCHgrateMesh Anim=skCHgrateAnims
#exec Anim Digest Anim=skCHgrateAnims VERBOSE 

//texture import (skCHgrateTex0) -AdamJD 
#exec Texture Import File=Textures\skCHgrateTex0.png Name=skCHgrateTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCHgrateMesh Num=0 Texture=skCHgrateTex0

