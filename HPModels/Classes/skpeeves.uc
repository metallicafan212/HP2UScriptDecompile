//================================================================================
// skpeeves.
//================================================================================

class skpeeves extends HPMesh
  Abstract;
  
//model import (skpeevesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skpeevesMesh ModelFile=Models\skpeevesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skpeevesMesh X=0 Y=0 Z=20 Yaw=0 Pitch=0 Roll=0 

//anim import (skpeevesAnims) -AdamJD 
#exec Anim Import Anim=skpeevesAnims AnimFile=Models\skpeevesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skpeevesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skpeevesMesh Anim=skpeevesAnims
#exec Anim Digest Anim=skpeevesAnims VERBOSE 

//texture import (skpeevesTex0) -AdamJD 
#exec Texture Import File=Textures\skpeevesTex0.png Name=skpeevesTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpeevesMesh Num=0 Texture=skpeevesTex0

//texture import (skpeevesTex1) -AdamJD 
#exec Texture Import File=Textures\skpeevesTex1.png Name=skpeevesTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpeevesMesh Num=1 Texture=skpeevesTex1

//texture import (skpeevesTex2) -AdamJD 
#exec Texture Import File=Textures\skpeevesTex2.png Name=skpeevesTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skpeevesMesh Num=2 Texture=skpeevesTex2

