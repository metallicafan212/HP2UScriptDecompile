//================================================================================
// skChocolateFrog.
//================================================================================

class skChocolateFrog extends HPMesh
  Abstract;
  
//model import (skChocolateFrogMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChocolateFrogMesh ModelFile=Models\skChocolateFrogMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChocolateFrogMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChocolateFrogAnims) -AdamJD 
#exec Anim Import Anim=skChocolateFrogAnims AnimFile=Models\skChocolateFrogAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChocolateFrogMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChocolateFrogMesh Anim=skChocolateFrogAnims
#exec Anim Digest Anim=skChocolateFrogAnims VERBOSE 

//texture import (skChocolateFrogTex0) -AdamJD 
#exec Texture Import File=Textures\skChocolateFrogTex0.png Name=skChocolateFrogTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChocolateFrogMesh Num=0 Texture=skChocolateFrogTex0

