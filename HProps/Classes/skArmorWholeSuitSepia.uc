//================================================================================
// skArmorWholeSuitSepia.
//================================================================================

class skArmorWholeSuitSepia extends HPMeshActor;

//model import (skArmorWholeSuitSepiaMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skArmorWholeSuitSepiaMesh ModelFile=Models\skArmorWholeSuitSepiaMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skArmorWholeSuitSepiaMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skArmorWholeSuitSepiaAnims) -AdamJD 
#exec Anim Import Anim=skArmorWholeSuitSepiaAnims AnimFile=Models\skArmorWholeSuitSepiaAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skArmorWholeSuitSepiaMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skArmorWholeSuitSepiaMesh Anim=skArmorWholeSuitSepiaAnims
#exec Anim Digest Anim=skArmorWholeSuitSepiaAnims VERBOSE

//texture import (skArmorWholeSuitSepiaTex0) -AdamJD 
#exec Texture Import File=Textures\skArmorWholeSuitSepiaTex0.png Name=skArmorWholeSuitSepiaTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skArmorWholeSuitSepiaMesh Num=0 Texture=skArmorWholeSuitSepiaTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skArmorWholeSuitSepiaMesh
}
