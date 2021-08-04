//================================================================================
// skWillowWisps.
//================================================================================

class skWillowWisps extends HPMesh
  Abstract;
  
//model import (skWillowWispsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWillowWispsMesh ModelFile=Models\skWillowWispsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWillowWispsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWillowWispsAnims) -AdamJD 
#exec Anim Import Anim=skWillowWispsAnims AnimFile=Models\skWillowWispsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWillowWispsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWillowWispsMesh Anim=skWillowWispsAnims
#exec Anim Digest Anim=skWillowWispsAnims VERBOSE 

//texture import (skWillowWispsTex0) -AdamJD 
#exec Texture Import File=Textures\skWillowWispsTex0.png Name=skWillowWispsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWillowWispsMesh Num=0 Texture=skWillowWispsTex0

