
;  menu
Macro VD_ShowMenu(Id,menu)
  
  menu = 1- menu
  SetMenuItemState(#MenuWinVD,Id, menu)
  Drawcanvas()
  
EndMacro
Procedure VD_CreatePopUpMenu()
  
  ; pour créer les menu popup :
  ; - menu popup pour les points (clic droit sur point)
  If CreatePopupMenu(#MenuVDPopUpPt)
    
    ; MenuItem(#menuVD_PathOpen,"Open path")
    ; MenuItem(#menuVD_PathClose,"Close path")
    ; MenuBar()
    ; MenuItem(#menuVD_AddPtBefore,"Add point before this point")        
    ; MenuItem(#menuVD_AddPtAfter,"Add point after this point")
    MenuItem(#menuVD_AddPtAtMiddle,"Add point in the middle of two selected points")
    MenuBar()
    MenuItem(#menuVD_PtSelectAll,"Select all the points of the shape")
    MenuBar()
    MenuItem(#menuVD_DeletePt,"Delete this point")
    MenuBar()
    MenuItem(#menuVD_ConvertToline,"Convert to line")
    MenuItem(#menuVD_ConvertToCurve,"Convert to curve")
    MenuItem(#menuVD_ConvertToShape,"Convert to complexe shape")
    MenuBar()
    MenuItem(#menuVD_SeparateShape,"Separate all sub-shape to shape")
    MenuItem(#menuVD_JointShape,"Joint selected shape")
    
  EndIf
  
EndProcedure

Procedure ChangeShortCut(Create=1)
  If create=1
    ; tool and UI shortcut
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_E,#menuVD_EditPoint)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_W,#menuVD_PointMirored)
    
    ; main menu
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_O,#menuVD_ShapeOpen)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_N,#menuVD_ShapeNew)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_S,#menuVD_ShapeSave)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Shift|#PB_Shortcut_E,#menuVD_ExportImageObj)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_C,#menuVD_ShapeCopy)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_V,#menuVD_ShapePast)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_D,#menuVD_ShapeDeselectAll)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_A,#menuVD_ShapeSelectAll)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Add,#menuVD_Zoomplus)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Subtract,#menuVD_ZoomMoins)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad5,#menuVD_Zoom50)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad2,#menuVD_Zoom200)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad8,#menuVD_Zoom500)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad6,#menuVD_Zoom1000)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad7,#menuVD_Zoom1500)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad1,#menuVD_ZoomReset)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad0,#menuVD_ViewReset)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_Pad4,#menuVD_ViewCenter)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_G,#menuVD_ShowGrid)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Delete,#menuVD_ShapeDelete)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_L,#menuVD_LockSelected)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Shift|#PB_Shortcut_L,#menuVD_LockAllExceptSelected)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_L,#menuVD_UnLockAll)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_P,#menuVD_ShapeSetParent)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Shift|#PB_Shortcut_P,#menuVD_ShapeDeParenting)
    
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Shift|#PB_Shortcut_H,#menuVD_HideAllExceptSelected)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_H,#menuVD_HideSelected)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_Control|#PB_Shortcut_H,#menuVD_UnHideAll)
    AddKeyboardShortcut(#Win_VD_main,#PB_Shortcut_F1,#menuVD_HelpHtml)
    
  Else
    RemoveKeyboardShortcut(#Win_VD_main, #PB_Shortcut_All )
  EndIf
EndProcedure
Procedure VD_CreateTheMenu()
  
  If CreateMenu(#MenuWinVD,WindowID(#Win_VD_main))
    
    ;{ files
    MenuTitle(lang("Files"))
    ;         MenuItem(#menuVD_ProjNew,"New Project")
    ;         MenuItem(#menuVD_ProjOpen,"Open Project")
    ;         MenuItem(#menuVD_ProjSave,"Save Project")
    ;         MenuItem(#menuVD_ProjSaveCopy,"Save Project copy")
    ;         For i = #menuVD_ProjNew To #menuVD_ProjSaveCopy
    ;             DisableMenuItem(#MenuWinVD,i,1)
    ;         Next
    
;     MenuBar()
    MenuItem(#menuVD_ShapeNew,lang("New")+Chr(9)+"Ctrl+N")
    MenuItem(#menuVD_ShapeOpen,lang("Open")+Chr(9)+"Ctrl+O")
    MenuItem(#menuVD_ShapeMergeShape,lang("Merge"))
    MenuBar()
    MenuItem(#menuVD_ShapeSave,lang("Save")+Chr(9)+"Ctrl+S")
    MenuItem(#menuVD_ShapeSaveAs,lang("Save as"))
    MenuItem(#menuVD_ShapeSaveselected,lang("Save selected"))
    MenuBar()
    MenuItem(#menuVD_ProjProperties,lang("Project properties"))
    MenuItem(#menuVD_ExportImageObj,lang("Export the object as image")+Chr(9)+"Ctrl+Shift+E")
    MenuItem(#menuVD_ExportScene,lang("Export Scene (full image)"))
    MenuBar()
    MenuItem(#menuVD_ExportPb,lang("Export in Purebasic"))
    MenuBar()
    MenuItem(#menuVD_Preference, lang("Preference"))
    MenuBar()
    MenuItem(#menuVD_ShapeQuit,lang("Quit"))
    ;}
    
    ;{ EDIT
    MenuTitle(lang("Edit"))
    MenuItem(#menuVD_ShapeCopy,lang("Copy")+Chr(9)+"Ctrl+C")
    MenuItem(#menuVD_ShapePast,lang("Paste")+Chr(9)+"Ctrl+V")
    ;}
    
    ;{ VIEW
    MenuTitle(lang("View") )
    OpenSubMenu(lang("Zoom"))
    MenuItem(#menuVD_Zoomplus,lang("Zoom")+" +"+Chr(9)+"Ctrl + ")
    MenuItem(#menuVD_ZoomMoins,lang("Zoom")+" -"+Chr(9)+"Ctrl - ")
    MenuItem(#menuVD_Zoom50,lang("Zoom")+" 50%"+Chr(9)+"Ctrl+Pad5")
    MenuItem(#menuVD_ZoomReset,lang("Zoom")+" 100%"+Chr(9)+"Ctrl+Pad1")
    MenuItem(#menuVD_Zoom200,lang("Zoom")+" 200%"+Chr(9)+"Ctrl+Pad2")
    MenuItem(#menuVD_Zoom500,lang("Zoom")+" 500%"+Chr(9)+"Ctrl+Pad8")
    MenuItem(#menuVD_Zoom1000,lang("Zoom")+" 1000%"+Chr(9)+"Ctrl+Pad6")
    MenuItem(#menuVD_Zoom1500,lang("Zoom")+" 1500%"+Chr(9)+"Ctrl+Pad7")
    CloseSubMenu()
    MenuBar()
    MenuItem(#menuVD_ViewCenter,lang("View Center")+Chr(9)+"Ctrl+Pad4")
    MenuItem(#menuVD_ViewReset,lang("View Reset")+Chr(9)+"Ctrl+Pad0")
    MenuBar()
    OpenSubMenu(lang("Show/hide"))
    MenuItem(#menuVD_ShowGrid,lang("Show grid")+Chr(9)+"Ctrl+G")
    SetMenuItemState(#MenuWinVD,#menuVD_ShowGrid,VdOptions\ShowGrid)
    MenuItem(#menuVD_ShowCamBorder,lang("Show camera border"))
    MenuItem(#menuVD_ShowCamCache,lang("Show camera cache"))
    MenuItem(#menuVD_ShowOrigin,lang("Show a cross in (0,0)"))
    MenuBar()
    MenuItem(#menuVD_HideAncre,lang("Hide anchor"))
    MenuItem(#menuVD_ShowAncreSelected,lang("Show anchor of selected shapes"))
    MenuItem(#menuVD_ShowSelection,lang("Show selection (dash stroke)"))
    MenuItem(#menuVD_ShowOnlySelected,lang("Show only selected"))
    SetMenuItemState(#MenuWinVD,#menuVD_ShowSelection,VdOptions\ShowSelection)
    SetMenuItemState(#MenuWinVD,#menuVD_HideAncre,VdOptions\HideAncre)
    CloseSubMenu()
    
    ;}
    
    ;{ selection
    MenuTitle(lang("Selection"))
    MenuItem(#menuVD_ShapeSelectAll,Lang("Select All")+Chr(9)+"Ctrl+A")
    MenuItem(#menuVD_ShapeDeselectAll,Lang("Deselect All")+Chr(9)+"Ctrl+D")
    MenuItem(#menuVD_ShapeLockSelect,Lang("Lock selection"))
    MenuBar()
    MenuItem(#menuVD_ShapeSetGroup,lang("Open Selection window")+Chr(9)+"Ctrl+G")

    ;}
    
    ;{ Layers
    MenuTitle(lang("Layer"))
    MenuItem(#menuVD_AddObjet,lang("Add a new Layer"))
    MenuItem(#menuVD_DeleteObjet,lang("Delete the current Layer"))
    ;}
    
;     ;{ objects
;     MenuTitle(lang("Object"))
;     MenuItem(#menuVD_AddObjet,lang("Add a new object"))
;     MenuItem(#menuVD_DeleteObjet,lang("Delete the current object"))
;     ;}
    
    ;{ shapes 
    MenuTitle(lang("Shape"))
    ;       MenuItem(#menuVD_ShapeCopy,"Copy current shape"+Chr(9)+"Ctrl+C")
    ;       MenuItem(#menuVD_ShapePast,"Paste"+Chr(9)+"Ctrl+V")
    MenuItem(#menuVD_ShapePastToshape,lang("Past previous parameters to shape"))
    MenuBar()
    MenuItem(#menuVD_ShapeDelete,lang("Delete the current shape")+Chr(9)+"Del")
    MenuBar()
    OpenSubMenu(lang("Lock"))
    MenuItem(#menuVD_LockSelected,lang("Lock")+Chr(9)+"L")
    MenuItem(#menuVD_UnLockAll,lang("UnLock all shapes of the layer")+Chr(9)+"Ctrl+L")
    MenuItem(#menuVD_LockAllExceptSelected,lang("Lock all except selected")+Chr(9)+"Shift+L")
    CloseSubMenu()
    MenuBar()
    OpenSubMenu(lang("Hide"))
    MenuItem(#menuVD_HideSelected,lang("Hide")+Chr(9)+"H")
    MenuItem(#menuVD_UnHideAll,lang("Unhide shapes of the layer")+Chr(9)+"Ctrl+H")
    MenuItem(#menuVD_HideAllExceptSelected,lang("Hide all except selected")+Chr(9)+"Shift+H")
    CloseSubMenu()
    MenuBar()
    OpenSubMenu(lang("Origin (center)"))
    MenuItem(#menuVD_SetShapeToOrigin,lang("Set shape to origin"))
    MenuItem(#menuVD_SetOriginToShape,lang("Set origin to shape"))
    MenuItem(#menuVD_SetOriginToMouse,lang("Set origin to mouse"))
    CloseSubMenu()
    MenuBar()
    OpenSubMenu(lang("Depth"))
    MenuItem(#menuVD_SetShapeToBottom,lang("Set Shape to bottom (depth)"))
    MenuItem(#menuVD_SetShapeToTop,lang("Set Shape to top (depth)"))
    CloseSubMenu()
    MenuBar()
    ;OpenSubMenu(lang("Group"))
     ;CloseSubMenu()
    OpenSubMenu(lang("Parent"))
    MenuItem(#menuVD_ShapeSetParent,lang("Set shapes parent with last selected")+Chr(9)+"Ctrl+p")
    MenuItem(#menuVD_ShapeDeParenting,lang("Deparenting selected shapes")+Chr(9)+"Shift+p")
    CloseSubMenu()
    ;}
    
    ;{ window & help
    MenuTitle(lang("Window") )
    ; OpenSubMenu("WorkSpace")
    ;MenuItem(#menuVD_WS_Draw,"Drawing (& ShapeKey)")
    ;MenuItem(#menuVD_WS_Animation,"Animation (Dope sheet, LNA)")
    MenuItem(#menuVD_CharacterEditor, lang("character editor"))
    MenuBar()
    MenuItem(#menuVD_ShowTimeLine,lang("Show Timeline"))
    MenuBar()
    MenuItem(#menuVD_WS_Scene,lang("Scene"))
    SetMenuItemState(#MenuWinVD,#menuVD_WS_Scene,1)
    ;MenuItem(#menuVD_WS_Sequence,"Sequence")
    ;MenuItem(#menuVD_WS_Compositor,"Compositor")
    
    MenuTitle(lang("Help")  )      
    MenuItem(#menuVD_About,lang("About"))
    MenuItem(#menuVD_Update,lang("Update"))
    MenuBar()
    MenuItem(#menuVD_Help,lang("Help (rtf)"))
    MenuItem(#menuVD_Wiki,lang("Help (Wiki)"))
    
    ; MenuItem(#menuVD_HelpHtml,"Help (html)"+Chr(9)+"F1")
    ;}
    
    ;{ Shortcuts
    ChangeShortCut()
    ;}
    
  EndIf
  
EndProcedure



; The functions by menu

;{ Files

; options
Procedure Vd_OptionsReset()
  
  With VDOptions
    
    \winw = 1024
    \winh = 768
    \WinState   = #PB_Window_Maximize
    
    \HideAncre      = 0
    \ShowOnlySel    = 0
    \ShowSelection  = 1
    \ShowCameraBorder   = 1
    \ShowCameraCache    = 1
    \CameraCacheAlpha   = 255
    \UsethemeColor   = 1
    
    \Action   = 0
    \ToolOptions\Alpha = 255
    \ToolOptions\color = 0
    \ToolOptions\Open = 1
    \ToolOptions\Style = #VD_StyleLine
    \ToolOptions\Width = 5
    \ToolOptions\distance = 20
    \ToolOptions\angle = 20
    
    \ToolOptionsFX\Alpha = 255
    \ToolOptionsFX\color = RGB(255,213,170)
    \ToolOptionsFX\Open = 1
    \ToolOptions\Style = #VD_StyleFilled
    \ToolOptionsFX\Width = 5
    
    ; camera
    \CameraX=0
    \CameraY=0
    \CameraW=1024
    \CameraH=768
    
    
    \ShowGrid = 0
    \GridColor = RGBA(200,200,200,255)
    \GridW = 32
    \GridH = 32
    
    \BgColor = RGBA(120,120,120,255)
    \ColorGadget = RGB(150,150,150)
    
    \PanelW     = 210
    \PanelLayerW     = 200
    \ToolBarH   = 25
    \TimeLineH  = 80
    \BankCaseW  = 50
    \bankOutputSize  = 64
    \bankOutputSizeFOrCreation  = 128
    
    \ConfirmExit = 1
    \ShowTip    = 1
    \Zoom       = 100
    \Autosave   = 1
    \AutosaveTime = 180
    
    \Snap   = 0
    \SnapX  = 32
    \SnapY  = 32
    \Offset = 0
    \PathSave$ = "save"
    \PathOpen$ = "save"
    
  EndWith
  
EndProcedure

Procedure VD_SaveOptions()
    
    FileName.s = GetCurrentDirectory() + "Preferences.json"

    ; Sauvegarde des options
    CreateJSON(#JSONFile)
    InsertJSONStructure(JSONValue(#JSONFile), @VdOptions, sVdOptions)
    SaveJSON(#JSONFile, FileName, #PB_JSON_PrettyPrint)

EndProcedure

Procedure VD_LoadOptions()
    
    Vd_OptionsReset()
    
    FileName$ = GetCurrentDirectory() + "Preferences.json"
    
    If FileSize(FileName$) < 0        
        VD_SaveOptions()
    EndIf
        
    ; Lecture des options
    If LoadJSON(#JSONFile, FileName$, #PB_JSON_NoCase)
      ExtractJSONStructure(JSONValue(#JSONFile), @VdOptions, sVdOptions)
    EndIf
    min(VdOptions\TimeLineH, 20)
    
EndProcedure




Procedure Doc_New(mode=1,copy=0,draw=1,x=0,y=0)
  
  ; mode = #DocFileEraseALL : erase all
  ; mode = #DocFileMerge : open and merge
  ; mode = #DocFileMergeFrombank : merge a file from the bank shape
  
  Shared posX.w, posY.w
  posX = x
  posY = Y
  
  DocFilename$ = vd\DocFilename$ 
  If mode = #DocFileEraseALL
    ; ReDim Obj(ObjId)\Shape.sShape(0)
    Dim Obj.sObj(0)
    Vd\NbShape  = -1
    vd\Shift = 0
    vd\ClicLb = 0
    ShapeFxId = 0
    ShapeId = -1
    OldShapeId=-1
    ObjId = 0 
    NbObj = -1
    ShapeIdUnik = 0
    Obj(ObjId)\Nom$ = "Object0"
    Obj(ObjId)\alpha = 255
    Obj(ObjId)\w = 100
    Obj(ObjId)\h = 100
    VdOptions\AutosaveFileName$ =#Empty$
    vd\ShapeFileName$ = #Empty$
    vd\DocFilename$  =#Empty$
    ; Global Dim Animation.sAnim(0)
  EndIf
  
  PtId = 0
  
  ; on ajoute un objet
  If copy = 0
    
    If mode >= #DocFileMerge 
      ;{ on ajoute l'objet (merge ou addshape)
      
      If vd\ShapeFileName$ = ""
        SetWindowTitle(#Win_VD_main,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD)
        ProcedureReturn 0
        ; vd\ShapeFileName$ = "1-defaut.txt"
      EndIf
      
      ;Debug "on va loader un shape "+ArraySize(Obj(ObjId)\shape())
      If mode = #DocFileMergeFromBank
        folder$ = GetGadgetText(#G_shapeListFolderAdd)+"\"
        ; Debug  folder$
        thefile$ = "data\shapes\"+folder$+vd\ShapeFileName$
        
      ElseIf mode = #DocFileMerge
        thefile$ = vd\ShapeFileName$
      EndIf
    
      Debug "le fichier qu'on va ouvrir : "+thefile$ 
      
      If FileSize(thefile$) <= 0
        MessageRequester(lang("Info"), lang("The file is empty"))
        ProcedureReturn #Null
      EndIf
      
      If Shape_Load(2, thefile$,draw) = 0
        ProcedureReturn 0
      EndIf
      
      
      ;Debug "Taille_1 : "+ArraySize(Obj(ObjId)\shape())
      
      For i=0 To ArraySize(Obj(ObjId)\Shape())
        If Obj(ObjId)\Shape(i)\Nom$ = ""
          DeleteArrayElement(Obj(ObjId)\Shape,i)
          i-1
        EndIf        
      Next
      
      ; Debug "Taille_2 : "+ArraySize(Obj(ObjId)\shape())
      ; Obj(ObjId)\Shape(0)\CurX = Obj(ObjId)\Shape(0)\pt(0)\x
      ; Obj(ObjId)\Shape(0)\CurY = Obj(ObjId)\Shape(0)\pt(0)\y
      
      SetWindowTitle(#Win_VD_main,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD)
      Vd\DocFilename$ = ""
      
      UpdateListShape()
      ; Debug "Taille_3 : "+ArraySize(Obj(ObjId)\shape())
      ;       If Obj(ObjId)\Shape(0)\Nom$ <> ""
      ;         ShapeAddFx()
      ;       EndIf
      ; Debug "Taille_4 : "+ArraySize(Obj(ObjId)\shape())
      ; Debug "fin de création"
      
      If draw=1
        Drawcanvas()
      EndIf
      ;}
      
    EndIf
    
  EndIf
  
  VD_Layer_UpdateUI()
  UpdateListShape()
  
  If vd\DocFilename$ =#Empty$ And copy = 0 And eraseall = #DocFileMerge
     vd\DocFilename$ = DocFilename$ 
  EndIf
  
   ProcedureReturn 1
EndProcedure

Procedure Doc_Save(File$=#Empty$, autosave=0)
  Shape_Save(file$,autosave)
EndProcedure

; export in Purebasic code
Procedure VD_ExportPbCommand()
  
  ; pour exporter au format pb :)
  ; on ouvre le fichier à sauvegarder
  File$ = SaveFileRequester("Save as Purebasic document...", GetCurrentDirectory(), "Pb files (.pb)|*.pb|All Files|*.*", 0)
  If file$ <> ""
    
    file$ = RemoveString(file$,".pb")
    If GetExtensionPart(File$) <> "pb"
      File$+".pb"
    EndIf
    
    If CreateFile(2,file$)
      
      WriteStringN(2,"; Made with Cartoon ! "+StrD(ValD(#ProgramVersionVD),5))             
      WriteStringN(2,"; Date : "+FormatDate("%yyyy/%mm/%dd, %hh:%ii:%ss", Date()) )        
      WriteStringN(2,"; Pb Version needed : 5.42 + " )            
      WriteStringN(2,"")            
      WriteStringN(2,"Global Zoom.f = 1" )
      WriteStringN(2,"")
      WriteStringN(2,"")
      
      For k =0 To ArraySize(Obj())
        
        WriteStringN(2,"Procedure "+Obj(k)\Nom$+"(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="+Chr(34)+Chr(34)+")")
        WriteStringN(2,"")
        WriteStringN(2,"    Protected Z.f")
        WriteStringN(2,"    Z = Zoom")
        
        ; d'abord, je dois vérifier quel est le x et le y le plus petit, car ce sera l'origine
        x0 = Obj(k)\Shape(0)\x- Obj(k)\Shape(0)\SizeW
        y0 = Obj(k)\Shape(0)\y- Obj(k)\Shape(0)\SizeH
        
        For i=0 To ArraySize(Obj(k)\Shape()) 
          
          With Obj(k)\Shape(i)
            
            Select \ShapTyp 
                
              Case #VD_ShapeCircle    
                xx0 = \x-\SizeW
                yy0 = \y-\SizeH
                If xx0 >=\SizeW And yy0 >=\SizeH
                  If x0 >xx0  And y0>yy0
                    x0 = \x -\SizeW                     
                    y0 = \y -\SizeH
                    final = i
                  EndIf
                EndIf
                
              Case #VD_ShapeBox,#VD_ShapeBoxRnd 
                xx0 = \x
                yy0 = \y
                If xx0 >=0 And yy0>0
                  If x0 >xx0  And y0>yy0
                    x0 = \x                    
                    y0 = \y 
                    final = i
                  EndIf
                EndIf
                
              Case #VD_ShapeShape, #VD_ShapeLine, #VD_ShapeCurve
                For j=0 To ArraySize(\pt())
                  If x0>\pt(j)\x+\x And y0>\pt(j)\y+\y
                    x0 = \pt(j)\x+\x
                    y0 = \pt(j)\y+\y
                    final = i
                  EndIf
                Next                        
            EndSelect            
            
          EndWith
          
        Next
        
        ; puis, on verifie les x0 et y0
        Select Obj(k)\Shape(final)\ShapTyp
            
          Case #VD_ShapeBox,#VD_ShapeBoxRnd,#VD_ShapeCircle
            min(x0,0)
            min(y0,0)
            
        EndSelect
        
        ; puis, je sauve le contenu des objet-layer
        For j=0 To ArraySize(Obj(k)\Shape())
          
          With Obj(k)\Shape(j)
            
            If \Hide = 0
              
              vx = \x - x0 
              vy = \y - y0
              
              ; je sauvegarde en fonction du type de shape
              x1 = \pt(0)\x + vx 
              y1 = \pt(0)\y + vy 
              
              WriteStringN(2,"    MovePathCursor(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z)")
              
              Select \ShapTyp
                  
                Case #VD_ShapeShape              
                  For i =0 To ArraySize(\pt()) Step 3                                    
                    u = 1+i
                    If u > ArraySize(\pt())
                      u =0
                    EndIf
                    v = u+1
                    If v > ArraySize(\pt())
                      v =0
                    EndIf
                    w = v+1                                    
                    If w > ArraySize(\pt())
                      w=0
                      x2 = x1
                      y2 = y1
                    Else
                      x2 = \pt(w)\x+vx
                      y2 = \pt(w)\y+vy
                    EndIf                                    
                    WriteStringN(2,"    AddPathCurve(("+Str(\pt(u)\x+vx)+"+x)*Z, ("+Str(\pt(u)\y+vy)+"+y)*Z, ("+
                                   Str(\pt(v)\x+vx)+"+x)*Z, ("+Str(\pt(v)\y+vy)+"+y)*Z, ("+
                                   Str(x2)+"+x)*Z, ("+Str(y2)+"+y)*Z)")
                  Next
                  
                Case #VD_ShapeBox
                  WriteStringN(2,"    AddPathBox(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                  
                  
                Case #VD_ShapeCircle
                  ; WriteStringN(2,"    AddPathEllipse(("+Str(\pt(0)\x+vx)+"+x)*Z, ("+Str(\pt(0)\y+vy)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                  WriteStringN(2,"    AddPathEllipse(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                  
                Case #VD_ShapeImage
                  ;WriteStringN(2,"MovePathCursor(("+Str(vx)+"+x)*Z, "+Str(vy)+"+y)*Z)")
                  If IsImage(\img)                                   
                    ;WriteStringN(2,"DrawVectorImage(ImageID(\img),\Alpha,\SizeW,\SizeH)                                                               
                  EndIf
                  
                Case #VD_ShapeText                                 
                  WriteStringN(2,"    MovePathCursor(("+Str(vx)+"+x)*Z, ("+Str(vy)+"+y)*Z)")
                  WriteStringN(2,"    VectorFont(FontID(Font), ("+Str(\SizeW)+"*ScaleX)*Z)")
                  WriteStringN(2,"    txt$ = "+\Text$+ " ; you can comment this line if needed and use the txt parameter in the procedure")
                  WriteStringN(2,"    AddPathText(txt$)")
                  
                Case #VD_ShapeCurve
                  For i =1 To ArraySize(\pt())-1 Step 3
                    u = i
                    v = i+1
                    w = i+2
                    If w > ArraySize(\pt())
                      w=0
                      x2 = x1
                      y2 = y1
                    Else
                      x2 = \pt(w)\x+vx
                      y2 = \pt(w)\y+vy
                    EndIf             
                    ;AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                    WriteStringN(2,"    AddPathCurve(("+Str(\pt(u)\x+vx)+"+x)*Z, ("+Str(\pt(u)\y+vy)+"+y)*Z, ("+
                                   Str(\pt(v)\x+vx)+"+x)*Z, ("+Str(\pt(v)\y+vy)+"+y)*Z, ("+
                                   Str(x2)+"+x)*Z, ("+Str(y2)+"+y)*Z)")
                  Next
                  
                Case #VD_ShapeLine
                  For i =0 To ArraySize(\pt()) 
                    WriteStringN(2, "    AddPathLine(("+Str(\pt(i)\x+vx)+"+x)*Z, ("+Str(\pt(i)\y+vy)+"+y)*Z)")
                  Next
                  
              EndSelect
              
              ; puis, je sauvegarde la couleur
              If \Linked = 0
                
                ;WriteStringN(2,"") 
                If VdOptions\UseHexForPBCode = 0
                  color$ = "RGBA(Red("+Str(Red(\color))+"),Green("+Str(Green(\color))+"),Blue("+Str(Blue(\color))+"),"+Str(\Alpha)+")"
                  WriteStringN(2,"    VectorSourceColor("+Color$+")")   
                Else
                  color$ = "$"+Hex(\color)
                  WriteStringN(2,"    VectorSourceColor("+Color$+")")   
                EndIf
                
                ;{
                ;                         Select \ColorGrad
                ;                                 
                ;                             Case 0
                ;                                 VectorSourceColor(\color)   
                ;                                 
                ;                             Case 1 ; gradient lineaire
                ;                                 n = ArraySize(\ColGrad())
                ;                                 p = ArraySize(\pt())
                ;                                 VectorSourceLinearGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,\pt(p)\x,\pt(p)\y)         
                ;                                 For i=0 To n
                ;                                     d = i/n
                ;                                     VectorSourceGradientColor(\ColGrad(i),d) 
                ;                                 Next
                ;                                 
                ;                             Case 2 ; gradient circulaire
                ;                                 n = ArraySize(\ColGrad())
                ;                                 VectorSourceCircularGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,w/2) 
                ;                                 For i=0 To n
                ;                                     d = i/n
                ;                                     VectorSourceGradientColor(\ColGrad(i),d)                    
                ;                                 Next
                ;                                 
                ;                             Case 3 ; degradé 
                ;                                 n = ArraySize(\ColGrad())
                ;                                 VectorSourceImage(ImageID(\Img))    
                ;                                 For i=0 To n
                ;                                     d = i/n
                ;                                     VectorSourceGradientColor(\ColGrad(i),d) 
                ;                                 Next
                ;                                 
                ;                                 
                ;                                 
                ;                         EndSelect
                ;}
                
                ; on choisit le type (line, dash, dot, filled..)
                Select \Typ
                  Case 0
                    WriteStringN(2,"    FillPath()")
                    
                  Case 1
                    WriteStringN(2,"    StrokePath("+Str(\w)+",#PB_Path_RoundEnd)")
                    
                  Case 2
                    WriteStringN(2,"    DashPath("+Str(\w)+", "+Str(\h)+")")
                    
                  Case 3
                    WriteStringN(2,"    DotPath("+Str(\w)+", "+Str(\h)+",#PB_Path_RoundEnd)")
                    
                EndSelect
                
                ;WriteStringN(2,"")  
                WriteStringN(2,"")  
                
              EndIf
              
            EndIf
            
          EndWith
          
        Next
        
        WriteStringN(2,"")
        WriteStringN(2,"EndProcedure ")
        WriteStringN(2,"")
        WriteStringN(2,"")
        
        
      Next 
      
      
      ; ajout de l'exemple si on le souhaite
       WriteStringN(2,"; code test")
       WriteStringN(2,"w = 1024")
       WriteStringN(2,"h = 600")
       WriteStringN(2,"OpenWindow(0, 0, 0, w, h, "+Chr(34)+"Code Test"+Chr(34)+", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)")
       WriteStringN(2,"CanvasGadget(0,0,0,w,h)")
       WriteStringN(2,"If StartVectorDrawing(CanvasVectorOutput(0))")
       WriteStringN(2,"  AddPathBox(0,0, GadgetWidth(0),GadgetHeight(0))")
       WriteStringN(2,"  VectorSourceColor(RGBA(120,120,120,255))")
       WriteStringN(2,"  FillPath()")
       For k=0 To ArraySize(Obj())
         WriteStringN(2,"  "+Obj(k)\Nom$+"("+Str(Obj(k)\x)+","+Str(Obj(k)\y)+")")
       Next
       WriteStringN(2,"  StopVectorDrawing()")
       WriteStringN(2,"EndIf")
       WriteStringN(2,"")
       WriteStringN(2,"Repeat")
       WriteStringN(2,"  Event = WaitWindowEvent()")
       WriteStringN(2,"Until Event = #PB_Event_CloseWindow")
    
      
      CloseFile(2)
    EndIf
    
    
  EndIf
  
EndProcedure

Procedure VD_ExportInSVG()
  
EndProcedure

; export image
Procedure Scene_Export(scene=0,forbankimg=0,file$=#Empty$)
  
  Shared ExportImage
  
  ; pour exporter une image ou une série d'image
  vx = vd\ViewX
  vy = vd\ViewY
  
  ; on choisit le nom de l'image à sauvegarder
  If forbankimg=0
    File$ = SaveFileRequester(lang("Save Image..."), File$, "png|*.png|Jpg|*.jpg", 0)
  EndIf

  If File$ <> #Empty$ 
    
    Select SelectedFilePattern()
      Case 0
        If GetExtensionPart(File$) <> "png"
          File$+".png"
        EndIf 
      Case 1
        If GetExtensionPart(File$) <> "jpg"
          File$+".jpg"
        EndIf
    EndSelect
    
    exportimage= 1
    vd\ViewX = 0 ; -VD_camera(cameraId)\x
    vd\ViewY = 0; -VD_camera(cameraId)\y
    
    w1 = GadgetWidth(#G_canvasVector)
    h1 = GadgetHeight(#G_canvasVector)
    w = VD_camera(cameraId)\w
    h = VD_camera(cameraId)\H
    If scene =1
       W = VD_camera(cameraId)\x + VD_camera(cameraId)\W * VD_camera(cameraId)\scale * 0.01
       H = VD_camera(cameraId)\y + VD_camera(cameraId)\H * VD_camera(cameraId)\scale * 0.01
    EndIf
;     
;     Debug "taille canvas : "+Str(w1)+"/"+Str(h1)
;     Debug "taille camera : "+Str(W)+"/"+Str(h)
    
    If w1 < w ; VdOptions\CameraW
      w1 = W ; VdOptions\CameraW
    EndIf
    If h1 < h  ;VdOptions\CameraH
      h1 = H ;VdOptions\CameraH
    EndIf
    
    If CreateImage(#Img_Export, w1, h1, 32,#PB_Image_Transparent) 
      
      ;             ; on efface l'image temporaire
      ;             If StartDrawing(ImageOutput(0))
      ;                 DrawingMode(#PB_2DDrawing_AllChannels)
      ;                 Box(0,0,GadgetWidth(0),GadgetHeight(0),RGBA(0,0,0,0))
      ;                 StopDrawing()
      ;             EndIf
      
      ; on dessine sur l'image temporaire notre image
      If StartVectorDrawing(ImageVectorOutput(#Img_Export))
        If old = 0
          ;{ c'est celui-ci qu'on utilise
          ResetCoordinates()
          ;If scene =1
            ScaleCoordinates(VD_camera(cameraId)\scale*0.01,VD_camera(cameraId)\scale*0.01)
          ;EndIf
        
          For m = 0 To ArraySize(Obj())  
            
            If Obj(m)\Hide = 0
              
              For j =0 To ArraySize(Obj(m)\Shape())  
                If Obj(m)\Shape(j)\Hide = 0
                  ; si clippath
                  ;                           SaveVectorState()
                  ;                           VdDrawShape1(m,j)
                  ;                           ClipPath()
                  
                  ; on dessine les fx en dessous
                  VdDrawFx(m,j,0)                            
                  ; dessin du shape
                  VdDrawShape1(m,j)
                  VDDrawShapeColor(m,j)                            
                  ; si fx au dessus
                  VdDrawFx(m,j,1) 
                  ; RestoreVectorState()   
                EndIf
              Next
              
            EndIf
            
          Next                     
          ;}
        Else
          ;{ new export , pas utilisé
          For j =0 To  ArraySize(Obj(ObjId)\Shape())
            With Obj(ObjId)\Shape(j)
              
              MovePathCursor(\pt(0)\x,\pt(0)\y)
              
              ; pour les Fx en dessous
              For i =0 To ArraySize(\pt()) Step 3
                
                u = 1+i
                If u > ArraySize(\pt())
                  u =0
                EndIf
                v = u+1
                If v > ArraySize(\pt())
                  v =0
                EndIf
                w = v+1              
                If w > ArraySize(\pt())
                  w=0
                EndIf
                
                AddPathCurve(\pt(u)\x, \pt(u)\y,\pt(v)\x,\pt(v)\y,\pt(w)\x,\pt(w)\y)
              Next
              
              ; pour les Fx au dessus
              
              ; remplir le chemin
              color = RGBA(Red(\color),Green(\color),Blue(\color),\Alpha)
              VectorSourceColor(Color)
              FillPath()
            EndWith
          Next
          ;}
        EndIf
        ; Debug"sortie :"+ GadgetWidth(#G_canvasVector)+"/"+GadgetHeight(#G_canvasVector)
        StopVectorDrawing()
      EndIf
      
      ;{  ; on définit les min x/y et max x/y
      minx = ImageWidth(#Img_Export)
      miny = ImageHeight(#Img_Export)
      maxX = 0
      maxY = 0
      
      ; puis, on vérifie si l'alpha est >0 , si oui, on une couleur et donc on garde le pixel
      If StartDrawing(ImageOutput(#Img_Export))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        For x=0 To ImageWidth(#Img_Export)-1
          For y =0 To ImageHeight(#Img_Export)-1
            Couleur = Point(x,y)
            a = Alpha(couleur)
            If a >0
              If minx>x
                minx=x
              EndIf
              If miny > y
                miny=y
              EndIf
              If maxX < x
                maxX=x
              EndIf
              If maxY<y
                maxY = y
              EndIf
            EndIf                    
          Next
        Next
        StopDrawing()
      EndIf
      ; Debug "x : "+Str(minx)+"/y : "+Str(miny)+" | w "+maxX+"/h "+maxY
      ; Debug "w : "+Str(maxX-minx)+"/h : "+Str(maxY-miny)
      x = minx
      y = miny
      w = Abs(maxX-minX)+1
      h = Abs(maxY-miny)+1
      ;}
      
      If scene = 1
        x = VD_camera(cameraid)\x ; VdOptions\CameraX
        y = VD_camera(cameraId)\y ; VdOptions\CameraY
        ; w = VD_camera(cameraID)\w ; VdOptions\CameraW
        ;h = VD_camera(cameraId)\h ; VdOptions\CameraH
        W = (VD_camera(cameraId)\W) * VD_camera(cameraId)\scale * 0.01
        H = (VD_camera(cameraId)\H) * VD_camera(cameraId)\scale * 0.01
      EndIf
      
    
      
      ; unpremultiply, to fixe the PB bug eport with vectorlib
      If StartDrawing(ImageOutput(#Img_Export))
        Premultiply::UnpremultiplyPixels(DrawingBuffer(), (DrawingBufferPitch()*OutputHeight())>>2)
        StopDrawing()
      EndIf
      
      ; SaveImage(#Img_Export, File$+"_original.png", #PB_ImagePlugin_PNG)
      
      If GrabImage(#Img_Export,#Img_ExportCopy,x,y,w,h)
        
        ; If it's a preview for the bank image :
        If forbankimg>=1
          If forbankimg = 1
            ResizeImageProportion(#Img_ExportCopy,vdoptions\bankOutputSize,#PB_Image_Smooth)
          ElseIf forbankimg = 2 ; for character creator
             ; ResizeImageProportion(#Img_ExportCopy,vdoptions\bankOutputSizeFOrCreation,#PB_Image_Smooth)
          EndIf
        EndIf
        
        ; on sauve
        If SaveImage(#Img_ExportCopy, File$, #PB_ImagePlugin_PNG) = 0
          MessageRequester(lang("Save image"), lang("Can't save image: " )+ File$)
          ; Else
          ; MessageRequester("Save image","Image saved ! ")
        EndIf
        
      EndIf
      
      ; free the images
      FreeImage2(#Img_Export)
      FreeImage2(#Img_ExportCopy)
      
    EndIf            
    
  EndIf
  
  vd\ViewX = vx
  vd\ViewY = vy
  ExportImage = 0
  
EndProcedure


; autosave
Procedure AutoSave()
  
  Static AutosaveTimeStart, AutosaveFileName$
  
  ; autosave, not in a thread, there is an autosave function with thread if needed (in procedures.pb)
  If  VdOptions\Autosave = 1
    
    autosavetime_ = ElapsedMilliseconds() - AutosaveTimeStart
    
    If autosavetime_ >= VdOptions\AutosaveTime * 60000
      AutosaveTimeStart = ElapsedMilliseconds()
      
      ; verify if a layer or a shape has changed
      
      ; If VdOptions\ImageHasChanged <> 0 Or LayerHasChanged = 1
      
      ; CreateWindowInfo("AUTOSAVE")
      
      VdOptions\DocHasChanged = 0
      
      ; First, examine if directories exists // d'abord on vérifie que le dossier "save existe
      saveDir$ = GetCurrentDirectory()+"save\"
      If ExamineDirectory(0, GetCurrentDirectory(), "")
        While NextDirectoryEntry(0)
          If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
            If DirectoryEntryName(0) = "save"
              trouve = 1
            EndIf
          EndIf
        Wend 
        FinishDirectory(0)
      EndIf
      
      If trouve = 0
        If CreateDirectory(saveDir$) = 0
          MessageRequester(Lang("Error"), lang("Unable to create the 'save' directory."))
          saveDir$ = GetCurrentDirectory()
        EndIf
      EndIf
      ; create autosave if needed
      Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 
      
      ; check if we have still an autosavefilename$
      If AutosaveFileName$ = ""
        AutosaveFileName$ = saveDir$+"AutoSave_"+VD\DocFilename$+"_"+Date$+hour$
      EndIf
      Debug AutosaveFileName$
      Doc_Save(AutosaveFileName$,1)
      
      ; UpdateWindowInfo("AUTOSAVE : #Save layer Image : #"+layer(i)\Name$)
      
      ; CloseWindowInfo()
      
      ; reset the clic/paint variable
      vd\ClicLb = 0
      vd\Shift = 0
      vd\Alt = 0
      vd\Ctrl = 0
      
    EndIf
    
  EndIf
  
EndProcedure

;}


;{ help
Procedure VD_OpenTheHelp(html=0)
  
  If html = 0
    If RunProgram(GetCurrentDirectory()+"data\help\help.rtf") :EndIf
  Else
    If RunProgram(GetCurrentDirectory()+"data\help\html\index.html") :EndIf
  EndIf
  
EndProcedure
;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 764
; FirstLine = 11
; Folding = ATpsBQAAAAA1A-DAA9AA-
; EnableXP
; DisableDebugger