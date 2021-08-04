//================================================================================
// skspikybushnothorns.
//================================================================================

class skspikybushnothorns extends HPMesh
  Abstract;
  
//model import (skspikybushnothornsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skspikybushnothornsMesh ModelFile=Models\skspikybushnothornsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skspikybushnothornsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skspikybushnothornsAnims) -AdamJD 
#exec Anim Import Anim=skspikybushnothornsAnims AnimFile=Models\skspikybushnothornsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skspikybushnothornsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skspikybushnothornsMesh Anim=skspikybushnothornsAnims
#exec Anim Digest Anim=skspikybushnothornsAnims VERBOSE 

//texture import (skspikybushnothornsTex0) -AdamJD 
#exec Texture Import File=Textures\skspikybushnothornsTex0.png Name=skspikybushnothornsTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skspikybushnothornsMesh Num=0 Texture=skspikybushnothornsTex0

