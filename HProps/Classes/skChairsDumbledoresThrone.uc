//================================================================================
// skChairsDumbledoresThrone.
//================================================================================

class skChairsDumbledoresThrone extends HPMeshActor;

//model import (skChairsDumbledoresThroneMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsDumbledoresThroneMesh ModelFile=Models\skChairsDumbledoresThroneMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsDumbledoresThroneMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skChairsDumbledoresThroneAnims) -AdamJD 
#exec Anim Import Anim=skChairsDumbledoresThroneAnims AnimFile=Models\skChairsDumbledoresThroneAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsDumbledoresThroneMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsDumbledoresThroneMesh Anim=skChairsDumbledoresThroneAnims
#exec Anim Digest Anim=skChairsDumbledoresThroneAnims VERBOSE 

//texture import (skChairsDumbledoresThroneTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsDumbledoresThroneTex0.png Name=skChairsDumbledoresThroneTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsDumbledoresThroneMesh Num=0 Texture=skChairsDumbledoresThroneTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsDumbledoresThroneMesh
}
