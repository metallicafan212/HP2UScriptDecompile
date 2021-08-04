//================================================================================
// skOliverWoodSnitch.
//================================================================================

class skOliverWoodSnitch extends HPMesh
  Abstract;
  
//model import (skOliverWoodSnitchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skOliverWoodSnitchMesh ModelFile=Models\skOliverWoodSnitchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skOliverWoodSnitchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skOliverWoodSnitchAnims) -AdamJD 
#exec Anim Import Anim=skOliverWoodSnitchAnims AnimFile=Models\skOliverWoodSnitchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skOliverWoodSnitchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skOliverWoodSnitchMesh Anim=skOliverWoodSnitchAnims
#exec Anim Digest Anim=skOliverWoodSnitchAnims VERBOSE 

//texture import (skOliverWoodSnitchTex0) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodSnitchTex0.png Name=skOliverWoodSnitchTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodSnitchMesh Num=0 Texture=skOliverWoodSnitchTex0

//texture import (skOliverWoodSnitchTex1) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodSnitchTex1.png Name=skOliverWoodSnitchTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodSnitchMesh Num=1 Texture=skOliverWoodSnitchTex1

//texture import (skOliverWoodSnitchTex2) -AdamJD 
#exec Texture Import File=Textures\skOliverWoodSnitchTex2.png Name=skOliverWoodSnitchTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skOliverWoodSnitchMesh Num=2 Texture=skOliverWoodSnitchTex2

