//================================================================================
// skChristmasOrnamentBall.
//================================================================================

class skChristmasOrnamentBall extends HPMeshActor;

//model import (skChristmasOrnamentBallMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChristmasOrnamentBallMesh ModelFile=Models\skChristmasOrnamentBallMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChristmasOrnamentBallMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChristmasOrnamentBallAnims) -AdamJD 
#exec Anim Import Anim=skChristmasOrnamentBallAnims AnimFile=Models\skChristmasOrnamentBallAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChristmasOrnamentBallMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChristmasOrnamentBallMesh Anim=skChristmasOrnamentBallAnims
#exec Anim Digest Anim=skChristmasOrnamentBallAnims VERBOSE 

//texture import (skChristmasOrnamentBallTex0) -AdamJD 
#exec Texture Import File=Textures\skChristmasOrnamentBallTex0.png Name=skChristmasOrnamentBallTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChristmasOrnamentBallMesh Num=0 Texture=skChristmasOrnamentBallTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChristmasOrnamentBallMesh
}
