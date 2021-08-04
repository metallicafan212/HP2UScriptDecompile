//================================================================================
// skOliverWood.
//================================================================================

class skOliverWood extends HPMesh
  Abstract;
  
//model import (skOliverWoodMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skOliverWoodMesh ModelFile=Models\skOliverWoodMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skOliverWoodMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGeorgeWeasleyAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skOliverWoodMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skOliverWoodMesh Anim=skGeorgeWeasleyAnims

//texture import (skOliverWoodTex0) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodTex0.png Name=skOliverWoodTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodMesh Num=0 Texture=skOliverWoodTex0

//texture import (skOliverWoodTex1) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodTex1.png Name=skOliverWoodTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodMesh Num=1 Texture=skOliverWoodTex1

