//================================================================================
// skJellybeanLowRes.
//================================================================================

class skJellybeanLowRes extends HPMeshActor;

//model import (skJellybeanLowResMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJellybeanLowResMesh ModelFile=Models\skJellybeanLowResMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJellybeanLowResMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJellybeanLowResAnims) -AdamJD 
#exec Anim Import Anim=skJellybeanLowResAnims AnimFile=Models\skJellybeanLowResAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJellybeanLowResMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJellybeanLowResMesh Anim=skJellybeanLowResAnims
#exec Anim Digest Anim=skJellybeanLowResAnims VERBOSE

//texture import (skJellybeanLowResTex0) -AdamJD 
#exec Texture Import File=Textures\skJellybeanLowResTex0.png Name=skJellybeanLowResTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJellybeanLowResMesh Num=0 Texture=skJellybeanLowResTex0 

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJellybeanLowResMesh
}
