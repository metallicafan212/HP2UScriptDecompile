//================================================================================
// skBarrelMiners.
//================================================================================

class skBarrelMiners extends HPMeshActor;

//model import (skBarrelMinersMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBarrelMinersMesh ModelFile=Models\skBarrelMinersMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBarrelMinersMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBarrelMinersAnims) -AdamJD 
#exec Anim Import Anim=skBarrelMinersAnims AnimFile=Models\skBarrelMinersAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBarrelMinersMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBarrelMinersMesh Anim=skBarrelMinersAnims
#exec Anim Digest Anim=skBarrelMinersAnims VERBOSE 

//texture import (skBarrelMinersTex0) -AdamJD 
#exec Texture Import File=Textures\skBarrelMinersTex0.png Name=skBarrelMinersTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBarrelMinersMesh Num=0 Texture=skBarrelMinersTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBarrelMinersMesh
}
