//================================================================================
// skTableWoodSquare.
//================================================================================

class skTableWoodSquare extends HPMeshActor;

//model import (skTableWoodSquareMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTableWoodSquareMesh ModelFile=Models\skTableWoodSquareMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTableWoodSquareMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTableWoodSquareAnims) -AdamJD 
#exec Anim Import Anim=skTableWoodSquareAnims AnimFile=Models\skTableWoodSquareAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTableWoodSquareMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTableWoodSquareMesh Anim=skTableWoodSquareAnims
#exec Anim Digest Anim=skTableWoodSquareAnims VERBOSE 

//texture import (skTableWoodSquareTex0) -AdamJD 
#exec Texture Import File=Textures\skTableWoodSquareTex0.png Name=skTableWoodSquareTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTableWoodSquareMesh Num=0 Texture=skTableWoodSquareTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTableWoodSquareMesh
}
