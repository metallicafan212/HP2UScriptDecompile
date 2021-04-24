//================================================================================
// skDresser.
//================================================================================

class skDresser extends HPMeshActor;

//model import (skDresserMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDresserMesh ModelFile=Models\skDresserMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDresserMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDresserAnims) -AdamJD 
#exec Anim Import Anim=skDresserAnims AnimFile=Models\skDresserAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDresserMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDresserMesh Anim=skDresserAnims
#exec Anim Digest Anim=skDresserAnims VERBOSE 

//texture import (skDresserTex0) -AdamJD 
#exec Texture Import File=Textures\skDresserTex0.png Name=skDresserTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDresserMesh Num=0 Texture=skDresserTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDresserMesh
}
