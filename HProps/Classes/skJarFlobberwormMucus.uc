//================================================================================
// skJarFlobberwormMucus.
//================================================================================

class skJarFlobberwormMucus extends HPMeshActor;

//model import (skJarFlobberwormMucusMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarFlobberwormMucusMesh ModelFile=Models\skJarFlobberwormMucusMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarFlobberwormMucusMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJarFlobberwormMucusAnims) -AdamJD 
#exec Anim Import Anim=skJarFlobberwormMucusAnims AnimFile=Models\skJarFlobberwormMucusAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarFlobberwormMucusMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarFlobberwormMucusMesh Anim=skJarFlobberwormMucusAnims
#exec Anim Digest Anim=skJarFlobberwormMucusAnims VERBOSE 

//texture import (skJarFlobberwormMucusTex0) -AdamJD 
#exec Texture Import File=Textures\skJarFlobberwormMucusTex0.png Name=skJarFlobberwormMucusTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarFlobberwormMucusMesh Num=0 Texture=skJarFlobberwormMucusTex0

//texture import (skJarFlobberwormMucusTex1) -AdamJD 
#exec Texture Import File=Textures\skJarFlobberwormMucusTex1.png Name=skJarFlobberwormMucusTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarFlobberwormMucusMesh Num=1 Texture=skJarFlobberwormMucusTex1

//texture import (skJarFlobberwormMucusTex2) -AdamJD 
#exec Texture Import File=Textures\skJarFlobberwormMucusTex2.png Name=skJarFlobberwormMucusTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarFlobberwormMucusMesh Num=2 Texture=skJarFlobberwormMucusTex2

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarFlobberwormMucusMesh
}
