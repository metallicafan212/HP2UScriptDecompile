//================================================================================
// skDishesPeevesPot.
//================================================================================

class skDishesPeevesPot extends HPMeshActor;

//model import (skDishesPeevesPotMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDishesPeevesPotMesh ModelFile=Models\skDishesPeevesPotMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDishesPeevesPotMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDishesPeevesPotAnims) -AdamJD 
#exec Anim Import Anim=skDishesPeevesPotAnims AnimFile=Models\skDishesPeevesPotAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDishesPeevesPotMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDishesPeevesPotMesh Anim=skDishesPeevesPotAnims
#exec Anim Digest Anim=skDishesPeevesPotAnims VERBOSE 

//texture import (skDishesPeevesPotTex0) -AdamJD 
#exec Texture Import File=Textures\skDishesPeevesPotTex0.png Name=skDishesPeevesPotTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesPeevesPotMesh Num=0 Texture=skDishesPeevesPotTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDishesPeevesPotMesh
}
