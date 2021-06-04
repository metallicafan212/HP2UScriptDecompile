//================================================================================
// skQuidditchQuaffle.
//================================================================================

class skQuidditchQuaffle extends HPMeshActor;

//model import (skQuidditchQuaffleMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skQuidditchQuaffleMesh ModelFile=Models\skQuidditchQuaffleMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skQuidditchQuaffleMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skQuidditchQuaffleAnims) -AdamJD 
#exec Anim Import Anim=skQuidditchQuaffleAnims AnimFile=Models\skQuidditchQuaffleAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skQuidditchQuaffleMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skQuidditchQuaffleMesh Anim=skQuidditchQuaffleAnims
#exec Anim Digest Anim=skQuidditchQuaffleAnims VERBOSE 

//texture import (skQuidditchQuaffleTex0) -AdamJD 
#exec Texture Import File=Textures\skQuidditchQuaffleTex0.png Name=skQuidditchQuaffleTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skQuidditchQuaffleMesh Num=0 Texture=skQuidditchQuaffleTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skQuidditchQuaffleMesh
}
