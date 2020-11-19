# Metallicafan212: Python script to generate a UC file with all texture imports
import os;
from PIL import Image;

# Metallicafan212: List of texture files to exclude
#texExclude = ["Texture0.png", "Texture1.png", "Texture2.png", "Texture3.png", "Texture4.png", "Texture5.png", "Texture6.png", "Texture7.png", "Texture8.png",];

texExclude = ["HiddenPawn.PNG", "ica.PNG", "icb.PNG", "icc.PNG", "icd.PNG", "ice.PNG", "icf.PNG", "icg.PNG", "ich.PNG", "SecretTexture.PNG", "spell_trigger.PNG",
              "SpongifyTargetTexture.PNG", "SpongifyTexture.PNG", "SthingE.PNG"
             ];

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

def GenTexBitch():
    
    # Metallicafan212: Class string
    texBitch = "class AssTexImportBitch based on Actor\n\tabstract;\n\n";
    
    maskedFlags = "536870914";
    noMaskFlags = "0";
    
    # Metallicafan212: Generate the Texture%d.png files since I'm a lazy bastard
    for i in range(0, 40):
        texExclude.append("Texture" + str(i) + ".PNG");

    # Metallicafan212: We need to loop over the textures folder
    for subdir, dirs, files in os.walk("Textures"):
        for file in files:
            # Metallicafan212: Check if it's in the array
            if(not file in texExclude):
                # Metallicafan212: Add it on
                tempStr = "";
                
                localFlags = "";
                
                # Metallicafan212: Load the image
                temImg = Image.open(os.path.join(subdir, file));
                
                if(HasAlpha(temImg)):
                    localFlags = maskedFlags;
                else:
                    localFlags = noMaskFlags;
                
                if(subdir != "Textures"):
                    tempStr = "#exec Texture Import File=" + subdir + "\\" + file + "\tGROUP=" + os.path.basename(subdir) + "\tName=" + os.path.splitext(file)[0] + " COMPRESSION=3 UPSCALE=1 Mips=1 Flags=" + localFlags + "\n";
                    #print(tempStr);
                else:
                    tempStr = "#exec Texture Import File=Textures\\" + file + "\t\tName=" + os.path.splitext(os.path.basename(file))[0] + " COMPRESSION=3 UPSCALE=1 Mips=1 Flags=" + localFlags + "\n";
                    #print(tempStr);
                
                # Metallicafan212: Add it to the class
                texBitch += tempStr;
    
    # Metallicafan212: Now write it out
    if not os.path.exists("Classes\\Ass"):
        os.mkdir("Classes\\Ass");
        
    with open("Classes\\Ass\\AssTexImportBitch.uc", "w+") as f:
        f.write(texBitch);
        
        
if __name__ == '__main__':
    GenTexBitch();
