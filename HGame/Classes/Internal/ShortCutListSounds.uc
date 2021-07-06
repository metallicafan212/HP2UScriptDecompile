//================================================================================
// ShortCutListSounds.
//================================================================================

class ShortCutListSounds extends ShortCutList;

var string MasterList[1500];
var string status[1500];
var string MasterText[1500];
var int MasterCount;
const MAX_ROWS= 1500;

function Created()
{
  Super.Created();
  RowHeight = 12.0;
  bShowHorizSB = True;
  AddColumn(" Index",28.0);
  AddColumn(" Status",32.0);
  AddColumn(" Name",80.0);
  AddColumn(" Description",1024.0);
  NumRows = 0;
  Reset();
}

function Reset()
{
  local string Text;
  local Sound Sound;
  local int I;

  NumRows = MasterCount;
  // I = 0;
  // if ( I < NumRows )
  for(I = 0; I < NumRows; I++)
  {
    if ( MasterText[I] == "" )
    {
      status[I] = "NOTXT";
    } else {
      if ( Sound == None )
      {
        status[I] = "NOSND";
      } else {
        status[I] = "OK";
      }
    }
    // I++;
    // goto JL0012;
  }
}

function LaunchShortcut (int Row)
{
}

function PaintColumn (Canvas C, UWindowGridColumn Column, float MouseX, float MouseY)
{
  local int TopMargin;
  local int BottomMargin;
  local int NumRowsVisible;
  local int CurRow;
  local int CurOffset;
  local int LastRow;

  if ( bShowHorizSB )
  {
    BottomMargin = LookAndFeel.Size_ScrollbarWidth;
  }
  else 
  {
    BottomMargin = 0;
  }
  TopMargin = LookAndFeel.ColumnHeadingHeight;
  NumRowsVisible = (WinHeight - (TopMargin + BottomMargin)) / RowHeight;
  VertSB.SetRange(0, NumRows, NumRowsVisible);
  CurRow = VertSB.Pos;
  LastRow = CurRow + NumRowsVisible;
  if ( LastRow > NumRows )
  {
    LastRow = NumRows;
  }
  CurOffset = 0;
  C.DrawColor.G = 255;
  // if ( CurRow < LastRow )
  while ( CurRow < LastRow )
  {
    if ( CurRow == SelectedRow )
    {
      C.DrawColor.R = 0;
      C.DrawColor.B = 0;
    } else {
      C.DrawColor.R = 255;
      C.DrawColor.B = 255;
    }
    switch (Column.ColumnNum)
    {
      case 0:
      Column.ClipText(C,2.0,TopMargin + CurOffset,CurRow);
      break;
      case 1:
      Column.ClipText(C,2.0,TopMargin + CurOffset,status[CurRow]);
      break;
      case 2:
      Column.ClipText(C,2.0,TopMargin + CurOffset,MasterList[CurRow]);
      break;
      case 3:
      Column.ClipText(C,2.0,TopMargin + CurOffset,MasterText[CurRow]);
      break;
      default:
    }
    CurOffset += RowHeight;
	++CurRow;
    // goto JL00DF;
  }
}

function MouseMove (float X, float Y)
{
  if ( bMouseDown )
  {
    HPConsole(Root.Console).Viewport.Actor.ClientMessage("mmove " $ string(X) $ " " $ string(Y));
    SelectedRow = VertSB.Pos;
    // There are 1 jump destination(s) inside the last statement!
  }
  
  Super.MouseMove(X,Y);
}

function SortColumn (UWindowGridColumn Column)
{
}

defaultproperties
{
    MasterList(0)="111DumbledoreInfo1"

    MasterList(1)="111DumbledoreInfo2"

    MasterList(2)="111DumbledoreInfo3"

    MasterList(3)="111DumbledoreInfo4"

    MasterList(4)="111DumbledoreInfo6"

    MasterList(5)="111DumbledoreInfo7"

    MasterList(6)="111DumbledoreInfo8"

    MasterList(7)="111Fred&George11"

    MasterList(8)="111HermioneInfo1"

    MasterList(9)="111MalfoyBlocker1"

    MasterList(10)="111MalfoyBlocker2"

    MasterList(11)="111MalfoyBlocker3"

    MasterList(12)="111MalfoyBlocker4"

    MasterList(13)="111Peeves1"

    MasterList(14)="111Peeves2"

    MasterList(15)="111Peeves3"

    MasterList(16)="111Peeves4"

    MasterList(17)="111Peeves5"

    MasterList(18)="111Peeves7"

    MasterList(19)="111RonandHerm1"

    MasterList(20)="111RonandHerm4"

    MasterList(21)="111RonInfo7"

    MasterList(22)="111StudentBoy1"

    MasterList(23)="111StudentBoy15"

    MasterList(24)="111StudentBoy22"

    MasterList(25)="111StudentBoy24"

    MasterList(26)="111StudentBoySeamus1"

    MasterList(27)="111StudentBoySeamus4"

    MasterList(28)="111StudentBoySeamus5"

    MasterList(29)="111StudentBoySeamus6"

    MasterList(30)="111studentgirlginger2"

    MasterList(31)="111studentgirlginger3"

    MasterList(32)="111TalkingBook8"

    MasterList(33)="112MalfoyInfo1"

    MasterList(34)="112MalfoyInfo2"

    MasterList(35)="112NickB5"

    MasterList(36)="112NickSnails5"

    MasterList(37)="112RonRoom21"

    MasterList(38)="113Hooch_Emotives1"

    MasterList(39)="113Hooch_Emotives2"

    MasterList(40)="113Hooch_Emotives3"

    MasterList(41)="113MadameHooch_Harry_Returns3"

    MasterList(42)="114FlitwickLate6"

    MasterList(43)="114FlitwickLate7"

    MasterList(44)="116Crabbe1"

    MasterList(45)="116Goyle1"

    MasterList(46)="116MalfoyA4"

    MasterList(47)="116MalfoyD1"

    MasterList(48)="119StudentInfo3"

    MasterList(49)="121HagridA1"

    MasterList(50)="121HagridA2"

    MasterList(51)="121HagridB1"

    MasterList(52)="121HagridB6"

    MasterList(53)="121HagridC1"

    MasterList(54)="121HagridC2"

    MasterList(55)="121HagridC3"

    MasterList(56)="121HagridE7"

    MasterList(57)="121Hermione1"

    MasterList(58)="121McGonogal1"

    MasterList(59)="121McGonogal2"

    MasterList(60)="121McGonogal3"

    MasterList(61)="121Neville3"

    MasterList(62)="121Neville4"

    MasterList(63)="121Neville6"

    MasterList(64)="121NevilleA1"

    MasterList(65)="121NevilleA2"

    MasterList(66)="121NevilleA3"

    MasterList(67)="121NevilleA4"

    MasterList(68)="121NevilleB1"

    MasterList(69)="121NevilleB3"

    MasterList(70)="121NevilleB4"

    MasterList(71)="121RonA5"

    MasterList(72)="121RonE1"

    MasterList(73)="121RonE2"

    MasterList(74)="121Weasley6"

    MasterList(75)="124Hagrid1"

    MasterList(76)="124Hagrid10"

    MasterList(77)="124Hagrid11"

    MasterList(78)="124Hagrid2"

    MasterList(79)="124Hagrid3"

    MasterList(80)="124Hagrid4"

    MasterList(81)="124Hagrid5"

    MasterList(82)="124Hagrid7"

    MasterList(83)="124Hagrid8"

    MasterList(84)="124Hagrid9"

    MasterList(85)="124HagridB3"

    MasterList(86)="124HagridB4"

    MasterList(87)="124HagridB8"

    MasterList(88)="124HagridB9"

    MasterList(89)="125DracoMalfoy_Intro1"

    MasterList(90)="125DracoMalfoy_Intro10"

    MasterList(91)="125DracoMalfoy_Intro2"

    MasterList(92)="125DracoMalfoy_Intro4"

    MasterList(93)="125DracoMalfoy_Intro6"

    MasterList(94)="125DracoMalfoy_Intro7"

    MasterList(95)="125DracoMalfoy_Intro9"

    MasterList(96)="125DracoMalfoy_Outro1"

    MasterList(97)="125DracoMalfoy_Outro2"

    MasterList(98)="125DracoMalfoy_Outro3"

    MasterList(99)="125Malfoy_Emotives1"

    MasterList(100)="125Malfoy_Emotives2"

    MasterList(101)="125Malfoy_Emotives3"

    MasterList(102)="127commentary1"

    MasterList(103)="127commentary10"

    MasterList(104)="127Commentary100"

    MasterList(105)="127Commentary100"

    MasterList(106)="127Commentary101"

    MasterList(107)="127Commentary101"

    MasterList(108)="127Commentary102"

    MasterList(109)="127Commentary102"

    MasterList(110)="127Commentary103"

    MasterList(111)="127Commentary104"

    MasterList(112)="127Commentary105"

    MasterList(113)="127Commentary106"

    MasterList(114)="127Commentary107"

    MasterList(115)="127Commentary108"

    MasterList(116)="127Commentary109"

    MasterList(117)="127commentary11"

    MasterList(118)="127Commentary110"

    MasterList(119)="127Commentary111"

    MasterList(120)="127Commentary112"

    MasterList(121)="127Commentary113"

    MasterList(122)="127Commentary114"

    MasterList(123)="127Commentary115"

    MasterList(124)="127Commentary116"

    MasterList(125)="127commentary12"

    MasterList(126)="127commentary13"

    MasterList(127)="127commentary14"

    MasterList(128)="127commentary15"

    MasterList(129)="127commentary16"

    MasterList(130)="127commentary17"

    MasterList(131)="127commentary18"

    MasterList(132)="127commentary19"

    MasterList(133)="127commentary2"

    MasterList(134)="127commentary20"

    MasterList(135)="127commentary21"

    MasterList(136)="127commentary22"

    MasterList(137)="127commentary23"

    MasterList(138)="127commentary24"

    MasterList(139)="127commentary25"

    MasterList(140)="127commentary26"

    MasterList(141)="127commentary27"

    MasterList(142)="127commentary28"

    MasterList(143)="127commentary29"

    MasterList(144)="127commentary3"

    MasterList(145)="127commentary30"

    MasterList(146)="127commentary31"

    MasterList(147)="127commentary32"

    MasterList(148)="127commentary33"

    MasterList(149)="127commentary34"

    MasterList(150)="127commentary35"

    MasterList(151)="127commentary36"

    MasterList(152)="127commentary37"

    MasterList(153)="127commentary38"

    MasterList(154)="127commentary39"

    MasterList(155)="127commentary4"

    MasterList(156)="127commentary40"

    MasterList(157)="127commentary41"

    MasterList(158)="127commentary42"

    MasterList(159)="127commentary43"

    MasterList(160)="127commentary44"

    MasterList(161)="127commentary45"

    MasterList(162)="127commentary46"

    MasterList(163)="127commentary47"

    MasterList(164)="127commentary48"

    MasterList(165)="127commentary49"

    MasterList(166)="127commentary5"

    MasterList(167)="127commentary50"

    MasterList(168)="127commentary51"

    MasterList(169)="127commentary52"

    MasterList(170)="127commentary53"

    MasterList(171)="127commentary54"

    MasterList(172)="127commentary55"

    MasterList(173)="127commentary56"

    MasterList(174)="127commentary57"

    MasterList(175)="127commentary58"

    MasterList(176)="127commentary59"

    MasterList(177)="127commentary6"

    MasterList(178)="127commentary60"

    MasterList(179)="127commentary61"

    MasterList(180)="127commentary62"

    MasterList(181)="127commentary63"

    MasterList(182)="127commentary64"

    MasterList(183)="127commentary65"

    MasterList(184)="127commentary66"

    MasterList(185)="127commentary67"

    MasterList(186)="127commentary68"

    MasterList(187)="127commentary69"

    MasterList(188)="127commentary7"

    MasterList(189)="127commentary70"

    MasterList(190)="127commentary71"

    MasterList(191)="127commentary72"

    MasterList(192)="127commentary73"

    MasterList(193)="127commentary74"

    MasterList(194)="127commentary75"

    MasterList(195)="127commentary76"

    MasterList(196)="127commentary77"

    MasterList(197)="127commentary78"

    MasterList(198)="127commentary79"

    MasterList(199)="127commentary8"

    MasterList(200)="127commentary80"

    MasterList(201)="127commentary81"

    MasterList(202)="127commentary82"

    MasterList(203)="127commentary83"

    MasterList(204)="127commentary84"

    MasterList(205)="127commentary85"

    MasterList(206)="127commentary86"

    MasterList(207)="127commentary87"

    MasterList(208)="127commentary88"

    MasterList(209)="127commentary89"

    MasterList(210)="127commentary9"

    MasterList(211)="127commentary90"

    MasterList(212)="127commentary91"

    MasterList(213)="127commentary92"

    MasterList(214)="127commentary93"

    MasterList(215)="127commentary94"

    MasterList(216)="127Commentary95"

    MasterList(217)="127Commentary96"

    MasterList(218)="127Commentary97"

    MasterList(219)="127Commentary98"

    MasterList(220)="127Commentary99"

    MasterList(221)="127Harry1"

    MasterList(222)="127Harry2"

    MasterList(223)="127Harry3"

    MasterList(224)="127Harry4"

    MasterList(225)="127Harry5"

    MasterList(226)="127Harry6"

    MasterList(227)="127Harry7"

    MasterList(228)="127LeeJordan1"

    MasterList(229)="127LeeJordan10"

    MasterList(230)="127LeeJordan11"

    MasterList(231)="127LeeJordan12"

    MasterList(232)="127LeeJordan13"

    MasterList(233)="127LeeJordan14"

    MasterList(234)="127LeeJordan15"

    MasterList(235)="127LeeJordan16"

    MasterList(236)="127LeeJordan2"

    MasterList(237)="127LeeJordan3"

    MasterList(238)="127LeeJordan4"

    MasterList(239)="127LeeJordan5"

    MasterList(240)="127LeeJordan6"

    MasterList(241)="127LeeJordan7"

    MasterList(242)="127LeeJordan8"

    MasterList(243)="127LeeJordan9"

    MasterList(244)="127Outro1"

    MasterList(245)="131HermioneB1"

    MasterList(246)="131HermioneB2"

    MasterList(247)="131HermioneB3"

    MasterList(248)="131HermioneB4"

    MasterList(249)="131HermioneB5"

    MasterList(250)="131Nick9"

    MasterList(251)="131Peeves1"

    MasterList(252)="131StudentGirl6"

    MasterList(253)="135BackNForward4"

    MasterList(254)="135Comingback7"

    MasterList(255)="135Extra1"

    MasterList(256)="135Extra2"

    MasterList(257)="135Extra3"

    MasterList(258)="135Extra4"

    MasterList(259)="135Extra5"

    MasterList(260)="135Extra6"

    MasterList(261)="135Extra7"

    MasterList(262)="135Extra8"

    MasterList(263)="135QT3"

    MasterList(264)="135QT4"

    MasterList(265)="135QTsection31"

    MasterList(266)="135QTsection32"

    MasterList(267)="135Welcome1"

    MasterList(268)="141HermioneC2"

    MasterList(269)="141InvisibilityNote1"

    MasterList(270)="141RonA2"

    MasterList(271)="141RonA3"

    MasterList(272)="141RonA4"

    MasterList(273)="141RonB4"

    MasterList(274)="141RonC1"

    MasterList(275)="141RonC2"

    MasterList(276)="141Student1"

    MasterList(277)="142FilchB2"

    MasterList(278)="142FilchB3"

    MasterList(279)="142FilchB4"

    MasterList(280)="142FilchB8"

    MasterList(281)="142FilchC2"

    MasterList(282)="142FilchC3"

    MasterList(283)="142FilchC4"

    MasterList(284)="142FilchC5"

    MasterList(285)="142FilchC6"

    MasterList(286)="142FilchD1"

    MasterList(287)="142FilchD2"

    MasterList(288)="142FilchD3"

    MasterList(289)="142FilchD4"

    MasterList(290)="144Herm_Ron2"

    MasterList(291)="144Ron2"

    MasterList(292)="144RonB2"

    MasterList(293)="144RonB4"

    MasterList(294)="144RonC1"

    MasterList(295)="145Herm_Ron2"

    MasterList(296)="145Herm_Ron3"

    MasterList(297)="145Herm_Ron5"

    MasterList(298)="145Herm_Ron6"

    MasterList(299)="145Herm_RonDS1"

    MasterList(300)="145Herm_RonDS12"

    MasterList(301)="145Herm_RonDS3"

    MasterList(302)="145Herm_RonDS4"

    MasterList(303)="145Herm_RonDS5"

    MasterList(304)="145Herm_RonDS6"

    MasterList(305)="145Herm_RonDS7"

    MasterList(306)="145Herm_RonDS9"

    MasterList(307)="145Herm_RonKeys1"

    MasterList(308)="145Herm_RonKeys2"

    MasterList(309)="146Herm_RonChess1"

    MasterList(310)="146Herm_RonChess2"

    MasterList(311)="146Herm_RonChess23"

    MasterList(312)="146Herm_RonChess24"

    MasterList(313)="146Herm_RonChess25"

    MasterList(314)="146Herm_RonChess26"

    MasterList(315)="146Herm_RonChess27"

    MasterList(316)="146Herm_RonChess28"

    MasterList(317)="146Herm_RonChess3"

    MasterList(318)="146Herm_RonTroll4"

    MasterList(319)="146HermChessDone1"

    MasterList(320)="146HermPotions4"

    MasterList(321)="147Quirrel11"

    MasterList(322)="147Quirrel12"

    MasterList(323)="147Quirrel14"

    MasterList(324)="147Quirrel15"

    MasterList(325)="147Quirrel16"

    MasterList(326)="147QuirrelEnd1"

    MasterList(327)="147QuirrelEnd2"

    MasterList(328)="147QuirrelExtra1"

    MasterList(329)="147QuirrelExtra2"

    MasterList(330)="147QuirrelMid1"

    MasterList(331)="147QuirrelMid2"

    MasterList(332)="147QuirrelMisc1"

    MasterList(333)="147QuirrelMisc10"

    MasterList(334)="147QuirrelMisc11"

    MasterList(335)="147QuirrelMisc12"

    MasterList(336)="147QuirrelMisc13"

    MasterList(337)="147QuirrelMisc2"

    MasterList(338)="147QuirrelMisc3"

    MasterList(339)="147QuirrelMisc4"

    MasterList(340)="147QuirrelMisc5"

    MasterList(341)="147QuirrelMisc6"

    MasterList(342)="147QuirrelMisc7"

    MasterList(343)="147QuirrelMisc8"

    MasterList(344)="147QuirrelMisc9"

    MasterList(345)="147Voldemort1"

    MasterList(346)="147Voldemort2"

    MasterList(347)="147Voldemort3"

    MasterList(348)="147Voldemort4"

    MasterList(349)="147Voldemort5"

    MasterList(350)="147Voldermort11"

    MasterList(351)="147Voldermort12"

    MasterList(352)="147Voldermort13"

    MasterList(353)="147Voldermort14"

    MasterList(354)="147Voldermort15"

    MasterList(355)="147Voldermort16"

    MasterList(356)="147Voldermort21"

    MasterList(357)="147Voldermort22"

    MasterList(358)="147Voldermort23"

    MasterList(359)="147Voldermort24"

    MasterList(360)="147Voldermort31"

    MasterList(361)="BlankDumbledore2"

    MasterList(362)="BlankHagrid3"

    MasterList(363)="BlankHermione3"

    MasterList(364)="BlankHermione7"

    MasterList(365)="BlankHermione8"

    MasterList(366)="BlankPeeves1"

    MasterList(367)="BlankPeeves4"

    MasterList(368)="BlankRon1"

    MasterList(369)="BlankRon2"

    MasterList(370)="BlankRon3"

    MasterList(371)="BlankRon4"

    MasterList(372)="BlankVoldermort1"

    MasterList(373)="BlankVoldermort2"

    MasterList(374)="BlankVoldermort3"

    MasterList(375)="BlankVoldermort4"

    MasterList(376)="crabbe1"

    MasterList(377)="crabbe2"

    MasterList(378)="DUMBLEDORE_01"

    MasterList(379)="DUMBLEDORE_02"

    MasterList(380)="EmotiveDracoMalfoy11"

    MasterList(381)="EmotiveDracoMalfoy12"

    MasterList(382)="EmotiveDracoMalfoy13"

    MasterList(383)="EmotiveDracoMalfoy14"

    MasterList(384)="EmotiveFilch19"

    MasterList(385)="EmotiveFilch20"

    MasterList(386)="EmotiveFilch21"

    MasterList(387)="EmotiveFilch22"

    MasterList(388)="EmotiveFilch31"

    MasterList(389)="EmotiveFilch32"

    MasterList(390)="EmotiveFilch33"

    MasterList(391)="EmotiveFilch34"

    MasterList(392)="EmotiveFilch35"

    MasterList(393)="EmotiveFilch36"

    MasterList(394)="EmotiveFilch37"

    MasterList(395)="EmotiveFilch38"

    MasterList(396)="EmotiveFlitwick19"

    MasterList(397)="EmotiveFlitwick20"

    MasterList(398)="EmotiveFlitwick21"

    MasterList(399)="EmotiveFlitwick22"

    MasterList(400)="EmotiveFlitwick31"

    MasterList(401)="EmotiveFlitwick32"

    MasterList(402)="EmotiveFlitwick33"

    MasterList(403)="EmotiveFlitwick34"

    MasterList(404)="EmotiveHagrid35"

    MasterList(405)="EmotiveHagrid36"

    MasterList(406)="EmotiveHagrid37"

    MasterList(407)="EmotiveHagrid38"

    MasterList(408)="EmotiveHarry1"

    MasterList(409)="EmotiveHarry10"

    MasterList(410)="EmotiveHarry11"

    MasterList(411)="EmotiveHarry11"

    MasterList(412)="EmotiveHarry12"

    MasterList(413)="EmotiveHarry12"

    MasterList(414)="EmotiveHarry13"

    MasterList(415)="EmotiveHarry13"

    MasterList(416)="EmotiveHarry14"

    MasterList(417)="EmotiveHarry14"

    MasterList(418)="EmotiveHarry15"

    MasterList(419)="EmotiveHarry15"

    MasterList(420)="EmotiveHarry16"

    MasterList(421)="EmotiveHarry17"

    MasterList(422)="EmotiveHarry17"

    MasterList(423)="EmotiveHarry18"

    MasterList(424)="EmotiveHarry18"

    MasterList(425)="EmotiveHarry19"

    MasterList(426)="EmotiveHarry2"

    MasterList(427)="EmotiveHarry20"

    MasterList(428)="EmotiveHarry21"

    MasterList(429)="EmotiveHarry22"

    MasterList(430)="EmotiveHarry23"

    MasterList(431)="EmotiveHarry24"

    MasterList(432)="EmotiveHarry25"

    MasterList(433)="EmotiveHarry26"

    MasterList(434)="EmotiveHarry27"

    MasterList(435)="EmotiveHarry28"

    MasterList(436)="EmotiveHarry29"

    MasterList(437)="EmotiveHarry3"

    MasterList(438)="EmotiveHarry30"

    MasterList(439)="EmotiveHarry31"

    MasterList(440)="EmotiveHarry32"

    MasterList(441)="EmotiveHarry33"

    MasterList(442)="EmotiveHarry34"

    MasterList(443)="EmotiveHarry4"

    MasterList(444)="EmotiveHarry5"

    MasterList(445)="EmotiveHarry6"

    MasterList(446)="EmotiveHarry7"

    MasterList(447)="EmotiveHarry8"

    MasterList(448)="EmotiveHarry9"

    MasterList(449)="EmotiveHermione14"

    MasterList(450)="EmotiveHermione15"

    MasterList(451)="EmotiveHermione11"

    MasterList(452)="EmotivePeeves19"

    MasterList(453)="EmotivePeeves20"

    MasterList(454)="EmotivePeeves21"

    MasterList(455)="EmotivePeeves22"

    MasterList(456)="EmotivePeeves23"

    MasterList(457)="EmotivePeeves24"

    MasterList(458)="EmotivePeeves25"

    MasterList(459)="EmotivePeeves26"

    MasterList(460)="EmotivePeeves27"

    MasterList(461)="EmotivePeeves28"

    MasterList(462)="EmotivePeeves29"

    MasterList(463)="EmotivePeeves30"

    MasterList(464)="EmotivePeeves31"

    MasterList(465)="EmotivePeeves32"

    MasterList(466)="EmotivePeeves33"

    MasterList(467)="EmotivePeeves34"

    MasterList(468)="EmotivePeeves35"

    MasterList(469)="EmotivePeeves36"

    MasterList(470)="EmotivePeeves37"

    MasterList(471)="EmotivePeeves38"

    MasterList(472)="EmotiveQuirrel1"

    MasterList(473)="EmotiveQuirrel10"

    MasterList(474)="EmotiveQuirrel11"

    MasterList(475)="EmotiveQuirrel12"

    MasterList(476)="EmotiveQuirrel13"

    MasterList(477)="EmotiveQuirrel14"

    MasterList(478)="EmotiveQuirrel15"

    MasterList(479)="EmotiveQuirrel16"

    MasterList(480)="EmotiveQuirrel2"

    MasterList(481)="EmotiveQuirrel3"

    MasterList(482)="EmotiveQuirrel4"

    MasterList(483)="EmotiveQuirrel5"

    MasterList(484)="EmotiveQuirrel6"

    MasterList(485)="EmotiveQuirrel7"

    MasterList(486)="EmotiveQuirrel8"

    MasterList(487)="EmotiveQuirrel9"

    MasterList(488)="EmotiveRon1"

    MasterList(489)="EmotiveRon10"

    MasterList(490)="EmotiveRon19"

    MasterList(491)="EmotiveRon2"

    MasterList(492)="EmotiveRon20"

    MasterList(493)="EmotiveRon21"

    MasterList(494)="EmotiveRon22"

    MasterList(495)="EmotiveRon23"

    MasterList(496)="EmotiveRon24"

    MasterList(497)="EmotiveRon25"

    MasterList(498)="EmotiveRon26"

    MasterList(499)="EmotiveRon27"

    MasterList(500)="EmotiveRon28"

    MasterList(501)="EmotiveRon29"

    MasterList(502)="EmotiveRon3"

    MasterList(503)="EmotiveRon30"

    MasterList(504)="EmotiveRon31"

    MasterList(505)="EmotiveRon32"

    MasterList(506)="EmotiveRon33"

    MasterList(507)="EmotiveRon34"

    MasterList(508)="EmotiveRon35"

    MasterList(509)="EmotiveRon36"

    MasterList(510)="EmotiveRon37"

    MasterList(511)="EmotiveRon38"

    MasterList(512)="EmotiveRon4"

    MasterList(513)="EmotiveRon5"

    MasterList(514)="EmotiveRon6"

    MasterList(515)="EmotiveRon7"

    MasterList(516)="EmotiveRon8"

    MasterList(517)="EmotiveRon9"

    MasterList(518)="EmotiveSnape19"

    MasterList(519)="EmotiveSnape20"

    MasterList(520)="EmotiveSnape21"

    MasterList(521)="EmotiveSnape22"

    MasterList(522)="EmotiveSnape31"

    MasterList(523)="EmotiveSnape32"

    MasterList(524)="EmotiveSnape33"

    MasterList(525)="EmotiveSnape34"

    MasterList(526)="EmotiveSnape35"

    MasterList(527)="EmotiveSnape36"

    MasterList(528)="EmotiveSnape37"

    MasterList(529)="EmotiveSnape38"

    MasterList(530)="EmotiveVoldermort1"

    MasterList(531)="EmotiveVoldermort10"

    MasterList(532)="EmotiveVoldermort11"

    MasterList(533)="EmotiveVoldermort12"

    MasterList(534)="EmotiveVoldermort13"

    MasterList(535)="EmotiveVoldermort14"

    MasterList(536)="EmotiveVoldermort15"

    MasterList(537)="EmotiveVoldermort16"

    MasterList(538)="EmotiveVoldermort17"

    MasterList(539)="EmotiveVoldermort18"

    MasterList(540)="EmotiveVoldermort19"

    MasterList(541)="EmotiveVoldermort2"

    MasterList(542)="EmotiveVoldermort20"

    MasterList(543)="EmotiveVoldermort21"

    MasterList(544)="EmotiveVoldermort22"

    MasterList(545)="EmotiveVoldermort3"

    MasterList(546)="EmotiveVoldermort35"

    MasterList(547)="EmotiveVoldermort36"

    MasterList(548)="EmotiveVoldermort37"

    MasterList(549)="EmotiveVoldermort38"

    MasterList(550)="EmotiveVoldermort4"

    MasterList(551)="EmotiveVoldermort5"

    MasterList(552)="EmotiveVoldermort6"

    MasterList(553)="EmotiveVoldermort7"

    MasterList(554)="EmotiveVoldermort8"

    MasterList(555)="EmotiveVoldermort9"

    MasterList(556)="Extra42"

    MasterList(557)="Extra43"

    MasterList(558)="Extra44"

    MasterList(559)="Extra45"

    MasterList(560)="Extra46"

    MasterList(561)="Extra47"

    MasterList(562)="Extra48"

    MasterList(563)="Extra49"

    MasterList(564)="Extra50"

    MasterList(565)="Extra51"

    MasterList(566)="Extra52"

    MasterList(567)="FILCH_01"

    MasterList(568)="FILCH_02"

    MasterList(569)="FILCH_03"

    MasterList(570)="FILCH_04"

    MasterList(571)="FILCH_05"

    MasterList(572)="filch_sneak_10"

    MasterList(573)="filch_sneak_11"

    MasterList(574)="filch_sneak_2"

    MasterList(575)="filch_sneak_3"

    MasterList(576)="filch_sneak_4"

    MasterList(577)="filch_sneak_5"

    MasterList(578)="filch_sneak_6"

    MasterList(579)="filch_sneak_7"

    MasterList(580)="filch_sneak_8"

    MasterList(581)="filch_sneak_9"

    MasterList(582)="FLITWICK_001"

    MasterList(583)="FLITWICK_014"

    MasterList(584)="FLITWICK_015"

    MasterList(585)="FLITWICK_016"

    MasterList(586)="FLITWICK_017"

    MasterList(587)="FLITWICK_018"

    MasterList(588)="FLITWICK_019"

    MasterList(589)="FLITWICK_020"

    MasterList(590)="FLITWICK_021"

    MasterList(591)="FLITWICK_022"

    MasterList(592)="FLITWICK_064"

    MasterList(593)="FLITWICK_069"

    MasterList(594)="FLITWICK_070"

    MasterList(595)="FLITWICK_071"

    MasterList(596)="flitwick_chall_1"

    MasterList(597)="flitwick_chall_2"

    MasterList(598)="flitwick_chall_6"

    MasterList(599)="flitwick_lesson_15"

    MasterList(600)="flitwick_lesson_19"

    MasterList(601)="flitwick_lesson_20"

    MasterList(602)="flitwick_lesson_22"

    MasterList(603)="flitwick_lesson_23"

    MasterList(604)="flitwick_lesson_24"

    MasterList(605)="flitwick_lesson_32"

    MasterList(606)="flitwick_lesson_33"

    MasterList(607)="flitwick_lesson_37"

    MasterList(608)="flitwick_lesson_40"

    MasterList(609)="flitwick_lesson_43"

    MasterList(610)="flitwick_lesson_50"

    MasterList(611)="flitwick_lesson_53"

    MasterList(612)="flitwick_lesson_56"

    MasterList(613)="flitwick_lesson_59"

    MasterList(614)="FRED_GEORGE_001"

    MasterList(615)="FRED_GEORGE_002"

    MasterList(616)="FRED_GEORGE_003"

    MasterList(617)="FRED_GEORGE_004"

    MasterList(618)="FRED_GEORGE_005"

    MasterList(619)="FRED_GEORGE_006"

    MasterList(620)="FRED_GEORGE_007"

    MasterList(621)="FRED_GEORGE_009"

    MasterList(622)="FRED_GEORGE_010"

    MasterList(623)="FRED_GEORGE_011"

    MasterList(624)="FRED_GEORGE_012"

    MasterList(625)="FRED_GEORGE_013"

    MasterList(626)="FRED_GEORGE_014"

    MasterList(627)="FRED_GEORGE_015"

    MasterList(628)="FRED_GEORGE_016"

    MasterList(629)="FRED_GEORGE_017"

    MasterList(630)="FRED_GEORGE_019"

    MasterList(631)="fred_george_new_1"

    MasterList(632)="fred_george_new_10"

    MasterList(633)="fred_george_new_105"

    MasterList(634)="fred_george_new_106"

    MasterList(635)="fred_george_new_108"

    MasterList(636)="fred_george_new_109"

    MasterList(637)="fred_george_new_11"

    MasterList(638)="fred_george_new_112"

    MasterList(639)="fred_george_new_116"

    MasterList(640)="fred_george_new_121"

    MasterList(641)="fred_george_new_124"

    MasterList(642)="fred_george_new_126"

    MasterList(643)="fred_george_new_127"

    MasterList(644)="fred_george_new_128"

    MasterList(645)="fred_george_new_13"

    MasterList(646)="fred_george_new_133"

    MasterList(647)="fred_george_new_135"

    MasterList(648)="fred_george_new_139"

    MasterList(649)="fred_george_new_146"

    MasterList(650)="fred_george_new_147"

    MasterList(651)="fred_george_new_148"

    MasterList(652)="fred_george_new_149"

    MasterList(653)="fred_george_new_15"

    MasterList(654)="fred_george_new_150"

    MasterList(655)="fred_george_new_151"

    MasterList(656)="fred_george_new_153"

    MasterList(657)="fred_george_new_17"

    MasterList(658)="fred_george_new_24"

    MasterList(659)="fred_george_new_42"

    MasterList(660)="fred_george_new_49"

    MasterList(661)="fred_george_new_66"

    MasterList(662)="fred_george_new_67"

    MasterList(663)="fred_george_new_88"

    MasterList(664)="fred_george_new_93"

    MasterList(665)="fred_george_new_95"

    MasterList(666)="fred_george_new_96"

    MasterList(667)="goyle1"

    MasterList(668)="HAG_010"

    MasterList(669)="HAG_012"

    MasterList(670)="HAG_016"

    MasterList(671)="HAG_017"

    MasterList(672)="HAG_036"

    MasterList(673)="HAG_063"

    MasterList(674)="HAG_064"

    MasterList(675)="hagrid_seeds_1"

    MasterList(676)="hagrid_seeds_11"

    MasterList(677)="hagrid_seeds_12"

    MasterList(678)="hagrid_seeds_15"

    MasterList(679)="hagrid_seeds_16"

    MasterList(680)="hagrid_seeds_17"

    MasterList(681)="hagrid_seeds_18"

    MasterList(682)="hagrid_seeds_19"

    MasterList(683)="hagrid_seeds_20"

    MasterList(684)="hagrid_seeds_21"

    MasterList(685)="hagrid_seeds_22"

    MasterList(686)="hagrid_seeds_24"

    MasterList(687)="Hagrid_seeds_25"

    MasterList(688)="Hagrid_seeds_26"

    MasterList(689)="Hagrid_seeds_27"

    MasterList(690)="Hagrid_seeds_28"

    MasterList(691)="Hagrid_seeds_29"

    MasterList(692)="Hagrid_seeds_30"

    MasterList(693)="hagrid_seeds_8"

    MasterList(694)="hagrid_seeds_9"

    MasterList(695)="harry_1"

    MasterList(696)="harry_10"

    MasterList(697)="harry_100"

    MasterList(698)="harry_105"

    MasterList(699)="harry_107"

    MasterList(700)="harry_112"

    MasterList(701)="harry_114"

    MasterList(702)="harry_115"

    MasterList(703)="harry_118"

    MasterList(704)="harry_119"

    MasterList(705)="harry_12"

    MasterList(706)="harry_121"

    MasterList(707)="harry_122"

    MasterList(708)="harry_128"

    MasterList(709)="harry_131"

    MasterList(710)="harry_132"

    MasterList(711)="harry_133"

    MasterList(712)="harry_134"

    MasterList(713)="harry_135"

    MasterList(714)="harry_137"

    MasterList(715)="harry_138"

    MasterList(716)="harry_140"

    MasterList(717)="harry_141"

    MasterList(718)="harry_146"

    MasterList(719)="harry_147"

    MasterList(720)="harry_148"

    MasterList(721)="harry_149"

    MasterList(722)="harry_150"

    MasterList(723)="harry_156"

    MasterList(724)="harry_157"

    MasterList(725)="harry_158"

    MasterList(726)="harry_159"

    MasterList(727)="harry_167"

    MasterList(728)="harry_168"

    MasterList(729)="harry_170"

    MasterList(730)="harry_173"

    MasterList(731)="harry_174"

    MasterList(732)="harry_178"

    MasterList(733)="harry_180"

    MasterList(734)="harry_181"

    MasterList(735)="harry_182"

    MasterList(736)="harry_186"

    MasterList(737)="harry_187"

    MasterList(738)="harry_188"

    MasterList(739)="harry_189"

    MasterList(740)="harry_190"

    MasterList(741)="harry_193"

    MasterList(742)="harry_195"

    MasterList(743)="harry_196"

    MasterList(744)="harry_204"

    MasterList(745)="harry_205"

    MasterList(746)="harry_21"

    MasterList(747)="harry_210"

    MasterList(748)="harry_228"

    MasterList(749)="harry_230"

    MasterList(750)="harry_231"

    MasterList(751)="harry_232"

    MasterList(752)="harry_233"

    MasterList(753)="harry_239"

    MasterList(754)="harry_24"

    MasterList(755)="harry_240"

    MasterList(756)="harry_245"

    MasterList(757)="harry_25"

    MasterList(758)="harry_250"

    MasterList(759)="harry_26"

    MasterList(760)="harry_266"

    MasterList(761)="harry_267"

    MasterList(762)="harry_270"

    MasterList(763)="harry_271"

    MasterList(764)="harry_271b"

    MasterList(765)="harry_272"

    MasterList(766)="harry_273"

    MasterList(767)="harry_44"

    MasterList(768)="harry_45"

    MasterList(769)="harry_47"

    MasterList(770)="harry_48"

    MasterList(771)="harry_500"

    MasterList(772)="harry_501"

    MasterList(773)="harry_502"

    MasterList(774)="harry_503"

    MasterList(775)="harry_51"

    MasterList(776)="harry_54"

    MasterList(777)="harry_6"

    MasterList(778)="harry_63"

    MasterList(779)="harry_7"

    MasterList(780)="harry_71"

    MasterList(781)="harry_72"

    MasterList(782)="harry_75"

    MasterList(783)="harry_76"

    MasterList(784)="harry_77"

    MasterList(785)="harry_78"

    MasterList(786)="harry_79"

    MasterList(787)="harry_81"

    MasterList(788)="harry_86"

    MasterList(789)="harry_93"

    MasterList(790)="harry_96"

    MasterList(791)="harry_97"

    MasterList(792)="harry_98"

    MasterList(793)="harry_99"

    MasterList(794)="harry_dungeon_01"

    MasterList(795)="harry_dungeon_06"

    MasterList(796)="harry_dungeon_07"

    MasterList(797)="harry_dungeon_08"

    MasterList(798)="HERMIONE_002"

    MasterList(799)="HERMIONE_003"

    MasterList(800)="HERMIONE_004"

    MasterList(801)="HERMIONE_017"

    MasterList(802)="HERMIONE_018"

    MasterList(803)="HERMIONE_019"

    MasterList(804)="HERMIONE_020"

    MasterList(805)="HERMIONE_021"

    MasterList(806)="HERMIONE_024"

    MasterList(807)="HERMIONE_025"

    MasterList(808)="HERMIONE_026"

    MasterList(809)="HERMIONE_027"

    MasterList(810)="HERMIONE_028"

    MasterList(811)="HERMIONE_029"

    MasterList(812)="HERMIONE_030"

    MasterList(813)="HERMIONE_031"

    MasterList(814)="HERMIONE_032"

    MasterList(815)="HERMIONE_033"

    MasterList(816)="HERMIONE_034"

    MasterList(817)="HERMIONE_035"

    MasterList(818)="HERMIONE_036"

    MasterList(819)="HERMIONE_041"

    MasterList(820)="HERMIONE_042"

    MasterList(821)="HERMIONE_043"

    MasterList(822)="HERMIONE_044"

    MasterList(823)="HERMIONE_45"

    MasterList(824)="HERMIONE_46"

    MasterList(825)="HERMIONE_47"

    MasterList(826)="HERMIONE_51"

    MasterList(827)="HERMIONE_53"

    MasterList(828)="HERMIONE_54"

    MasterList(829)="HERMIONE_60"

    MasterList(830)="HERMIONE_62"

    MasterList(831)="HERMIONE_63"

    MasterList(832)="HERMIONE_64"

    MasterList(833)="HERMIONE_66"

    MasterList(834)="HERMIONE_68"

    MasterList(835)="hermione_chall_1"

    MasterList(836)="hermione_chall_3"

    MasterList(837)="hermione_chall_4"

    MasterList(838)="hermione_lesson_11"

    MasterList(839)="hermione_lesson_12"

    MasterList(840)="hermione_lesson_20"

    MasterList(841)="hermione_lesson_25"

    MasterList(842)="hermione_lesson_29"

    MasterList(843)="hermione_lesson_30"

    MasterList(844)="hermione_lesson_35"

    MasterList(845)="hermione_lesson_36"

    MasterList(846)="hermione_lesson_37"

    MasterList(847)="hermione_lesson_39"

    MasterList(848)="hermione_lesson_45"

    MasterList(849)="hermione_lesson_54"

    MasterList(850)="hermione_lesson_57"

    MasterList(851)="hermione_lesson_6"

    MasterList(852)="hermione_lesson_61"

    MasterList(853)="hermione_lesson_63"

    MasterList(854)="hermione_lesson_7"

    MasterList(855)="hermione_lesson_score_1"

    MasterList(856)="hermione_lesson_score_2"

    MasterList(857)="hermione_lesson_score_3"

    MasterList(858)="hermione_lesson_score_4"

    MasterList(859)="hermione_new_1"

    MasterList(860)="hermione_new_10"

    MasterList(861)="hermione_new_100"

    MasterList(862)="hermione_new_13"

    MasterList(863)="hermione_new_19"

    MasterList(864)="hermione_new_2"

    MasterList(865)="hermione_new_20"

    MasterList(866)="hermione_new_21"

    MasterList(867)="hermione_new_22"

    MasterList(868)="hermione_new_23"

    MasterList(869)="hermione_new_3"

    MasterList(870)="hermione_new_37"

    MasterList(871)="hermione_new_38"

    MasterList(872)="hermione_new_39"

    MasterList(873)="hermione_new_4"

    MasterList(874)="hermione_new_40"

    MasterList(875)="hermione_new_41"

    MasterList(876)="hermione_new_42"

    MasterList(877)="hermione_new_43"

    MasterList(878)="hermione_new_44"

    MasterList(879)="hermione_new_5"

    MasterList(880)="hermione_new_7"

    MasterList(881)="hermione_new_9"

    MasterList(882)="HOOCH_001"

    MasterList(883)="HOOCH_003"

    MasterList(884)="HOOCH_004"

    MasterList(885)="HOOCH_005"

    MasterList(886)="HOOCH_006"

    MasterList(887)="HOOCH_007"

    MasterList(888)="HOOCH_008"

    MasterList(889)="HOOCH_009"

    MasterList(890)="HOOCH_010"

    MasterList(891)="HOOCH_011"

    MasterList(892)="HOOCH_012"

    MasterList(893)="HOOCH_013"

    MasterList(894)="HOOCH_014"

    MasterList(895)="HOOCH_015"

    MasterList(896)="HOOCH_016"

    MasterList(897)="HOOCH_017"

    MasterList(898)="HOOCH_018"

    MasterList(899)="HOOCH_020"

    MasterList(900)="HOOCH_025"

    MasterList(901)="HOOCH_026"

    MasterList(902)="hootch_new_10"

    MasterList(903)="hootch_new_11"

    MasterList(904)="hootch_new_12"

    MasterList(905)="hootch_new_13"

    MasterList(906)="hootch_new_17"

    MasterList(907)="hootch_new_18"

    MasterList(908)="hootch_new_19"

    MasterList(909)="hootch_new_2"

    MasterList(910)="hootch_new_20"

    MasterList(911)="hootch_new_21"

    MasterList(912)="hootch_new_22"

    MasterList(913)="hootch_new_3"

    MasterList(914)="hootch_new_4"

    MasterList(915)="hootch_new_5"

    MasterList(916)="hootch_new_6"

    MasterList(917)="hootch_new_7"

    MasterList(918)="hootch_new_8"

    MasterList(919)="hootch_new_9"

    MasterList(920)="MALFOY_002"

    MasterList(921)="MALFOY_004"

    MasterList(922)="MALFOY_005"

    MasterList(923)="MALFOY_006"

    MasterList(924)="MALFOY_007"

    MasterList(925)="MALFOY_008"

    MasterList(926)="MALFOY_009"

    MasterList(927)="MALFOY_010"

    MasterList(928)="MALFOY_011"

    MasterList(929)="MALFOY_012"

    MasterList(930)="malfoy_int_1"

    MasterList(931)="malfoy_int_2"

    MasterList(932)="malfoy_int_3"

    MasterList(933)="malfoy_int_4"

    MasterList(934)="mcgonagall_new_1"

    MasterList(935)="mcgonagall_new_2"

    MasterList(936)="nearly_nick_11"

    MasterList(937)="nearly_nick_20"

    MasterList(938)="nearly_nick_21"

    MasterList(939)="nearly_nick_22"

    MasterList(940)="nearly_nick_23"

    MasterList(941)="nearly_nick_29"

    MasterList(942)="nearly_nick_30"

    MasterList(943)="nearly_nick_32"

    MasterList(944)="nearly_nick_34"

    MasterList(945)="nearly_nick_35"

    MasterList(946)="nearly_nick_36"

    MasterList(947)="nearly_nick_37"

    MasterList(948)="nearly_nick_38"

    MasterList(949)="nearly_nick_4"

    MasterList(950)="nearly_nick_40"

    MasterList(951)="neville_hall_1"

    MasterList(952)="neville_hall_10"

    MasterList(953)="neville_hall_12"

    MasterList(954)="neville_hall_13"

    MasterList(955)="neville_hall_3"

    MasterList(956)="neville_hall_4"

    MasterList(957)="neville_hall_5"

    MasterList(958)="neville_hall_6"

    MasterList(959)="neville_hall_7"

    MasterList(960)="neville_hall_8"

    MasterList(961)="neville_hall_9"

    MasterList(962)="New"

    MasterList(963)="P111Hermione10"

    MasterList(964)="P111Hermione11"

    MasterList(965)="P111Hermione12"

    MasterList(966)="P111Hermione9"

    MasterList(967)="PEEVES_001"

    MasterList(968)="PEEVES_002"

    MasterList(969)="peeves_new_1"

    MasterList(970)="peeves_new_6"

    MasterList(971)="peeves_new_7"

    MasterList(972)="prefect_new_10"

    MasterList(973)="prefect_new_11"

    MasterList(974)="prefect_new_12"

    MasterList(975)="prefect_new_13"

    MasterList(976)="prefect_new_14"

    MasterList(977)="prefect_new_15"

    MasterList(978)="prefect_new_16"

    MasterList(979)="prefect_new_17"

    MasterList(980)="prefect_new_18"

    MasterList(981)="prefect_new_20"

    MasterList(982)="prefect_new_21"

    MasterList(983)="prefect_new_22"

    MasterList(984)="prefect_new_4"

    MasterList(985)="prefect_new_6"

    MasterList(986)="prefect_new_7"

    MasterList(987)="quid_instructions"

    MasterList(988)="quidcom_1"

    MasterList(989)="quidcom_2"

    MasterList(990)="quidcom_3"

    MasterList(991)="quidcom_4"

    MasterList(992)="quidcom_5"

    MasterList(993)="Quirrel_barrel"

    MasterList(994)="QUIRRELL_001"

    MasterList(995)="QUIRRELL_014"

    MasterList(996)="QUIRRELL_015"

    MasterList(997)="QUIRRELL_016"

    MasterList(998)="QUIRRELL_017"

    MasterList(999)="QUIRRELL_018"

    MasterList(1000)="QUIRRELL_019"

    MasterList(1001)="QUIRRELL_020"

    MasterList(1002)="QUIRRELL_021"

    MasterList(1003)="QUIRRELL_022"

    MasterList(1004)="QUIRRELL_023"

    MasterList(1005)="QUIRRELL_024"

    MasterList(1006)="QUIRRELL_037"

    MasterList(1007)="QUIRRELL_038"

    MasterList(1008)="QUIRRELL_039"

    MasterList(1009)="QUIRRELL_040"

    MasterList(1010)="QUIRRELL_041"

    MasterList(1011)="QUIRRELL_042"

    MasterList(1012)="QUIRRELL_043"

    MasterList(1013)="quirrell_lesson_1"

    MasterList(1014)="quirrell_lesson_10"

    MasterList(1015)="quirrell_lesson_101"

    MasterList(1016)="quirrell_lesson_103"

    MasterList(1017)="quirrell_lesson_106"

    MasterList(1018)="quirrell_lesson_118"

    MasterList(1019)="quirrell_lesson_120"

    MasterList(1020)="quirrell_lesson_125"

    MasterList(1021)="quirrell_lesson_14"

    MasterList(1022)="quirrell_lesson_15"

    MasterList(1023)="quirrell_lesson_154"

    MasterList(1024)="quirrell_lesson_159"

    MasterList(1025)="quirrell_lesson_16"

    MasterList(1026)="quirrell_lesson_163"

    MasterList(1027)="quirrell_lesson_165"

    MasterList(1028)="quirrell_lesson_17"

    MasterList(1029)="quirrell_lesson_171"

    MasterList(1030)="quirrell_lesson_173"

    MasterList(1031)="quirrell_lesson_175"

    MasterList(1032)="quirrell_lesson_176"

    MasterList(1033)="quirrell_lesson_18"

    MasterList(1034)="quirrell_lesson_193"

    MasterList(1035)="quirrell_lesson_195"

    MasterList(1036)="quirrell_lesson_2"

    MasterList(1037)="quirrell_lesson_20"

    MasterList(1038)="quirrell_lesson_23"

    MasterList(1039)="quirrell_lesson_25"

    MasterList(1040)="quirrell_lesson_28"

    MasterList(1041)="quirrell_lesson_29"

    MasterList(1042)="quirrell_lesson_3"

    MasterList(1043)="quirrell_lesson_30"

    MasterList(1044)="quirrell_lesson_31"

    MasterList(1045)="quirrell_lesson_32"

    MasterList(1046)="quirrell_lesson_34"

    MasterList(1047)="quirrell_lesson_4"

    MasterList(1048)="quirrell_lesson_43"

    MasterList(1049)="quirrell_lesson_48"

    MasterList(1050)="quirrell_lesson_65"

    MasterList(1051)="quirrell_lesson_7"

    MasterList(1052)="quirrell_lesson_74"

    MasterList(1053)="quirrell_lesson_75"

    MasterList(1054)="quirrell_lesson_76"

    MasterList(1055)="quirrell_lesson_77"

    MasterList(1056)="quirrell_lesson_9"

    MasterList(1057)="quirrell_lesson_90"

    MasterList(1058)="quirrell_lesson_98"

    MasterList(1059)="quirrell_lesson_99"

    MasterList(1060)="RON_001"

    MasterList(1061)="RON_002"

    MasterList(1062)="RON_003"

    MasterList(1063)="RON_004"

    MasterList(1064)="RON_006"

    MasterList(1065)="RON_007"

    MasterList(1066)="RON_008"

    MasterList(1067)="RON_009"

    MasterList(1068)="RON_010"

    MasterList(1069)="RON_011"

    MasterList(1070)="RON_012"

    MasterList(1071)="ron_new_1"

    MasterList(1072)="ron_new_10"

    MasterList(1073)="ron_new_13"

    MasterList(1074)="ron_new_14"

    MasterList(1075)="ron_new_15"

    MasterList(1076)="ron_new_16"

    MasterList(1077)="ron_new_17"

    MasterList(1078)="ron_new_18"

    MasterList(1079)="ron_new_19"

    MasterList(1080)="ron_new_2"

    MasterList(1081)="ron_new_20"

    MasterList(1082)="ron_new_21"

    MasterList(1083)="ron_new_3"

    MasterList(1084)="ron_new_4"

    MasterList(1085)="ron_new_5"

    MasterList(1086)="ron_new_6"

    MasterList(1087)="ron_new_7"

    MasterList(1088)="ron_new_8"

    MasterList(1089)="ron_new_9"

    MasterList(1090)="SNAPE_001"

    MasterList(1091)="SNAPE_002"

    MasterList(1092)="SNAPE_003"

    MasterList(1093)="SNAPE_004"

    MasterList(1094)="SNAPE_005"

    MasterList(1095)="snape_new_1"

    MasterList(1096)="snape_new_2"

    MasterList(1097)="snape_new_3"

    MasterList(1098)="snape_new_4"

    MasterList(1099)="snape_new_5"

    MasterList(1100)="snape_new_7"

    MasterList(1101)="Spells1"

    MasterList(1102)="Spells10"

    MasterList(1103)="Spells12"

    MasterList(1104)="Spells13"

    MasterList(1105)="Spells2"

    MasterList(1106)="Spells3"

    MasterList(1107)="Spells4"

    MasterList(1108)="Spells5"

    MasterList(1109)="Spells7"

    MasterList(1110)="Spells9"

    MasterList(1111)="SPROUT_003"

    MasterList(1112)="SPROUT_004"

    MasterList(1113)="SPROUT_048"

    MasterList(1114)="SPROUT_049"

    MasterList(1115)="SPROUT_054"

    MasterList(1116)="SPROUT_059"

    MasterList(1117)="SPROUT_060"

    MasterList(1118)="SPROUT_061"

    MasterList(1119)="SPROUT_065"

    MasterList(1120)="SPROUT_066"

    MasterList(1121)="SPROUT_067"

    MasterList(1122)="SPROUT_068"

    MasterList(1123)="SPROUT_069"

    MasterList(1124)="SPROUT_070"

    MasterList(1125)="SPROUT_071"

    MasterList(1126)="SPROUT_072"

    MasterList(1127)="SPROUT_073"

    MasterList(1128)="SPROUT_074"

    MasterList(1129)="SPROUT_075"

    MasterList(1130)="SPROUT_076"

    MasterList(1131)="SPROUT_077"

    MasterList(1132)="sprout_new_2"

    MasterList(1133)="sprout_new_21"

    MasterList(1134)="sprout_new_24"

    MasterList(1135)="sprout_new_26"

    MasterList(1136)="sprout_new_33"

    MasterList(1137)="sprout_new_42"

    MasterList(1138)="sprout_new_45"

    MasterList(1139)="sprout_new_50"

    MasterList(1140)="sprout_new_52"

    MasterList(1141)="sprout_new_53"

    MasterList(1142)="sprout_new_58"

    MasterList(1143)="sprout_new_60"

    MasterList(1144)="sprout_new_67"

    MasterList(1145)="sprout_new_72"

    MasterList(1146)="sprout_new_75"

    MasterList(1147)="storybook_new_1"

    MasterList(1148)="storybook_new_10"

    MasterList(1149)="storybook_new_10a"

    MasterList(1150)="storybook_new_10b"

    MasterList(1151)="storybook_new_11"

    MasterList(1152)="storybook_new_11a"

    MasterList(1153)="storybook_new_12"

    MasterList(1154)="storybook_new_12a"

    MasterList(1155)="storybook_new_12b"

    MasterList(1156)="storybook_new_13"

    MasterList(1157)="storybook_new_13a"

    MasterList(1158)="storybook_new_2"

    MasterList(1159)="storybook_new_20"

    MasterList(1160)="storybook_new_21"

    MasterList(1161)="storybook_new_22"

    MasterList(1162)="storybook_new_23"

    MasterList(1163)="storybook_new_24"

    MasterList(1164)="storybook_new_25"

    MasterList(1165)="storybook_new_26"

    MasterList(1166)="storybook_new_27"

    MasterList(1167)="storybook_new_28"

    MasterList(1168)="storybook_new_28b"

    MasterList(1169)="storybook_new_29"

    MasterList(1170)="storybook_new_2a"

    MasterList(1171)="storybook_new_3"

    MasterList(1172)="storybook_new_30"

    MasterList(1173)="storybook_new_31"

    MasterList(1174)="storybook_new_32"

    MasterList(1175)="storybook_new_33"

    MasterList(1176)="storybook_new_33"

    MasterList(1177)="storybook_new_3a"

    MasterList(1178)="storybook_new_4"

    MasterList(1179)="storybook_new_4a"

    MasterList(1180)="storybook_new_4b"

    MasterList(1181)="storybook_new_5"

    MasterList(1182)="storybook_new_5a"

    MasterList(1183)="storybook_new_6"

    MasterList(1184)="storybook_new_6a"

    MasterList(1185)="storybook_new_7"

    MasterList(1186)="storybook_new_7a"

    MasterList(1187)="storybook_new_8"

    MasterList(1188)="storybook_new_8a"

    MasterList(1189)="storybook_new_9"

    MasterList(1190)="storybook_new_9a"

    MasterList(1191)="StoryBook1"

    MasterList(1192)="StoryBook10"

    MasterList(1193)="StoryBook11"

    MasterList(1194)="StoryBook12"

    MasterList(1195)="StoryBook13"

    MasterList(1196)="StoryBook14"

    MasterList(1197)="StoryBook15"

    MasterList(1198)="StoryBook16"

    MasterList(1199)="StoryBook17"

    MasterList(1200)="StoryBook18"

    MasterList(1201)="StoryBook19"

    MasterList(1202)="StoryBook2"

    MasterList(1203)="StoryBook20"

    MasterList(1204)="StoryBook21"

    MasterList(1205)="StoryBook23"

    MasterList(1206)="StoryBook24"

    MasterList(1207)="StoryBook25"

    MasterList(1208)="StoryBook26"

    MasterList(1209)="StoryBook28"

    MasterList(1210)="StoryBook29"

    MasterList(1211)="StoryBook3"

    MasterList(1212)="StoryBook30"

    MasterList(1213)="StoryBook31"

    MasterList(1214)="StoryBook34"

    MasterList(1215)="StoryBook35"

    MasterList(1216)="StoryBook37"

    MasterList(1217)="StoryBook38"

    MasterList(1218)="StoryBook39"

    MasterList(1219)="StoryBook4"

    MasterList(1220)="StoryBook40"

    MasterList(1221)="StoryBook41"

    MasterList(1222)="StoryBook42"

    MasterList(1223)="StoryBook44"

    MasterList(1224)="StoryBook45"

    MasterList(1225)="StoryBook46"

    MasterList(1226)="StoryBook47"

    MasterList(1227)="StoryBook48"

    MasterList(1228)="StoryBook49"

    MasterList(1229)="StoryBook5"

    MasterList(1230)="StoryBook50"

    MasterList(1231)="StoryBook51"

    MasterList(1232)="StoryBook52"

    MasterList(1233)="StoryBook53"

    MasterList(1234)="StoryBook54"

    MasterList(1235)="StoryBook55"

    MasterList(1236)="StoryBook6"

    MasterList(1237)="StoryBook7"

    MasterList(1238)="StoryBook8"

    MasterList(1239)="StoryBook9"

    MasterList(1240)="STUDENT_01"

    MasterList(1241)="STUDENT_02"

    MasterList(1242)="STUDENT_03"

    MasterList(1243)="STUDENT_04"

    MasterList(1244)="STUDENT_06"

    MasterList(1245)="student_boy_exit_01"

    MasterList(1246)="student_boy_exit_02"

    MasterList(1247)="student_boy_exit_03"

    MasterList(1248)="student_boy_exit_04"

    MasterList(1249)="student_boy_exit_05"

    MasterList(1250)="student_boy_exit_06"

    MasterList(1251)="student_boy_exit_07"

    MasterList(1252)="student_boy_exit_08"

    MasterList(1253)="student_boy_exit_09"

    MasterList(1254)="student_boy_exit_10"

    MasterList(1255)="student_boy_intro_01"

    MasterList(1256)="student_boy_intro_02"

    MasterList(1257)="student_boy_intro_03"

    MasterList(1258)="student_boy_intro_04"

    MasterList(1259)="student_boy_intro_05"

    MasterList(1260)="student_boy_new_01"

    MasterList(1261)="student_boy_new_02"

    MasterList(1262)="student_boy_new_03"

    MasterList(1263)="student_boy_new_06"

    MasterList(1264)="student_boy_new_07"

    MasterList(1265)="student_boy_new_09"

    MasterList(1266)="student_boy_new_10"

    MasterList(1267)="student_boy_new_13"

    MasterList(1268)="student_boy_new_14"

    MasterList(1269)="student_boy_new_16"

    MasterList(1270)="student_boy_new_17"

    MasterList(1271)="student_boy_new_19"

    MasterList(1272)="student_boy_new_20"

    MasterList(1273)="student_boy_new_23"

    MasterList(1274)="student_boy_new_24"

    MasterList(1275)="student_boy_new_25"

    MasterList(1276)="student_boy_new_26"

    MasterList(1277)="student_boy_new_27"

    MasterList(1278)="student_boy_new_28"

    MasterList(1279)="student_boy_new_30"

    MasterList(1280)="student_boy_new_31"

    MasterList(1281)="student_boy_new_32"

    MasterList(1282)="student_boy_new_33"

    MasterList(1283)="student_boy_new_34"

    MasterList(1284)="student_boy_new_35"

    MasterList(1285)="student_boy_new_36"

    MasterList(1286)="student_boy_new_37"

    MasterList(1287)="student_boy_new_38"

    MasterList(1288)="student_boy_new_39"

    MasterList(1289)="student_boy_new_40"

    MasterList(1290)="student_boy_new_41"

    MasterList(1291)="student_boy_new_42"

    MasterList(1292)="student_boy_new_43"

    MasterList(1293)="student_boy_new_44"

    MasterList(1294)="student_boy_new_45"

    MasterList(1295)="student_boy_new_46"

    MasterList(1296)="student_boy_new_47"

    MasterList(1297)="student_boy_new_48"

    MasterList(1298)="student_boy_new_49"

    MasterList(1299)="student_boy_new_50"

    MasterList(1300)="student_boy_new_51"

    MasterList(1301)="student_boy_new_52"

    MasterList(1302)="student_boy_new_53"

    MasterList(1303)="student_boy_new_54"

    MasterList(1304)="student_boy_new_55"

    MasterList(1305)="student_boy_new_56"

    MasterList(1306)="student_boy_new_57"

    MasterList(1307)="student_boy_new_58"

    MasterList(1308)="student_boy_new_60"

    MasterList(1309)="student_boy_new_61"

    MasterList(1310)="student_boy_new_63"

    MasterList(1311)="student_girl_exit_03"

    MasterList(1312)="student_girl_exit_04"

    MasterList(1313)="student_girl_exit_05"

    MasterList(1314)="student_girl_exit_06"

    MasterList(1315)="student_girl_exit_07"

    MasterList(1316)="student_girl_exit_10"

    MasterList(1317)="student_girl_incendio_1"

    MasterList(1318)="student_girl_incendio_2"

    MasterList(1319)="student_girl_incendio_3"

    MasterList(1320)="student_girl_intro_01"

    MasterList(1321)="student_girl_intro_03"

    MasterList(1322)="student_girl_intro_05"

    MasterList(1323)="student_girl_new_01"

    MasterList(1324)="student_girl_new_02"

    MasterList(1325)="student_girl_new_03"

    MasterList(1326)="student_girl_new_04"

    MasterList(1327)="student_girl_new_05"

    MasterList(1328)="student_girl_new_06"

    MasterList(1329)="student_girl_new_07"

    MasterList(1330)="student_girl_new_08"

    MasterList(1331)="student_girl_new_09"

    MasterList(1332)="student_girl_new_10"

    MasterList(1333)="student_girl_new_13"

    MasterList(1334)="student_girl_new_17"

    MasterList(1335)="student_girl_new_18"

    MasterList(1336)="student_girl_new_19"

    MasterList(1337)="student_girl_new_20"

    MasterList(1338)="student_girl_new_23"

    MasterList(1339)="student_girl_new_24"

    MasterList(1340)="student_girl_new_27"

    MasterList(1341)="student_girl_new_28"

    MasterList(1342)="student_girl_new_30"

    MasterList(1343)="student_girl_new_31"

    MasterList(1344)="student_girl_new_33"

    MasterList(1345)="student_girl_new_34"

    MasterList(1346)="student_girl_new_35"

    MasterList(1347)="student_girl_new_37"

    MasterList(1348)="student_girl_new_38"

    MasterList(1349)="student_girl_new_39"

    MasterList(1350)="student_girl_new_40"

    MasterList(1351)="student_girl_new_41"

    MasterList(1352)="student_girl_new_42"

    MasterList(1353)="student_girl_new_43"

    MasterList(1354)="student_girl_new_44"

    MasterList(1355)="student_girl_new_45"

    MasterList(1356)="student_girl_new_46"

    MasterList(1357)="student_girl_new_47"

    MasterList(1358)="student_girl_new_49"

    MasterList(1359)="student_girl_new_50"

    MasterList(1360)="student_girl_new_51"

    MasterList(1361)="student_girl_new_52"

    MasterList(1362)="student_girl_new_53"

    MasterList(1363)="student_girl_new_54"

    MasterList(1364)="student_girl_new_55"

    MasterList(1365)="student_girl_new_56"

    MasterList(1366)="student_girl_new_58"

    MasterList(1367)="student_girl_new_59"

    MasterList(1368)="student_girl_new_60"

    MasterList(1369)="student_girl_new_61"

    MasterList(1370)="student_girl_new_63"

    MasterList(1371)="student_girl_new_64"

    MasterList(1372)="student_girl_new_65"

    MasterList(1373)="student_girl_new_66"

    MasterList(1374)="student_girl_new_69"

    MasterList(1375)="WizardCard40"

    MasterList(1376)="WizardCard41"

    MasterList(1377)="WizardCard51"

    MasterList(1378)="WizardCard52"

    MasterList(1379)="WizardCard53"

    MasterList(1380)="WizardCard54"

    MasterList(1381)="WizardCard55"

    MasterList(1382)="WizardCard56"

    MasterList(1383)="WizardCard57"

    MasterList(1384)="WizardCard58"

    MasterList(1385)="WizardCard59"

    MasterList(1386)="WizardCard60"

    MasterList(1387)="WizardCard61"

    MasterList(1388)="WizardCard62"

    MasterList(1389)="WizardCard63"

    MasterList(1390)="WizardCard64"

    MasterList(1391)="WizardCard65"

    MasterList(1392)="WizardCard66"

    MasterList(1393)="WizardCard67"

    MasterList(1394)="WizardCard68"

    MasterList(1395)="WizardCard6"

    MasterCount=1396

}
