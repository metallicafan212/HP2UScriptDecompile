//================================================================================
// skChairsRedCouch.
//================================================================================

class skChairsRedCouch extends HPMeshActor;

//model import (skChairsRedCouchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsRedCouchMesh ModelFile=Models\skChairsRedCouchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsRedCouchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsRedCouchAnims) -AdamJD 
#exec Anim Import Anim=skChairsRedCouchAnims AnimFile=Models\skChairsRedCouchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsRedCouchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsRedCouchMesh Anim=skChairsRedCouchAnims
#exec Anim Digest Anim=skChairsRedCouchAnims VERBOSE 

//texture import (skChairsRedCouchTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsRedCouchTex0.png Name=skChairsRedCouchTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsRedCouchMesh Num=0 Texture=skChairsRedCouchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsRedCouchMesh
}
