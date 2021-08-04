//================================================================================
// GoldCardTimerManager.
//================================================================================

class GoldCardTimerManager extends CountdownTimerManager;

const strFULL_BAR= "HP2_Menu.Icon.HP2GoldCardTimerFull";
const strTIMER_EMPTY= "HP2_Menu.Icon.HP2GoldCardTimerEmpty";

function LoadTimerBarGraphics()
{
  fFULL_OFFSET_X = 55.0;
  fFULL_OFFSET_Y = 22.0;
  textureTimerEmpty = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2GoldCardTimerEmpty",Class'Texture'));
  textureFullBar = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2GoldCardTimerFull",Class'Texture'));
}

defaultproperties
{
    CutName="GoldCardTimerManager"

}
