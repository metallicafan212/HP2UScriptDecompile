//================================================================================
// skDiffindoRoots.
//================================================================================

class skDiffindoRoots extends HPMeshActor;

//model import (skDiffindoRootsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoRootsMesh ModelFile=Models\skDiffindoRootsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoRootsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoRootsAnims) -AdamJD 
#exec Anim Import Anim=skDiffindoRootsAnims AnimFile=Models\skDiffindoRootsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoRootsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoRootsMesh Anim=skDiffindoRootsAnims
#exec Anim Digest Anim=skDiffindoRootsAnims VERBOSE 

//texture import (skDiffindoRootsTex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoRootsTex0.png Name=skDiffindoRootsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoRootsMesh Num=0 Texture=skDiffindoRootsTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoRootsMesh
}
