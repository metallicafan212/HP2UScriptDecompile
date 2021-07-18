//================================================================================
// skLuciousMalfoy.
//================================================================================

class skLuciousMalfoy extends HPMesh
  Abstract;
  
//model import (skLuciousMalfoyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLuciousMalfoyMesh ModelFile=Models\skLuciousMalfoyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLuciousMalfoyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLuciousMalfoyAnims) -AdamJD 
#exec Anim Import Anim=skLuciousMalfoyAnims AnimFile=Models\skLuciousMalfoyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLuciousMalfoyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLuciousMalfoyMesh Anim=skLuciousMalfoyAnims
#exec Anim Digest Anim=skLuciousMalfoyAnims VERBOSE 

//texture import (skLuciousMalfoyTex0) -AdamJD 
#exec Texture Import File=Textures\skLuciousMalfoyTex0.png Name=skLuciousMalfoyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLuciousMalfoyMesh Num=0 Texture=skLuciousMalfoyTex0

//texture import (skLuciousMalfoyTex1) -AdamJD 
#exec Texture Import File=Textures\skLuciousMalfoyTex1.png Name=skLuciousMalfoyTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLuciousMalfoyMesh Num=1 Texture=skLuciousMalfoyTex1

