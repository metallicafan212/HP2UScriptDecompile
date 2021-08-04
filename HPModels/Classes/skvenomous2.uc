//================================================================================
// skvenomous2.
//================================================================================

class skvenomous2 extends HPMesh
  Abstract;
  
//model import (skvenomous2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skvenomous2Mesh ModelFile=Models\skvenomous2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skvenomous2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skvenomous2Anims) -AdamJD 
#exec Anim Import Anim=skvenomous2Anims AnimFile=Models\skvenomous2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skvenomous2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skvenomous2Mesh Anim=skvenomous2Anims
#exec Anim Digest Anim=skvenomous2Anims VERBOSE 

//texture import (skvenomous2Tex0) -AdamJD 
#exec Texture Import File=Textures\skvenomous2Tex0.png Name=skvenomous2Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skvenomous2Mesh Num=0 Texture=skvenomous2Tex0

