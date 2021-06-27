//================================================================================
// skBowtruckle.
//================================================================================

class skBowtruckle extends HPMesh
  Abstract;
  
//model import (skBowtruckleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBowtruckleMesh ModelFile=Models\skBowtruckleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBowtruckleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBowtruckleAnims) -AdamJD 
#exec Anim Import Anim=skBowtruckleAnims AnimFile=Models\skBowtruckleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBowtruckleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBowtruckleMesh Anim=skBowtruckleAnims
#exec Anim Digest Anim=skBowtruckleAnims VERBOSE 

//texture import (skBowtruckleTex0) -AdamJD 
#exec Texture Import File=Textures\skBowtruckleTex0.png Name=skBowtruckleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBowtruckleMesh Num=0 Texture=skBowtruckleTex0

//texture import (skBowtruckleTex1) -AdamJD 
#exec Texture Import File=Textures\skBowtruckleTex1.png Name=skBowtruckleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBowtruckleMesh Num=1 Texture=skBowtruckleTex1

