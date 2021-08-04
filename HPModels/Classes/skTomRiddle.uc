//================================================================================
// skTomRiddle.
//================================================================================

class skTomRiddle extends HPMesh
  Abstract;
  
//model import (skTomRiddleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTomRiddleMesh ModelFile=Models\skTomRiddleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTomRiddleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skTomRiddleAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skTomRiddleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTomRiddleMesh Anim=skTomRiddleAnims

//texture import (skTomRiddleTex0) -AdamJD 
#exec Texture Import File=Textures\skTomRiddleTex0.png Name=skTomRiddleTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTomRiddleMesh Num=0 Texture=skTomRiddleTex0

//texture import (skTomRiddleTex1) -AdamJD 
#exec Texture Import File=Textures\skTomRiddleTex1.png Name=skTomRiddleTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTomRiddleMesh Num=1 Texture=skTomRiddleTex1

