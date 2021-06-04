//================================================================================
// skGreenPurpleCheckerBean.
//================================================================================

class skGreenPurpleCheckerBean extends HPMeshActor;

//model import (skGreenPurpleCheckerBeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGreenPurpleCheckerBeanMesh ModelFile=Models\skGreenPurpleCheckerBeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGreenPurpleCheckerBeanMesh X=0 Y=0 Z=16 Yaw=0 Pitch=0 Roll=0 

//anim import (skGreenPurpleCheckerBeanAnims) -AdamJD 
#exec Anim Import Anim=skGreenPurpleCheckerBeanAnims AnimFile=Models\skGreenPurpleCheckerBeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGreenPurpleCheckerBeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGreenPurpleCheckerBeanMesh Anim=skGreenPurpleCheckerBeanAnims
#exec Anim Digest Anim=skGreenPurpleCheckerBeanAnims VERBOSE 

//texture import (skGreenPurpleCheckerBeanTex0) -AdamJD 
#exec Texture Import File=Textures\skGreenPurpleCheckerBeanTex0.png Name=skGreenPurpleCheckerBeanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGreenPurpleCheckerBeanMesh Num=0 Texture=skGreenPurpleCheckerBeanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skGreenPurpleCheckerBeanMesh
}
