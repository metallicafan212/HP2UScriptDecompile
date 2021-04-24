//================================================================================
// skFawkesAshes.
//================================================================================

class skFawkesAshes extends HPMeshActor;

//model import (skFawkesAshesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFawkesAshesMesh ModelFile=Models\skFawkesAshesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFawkesAshesMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFawkesAshesAnims) -AdamJD 
#exec Anim Import Anim=skFawkesAshesAnims AnimFile=Models\skFawkesAshesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFawkesAshesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFawkesAshesMesh Anim=skFawkesAshesAnims
#exec Anim Digest Anim=skFawkesAshesAnims VERBOSE 

//texture import (skFawkesAshesTex0) -AdamJD 
#exec Texture Import File=Textures\skFawkesAshesTex0.png Name=skFawkesAshesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFawkesAshesMesh Num=0 Texture=skFawkesAshesTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFawkesAshesMesh
}
