//================================================================================
// skEaselA.
//================================================================================

class skEaselA extends HPMeshActor;

//model import (skEaselAMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skEaselAMesh ModelFile=Models\skEaselAMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skEaselAMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skEaselAAnims) -AdamJD 
#exec Anim Import Anim=skEaselAAnims AnimFile=Models\skEaselAAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skEaselAMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skEaselAMesh Anim=skEaselAAnims
#exec Anim Digest Anim=skEaselAAnims VERBOSE 

//texture import (skEaselATex0) -AdamJD 
#exec Texture Import File=Textures\skEaselATex0.png Name=skEaselATex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skEaselAMesh Num=0 Texture=skEaselATex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skEaselAMesh
}
