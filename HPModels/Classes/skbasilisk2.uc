//================================================================================
// skbasilisk2.
//================================================================================

class skbasilisk2 extends HPMesh
  Abstract;
  
//model import (skbasilisk2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbasilisk2Mesh ModelFile=Models\skbasilisk2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbasilisk2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbasilisk2Anims) -AdamJD 
#exec Anim Import Anim=skbasilisk2Anims AnimFile=Models\skbasilisk2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbasilisk2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbasilisk2Mesh Anim=skbasilisk2Anims
#exec Anim Digest Anim=skbasilisk2Anims VERBOSE 

//texture import (skbasilisk2Tex0) -AdamJD 
#exec Texture Import File=Textures\skbasilisk2Tex0.png Name=skbasilisk2Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasilisk2Mesh Num=0 Texture=skbasilisk2Tex0

//texture import (skbasilisk2Tex1) -AdamJD 
#exec Texture Import File=Textures\skbasilisk2Tex1.png Name=skbasilisk2Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasilisk2Mesh Num=1 Texture=skbasilisk2Tex1

//texture import (skbasilisk2Tex2) -AdamJD 
#exec Texture Import File=Textures\skbasilisk2Tex2.png Name=skbasilisk2Tex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasilisk2Mesh Num=2 Texture=skbasilisk2Tex2

//texture import (skbasilisk2Tex3) -AdamJD 
#exec Texture Import File=Textures\skbasilisk2Tex3.png Name=skbasilisk2Tex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbasilisk2Mesh Num=3 Texture=skbasilisk2Tex3

