//================================================================================
// skSculptureClawFoot.
//================================================================================

class skSculptureClawFoot extends HPMeshActor;

//model import (skSculptureClawFootMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSculptureClawFootMesh ModelFile=Models\skSculptureClawFootMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSculptureClawFootMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSculptureClawFootAnims) -AdamJD 
#exec Anim Import Anim=skSculptureClawFootAnims AnimFile=Models\skSculptureClawFootAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSculptureClawFootMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSculptureClawFootMesh Anim=skSculptureClawFootAnims
#exec Anim Digest Anim=skSculptureClawFootAnims VERBOSE 

//texture import (skSculptureClawFootTex0) -AdamJD 
#exec Texture Import File=Textures\skSculptureClawFootTex0.png Name=skSculptureClawFootTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSculptureClawFootMesh Num=0 Texture=skSculptureClawFootTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSculptureClawFootMesh
}
