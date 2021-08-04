//================================================================================
// skArmorHelmet.
//================================================================================

class skArmorHelmet extends HPMeshActor;

//model import (skArmorHelmetMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skArmorHelmetMesh ModelFile=Models\skArmorHelmetMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skArmorHelmetMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skArmorHelmetAnims) -AdamJD 
#exec Anim Import Anim=skArmorHelmetAnims AnimFile=Models\skArmorHelmetAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skArmorHelmetMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skArmorHelmetMesh Anim=skArmorHelmetAnims
#exec Anim Digest Anim=skArmorHelmetAnims VERBOSE 

//texture import (skArmorHelmetTex0) -AdamJD 
#exec Texture Import File=Textures\skArmorHelmetTex0.png Name=skArmorHelmetTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skArmorHelmetMesh Num=0 Texture=skArmorHelmetTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skArmorHelmetMesh
}
