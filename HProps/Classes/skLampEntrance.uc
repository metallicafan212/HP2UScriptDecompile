//================================================================================
// skLampEntrance.
//================================================================================

class skLampEntrance extends HPMeshActor;

//model import (skLampEntranceMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLampEntranceMesh ModelFile=Models\skLampEntranceMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLampEntranceMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLampEntranceAnims) -AdamJD 
#exec Anim Import Anim=skLampEntranceAnims AnimFile=Models\skLampEntranceAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLampEntranceMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLampEntranceMesh Anim=skLampEntranceAnims
#exec Anim Digest Anim=skLampEntranceAnims VERBOSE 

//texture import (skLampEntranceTex0) -AdamJD 
#exec Texture Import File=Textures\skLampEntranceTex0.png Name=skLampEntranceTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLampEntranceMesh Num=0 Texture=skLampEntranceTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLampEntranceMesh
}
