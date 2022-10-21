//================================================================================
// skDragonSkeleton.
//================================================================================

class skDragonSkeleton extends HPMeshActor;

//model import (skDragonSkeletonMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDragonSkeletonMesh ModelFile=Models\skDragonSkeletonMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDragonSkeletonMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDragonSkeletonAnims) -AdamJD 
#exec Anim Import Anim=skDragonSkeletonAnims AnimFile=Models\skDragonSkeletonAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDragonSkeletonMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDragonSkeletonMesh Anim=skDragonSkeletonAnims
#exec Anim Digest Anim=skDragonSkeletonAnims VERBOSE 

//texture import (skDragonSkeletonTex0) -AdamJD 
#exec Texture Import File=Textures\skDragonSkeletonTex0.png Name=skDragonSkeletonTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonSkeletonMesh Num=0 Texture=skDragonSkeletonTex0

//texture import (skDragonSkeletonTex1) -AdamJD 
#exec Texture Import File=Textures\skDragonSkeletonTex1.png Name=skDragonSkeletonTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonSkeletonMesh Num=1 Texture=skDragonSkeletonTex1

//texture import (skDragonSkeletonTex2) -AdamJD 
#exec Texture Import File=Textures\skDragonSkeletonTex2.png Name=skDragonSkeletonTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonSkeletonMesh Num=2 Texture=skDragonSkeletonTex2

//texture import (skDragonSkeletonTex3) -AdamJD 
#exec Texture Import File=Textures\skDragonSkeletonTex3.png Name=skDragonSkeletonTex3 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonSkeletonMesh Num=3 Texture=skDragonSkeletonTex3

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDragonSkeletonMesh
}
