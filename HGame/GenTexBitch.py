# Metallicafan212: Python script to generate a UC file with all texture imports
import os;
from PIL import Image;

# Metallicafan212: List of texture files to exclude
#texExclude = ["Texture0.png", "Texture1.png", "Texture2.png", "Texture3.png", "Texture4.png", "Texture5.png", "Texture6.png", "Texture7.png", "Texture8.png",];

#AdamJD: This contains the non wizard card textures and unused textures
texExclude = ["HiddenPawn.PNG", "ica.PNG", "icb.PNG", "icc.PNG", "icd.PNG", "ice.PNG", "icf.PNG", "icg.PNG", "ich.PNG", "SecretTexture.PNG", "spell_trigger.PNG",
              "SpongifyTargetTexture.PNG", "SpongifyTexture.PNG", "SthingE.PNG", "CutCamIcon.PNG", "CutMarkIcon.PNG", "defaultSpellIcon.PNG", "ButtonDownTexture.PNG", "ButtonUpTexture.PNG",
              "FELoadingBackground1.PNG", "FELoadingBackground2.PNG", "FELoadingBackground3.PNG", "FELoadingBackground4.PNG", "FELoadingBackground5.PNG", "FELoadingBackground6.PNG", "leftPanel.PNG",
              "EnemyBarEmpty.PNG", "EnemyBarFull.PNG", "EnemyHead1.PNG", "EnemyHead2.PNG", "EnemyHead3.PNG", "EnemyHead4.PNG", "EnemyHead5.PNG", "EnemyHead6.PNG", #these are not used -AdamJD
              "DemoDown.PNG", "DemoOver.PNG", "DemoUp.PNG", "FEMessageBoxBtn.PNG", "FluffyHeadMAsleep.PNG", "FluffyHeadMAwake.PNG", "frogIcon.PNG", "fullPotionIcon.PNG", "GryfCrestGreyTexture.PNG", "GryfCrestTexture.PNG", "halfPotionIcon.PNG", #these are not used -AdamJD
              "HPLogoTexture.PNG", "HuffCrestGreyTexture.PNG", "HuffCrestTexture.PNG", "LevelDown.PNG", "LevelOver.PNG", "LevelUp.PNG", "LumosLightIcon.PNG", #these are not used -AdamJD
              "MainBack1.PNG", "MainBack2.PNG", "MainBack3.PNG", "MainBack4.PNG", "MainBack5.PNG", "MainBack6.PNG", "MainBackDown.PNG", "MainBackOver.PNG", "MainBackUp.PNG", "MalfoyHead.PNG", #these are not used -AdamJD
              "middlePanel.PNG", "PeevesHead.PNG", "QuidMatchLockTexture.PNG", "RaveCrestGreyTexture.PNG", "RaveCrestTexture.PNG", "rightPanel.PNG", "skgoldchestTex0.PNG", "SlytCrestGreyTexture.PNG", "SlytCrestTexture.PNG", "VoldemortHead.PNG", "WizCardHilite.PNG", #these are not used -AdamJD
              "WizCardGodricBigTextureLayer0.PNG", "WizCardGodricBigTextureLayer1.PNG", "WizCardGodricBigTextureLayer2.PNG", "WizCardParacelsusBigTextureLayer0.PNG", "WizCardParacelsusBigTextureLayer1.PNG", "WizCardParacelsusBigTextureLayer2.PNG", "WizCardSalazarBigTextureLayer0.PNG", "WizCardSalazarBigTextureLayer1.PNG", "WizCardSalazarBigTextureLayer2.PNG", #these are not used -AdamJD
              "CardGlowBronze.PNG", "CardGlowGold.PNG", "CardGlowGoldBig.PNG", "CardGlowSilver.PNG", "WizCardMissingBigTexture.PNG", "WizCardMissingSmallTexture.PNG",
              "FEBack1Texture1.PNG", "FEBack1Texture2.PNG", "FEBack1Texture3.PNG", "FEBack1Texture4.PNG", "FEBack1Texture5.PNG", "FEBack1Texture6.PNG", 
              "FEInGameBackTexture1.PNG", "FEInGameBackTexture2.PNG", "FEInGameBackTexture3.PNG", "FEInGameBackTexture4.PNG", "FEInGameBackTexture5.PNG", "FEInGameBackTexture6.PNG",
              "FEComboIdleTexture.PNG", "FEComboListBox.PNG", "FEComboListLarge.PNG", "FEComboListSmall.PNG", "FEComboOverTexture.PNG", "FEOptionTickCheckedOverTex.PNG",
              "FEOptionTickCheckedTex.PNG", "FEOptionTickUncheckedOverTex.PNG", "FEOptionTickUncheckedTex.PNG", "FEOverOption3Texture.PNG", "FEOverOption5Texture.PNG",
              "FEOverOptionTexture.PNG", "FEOverSliderTexture.PNG", "FESliderKnobTexture.PNG", "FESliderTexture.PNG", "QuidMatchBoxTexture.PNG",
              "CircleTexture.PNG", "DiamondTexture.PNG", "DiffindoTexture.PNG", "DownArrowTexture.PNG", "HarryLocationTexture.PNG", "HexTexture.PNG", "LeftArrowTexture.PNG",
              "RectangleTexture.PNG", "RictusempraTexture.PNG", "RightArrowTexture.PNG", "SkurgeTexture.PNG", "SquareGreenTexture.PNG", "tSpongifyTexture.PNG", "UpArrowTexture.PNG",
              "Map0Texture1.PNG", "Map0Texture2.PNG", "Map0Texture3.PNG", "Map0Texture4.PNG", "Map0Texture5.PNG", "Map0Texture6.PNG",
              "Map1Texture1.PNG", "Map1Texture2.PNG", "Map1Texture3.PNG", "Map1Texture4.PNG", "Map1Texture5.PNG", "Map1Texture6.PNG",
              "Map2Texture1.PNG", "Map2Texture2.PNG", "Map2Texture3.PNG", "Map2Texture4.PNG", "Map2Texture5.PNG", "Map2Texture6.PNG",
              "Map3Texture1.PNG", "Map3Texture2.PNG", "Map3Texture3.PNG", "Map3Texture4.PNG", "Map3Texture5.PNG", "Map3Texture6.PNG"
             ];

#AdamJD: Added another one for wizard cards because there's over 200 of them...
texExcludeWizCard = ["WizCardAgrippaBigTexture.PNG", "WizardCardAgrippaTex0.PNG", "WizCardAldertonBigTexture.PNG", "WizardCardAldertonTex0.PNG", "WizCardAndrosBigTexture.PNG", "WizardCardAndrosTex0.PNG",
                     "WizCardBarbaryBigTexture.PNG", "WizardCardBarbaryTex0.PNG", "WizCardBarkwithBigTexture.PNG", "WizardCardBarkwithTex0.PNG", "WizCardBeamishBigTexture.PNG", "WizardCardBeamishTex0.PNG",
                     "WizCardBelbyBigTexture.PNG", "WizardCardBelbyTex0.PNG", "WizCardBlaneBigTexture.PNG", "WizardCardBlaneTex0.PNG", "WizCardBloxamBigTexture.PNG", "WizardCardBloxamTex0.PNG",
                     "WizCardBonhamBigTexture.PNG", "WizardCardBonhamTex0.PNG", "WizCardBottBigTexture.PNG", "WizCardBertieBigTextureLayer0.PNG", "WizCardBertieBigTextureLayer1.PNG", "WizCardBertieBigTextureLayer2.PNG", "WizardCardBottTex0.PNG",
                     "WizCardCatchloveBigTexture.PNG", "WizardCardCatchloveTex0.PNG", "WizCardChittockBigTexture.PNG", "WizardCardChittockTex0.PNG", "WizCardCirceBigTexture.PNG", "WizardCardCirceTex0.PNG",
                     "WizCardClaggBigTexture.PNG", "WizardCardClaggTex0.PNG", "WizCardCliodneBigTexture.PNG", "WizardCardCliodneTex0.PNG", "WizCardCronkBigTexture.PNG", "WizardCardCronkTex0.PNG",
                     "WizCardCrumbBigTexture.PNG", "WizardCardCrumbTex0.PNG", "WizCardDodderidgeBigTexture.PNG", "WizardCardDodderidgeTex0.PNG", "WizCardDukeBigTexture.PNG", "WizardCardDukeTex0.PNG",
                     "WizCardDumbledoreBigTexture.PNG", "WizCardAlbusBigTextureLayer0.PNG", "WizCardAlbusBigTextureLayer1.PNG", "WizCardAlbusBigTextureLayer2.PNG", "WizardCardDumbledoreTex0.PNG",
                     "WizCardElphickBigTexture.PNG", "WizardCardElphickTex0.PNG", "WizCardEthelredBigTexture.PNG", "WizardCardEthelredTex0.PNG", "WizCardFancourtBigTexture.PNG", "WizardCardFancourtTex0.PNG",
                     "WizCardFayBigTexture.PNG", "WizardCardFayTex0.PNG", "WizCardFulbertBigTexture.PNG", "WizardCardFulbertTex0.PNG", "WizCardFurmageBigTexture.PNG", "WizardCardFurmageTex0.PNG",
                     "WizCardGoshawkBigTexture.PNG", "WizardCardGoshawkTex0.PNG", "WizCardGravesBigTexture.PNG", "WizardCardGravesTex0.PNG", "WizCardGregoryBigTexture.PNG", "WizardCardGregoryTex0.PNG",
                     "WizCardGrunnionBigTexture.PNG", "WizardCardGrunnionTex0.PNG", "WizCardGryffindorBigTexture.PNG", "WizardCardGryffindorTex0.PNG", "WizCardGunhildaBigTexture.PNG", "WizardCardGunhildaTex0.PNG",
                     "WizCardHerpoBigTexture.PNG", "WizCardHerpoBigTextureLayer0.PNG", "WizCardHerpoBigTextureLayer1.PNG", "WizCardHerpoBigTextureLayer2.PNG", "WizardCardHerpoTex0.PNG",
                     "WizCardHipworthBigTexture.PNG", "WizardCardHipworthTex0.PNG", "WizCardHufflepuffBigTexture.PNG", "WizCardHelgaBigTextureLayer0.PNG", "WizCardHelgaBigTextureLayer1.PNG", "WizCardHelgaBigTextureLayer2.PNG", "WizardCardHufflepuffTex0.PNG",
                     "WizCardJonesBigTexture.PNG", "WizardCardJonesTex0.PNG", "WizCardKeggBigTexture.PNG", "WizardCardKeggTex0.PNG", "WizCardKetteridgeBigTexture.PNG", "WizardCardKetteridgeTex0.PNG",
                     "WizCardKnightleyBigTexture.PNG", "WizCardMontagueBigTextureLayer0.PNG", "WizCardMontagueBigTextureLayer1.PNG", "WizCardMontagueBigTextureLayer2.PNG", "WizardCardKnightleyTex0.PNG",
                     "WizCardLufkinBigTexture.PNG", "WizardCardLufkinTex0.PNG", "WizCardMaeveBigTexture.PNG", "WizardCardMaeveTex0.PNG", "WizCardMarjoribanksBigTexture.PNG", "WizardCardMarjoribanksTex0.PNG",
                     "WizCardMerlinBigTexture.PNG", "WizardCardMerlinTex0.PNG", "WizCardMerwynBigTexture.PNG", "WizardCardMerwynTex0.PNG", "WizCardMontmorencyBigTexture.PNG", "WizardCardMontmorencyTex0.PNG",
                     "WizCardMopsusBigTexture.PNG", "WizardCardMopsusTex0.PNG", "WizCardMuldoonBigTexture.PNG", "WizardCardMuldoonTex0.PNG", "WizCardNutcombeBigTexture.PNG", "WizardCardNutcombeTex0.PNG",
                     "WizCardOglethorpeBigTexture.PNG", "WizardCardOglethorpeTex0.PNG", "WizCardOldridgeBigTexture.PNG", "WizardCardOldridgeTex0.PNG", "WizCardOliphantBigTexture.PNG", "WizardCardOliphantTex0.PNG",
                     "WizCardOllertonBigTexture.PNG", "WizardCardOllertonTex0.PNG", "WizCardParacelsusBigTexture.PNG", "WizardCardParacelsusTex0.PNG", "WizCardPeakesBigTexture.PNG", "WizardCardPeakesTex0.PNG",
                     "WizCardPilliwickleBigTexture.PNG", "WizardCardPilliwickleTex0.PNG", "WizCardPinkstoneBigTexture.PNG", "WizCardCarlottaBigTextureLayer0.PNG", "WizCardCarlottaBigTextureLayer1.PNG", "WizCardCarlottaBigTextureLayer2.PNG", "WizardCardPinkstoneTex0.PNG",
                     "WizCardPlattBigTexture.PNG", "WizardCardPlattTex0.PNG", "WizCardPlumptonBigTexture.PNG", "WizardCardPlumptonTex0.PNG", "WizCardPlunkettBigTexture.PNG", "WizardCardPlunkettTex0.PNG",
                     "WizCardPoBigTexture.PNG", "WizardCardPoTex0.PNG", "WizCardPokebyBigTexture.PNG", "WizardCardPokebyTex0.PNG",
                     "WizCardPotterBigTexture.PNG", "WizCardHarryBigTextureLayer0.PNG", "WizCardHarryBigTextureLayer1.PNG", "WizCardHarryBigTextureLayer2.PNG", "WizardCardPotterTex0.PNG",
                     "WizCardRastrickBigTexture.PNG", "WizardCardRastrickTex0.PNG", "WizCardRavenclawBigTexture.PNG", "WizCardRowenaBigTextureLayer0.PNG", "WizCardRowenaBigTextureLayer1.PNG", "WizCardRowenaBigTextureLayer2.PNG", "WizardCardRavenclawTex0.PNG",
                     "WizCardSawbridgeBigTexture.PNG", "WizardCardSawbridgeTex0.PNG", "WizCardScamanderBigTexture.PNG", "WizardCardScamanderTex0.PNG", "WizCardShimplingBigTexture.PNG", "WizardCardShimplingTex0.PNG",
                     "WizCardShingletonBigTexture.PNG", "WizardCardShingletonTex0.PNG", "WizCardSlytherinBigTexture.PNG", "WizardCardSlytherinTex0.PNG", "WizCardSmethwyckBigTexture.PNG", "WizardCardSmethwyckTex0.PNG",
                     "WizCardStalkBigTexture.PNG", "WizardCardStalkTex0.PNG", "WizCardStarkeyBigTexture.PNG", "WizardCardStarkeyTex0.PNG", "WizCardStroulgerBigTexture.PNG", "WizardCardStroulgerTex0.PNG",
                     "WizCardStumpBigTexture.PNG", "WizardCardStumpTex0.PNG", "WizCardSummerbeeBigTexture.PNG", "WizardCardSummerbeeTex0.PNG", "WizCardSweetingBigTexture.PNG", "WizardCardSweetingTex0.PNG",
                     "WizCardSykesBigTexture.PNG", "WizardCardSykesTex0.PNG", "WizCardThrustonBigTexture.PNG", "WizardCardThrustonTex0.PNG", "WizCardThurkellBigTexture.PNG", "WizardCardThurkellTex0.PNG",
                     "WizCardTokeBigTexture.PNG", "WizardCardTokeTex0.PNG", "WizCardToothillBigTexture.PNG", "WizardCardToothillTex0.PNG", "WizCardTremlettBigTexture.PNG", "WizardCardTremlettTex0.PNG",
                     "WizCardTugwoodBigTexture.PNG", "WizardCardTugwoodTex0.PNG", "WizCardTwonkBigTexture.PNG", "WizardCardTwonkTex0.PNG", "WizCardUricBigTexture.PNG", "WizardCardUricTex0.PNG",
                     "WizCardVablatskyBigTexture.PNG", "WizardCardVablatskyTex0.PNG", "WizCardWadcockBigTexture.PNG", "WizardCardWadcockTex0.PNG", "WizCardWafflingBigTexture.PNG", "WizardCardWafflingTex0.PNG",
                     "WizCardWagtailBigTexture.PNG", "WizardCardWagtailTex0.PNG", "WizCardWarbeckBigTexture.PNG", "WizardCardWarbeckTex0.PNG", "WizCardWellbelovedBigTexture.PNG", "WizardCardWellbelovedTex0.PNG",
                     "WizCardWendelinBigTexture.PNG", "WizardCardWendelinTex0.PNG", "WizCardWenlockBigTexture.PNG", "WizardCardWenlockTex0.PNG", "WizCardWhitehornBigTexture.PNG", "WizardCardWhitehornTex0.PNG",
                     "WizCardWildsmithBigTexture.PNG", "WizardCardWildsmithTex0.PNG", "WizCardWintringhamBigTexture.PNG", "WizardCardWintringhamTex0.PNG", "WizCardWithersBigTexture.PNG", "WizardCardWithersTex0.PNG",
                     "WizCardWoodcroftBigTexture.PNG", "WizardCardWoodcroftTex0.PNG", "WizCardWrightBigTexture.PNG", "WizardCardWrightTex0.PNG", "WizCardYoudleBigTexture.PNG", "WizardCardYoudleTex0.PNG"
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
        texExcludeWizCard.append("Texture" + str(i) + ".PNG"); #do the same for the wizard card array -AdamJD

    # Metallicafan212: We need to loop over the textures folder
    for subdir, dirs, files in os.walk("Textures"):
        for file in files:
            # Metallicafan212: Check if it's in the array
            if(not file in texExclude
               and not file in texExcludeWizCard): #also check if it's in the wizard card array -AdamJD
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
