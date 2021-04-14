//================================================================================
// skChristmasOrnamentStar.
//================================================================================

class skChristmasOrnamentStar extends HPMeshActor;

//model import (skChristmasOrnamentStarMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChristmasOrnamentStarMesh ModelFile=Models\skChristmasOrnamentStarMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChristmasOrnamentStarMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChristmasOrnamentStarAnims) -AdamJD 
#exec Anim Import Anim=skChristmasOrnamentStarAnims AnimFile=Models\skChristmasOrnamentStarAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChristmasOrnamentStarMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChristmasOrnamentStarMesh Anim=skChristmasOrnamentStarAnims
#exec Anim Digest Anim=skChristmasOrnamentStarAnims VERBOSE 

//texture import (skChristmasOrnamentStarTex0) -AdamJD 
#exec Texture Import File=Textures\skChristmasOrnamentStarTex0.png Name=skChristmasOrnamentStarTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChristmasOrnamentStarMesh Num=0 Texture=skChristmasOrnamentStarTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChristmasOrnamentStarMesh
}
