//================================================================================
// skSpikyPlantHeadSpikes.
//================================================================================

class skSpikyPlantHeadSpikes extends HPMesh
  Abstract;
  
//model import (skSpikyPlantHeadSpikesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpikyPlantHeadSpikesMesh ModelFile=Models\skSpikyPlantHeadSpikesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpikyPlantHeadSpikesMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpikyPlantHeadSpikesAnims) -AdamJD 
#exec Anim Import Anim=skSpikyPlantHeadSpikesAnims AnimFile=Models\skSpikyPlantHeadSpikesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpikyPlantHeadSpikesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpikyPlantHeadSpikesMesh Anim=skSpikyPlantHeadSpikesAnims
#exec Anim Digest Anim=skSpikyPlantHeadSpikesAnims VERBOSE 

//texture import (skSpikyPlantHeadSpikesTex0) -AdamJD 
#exec Texture Import File=Textures\skSpikyPlantHeadSpikesTex0.png Name=skSpikyPlantHeadSpikesTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpikyPlantHeadSpikesMesh Num=0 Texture=skSpikyPlantHeadSpikesTex0

