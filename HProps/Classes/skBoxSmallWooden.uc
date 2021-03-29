//================================================================================
// skBoxSmallWooden.
//================================================================================

class skBoxSmallWooden extends HPMeshActor;

//model import (skBoxSmallWoodenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBoxSmallWoodenMesh ModelFile=Models\skBoxSmallWoodenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBoxSmallWoodenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBoxSmallWoodenAnims) -AdamJD 
#exec Anim Import Anim=skBoxSmallWoodenAnims AnimFile=Models\skBoxSmallWoodenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBoxSmallWoodenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBoxSmallWoodenMesh Anim=skBoxSmallWoodenAnims
#exec Anim Digest Anim=skBoxSmallWoodenAnims VERBOSE 

//texture import (skBoxSmallWoodenTex0) -AdamJD 
#exec Texture Import File=Textures\skBoxSmallWoodenTex0.png Name=skBoxSmallWoodenTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoxSmallWoodenMesh Num=0 Texture=skBoxSmallWoodenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBoxSmallWoodenMesh
}
