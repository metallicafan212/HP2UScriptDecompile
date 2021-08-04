//================================================================================
// skgoldchest.
//================================================================================

class skgoldchest extends HPMesh
  Abstract;
  
//model import (skgoldchestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skgoldchestMesh ModelFile=Models\skgoldchestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skgoldchestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skbronzechestAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skgoldchestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skgoldchestMesh Anim=skbronzechestAnims

//texture import (skgoldchestTex0) -AdamJD 
#exec Texture Import File=Textures\skgoldchestTex0.png Name=skgoldchestTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skgoldchestMesh Num=0 Texture=skgoldchestTex0

