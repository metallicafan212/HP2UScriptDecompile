//================================================================================
// skCartMiners.
//================================================================================

class skCartMiners extends HPMeshActor;

//model import (skCartMinersMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCartMinersMesh ModelFile=Models\skCartMinersMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCartMinersMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCartMinersAnims) -AdamJD 
#exec Anim Import Anim=skCartMinersAnims AnimFile=Models\skCartMinersAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCartMinersMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCartMinersMesh Anim=skCartMinersAnims
#exec Anim Digest Anim=skCartMinersAnims VERBOSE 

//texture import (skCartMinersTex0) -AdamJD 
#exec Texture Import File=Textures\skCartMinersTex0.png Name=skCartMinersTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCartMinersMesh Num=0 Texture=skCartMinersTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCartMinersMesh
}
