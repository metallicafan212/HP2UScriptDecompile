//================================================================================
// skCrystalBall.
//================================================================================

class skCrystalBall extends HPMeshActor;

//model import (skCrystalBallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCrystalBallMesh ModelFile=Models\skCrystalBallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCrystalBallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCrystalBallAnims) -AdamJD 
#exec Anim Import Anim=skCrystalBallAnims AnimFile=Models\skCrystalBallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCrystalBallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCrystalBallMesh Anim=skCrystalBallAnims
#exec Anim Digest Anim=skCrystalBallAnims VERBOSE 

//texture import (skCrystalBallTex0) -AdamJD 
#exec Texture Import File=Textures\skCrystalBallTex0.png Name=skCrystalBallTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCrystalBallMesh Num=0 Texture=skCrystalBallTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCrystalBallMesh
}
