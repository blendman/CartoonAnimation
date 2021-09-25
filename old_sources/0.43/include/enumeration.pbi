
; variables, constantes 

CompilerIf Not Defined(White, #PB_Constant)
  #White = $EEEEEE
  #Black = 0
CompilerEndIf

CompilerIf #PB_Compiler_Processor = #PB_Processor_x86     
  #ProgramBitVD = " (x86)"
CompilerElse
  #ProgramBitVD = " (x64)"
CompilerEndIf

Enumeration ; window
 
  #Win_VD_main = 0
  #Win_VD_Intro
  #Win_VD_Update
  #Win_VD_Sceneproperties
  #Win_VD_Preference
  #Win_VD_Gradient
  #Win_Swatch
  #Win_VD_CharacterEditor
  #Win_VD_BGproperties
  #Win_VD_Groups
  #Win_VD_InfosForwainting
  
EndEnumeration

Enumeration ; Gadgets 
  
  ;{ Main window
  #G_canvasVector = 0
  
  #G_CanvasIntro ; for the window intro
  #G_CanvasPathVD
  #G_CanvasPathVDScene
  #G_CanvasPathVDObjet
  #G_CanvasPathVDShape
  
  #G_CanvasOptionVD
  #G_ToolVDCenter
  #G_ToolVDSnap
  #G_ToolVDSnapX
  #G_ToolVDSnapY
  #G_ToolVDEditMode
  
  ; Timeline
  #G_VDTimeline
  
  ;{ toolBar containter & tools options
  
  ;{ options des outils
  #G_ToolBarOptionVD2
  #G_ToolBarOptionVD
  #G_TBOptionToolSet
  
  #G_TBOptionToolInfo
  
  ; tjs le premier de la liste des options des outils
  #G_TBOptSA
  #G_TBOptLockX 
  #G_TBOptLockY
  #G_TBOptLockW
  #G_TBOptLockH
  #G_TBOptSizeTyp
  #G_TBOptWidth
  #G_TBOptHeight
  #G_TBOptRotation
  #G_TBOptRotationType
  #G_TBOptToolType
  #G_TBOptToolParam1
  #G_TBOptToolParam2
  
  #G_TBOptToolDistance
  #G_TBOptToolAngle

  ; general options for creation tool (box, ellipse, line, curve..)
  #G_TBOpt_TypePreset
  #G_TBOpt_TypePresetAdd
  #G_TBOpt_TypeOpen
  #G_TBOpt_TypeColor
  #G_TBOpt_TypeAlpha
  #G_TBOpt_TypeWidth
  #G_TBOpt_TypeStyle
  
  #G_TBOpt_TypeFXPreset
  #G_TBOpt_TypeFXPresetAdd
  #G_TBOpt_TypeFXOpen
  #G_TBOpt_TypeFXStyle
  #G_TBOpt_TypeFXColor
  #G_TBOpt_TypeFXAlpha
  #G_TBOpt_TypeFxWidth
  
  
  
  
  ; toujours dernier des options des outils
  #G_TBOptSizeLast 
  ;}
  
  ;{ tools in the container
  #G_ToolBarVD
  
  #G_ToolVDNew   
  #G_ToolVDOpen  
  #G_ToolVDSave  
  #G_ToolVDMove    
  #G_ToolVDSelect
  #G_ToolVDScale
  #G_ToolVDRot
  #G_ToolVDTransform
  #G_ToolVDAddPt
  #G_ToolVDInsertPt
  #G_ToolVDMovePt
  #G_ToolVDDelPt
  
  #G_ToolVDShape 
  #G_ToolVDBox
  #G_ToolVDBoxRnd
  #G_ToolVDCircle
  #G_ToolVDLine
  #G_ToolVDCurve
  #G_ToolVDImage
  #G_ToolVDText
  
  #G_ToolVDMirorH
  #G_ToolVDMirorV
  
  #G_ToolVDLast
  
  #G_ToolVDLast2
  ;}
  
  ;}
  
  
  #G_PanelFirst ; first panel gadget, needed for some menu
  
  ;{ Panel left  (properties, color, fx)  
  #G_panelVD
  
  ;{ Properties
  
  #G_shapeListFolderAdd
  #G_shapeListAdd 
  #G_shapeAdd 
  #G_shapeDel 
  #G_shapeSABank
  #G_shapeCanvasBank
  
  ; Edit (properties)
  #G_shapeList
  #G_shapeIdUnik
  #G_shapeHide     
  #G_shapeLock     
  #G_shapeShow
  
  #G_shapeSA
  
  ; ATTENTION, Doit démarrer en #G_shapeName et conserver les gadget jusque #G_shapeLast (on peut en ajoutant (s'ils sont disabled or not)
  ; attention : #G_shapeName should be the first gadget for shape gadget (to enable/disable all between #G_shapeName and #G_shapeLast)
  #G_shapeName
  #G_shapeLink    
  #G_shapeClose 
  #G_shapeDepth
  #G_shapeClip  
  #G_shapeParent
  ;}
  
  ;{ Edit & color
  
  #G_shapePosUp
  #G_shapePosDown    
  #G_shapeCX
  #G_shapeCY
  #G_shapeX
  #G_shapeY
  #G_shapeSizeW
  #G_shapeSizeH
  #G_shapeRot
  #G_shapeGroup
  
  #G_shapeColor
  #G_shapeColorTyp
  #G_shapeColorTypProp ; to open a window to create gradients
  #G_shapeGradient    
  #G_shapeTexture 
  #G_shapeTextureOk 
  #G_shapeAlpha

  #G_shapeTyp
  #G_shapeLineW ; width of the line (for line, dash, dot)
  #G_shapeLineH ; height for dash
  #G_shapeLineD ; distance for dot
  
  #G_shapeRnd
  
  #G_shapeContText
  #G_shapeText
  #G_shapeTextFont
  
  #G_shapeContImg
  #G_shapeImgChange
  #G_shapeImgRepeat
  #G_shapeImgX
  #G_shapeImgY
  ;#G_shapeImgRot
  #G_shapeImgW
  #G_shapeImgH
  ;}
  
  ;{ point
  #G_shapeAddPt
  #G_shapeDelPt
  
  #G_shapeNotRender
  #G_shapePtX
  #G_shapePtY
  #G_shapePtMenu
  #G_shapePtHard
  #G_shapePtSoft
  #G_shapePtMirored
  #G_shapePtUseMirored
  #G_shapePtXlock
  #G_shapePtYLock
  #G_shapePtLine
  #G_shapePtCurve
  ;}
  
  ;{ FX
  #G_shapeFxPresetList
  #G_shapeFxPresetAdd
  #G_shapeFxPresetSave
  #G_shapeFxList
  #G_shapeFxAdd
  #G_shapeFxDel
  #G_shapeFxActif
  #G_shapeFxOpen
  #G_shapeFxX
  #G_shapeFxY
  #G_shapeFxDepth
  #G_shapeFxAlpha
  #G_shapeFxColor
  #G_shapeFxColorTyp ; filled, gradient linear, circle gradient
  #G_shapeFxLineTyp
  #G_shapeFxLineW
  #G_shapeFxLineH
  #G_shapeFxLineD
  #G_shapeFxScale
  #G_shapeFxSizeH
  #G_shapeFxSizeW
  #G_shapeFxClip
  
  
 
  
  
  ;}
  
  ; attention ça doit être le dernier gadget pour les gadget shape // should be the last gadget for the shape gadgets
   #G_shapeLast
  ;}
  
  ;{ Panel control anim
  #G_PanelVDControl
  
  #G_VDAnimPlay
  #G_VDAnimFps
  #G_VDAnimStart
  #G_VDAnimEnd
  #G_VDAnimCurFrame
  #G_VDAnimMaxFrame
  ;}
  
  ;{ panel right
  
  #G_panelVD_R
   ;{ objet (layer)
  
  #G_ObjSA
  #G_ObjList
  #G_ObjDepth
  #G_ObjName
  #G_ObjX
  #G_ObjY
  #G_ObjCreate
  #G_ObjHide
  #G_ObjLock
  #G_ObjLockAlpha
  #G_ObjW
  #G_ObjH
  #G_ObjRot
  #G_ObjAdd
  #G_ObjDel
  #G_ObjUp
  #G_ObjDown
  #G_ObjBm
  #G_ObjAlpha
  
  #G_ObjSAClip
  #G_ObjClip
  #G_ObjClipW
  #G_ObjClipH
  #G_ObjClipColor
  #G_ObjClipAlpha
  #G_ObjClipHide
  #G_ObjClipBorder
  #G_ObjClipBorderColor
  #G_ObjClipBorderAlpha
  #G_ObjClipBorderStroke
  
  #G_ObjFirst ; non utilisé, mais nécessaire
  
  ;}
  
  ; options
  #G_Vd_OptBGCheck
  #G_Vd_OptBGColor
  #G_Vd_OptBGImgUse
  #G_Vd_OptBGImgLoad
  #G_Vd_OptBGImgprop
  #G_Vd_OptBGImgX
  #G_Vd_OptBGImgY
  #G_Vd_OptBGImgAlpha
  #G_Vd_OptBGImgW
  #G_Vd_OptBGImgH
  #G_Vd_OptBGImgDepth
  #G_Vd_OptCamCachAlpha
  
  ; last panel gadget, needed for some menu
  #G_PanelLast 
  #G_GadgetLastFormainwindow
  ;}    
  ;}
  
  ;{ other windows
  
  
  ; for all window
  #G_Win_BtnOk
  #G_Win_BtnCancel
  
  ;{ window info for waiting
  ; used for example when export is long or other things to load
  #G_CanvasWinInfos
  ;}
  
  ;{ window update
    #G_VD_UpdateBtnOk
   #G_VD_UpdateBtnCancel
   #G_VD_UpdateEdit 
  ;}
  
  ;{ window Scene properties
  #G_winScProp_cameraId
  #G_winScProp_cameraAdd
  #G_winScProp_cameraSave
  #G_winScProp_cameraName
  #G_winScProp_cameraW
  #G_winScProp_cameraH
  #G_winScProp_cameraX
  #G_winScProp_cameraY
  #G_winScProp_cameracropX
  #G_winScProp_cameracropY
  #G_winScProp_cameracropW
  #G_winScProp_cameracropH
  #G_winScProp_cameraZoom
  #G_winScProp_outputW
  #G_winScProp_outputH
  #G_winScProp_Pourcentage
  #G_winScProp_FormatOutput
  #G_winScProp_FormatOption
  ;}
  
  ;{ window preference
  #G_PrefPanel
  #G_pref_Lang
  #G_Pref_Autosave
  #G_Pref_AutosaveTime
  #G_Pref_UseBeta
  #G_Pref_ToolMoveCanSelect
  ;}
  
  ;{ window character editor
  #G_win_Editor_ElementSelect
  #G_win_Editor_ElementImage
  #G_win_Editor_ElementNext
  #G_win_Editor_ElementPrevious
  
  #G_win_Editor_Canvas
  #G_win_Editor_COntPanelL
  #G_win_Editor_PanelL
  #G_win_Editor_SA
  
  
  
  #G_win_Editor_PanelR
  #G_win_Editor_Eye
  #G_win_Editor_EyeNext
  #G_win_Editor_EyePrev
  #G_win_Editor_Head
  #G_win_Editor_HeadNext
  #G_win_Editor_HeadPrev
  #G_win_Editor_Hear
  #G_win_Editor_Nose
  #G_win_Editor_Mouth
  #G_win_Editor_Hair
  #G_win_Editor_Neck
  #G_win_Editor_Mustach
  #G_win_Editor_Glass
  #G_win_Editor_Hat
  #G_win_Editor_Folder
  #G_win_Editor_SubFolder
  #G_win_Editor_Random
  #G_win_Editor_Save
  #G_win_Editor_Load
  ;}
  
  ;{ window swatch editor
  ; Swatch
  #G_SA_Swatch
  #G_Swatch ; scroll area
  #G_SwatchCanvas
  #G_SwatchNew
  #G_SwatchMerge
  #G_SwatchOpen
  #G_SwatchSave
  #G_SwatchExport
  #G_SwatchEdit
  
  ; window swatch
  #G_WinSwatchScroll
  #G_WinSwatchCanvas
  #G_WinSwatchNbCol
  #G_WinSwatchNameSwatch
  #G_WinSwatchName
  #G_WinSwatchSave
  #G_WinSwatchNew
  #G_WinSwatchOpen
  #G_WinSwatchMerge
  #G_WinSwatchFromImg
  #G_WinSwatchAdd
  #G_WinSwatchDel
  #G_WinSwatchInsert
  #G_WinSwatchSort
  #G_WinSwatchExport
  
  
  
  
  ;}
  
  ;{ window gradient
  #G_WinGradientList
  #G_WinGradientcanvas
  #G_WinGradientName
  #G_WinGradientAdd
  #G_WinGradientDel
  #G_WinGradientSave
  ;}
  
  ;{ Window BG properties
  #G_win_BG_Canvas
  #G_win_BG_resize
  #G_win_BG_Scale
  #G_win_BG_ClipOutX
  #G_win_BG_ClipOutY
  #G_win_BG_ClipOutW
  #G_win_BG_ClipOutH
  ;}
  
  ;{ window groups
   #G_win_group_list
   #G_win_group_NewString
   #G_win_group_NewButton
   #G_win_group_Set
   #G_win_group_Remove
   #G_win_group_RenameGroup
   #G_win_group_Select
   #G_win_group_DeleteGroup
  ;}
  
  ; gadget for all window
  
  #G_Frame_1
  #G_Frame_2
  #G_Frame_3
  #G_Frame_4
  ;}
  
  #G_GadgetLast ; always the last gadget !
  
EndEnumeration
  
Enumeration ; menu
  
  #MenuWinVD = 2
  
  #MenuVDPopUpPt
  ; #MenuVDPopUp
  
  ;{ files
  #menuVD_ShapeNew =0
  #menuVD_ProjNew
  #menuVD_ProjOpen
  #menuVD_ProjSave
  #menuVD_ProjSaveCopy
  #menuVD_ShapeOpen 
  #menuVD_ShapeMergeObj 
  #menuVD_ShapeMergeShape 
  #menuVD_ShapeSave 
  #menuVD_ShapeSaveAs
  #menuVD_ShapeSaveselected 
  #menuVD_ExportImageObj
  #menuVD_ExportImageSelected
  #menuVD_ExportImageGroup
  #menuVD_ExportScene
  #menuVD_ExportPb
  #menuVD_ExportSVG
  #menuVD_ProjProperties
  #menuVD_Preference
  #menuVD_ShapeQuit
  ;}
  
  ;{ edit    
  #menuVD_ShapeCopy 
  #menuVD_ShapePast
  #menuVD_ShapeCopyFX
  #menuVD_ShapePastFX
  #menuVD_ShapePastToshape 
  ;}
  
  ;{ select
  #menuVD_ShapeSelectAll    
  #menuVD_ShapeDeselectAll    
  #menuVD_ShapeLockSelect
  ;}
  ;{ SHape
  #menuVD_ShapeDelete 
  #menuVD_ShapeVerifyIfOk
  #menuVD_SetShapeToBottom
  #menuVD_SetShapeToTop
  #menuVD_SetShapeToOrigin
  #menuVD_SetShapeToCursor
  #menuVD_SetOriginToShape
  #menuVD_SetOriginToMouse
  
  #menuVD_HideSelected
  #menuVD_UnHideAll
  #menuVD_HideAllExceptSelected
  
  #menuVD_LockSelected
  #menuVD_UnLockAll
  #menuVD_LockAllExceptSelected
  
  #menuVD_ShapeSetGroup
 
  #menuVD_ShapeSetParent
  #menuVD_ShapeDeParenting
  
  ;}
  
  ;{ layer
  #menuVD_DeleteObjet
  #menuVD_AddObjet
  #menuVD_SetObjetToBottom
  #menuVD_SetObjetToTop
  #menuVD_MergeObjetWithBottom
  ;}
  
  ;{ view
  #menuVD_Zoomplus
  #menuVD_ZoomMoins
  
  #menuVD_Zoom50
  #menuVD_ZoomReset
  #menuVD_Zoom200
  #menuVD_Zoom500    
  #menuVD_Zoom1000
  #menuVD_Zoom1500
  
  #menuVD_HideAncre
  #menuVD_ShowAncreSelected
  #menuVD_ShowOnlySelected
  
  #menuVD_ShowBoundingboxSelection
  #menuVD_ShowBoundingboxShape
  #menuVD_ShowSelection
  #menuVD_ViewReset
  #menuVD_ViewCenter
  #menuVD_ShowGrid
  #menuVD_ShowCamBorder
  #menuVD_ShowCamCache
  #menuVD_ShowOrigin
  ;}
  
  ;{ autre menu 
  ; tool
  #menuVD_EditPoint
  #menuVD_PointMirored
  
  ;# Window
  #menuVD_WS_Draw
  #menuVD_WS_Animation
  #menuVD_WS_Compo
  #menuVD_WS_Scene
  #menuVD_WS_Sequence
  #menuVD_ShowTimeLine
  #menuVD_CharacterEditor
  
  ;help
  #menuVD_About
  #menuVD_Update
  #menuVD_Help
  #menuVD_HelpHtml
  #menuVD_Wiki
  ;}
  
  
  ;{ pop up
  
  ; pt
  #menuVD_PathClose
  #menuVD_PathOpen
  #menuVD_AddPtBefore
  #menuVD_AddPtAfter
  #menuVD_CopyPt
  #menuVD_DeletePt
  #menuVD_ConvertToline
  #menuVD_ConvertToCurve
  #menuVD_ConvertToShape
  #menuVD_SeparateShape
  #menuVD_JointShape
  #menuVD_PtSelectAll
  #menuVD_AddPtAtMiddle
  #menuVD_AddPtInTheCurve
  ;}
  
  #menuVD_Last
  
  
EndEnumeration
; other constant needed for the document
#DocFileEraseALL = 1
#DocFileMerge = 2
#DocFileMergeFromBank = 3


Enumeration ; image & Id of array of images
    
  ;{ Images
  
  ; Here, the constant for Images
  #Img_Intro = 0
  
  #Img_bg = 1
  #Img_BGimg
  #Img_BGimgCopy ; if resize or flipout the BGimage.
  
  #Img_Export
  #Img_ExportCopy
  
  
  
  
  #ico_New
  #ico_Open
  #ico_Save
  #ico_saveAs
  #ico_Merge
  #ico_Export
  #ico_Ok
  #ico_Prop
  #ico_Image
  
  #Img_Last ; always last, to set the last image #constant
  
  
  
  ; the id for the array VDimg() (so, it should start at 0)
  ; it's not image, but Id of the array VDimg()
  ; là, je dois remettre à 0 car ce ne sont pas des images mais les id du tableau d'image (voir InitShapeImages()).
  ; ?? : need to be changed ! to use #image and not array of image.
  #Img_New = 0
  #Img_open
  #Img_Save
  
  #Img_Move 
  #Img_Rot
  #Img_Scale
  #Img_Addpt
  #Img_Delpt
;   #Img_MovePtTangent
;   #Img_MovePtFree
  #Img_MovePt
  #Img_Select
  #Img_Zoom
  #Img_Pan
  #Img_Shape
  #Img_Box
  #Img_BoxRnd
  #Img_Circle
  #Img_Line
  #Img_Curve
  #Img_Image
  #Img_Text
  #Img_MirorH
  #Img_MirorV
  #Img_FreeForm
  #Img_Polygon
  #Img_Star
  
  #Img_Properties
  #Img_Hard
  #Img_Soft
  
  ; play timeline
  #Img_Play     
  #Img_Stop 
  #Img_Loop 
  #Img_Start 
  #Img_End  
  #Img_VdLast ; tjs dernier
  
  ; same here, not constant image, but #contant for the array of image for layers : 
  #ivd_layer =0   
  #ivd_layersel    
  #ivd_layeradd    
  #ivd_layerdel    
  #ivd_layerhide    
  #ivd_layerlock    
  #ivd_layerup   
  #ivd_layerdown  
  
  ;}

EndEnumeration

Enumeration ; others
  
  ;{ fonts
  #FontArial20Bold = 10
  ;}
  
  ;{ action VD
  #VD_actionMove =0
  #VD_actionSelect
  #VD_actionScale
  #VD_actionRot
  #VD_actionTransform
  #VD_actionAddPt
  #VD_actionInsertPt
  #VD_actionMovePt
  
  
  #VD_actionDelPt ; toujours avant #VD_actionAddShape
  
  ; attention, même position que les gadgets
  #VD_actionAddShape
  #VD_actionAddBox
  #VD_actionAddBoxRnd
  #VD_actionAddCircle
  #VD_actionAddLine
  #VD_actionAddCurve
  #VD_actionAddImage
  #VD_actionAddText
  #VD_actionMirorH
  #VD_actionMirorV
  
  ; Les options par outils (ex : line -> free, polygonal
  #VD_Action_Type_0 = 0
  #VD_Action_Type_1
  #VD_Action_Type_2
  
  
  
  ;}
  
  ;{ mode edition for shape
  #VD_Editmode_All=0
  #VD_Editmode_Object
  #VD_Editmode_Shape
  #VD_Editmode_Point
  ;}
  
  ;{ shape type
  ; attention, meme sens que gadget et action !! 
  #VD_ShapeShape = 0
  #VD_ShapeBox    
  #VD_ShapeBoxRnd
  #VD_ShapeCircle
  #VD_ShapeLine
  #VD_ShapeCurve
  #VD_ShapeImage
  #VD_ShapeText
  
  ;}
  
  ;{ stroke type
    ; shape typ
  #ShapeTypBox = 0
  #ShapeTypCircle
  #ShapeTypLine
  #ShapeTypCurve
  #ShapeTypEllipse
  #ShapeTypText
  ; stroketyp
  #StrokeTypFill = 0
  #StrokeTypStroke
  #StrokeTypDash
  #StrokeTypPoint

  ;}
  
  ;{ Shape propertie
  #ShapePropertie_Color=0
  #ShapePropertie_ColorTyp
  #ShapePropertie_Style
  #ShapePropertie_Alpha
  #ShapePropertie_StrokeWidth
  #ShapePropertie_LineH
  #ShapePropertie_LineD
  #ShapePropertie_ActiveFx
  ; 
  #ShapePropertie_SetParent
  #ShapePropertie_DeParenting
  ;}
  
  ;{ Style FX
  #VD_StyleFilled = 0
  #VD_StyleLine
  #VD_StyleDash
  #VD_StyleDot
  #VD_StyleGradient
  ;}
  
  ;{ Type de gadgets
  #Gad_Spin = 0    
  #Gad_String
  #Gad_Btn
  #Gad_BtnImg
  #Gad_Chkbox
  #Gad_Cbbox
  #Gad_ListV
  
  ;}
  
  ;{ messagerequester 
  #MR_error=16
  #MR_Question=32
  #MR_QuestionYEsNo=33
  #MR_Info=64
  #MR_InfoYesCancel=65
  ;}
  
  ;{ files
  #JSONFile = 0
  ;}
  
  ;{ Workspace
  #VD_WorkSpaceScene =0
  #VD_WorkSpaceAnimation
  #VD_WorkSpaceObject
  #VD_WorkSpaceLNA ; non linear animation
  ;#VD_WorkSpaceSequence
  ;#VD_WorkSpaceCompo
  
  #VD_PathScene = 0
  #VD_PathObj 
  #VD_PathShape 
  ;}
  
  
EndEnumeration



; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 561
; FirstLine = 34
; Folding = QcAA1DFA+
; EnableXP