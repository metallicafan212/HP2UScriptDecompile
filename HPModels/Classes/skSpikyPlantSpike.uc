//================================================================================
// skSpikyPlantSpike.
//================================================================================

class skSpikyPlantSpike extends HPMesh
  Abstract;
  
//model import (skSpikyPlantSpikeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpikyPlantSpikeMesh ModelFile=Models\skSpikyPlantSpikeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpikyPlantSpikeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpikyPlantSpikeAnims) -AdamJD 
#exec Anim Import Anim=skSpikyPlantSpikeAnims AnimFile=Models\skSpikyPlantSpikeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpikyPlantSpikeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpikyPlantSpikeMesh Anim=skSpikyPlantSpikeAnims
#exec Anim Digest Anim=skSpikyPlantSpikeAnims VERBOSE 

//texture import (skSpikyPlantSpikeTex0) -AdamJD 
#exec Texture Import File=Textures\skSpikyPlantSpikeTex0.png Name=skSpikyPlantSpikeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpikyPlantSpikeMesh Num=0 Texture=skSpikyPlantSpikeTex0

