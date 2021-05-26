//================================================================================
// skLampWall.
//================================================================================

class skLampWall extends HPMeshActor;

//model import (skLampWallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLampWallMesh ModelFile=Models\skLampWallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLampWallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLampWallAnims) -AdamJD 
#exec Anim Import Anim=skLampWallAnims AnimFile=Models\skLampWallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLampWallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLampWallMesh Anim=skLampWallAnims
#exec Anim Digest Anim=skLampWallAnims VERBOSE 

//texture import (skLampWallTex0) -AdamJD 
#exec Texture Import File=Textures\skLampWallTex0.png Name=skLampWallTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLampWallMesh Num=0 Texture=skLampWallTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLampWallMesh
}
