//================================================================================
// skBooksOwlBookendBooks.
//================================================================================

class skBooksOwlBookendBooks extends HPMeshActor;

//model import (skBooksOwlBookendBooksMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksOwlBookendBooksMesh ModelFile=Models\skBooksOwlBookendBooksMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksOwlBookendBooksMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksOwlBookendBooksAnims) -AdamJD 
#exec Anim Import Anim=skBooksOwlBookendBooksAnims AnimFile=Models\skBooksOwlBookendBooksAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksOwlBookendBooksMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksOwlBookendBooksMesh Anim=skBooksOwlBookendBooksAnims
#exec Anim Digest Anim=skBooksOwlBookendBooksAnims VERBOSE 

//texture import (skBooksOwlBookendBooksTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksOwlBookendBooksTex0.png Name=skBooksOwlBookendBooksTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksOwlBookendBooksMesh Num=0 Texture=skBooksOwlBookendBooksTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksOwlBookendBooksMesh
}
