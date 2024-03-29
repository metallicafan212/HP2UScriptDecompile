//================================================================================
// sktablelamp.
//================================================================================

class sktablelamp extends HPMeshActor;

//model import (sktablelampMesh) -AdamJD 
#exec Mesh ModelImport Mesh=sktablelampMesh ModelFile=Models\sktablelampMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=sktablelampMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (sktablelampAnims) -AdamJD 
#exec Anim Import Anim=sktablelampAnims AnimFile=Models\sktablelampAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=sktablelampMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=sktablelampMesh Anim=sktablelampAnims
#exec Anim Digest Anim=sktablelampAnims VERBOSE

//texture import (sktablelampTex0) -AdamJD 
#exec Texture Import File=Textures\sktablelampTex0.png Name=sktablelampTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=sktablelampMesh Num=0 Texture=sktablelampTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=sktablelampMesh
}
