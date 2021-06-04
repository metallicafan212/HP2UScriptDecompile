//================================================================================
// skStoolsSortingHat.
//================================================================================

class skStoolsSortingHat extends HPMeshActor;

//model import (skStoolsSortingHatMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skStoolsSortingHatMesh ModelFile=Models\skStoolsSortingHatMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skStoolsSortingHatMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skStoolsSortingHatAnims) -AdamJD 
#exec Anim Import Anim=skStoolsSortingHatAnims AnimFile=Models\skStoolsSortingHatAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skStoolsSortingHatMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skStoolsSortingHatMesh Anim=skStoolsSortingHatAnims
#exec Anim Digest Anim=skStoolsSortingHatAnims VERBOSE 

//texture import (skStoolsSortingHatTex0) -AdamJD 
#exec Texture Import File=Textures\skStoolsSortingHatTex0.png Name=skStoolsSortingHatTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skStoolsSortingHatMesh Num=0 Texture=skStoolsSortingHatTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skStoolsSortingHatMesh
}
