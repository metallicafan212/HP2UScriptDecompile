//================================================================================
// skChristmasOrnamentBird.
//================================================================================

class skChristmasOrnamentBird extends HPMeshActor;

//model import (skChristmasOrnamentBirdMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChristmasOrnamentBirdMesh ModelFile=Models\skChristmasOrnamentBirdMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChristmasOrnamentBirdMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChristmasOrnamentBirdAnims) -AdamJD 
#exec Anim Import Anim=skChristmasOrnamentBirdAnims AnimFile=Models\skChristmasOrnamentBirdAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChristmasOrnamentBirdMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChristmasOrnamentBirdMesh Anim=skChristmasOrnamentBirdAnims
#exec Anim Digest Anim=skChristmasOrnamentBirdAnims VERBOSE 

//texture import (skChristmasOrnamentBirdTex0) -AdamJD 
#exec Texture Import File=Textures\skChristmasOrnamentBirdTex0.png Name=skChristmasOrnamentBirdTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChristmasOrnamentBirdMesh Num=0 Texture=skChristmasOrnamentBirdTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChristmasOrnamentBirdMesh
}
