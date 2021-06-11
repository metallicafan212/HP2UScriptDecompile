//================================================================================
// skTableHagrids.
//================================================================================

class skTableHagrids extends HPMeshActor;

//model import (skTableHagridsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableHagridsMesh ModelFile=Models\skTableHagridsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableHagridsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableHagridsAnims) -AdamJD 
#exec Anim Import Anim=skTableHagridsAnims AnimFile=Models\skTableHagridsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableHagridsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableHagridsMesh Anim=skTableHagridsAnims
#exec Anim Digest Anim=skTableHagridsAnims VERBOSE 

//texture import (skTableHagridsTex0) -AdamJD 
#exec Texture Import File=Textures\skTableHagridsTex0.png Name=skTableHagridsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableHagridsMesh Num=0 Texture=skTableHagridsTex0

//texture import (skTableHagridsTex1) -AdamJD 
#exec Texture Import File=Textures\skTableHagridsTex1.png Name=skTableHagridsTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableHagridsMesh Num=1 Texture=skTableHagridsTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableHagridsMesh
}
