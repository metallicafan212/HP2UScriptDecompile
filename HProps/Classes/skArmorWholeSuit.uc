//================================================================================
// skArmorWholeSuit.
//================================================================================

class skArmorWholeSuit extends HPMeshActor;

//model import (skArmorWholeSuitMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skArmorWholeSuitMesh ModelFile=Models\skArmorWholeSuitMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skArmorWholeSuitMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skArmorWholeSuitAnims) -AdamJD 
#exec Anim Import Anim=skArmorWholeSuitAnims AnimFile=Models\skArmorWholeSuitAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skArmorWholeSuitMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skArmorWholeSuitMesh Anim=skArmorWholeSuitAnims
#exec Anim Digest Anim=skArmorWholeSuitAnims VERBOSE 

//texture import (skArmorWholeSuitTex0) -AdamJD 
#exec Texture Import File=Textures\skArmorWholeSuitTex0.png Name=skArmorWholeSuitTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skArmorWholeSuitMesh Num=0 Texture=skArmorWholeSuitTex0 

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skArmorWholeSuitMesh
}
