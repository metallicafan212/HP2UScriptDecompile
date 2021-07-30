//================================================================================
// skvenomous1.
//================================================================================

class skvenomous1 extends HPMesh
  Abstract;
  
//model import (skvenomous1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skvenomous1Mesh ModelFile=Models\skvenomous1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skvenomous1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skvenomous1Anims) -AdamJD 
#exec Anim Import Anim=skvenomous1Anims AnimFile=Models\skvenomous1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skvenomous1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skvenomous1Mesh Anim=skvenomous1Anims
#exec Anim Digest Anim=skvenomous1Anims VERBOSE 

//texture import (skvenomous1Tex0) -AdamJD 
#exec Texture Import File=Textures\skvenomous1Tex0.png Name=skvenomous1Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skvenomous1Mesh Num=0 Texture=skvenomous1Tex0

//texture import (skvenomous1Tex1) -AdamJD 
#exec Texture Import File=Textures\skvenomous1Tex1.png Name=skvenomous1Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skvenomous1Mesh Num=1 Texture=skvenomous1Tex1

