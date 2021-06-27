//================================================================================
// skbronzechest.
//================================================================================

class skbronzechest extends HPMesh
  Abstract;
  
//model import (skbronzechestMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbronzechestMesh ModelFile=Models\skbronzechestMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbronzechestMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skbronzechestAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skbronzechestMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbronzechestMesh Anim=skbronzechestAnims

//texture import (skbronzechestTex0) -AdamJD 
#exec Texture Import File=Textures\skbronzechestTex0.png Name=skbronzechestTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbronzechestMesh Num=0 Texture=skbronzechestTex0

