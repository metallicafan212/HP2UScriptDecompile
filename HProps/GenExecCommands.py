#AdamJD: Python script to generate the mesh, anim and texture exec commands
import os;
from PIL import Image;

def HasAlpha(Img):
    if Img.mode == "P":
        mask = Img.info.get("transparancy", -1);
        
        # Metallicafan212: Loop over the palette and see if any are transparant
        for count, i in Img.getcolors():
            if i == mask:
                return True;
    elif Img.mode == "RGBA":
        extr = Img.getextrema();
        
        # Metallicafan212: Test for less than full alpha
        if(extr[3][0] < 255):
            return True;

    # Metallicafan212: No alpha
    return False;

def GenExecCommands():
    
    #AdamJD: Set up the exec Strings
    firstExecString = "";
    secondExecString = "";
    thirdExecString = "";

    #AdamJD: Loop over the models folder
    for subdir, dirs, files in os.walk("Models"):
        
        #AdamJD: Get the models for the model import exec commands
        for fileMesh in files:
                if fileMesh.endswith('.psk') or fileMesh.endswith('.PSK'):
                    meshName = os.path.splitext(os.path.basename(fileMesh))[0];
                    
                    modelImportString = ("//model import (" + meshName + ") -AdamJD \n"
                                         "#exec Mesh ModelImport Mesh=" + meshName + " ModelFile=Models\\" + fileMesh + " LODStyle=10 \n"
                                         "#exec Mesh Origin Mesh=" + meshName + " X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 \n"
                                         "\n"
                                        );

                    #AdamJD: Add it to the file
                    firstExecString += modelImportString;
                    
        #AdamJD: Get the anims for the anim import exec commands
        for fileAnim in files:
                 if fileAnim.endswith('.psa') or fileAnim.endswith('.PSA'):
                     animName = os.path.splitext(os.path.basename(fileAnim))[0];
                     animMeshName = animName[:-5] + "Mesh"; 
                    
                     animImportString = ("//anim import (" + animName + ") -AdamJD \n"
                                        "#exec Anim Import Anim=" + animName + " AnimFile=Models\\" + fileAnim + " Compress=1 MaxKeys=999999 ImportSeqs=1 \n"
                                        "#exec MeshMap Scale MeshMap=" + animMeshName + " X=1.0 Y=1.0 Z=1.0 \n"
                                        "#exec Mesh DefaultAnim Mesh=" + animMeshName + " Anim=" + animName + "\n"
                                        "#exec Anim Digest Anim=" + animName + " VERBOSE \n"
                                        "\n"
                                        );

                     #AdamJD: Add it to the file
                     secondExecString += animImportString;

    # Metallicafan212: We need to loop over the textures folder
    for subdir, dirs, files in os.walk("Textures"):

         #AdamJD: Get the textures for the texture import exec commands
         for fileTex in files:
            # Metallicafan212: Load the image
            temImg = Image.open(os.path.join(subdir, fileTex));
                
            if(HasAlpha(temImg)):
                localFlags = "536870914";
            else:
                localFlags = "0";

            #AdamJD: Find the texture name and make the mesh name
            texName = os.path.splitext(os.path.basename(fileTex))[0];
            texMeshName = texName[:-4] + "Mesh";

            #AdamJD: Get the texture number based on the texture name
            if(texName.endswith("1")):
               texNum = 1;
            elif(texName.endswith("2")):
               texNum = 2;
            elif(texName.endswith("3")):
               texNum = 3;
            elif(texName.endswith("4")):
               texNum = 4;
            elif(texName.endswith("5")):
               texNum = 5;
            elif(texName.endswith("6")):
               texNum = 6;
            else:
               texNum = 0;
            
            texString = ("//texture import (" + texName + ") -AdamJD \n"
                         "#exec Texture Import File=Textures\\" + fileTex + " Name=" + texName + " COMPRESSION=3 UPSCALE=1 Mips=1 Flags=" + localFlags + " Group=Skins \n"
                         "#exec MeshMap SetTexture MeshMap=" + texMeshName + " Num=" + str(texNum) + " Texture=" + texName + "\n"
                         "\n"
                        );
                
            # AdamJD: Add it to the file
            thirdExecString += texString;
    
    #AdamJD: Write out the exec commands        
    with open("ExecCommandImports.uc", "w+") as f:
        f.write("//this is just a temp file to have all the exec commands in one place, the file does not get compiled -AdamJD \n\n");
        f.write("\n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("//the model import exec commands \n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("\n");
        f.write(firstExecString);
        f.write("\n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("//the anim import exec commands \n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("\n");
        f.write(secondExecString);
        f.write("\n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("//the texture import exec commands \n");
        f.write("//------------------------------------------------------------------------------------------------------------------------------------------------ \n");
        f.write("\n");
        f.write(thirdExecString);
        
if __name__ == '__main__':
    GenExecCommands();
