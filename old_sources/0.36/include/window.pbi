; window

Procedure Addbuttons(win)
  
  w1 = WindowWidth(win)
  h1 = WindowHeight(win)
  h=30
  w=80
  ButtonGadget(#G_Win_BtnOk, w1-w-10, h1-h-5, w, h, Lang("Ok"))
  ButtonGadget(#G_Win_BtnCancel, w1-(w+10)*2, h1-h-5, w, h, Lang("Cancel"))
  
EndProcedure

; Window scene properties
Procedure OpenWindow_Sceneproperties()
  
  ;   VdOptions\CameraW = Val(InputRequester("Change","Change the width of rendering (camera))",Str(VdOptions\CameraW)))
  ;   VdOptions\CameraH = Val(InputRequester("Change","Change the height of rendering (camera))",Str(VdOptions\CameraH)))
  winW = 800
  WinH = 500
  If OpenWindow(#Win_VD_Sceneproperties,0,0,Winw,winH,lang("Scene Properties"),#PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget,WindowID(#Win_VD_main))
    WindowBounds(#Win_VD_Sceneproperties, 400, 500, winW, WinH) 

    ; create the gadgets
    x=10 : y=10 : w=120 : h=25 : a=4
    If FrameGadget(#PB_Any, x,y,250,(h+a)*7+35,lang("Camera"))
      y+25 : x=20
      AddGadget(#G_winScProp_cameraId,#Gad_Cbbox,x,y,w,h,"",0,0,lang("Select the camera"),cameraId,lang("Camera")+" :") : y+h+a
      For i=0 To ArraySize(VD_camera())
        AddGadgetItem(#G_winScProp_cameraId,i,VD_camera(i)\name$)
      Next
      SetGadgetState(#G_winScProp_cameraId, cameraId)
      
      AddGadget(#G_winScProp_cameraName,#Gad_String,x,y,w,h,VD_camera(cameraId)\name$,0,0,lang("Name of the current camera for output"),-65257,Lang("Name")) : y+h+a
      AddGadget(#G_winScProp_cameraX,#Gad_String,x,y,w,h,"",1,0,lang("X Position of the image output"),VD_camera(cameraId)\x,Lang("X")) : y+h+a
      AddGadget(#G_winScProp_cameraY,#Gad_String,x,y,w,h,"",1,0,lang("Y Position of the image output"),VD_camera(cameraId)\y,Lang("Y")) : y+h+a
      AddGadget(#G_winScProp_cameraW,#Gad_String,x,y,w,h,"",1,0,lang("Width of the image output"),VD_camera(cameraId)\w,Lang("Width")) : y+h+a
      AddGadget(#G_winScProp_cameraH,#Gad_String,x,y,w,h,"",1,0,lang("Height of the image output"),VD_camera(cameraId)\h,Lang("Height")) : y+h+a
      ; AddGadget(#G_winScProp_cameraZoom,#Gad_String,x,y,w,h,"",0,0,lang("Zoom of the image output"),VD_camera(cameraId)\zoom,Lang("Zoom")) : y+h+a
      AddGadget(#G_winScProp_Pourcentage,#Gad_String,x,y,w,h,"",0,0,lang("Pourcentage for output"),VD_camera(cameraId)\scale,Lang("%")) : y+h+a
      
    EndIf
    y+20
    x=10
    If FrameGadget(#PB_Any, x,y,250,(h+a)*2+35,lang("Output Image"))
      y+25 : x=20
      AddGadget(#G_winScProp_outputW,#Gad_String,x,y,w,h,"",2,0,lang("Width of output image"),
                (VD_camera(cameraId)\W)*VD_camera(cameraId)\scale*0.01 ,Lang("Width")) : y+h+a
      AddGadget(#G_winScProp_outputH,#Gad_String,x,y,w,h,"",2,0,lang("Height of output image"),
                (VD_camera(cameraId)\h)*VD_camera(cameraId)\scale*0.01 ,Lang("Height")) : y+h+a
    EndIf
    
    ;   #G_winScProp_cameracropX
    ;   #G_winScProp_cameracropY
    ;   #G_winScProp_cameracropW
    ;   #G_winScProp_cameracropH
    ;   #G_winScProp_FormatOutput
    ;   #G_winScProp_FormatOption
    ; Add 2 buttons
    Addbuttons(#Win_VD_Sceneproperties)
    
    Repeat
      
      Event = WindowEvent()
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_winScProp_cameraId
              cameraId = GetGadgetState(#G_winScProp_cameraId)
              
            Case #G_winScProp_Pourcentage
              scale = Val(GetGadgetText(#G_winScProp_Pourcentage))
              If scale >0 
                finalW = VD_camera(cameraId)\W*scale*0.01
                finalH = VD_camera(cameraId)\H*scale*0.01
                If finalW <= 8096 And FinalH <= 8096
                  VD_camera(cameraId)\scale = scale
                  SetGadgetText(#G_winScProp_outputW, Str(finalW))
                  SetGadgetText(#G_winScProp_outputH, Str(finalH))
                Else
                  MessageRequester(Lang("Info"), lang("The final size can't be > 8096x8096. The size is : "+Str(finalW)+"x"+Str(finalH)))
                EndIf
              EndIf
              
            Case #G_winScProp_cameraW
              w = Val(GetGadgetText(#G_winScProp_cameraW))
              If w >0 And w < 8096
                VD_camera(cameraId)\w = w
                VdOptions\CameraW = w
                 DrawCanvas()
                SetGadgetText(#G_winScProp_outputW, Str(VD_camera(cameraId)\W*VD_camera(cameraId)\scale*0.01))
              Else
                SetGadgetText(#G_winScProp_cameraw, Str(VD_camera(cameraId)\W))
              EndIf
              
            Case #G_winScProp_cameraH
              h = Val(GetGadgetText(#G_winScProp_cameraH))
              If h >0 And h < 8096
                VD_camera(cameraId)\H = h
                VdOptions\CameraH = h
                 DrawCanvas()
                SetGadgetText(#G_winScProp_outputH, Str(VD_camera(cameraId)\H*VD_camera(cameraId)\scale*0.01))
              Else
                SetGadgetText(#G_winScProp_cameraH, Str(VD_camera(cameraId)\H))
              EndIf
              
            Case #G_winScProp_cameraX
              x = Val(GetGadgetText(#G_winScProp_cameraX))
              VD_camera(cameraId)\x = x
              VdOptions\CameraX = x
              DrawCanvas()
              
            Case #G_winScProp_cameraY
              Y = Val(GetGadgetText(#G_winScProp_cameraY))
              VD_camera(cameraId)\Y = Y
              VdOptions\Cameray = y
              DrawCanvas()
               
            Case #G_winScProp_cameraName
              name$ = GetGadgetText(#G_winScProp_cameraName)
              If name$ <> #Empty$
                VD_camera(cameraId)\name$ = name$
              EndIf
              
            Case #G_Win_BtnOk
              quit = 2
            Case #G_Win_BtnCancel
              quit = 1
          EndSelect
          
        Case #PB_Event_CloseWindow
          quit = 2
      EndSelect
      
    Until quit >= 1
    
    CloseWindow(#Win_VD_Sceneproperties)
  EndIf
  
EndProcedure


; Window preference
Procedure WindowPref()
  
  Shared animBarre.a
  
  winW = 750
  winH = 500
  If OpenWindow(#Win_VD_Preference, 0, 0, winw, winH, Lang("Preferences"), #PB_Window_ScreenCentered|#PB_Window_SystemMenu, WindowID(#Win_VD_main))
    
    ; generality : 
    ; theme, langage, shortcuts
    ; saving : 
    ; brush (painting) : brush color saving
    ; rendering : use image reduced, see only zone visible, don't update the canvas in RT, use canvas or screen...
    
    ;{
    
    ;{ add gagdets
    h1 = 20
    
    
    If PanelGadget(#G_PrefPanel, 5, 5, winW-10, winH-40)
      
      ;{ General
      AddGadgetItem(#G_PrefPanel, -1, lang("General"))
      y1 = 5 :  x1 = 5
      FrameGadget(#G_Frame_1, x1, y1, 100, 40, lang("Langage")) : y1 +15
      
      ComboBoxGadget(#G_pref_Lang, 15, y1, 80, 20) : y1+35
      Directory$ = "data\Lang\"   
      If ExamineDirectory(0, Directory$, "*.ini")  
        While NextDirectoryEntry(0)
          If DirectoryEntryType(0) = #PB_DirectoryEntry_File
            nom$ = RemoveString(DirectoryEntryName(0),".ini")            
            If nom$ = VdOptions\Lang$
              pos = CountGadgetItems(#G_pref_Lang)
            EndIf
            AddGadgetItem(#G_pref_Lang,-1,nom$)  
          EndIf
        Wend
        FinishDirectory(0)
      EndIf
      SetGadgetState(#G_pref_Lang, pos)
      ;}
      
      ;{ interface
      AddGadgetItem(#G_PrefPanel, -1, lang("Interface"))
      y1 = 5 :  x1 = 5
      ;       AddStringGadget(#G_pref_Theme, x1, y1, 250, 20, OptionsIE\Theme$, lang("Theme :"), lang("Set the directory for the icone and images theme")) : y1+35
      ;} 
      
      ;{ saving
      AddGadgetItem(#G_PrefPanel, -1, lang("Saving"))
      y1 = 5 :  x1 = 5
      AddGadget(#G_Pref_Autosave, #Gad_Chkbox, x1, y1, 120, h1, LAng("Autosave"),0,0,lang("active the autosave or not"),VdOptions\Autosave) : y1+h1+10
      AddGadget(#G_Pref_AutosaveTime, #Gad_String, x1, y1, 120, h1, LAng("Autosave time"),0,0,lang("Define the time between two autosave (in minutes)"),VdOptions\AutosaveTime) : y1+h1+10
      
      
      ;       AddCheckBox(#G_Pref_ExportWithPaper, x1, y1, 120, h1, LAng("Export with paper"), OptionsIE\UsePaperForRendering, lang("Use the paper when export image.")) : y1+h1+10
      
      ;}
      
      ;{ shorctuts
      AddGadgetItem(#G_PrefPanel, -1, lang("Shorcuts"))
      y1 = 5 :  x1 = 5
      ;}
      
      ;{ rendering
      AddGadgetItem(#G_PrefPanel,-1,lang("Rendering"))
      y1 = 5 :  x1 = 5
      ;       ; choose the preview rendering gadget (canvas) or screen and sprites.
      ;       ComboBoxGadget(#G_pref_UseCanvas, x1, y1, 120, 20) : y1+35
      ;       AddGadgetItem(#G_pref_UseCanvas, 0, lang("Screen & Sprite"))  
      ;       AddGadgetItem(#G_pref_UseCanvas, 1, lang("Canvas (& Images)"))
      ;       GadgetToolTip(#G_pref_UseCanvas, lang("Choose the surface for preview and drawings"))
      ;       SetGadgetState(#G_pref_UseCanvas, OptionsIE\UseCanvas)
      ;       
      ;       AddCheckBox3(#G_pref_DrawOnImage,x1,y1,120,20,lang("Draw on image"),OptionsIE\DrawInRTOnImage,
      ;                    lang("Draw on image when painting with 'screen surface'")) : y1+35
      ; 
      ;}
      
      ;{ Grille
      
      AddGadgetItem(#G_PrefPanel,-1,lang("Grid"))
      y1 = 5
      x1 = 5
      ;       SpinGadget(#G_GridW, x1, y1, 50, 20, 1, 500, #PB_Spin_Numeric)
      ;       SpinGadget(#G_GridH, 60, Y1, 50, 20, 1, 500, #PB_Spin_Numeric)
      ;       ButtonGadget(#G_GridColor, 120, y1, 60, 20, lang("Grid Color"))
      ;       SetGadgetState(#G_GridW, OptionsIE\GridW)
      ;       SetGadgetState(#G_GridH, OptionsIE\gridH)     
      ;}
      
      ;{ paint
      ;       AddGadgetItem(#G_PrefPanel,-1,lang("Paint"))
      ;       y1 = 5
      ;       x1 = 5
      ;       text$ = Lang("Use right button to paint")
      ;       CheckBoxGadget(#G_pref_UseRightbutonTopaint, x1, y1, Len(text$)*8, 20, text$) : y1+30
      ;       SetGadgetState(#G_pref_UseRightbutonTopaint, OptionsIE\UseRighmouseToPaint)
      ;       
      ; ;       text$ = Lang("Save Color Brush")
      ; ;       CheckBoxGadget(#G_BrushPreset_Save_color, x1, y1, Len(text$)*8, 20, text$)
      ;       
      ;}
      
      ;{ Animation
      ;       
      ;       ; keep for the futur version with animation :)
      ;       
      ;       ;       AddGadgetItem(#G_PrefPanel,-1,Lang("Animation"))
      ;       ;       
      ;       ;       ComboBoxGadget(#G_WAnim_CoBFrameTimeline,10,10,80,20)
      ;       ;       AddGadgetItem(#G_WAnim_CoBFrameTimeline,-1,lang("Frame"))
      ;       ;       AddGadgetItem(#G_WAnim_CoBFrameTimeline,-1,lang("Seconde"))
      ;       ;       SetGadgetState(#G_WAnim_CoBFrameTimeline,0)
      ;       ;       
      ;       ;       ComboBoxGadget(#G_WAnim_CBTimelineBar, 10,40,80,20)
      ;       ;       AddGadgetItem(#G_WAnim_CBTimelineBar,-1,lang("Barre"))
      ;       ;       AddGadgetItem(#G_WAnim_CBTimelineBar,-1,lang("Line"))
      ;       ;       SetGadgetState(#G_WAnim_CBTimelineBar,animBarre)
      ;       ;       
      ;       ;       SpinGadget(#G_WPref_SizeFrame,10,80,30,20,4,24,#PB_Spin_Numeric)
      ;       ;       SetGadgetState(#G_WPref_SizeFrame,OptionsIE\SizeFrameW)
      ;       
      ;}
      
      CloseGadgetList()      
      
    EndIf
    
    
    ; Add 2 buttons
    Addbuttons(#Win_VD_Preference)
    ;}
    
    ;{ define variables by default
    ;     Lang$ = OptionsIE\Lang$ 
    ;     Theme$ = OptionsIE\Theme$
    ;     
    ;     UseCanvas = OptionsIE\UseCanvas
    ;     UseRighmouseToPaint = OptionsIE\UseRighmouseToPaint
    ;     
    Autosave = VdOptions\Autosave
    AutosaveTime = VdOptions\AutosaveTime
    ;     UsePaperForRendering = OptionsIE\UsePaperForRendering
    ;     
    ;     gridW = OptionsIE\GridW
    ;     GridH = OptionsIE\GridH
    ;     GridColor = OptionsIE\GridColor
    ;     
    ;     AnimBarre = OptionsIE\AnimBarre
    ;     SizeFrameW = OptionsIE\SizeFrameW
    ;}
    
    
    Repeat
      
      Event = WindowEvent()
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_Win_BtnOk
              quit = 1
              
            Case #G_Win_BtnCancel
              quit = 2
              
              ;             Case #G_pref_DrawOnImage
              ;               DrawInRTOnImage = GetGadgetState(EventGadget)
              ;               
            Case #G_Pref_Autosave
              Autosave = GetGadgetState(EventGadget)
              
            Case #G_Pref_AutosaveTime
              Autosavetime = Val(GetGadgetText(EventGadget))
              If Autosavetime< 1
                Autosavetime = 1
              EndIf
              
              ;             Case #G_Pref_ExportWithPaper
              ;               UsePaperForRendering = GetGadgetState(EventGadget)
              ;               
              ;             Case #G_pref_UseCanvas
              ;               UseCanvas = GetGadgetState(EventGadget)
              ;               
              ;             Case #G_pref_Lang
              ;               lang$ = GetGadgetText(#G_pref_Lang)
              ;               If lang$ <>  OptionsIE\lang$
              ;                 ; in Menu.pbi
              ;                 UpdateLanguageUI() 
              ;                 
              ;                 ; temporary message
              ;                 ; I have to update all the gadgets with the new langage
              ;                 MessageRequester(lang("Infos"), Lang("you need to restart Animatoon to see the changes of langage for gadgets"))
              ;               EndIf
              ;               
              ;             Case #G_GridW              
              ;               gridW = GetGadgetState(#G_GridW)
              ;               OptionsIE\GridW = GridW
              ;               UpdateGrid()
              ;               ScreenUpdateall()
              ;               
              ;             Case #G_GridH
              ;               gridH = GetGadgetState(#G_GridH)
              ;               OptionsIE\GridH = GridH
              ;               UpdateGrid()
              ;               ScreenUpdateall()
              ;               
              ;             Case #G_GridColor
              ;               GridColor = ColorRequester(OptionsIE\gridColor)
              ;               OptionsIE\GridColor= GridColor
              ;               UpdateGrid()
              ;               ScreenUpdateall()
              ;               
              ;             Case #G_pref_UseRightbutonTopaint
              ;               UseRighmouseToPaint = GetGadgetState(eventgadget)
              ;               
              ;             Case #G_BrushPreset_Save_color                  
              ;               brushPresetsavecolor = GetGadgetState(#G_BrushPreset_Save_color)
              ;               
              ;               ; animation
              ;             Case #G_WAnim_CBTimelineBar
              ;               AnimBarre = GetGadgetState(#G_WAnim_CBTimelineBar)
              ;               ;UpdateTimeLine()
              ;               
              ;               
              ;             Case #G_WPref_SizeFrame
              ;               SizeFrameW = GetGadgetState(#G_WPref_SizeFrame)
              ;               ;AddTimeLine(WindowWidth(#WinMain))                
              ;               ;UpdateTimeLine()
              
          EndSelect          
          
          
        Case #PB_Event_CloseWindow
          quit = 2
          
      EndSelect
      
      
    Until quit >= 1
    
    If quit = 1
      
      ; generality
      ;       If lang$ <>  OptionsIE\lang$
      ;         changelangage = 1
      ;       EndIf
      ;       
      ;       OptionsIE\Lang$ = Lang$
      ;       OptionsIE\Theme$ = Theme$
      ;       
      ;       If usecanvas <> OptionsIE\UseCanvas
      ;         updatecanvas = 1
      ;       EndIf
      ;       
      ;       OptionsIE\UseCanvas = usecanvas
      ;       OptionsIE\UseRighmouseToPaint = UseRighmouseToPaint
      ;       OptionsIE\DrawInRTOnImage = DrawInRTOnImage
      ;       
      ; saving
      VdOptions\Autosave = Autosave
      VdOptions\AutosaveTime = AutosaveTime
      ;       OptionsIE\UsePaperForRendering = UsePaperForRendering
      ;       
      ;       ; painting
      ;       ;OptionsIE\brushPresetsavecolor = brushPresetsavecolor
      ;       
      ;       ; anim
      ;       OptionsIE\SizeFrameW = SizeFrameW
      ;       OptionsIE\AnimBarre = AnimBarre
      ;       
      ;       ; utiles
      ;       If GridH <> OptionsIE\GridH Or OptionsIE\GridW <> GridW Or OptionsIE\GridColor<> GridColor
      ;         UpdateGrid()
      ;         ScreenupdateAll()
      ;       EndIf
      ;       OptionsIE\GridH = GridH
      ;       OptionsIE\GridW = GridW
      ;       OptionsIE\GridColor= GridColor
      ;       
      VD_SaveOptions()
    Else
      
    EndIf
    
    ;     If updatecanvas
    ;       IE_UpdateGadget()
    ;       Layer_UpdateElementsForRenderingSystem()
    ;     EndIf
    ;     
    ;     If changelangage = 1
    ;       UpdateLanguageUI() 
    ;     EndIf
    
    CloseWindow(#Win_VD_Preference)
    ;}     
  EndIf
  
EndProcedure


; window gradient
Procedure WindowGradient()
  
  winW = 750
  winH = 500
  If OpenWindow(#Win_VD_Gradient, 0, 0, winw, winH, Lang("Gradient"), #PB_Window_ScreenCentered|#PB_Window_SystemMenu, WindowID(#Win_VD_main))
    
    ; Add 2 buttons
    Addbuttons(#Win_VD_Gradient)
    
    
    Repeat
      
      Event = WindowEvent()
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_Win_BtnOk
              quit = 1
              
            Case #G_Win_BtnCancel
              quit = 2
              
          EndSelect          
          
          
        Case #PB_Event_CloseWindow
          quit = 2
          
      EndSelect
      
      
    Until quit >= 1
    CloseWindow(#Win_VD_Gradient)
  EndIf
  
EndProcedure


; window gradient
Procedure WindowCharacterEditor_updatecanvas()
  Shared character.scharacter
  
  
  If StartVectorDrawing(CanvasVectorOutput(#G_win_Editor_Canvas))
    
    AddPathBox(0,0,GadgetWidth(#G_win_Editor_Canvas),GadgetHeight(#G_win_Editor_Canvas))
    VectorSourceColor(RGBA(100,100,100,255))
    FillPath()
    
    x = GadgetWidth(#G_win_Editor_Canvas)/2 - ImageWidth(character\head\img)/2
    y = GadgetHeight(#G_win_Editor_Canvas)*0.7 - ImageHeight(character\head\img)/2
    With character
      MovePathCursor(x,y)
      DrawVectorImage(ImageID(\head\img))
      
      \eyeR\x = x-50
      \eyeR\y = y-80
      MovePathCursor(\eyeR\x, \eyeR\y)
      DrawVectorImage(ImageID(\eyeR\img)) 
      
      \eyeL\x = x+50
      \eyeL\y = y-80
      MovePathCursor(\eyel\x, \eyel\y)
      DrawVectorImage(ImageID(\eyel\img)) 
      
      \mouth\x = x
      \mouth\y = y
      MovePathCursor(\mouth\x, \mouth\y)
      DrawVectorImage(ImageID(\mouth\img)) 
      
      \nose\x = x
      \nose\y = y-20
      MovePathCursor(\nose\x, \nose\y)
      DrawVectorImage(ImageID(\nose\img)) 
      
      \hearR\x = x-80
      \hearR\y = y-80
      MovePathCursor(\hearR\x, \hearR\y)
      DrawVectorImage(ImageID(\hearR\img))
    EndWith
    
    
    StopVectorDrawing()
  EndIf
  
EndProcedure
Procedure WindowCharacterEditor()
  
  Shared character.scharacter
  
  winW = 750
  winH = 500
;   UseModule GadgetR
    win = #Win_VD_CharacterEditor


  If OpenWindowR(win, 0, 0, winw, winH, Lang("Character editor"), #PB_Window_ScreenCentered|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_SizeGadget|#PB_Window_SystemMenu, WindowID(#Win_VD_main))
    
;     
;     #G_win_Editor_ElementSelect
;     #G_win_Editor_ElementImage
;     #G_win_Editor_ElementNext
;     #G_win_Editor_ElementPrevious
    x = 200 : y = 10 : w2 = 300 : h2 = winh-40 : a=2
    
    If ContainerGadgetR(#G_win_Editor_COntPanelL, 0, 5, x-5, h2, #PB_Container_BorderLess,0,0,0,1)
      id = #G_win_Editor_PanelL
      If PanelGadgetR(id,0,0,x,h2,0,0,0,1)
        AddGadgetItem(id, 0, "create")
        ; combobox : type (humain, alien, house...
        ; combobox gabarit (si humain : homme/femme petit, trapu, ado, enfant6ans, enfant 9 ans, 12 ans, 15, 18ans...)
        ; combox : yeux/oreilles/bouche ?
        ; ou gadget ?
        ScrollAreaGadgetR(#G_win_Editor_SA,a,a,x-10-a*2,h2-a*2-40,x-35-a*2,h2+200,1,0,0,0,0,1)
        
        ; AddGadgetItem(id, 1, "Options")
        CloseGadgetListR()
        CloseGadgetListR()
      EndIf
      CloseGadgetListR()
    EndIf
    
    CanvasGadgetR(#G_win_Editor_Canvas,X,5,W2,H2,0,0,1,0,1)
    
;     ; Add 2 buttons
;     w1 = WindowWidth(win)
;     h1 = WindowHeight(win)
;     h=30
;     w=80
;     ButtonGadgetR(#G_Win_BtnOk, w1-w-10, h1-h-5, w, h, Lang("Ok"),0,1,0,1,0)
;     ButtonGadgetR(#G_Win_BtnCancel, w1-(w+10)*2, h1-h-5, w, h, Lang("Cancel"),0,1,0,1,0)

    ResizeWindow(win, #PB_Ignore , #PB_Ignore ,winw,winH):
    WindowBounds(win, 750, 500, #PB_Ignore, #PB_Ignore)
    
    ; TEST
    character\head\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\head\head.png")
    character\eyeR\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\eyes\eye_rodg.png")
    character\eyeL\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\eyes\eye_rodg.png")
    character\mouth\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\mouth\mouth_rodg.png")
    character\nose\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\nose\nose02.png")
    character\hearR\img = LoadImage(#PB_Any, GetCurrentDirectory()+"data\shapes\character-part\hear\hear01.png")
    
    WindowCharacterEditor_updatecanvas()
    
    Repeat
      
      Event = WaitWindowEvent(1)
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_SizeWindow
          WindowCharacterEditor_updatecanvas()
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_Win_BtnOk
              quit = 1
              
            Case #G_Win_BtnCancel
              quit = 2
              
          EndSelect          
          
          
        Case #PB_Event_CloseWindow
          quit = 2
          
      EndSelect
      
      
    Until quit >= 1
    
    CloseWindow(#Win_VD_CharacterEditor)
    
  EndIf
  

EndProcedure


; window BG image properties
Procedure WinddowBG_updateCanvas()
  Shared winBG_ratioH.d, winBG_ratioW.d
  
  If Not IsImage(#Img_BGimg)
    CreateImage(#Img_BGimg, 32,32)
  EndIf
  
  w = GadgetWidth(#G_win_BG_Canvas)
  h = GadgetHeight(#G_win_BG_Canvas)
  w1 = ImageWidth(#Img_BGimg)
  h1 = ImageHeight(#Img_BGimg)
  rx = VdOptions\BgImg\ClipOut\x
  ry = VdOptions\BgImg\ClipOut\y
  rw = VdOptions\BgImg\ClipOut\w
  rh = VdOptions\BgImg\ClipOut\h
  
 ; calcul the size for drawingimage
  If w1>h1
    nw = w
    nh = (h1 * w)/w1
  Else
    nh = h
    nw = (w1 * h)/h1
  EndIf
  
  winBG_ratioH.d = nh/h1
  winBG_ratioW.d = nw/w1
  
  If StartVectorDrawing(CanvasVectorOutput(#G_win_BG_Canvas))
    AddPathBox(0,0,w,h)
    VectorSourceColor(RGBA(200,200,200,255))
    FillPath()
    
    ; draw the image of BG
    MovePathCursor(0,0)
    DrawVectorImage(ImageID(#Img_BGimg), 255, nw,nh)
    
    ; draw the rectangle for crop
    AddPathBox(rx*  winBG_ratioW,ry*  winBG_ratioH,rw *  winBG_ratioW,rh *  winBG_ratioH)
    VectorSourceColor(RGBA(255,0,0,255))
    StrokePath(1)
    
    StopVectorDrawing()
  EndIf
  
EndProcedure
Procedure WindowBackgroundPropertie()
  Shared winBG_ratioH.d, winBG_ratioW.d

  winW = 800
  winH = 500
  If OpenWindow(#Win_VD_BGproperties, 0, 0, winw, winH, Lang("Background properties"), #PB_Window_ScreenCentered|#PB_Window_SystemMenu, WindowID(#Win_VD_main))
    
    ; create the gadgets for window Background
    x = 10 : y=10 : w=200 : h = winh-100 : h1 = 30 : w1 = 60: w2 =100
    AddGadget(#G_win_BG_resize,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Change the definition (résolution in %) of the Background image"),VdOptions\BgImg\Resize * 100,lang("Resolution")) : y +h1+5
    AddGadget(#G_win_BG_Scale,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Scale the Background image (in %), the scale is the display on the main canvas."),VdOptions\BgImg\Scale * 100,lang("Scale  (%)")) : y +h1+5
    AddGadget(#G_win_BG_ClipOutX,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Set X position of the Clipout for the Background image"),VdOptions\BgImg\ClipOut\x,lang("ClipOut X")) : y +h1+5
    AddGadget(#G_win_BG_ClipOutY,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Set Y position of the Clipout for the Background image"),VdOptions\BgImg\ClipOut\y,lang("ClipOut Y")) : y +h1+5
    AddGadget(#G_win_BG_ClipOutW,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Set the Clipout width of the Background image"),VdOptions\BgImg\ClipOut\w,lang("ClipOut W")) : y +h1+5
    AddGadget(#G_win_BG_ClipOutH,#Gad_string,x,y,w2,h1,#Empty$,0,0,lang("Set the Clipout height of the Background image"),VdOptions\BgImg\ClipOut\h,lang("ClipOut H")) : y +h1+5
    
    y =10 : x= GadgetX(#G_win_BG_resize)+w2+5
    wc = winW -x - 5
    CanvasGadget(#G_win_BG_Canvas,x,y,wc,winh-40-y)
    ; Add 2 buttons
    Addbuttons(#Win_VD_BGproperties)
    
    ; keep the previous parameters of background image
    Define clipout.Srectangle2
    Define clip.Srectangle2
    ClipOut\W = VdOptions\BgImg\ClipOut\W
    ClipOut\H = VdOptions\BgImg\ClipOut\H
    ClipOut\x = VdOptions\BgImg\ClipOut\x
    ClipOut\y= VdOptions\BgImg\ClipOut\y
    resize.d = VdOptions\BgImg\Resize
    Scale.d = VdOptions\BgImg\Scale
    ; need to update the canvas.
    WinddowBG_updateCanvas()
    
    Repeat
      
      Event = WindowEvent()
      EventGadget = EventGadget()
      
      Select event
        Case #PB_Event_Gadget
          gad = 0
          Select EventGadget
              
            Case #G_win_BG_Canvas
              If EventType() = #PB_EventType_LeftButtonDown
                down = 1
                x = GetGadgetAttribute(#G_win_BG_Canvas,#PB_Canvas_MouseX) / winBG_ratioW
                y = GetGadgetAttribute(#G_win_BG_Canvas,#PB_Canvas_MouseY) / winBG_ratioH
                VdOptions\BgImg\ClipOut\x = x
                VdOptions\BgImg\ClipOut\y = y
                SetGadgetText(#G_win_BG_ClipOutX,Str(x))
                SetGadgetText(#G_win_BG_ClipOutY,Str(Y))
                WinddowBG_updateCanvas()
                BG_ResizeImage()
                DrawCanvas()
              ElseIf EventType() = #PB_EventType_LeftButtonUp
                down = 0
              EndIf
              If down And  EventType() = #PB_EventType_MouseMove
                x = GetGadgetAttribute(#G_win_BG_Canvas,#PB_Canvas_MouseX) / winBG_ratioW - VdOptions\BgImg\ClipOut\x
                y = GetGadgetAttribute(#G_win_BG_Canvas,#PB_Canvas_MouseY) / winBG_ratioH - VdOptions\BgImg\ClipOut\y
                VdOptions\BgImg\ClipOut\w = x
                VdOptions\BgImg\ClipOut\h = y
                SetGadgetText(#G_win_BG_ClipOutW,Str(x))
                SetGadgetText(#G_win_BG_ClipOutH,Str(Y))
                WinddowBG_updateCanvas()
                BG_ResizeImage()
                DrawCanvas()
              EndIf
              
            Case #G_win_BG_ClipOutx,#G_win_BG_ClipOutY,#G_win_BG_ClipOutW, #G_win_BG_ClipOutH, #G_win_BG_resize, #G_win_BG_Scale
              ; resize (size in pixel of the image displayed
              r.d = Val(GetGadgetText(#G_win_BG_resize)) * 0.01
              If r>0 And r<=1
                VdOptions\BgImg\Resize = r
              EndIf
              ; scale (vector scale)
              s.d = Val(GetGadgetText(#G_win_BG_Scale)) * 0.01
              If s>0
                 VdOptions\BgImg\scale = s
               EndIf
               ; clipout
              Clip\W = Val(GetGadgetText(#G_win_BG_ClipOutW))
              Clip\H = Val(GetGadgetText(#G_win_BG_ClipOutH))
              Clip\x = Val(GetGadgetText(#G_win_BG_ClipOutX))
              Clip\y= Val(GetGadgetText(#G_win_BG_ClipOutY))
              If clip\w >0 And clip\h >0 And clip\x <ImageWidth(#Img_BGimg) And clip\y <ImageHeight(#Img_BGimg)
                VdOptions\BgImg\ClipOut\W = Clip\W 
                VdOptions\BgImg\ClipOut\h = Clip\h 
                VdOptions\BgImg\ClipOut\x = Clip\x 
                VdOptions\BgImg\ClipOut\y = Clip\y 
              EndIf
              WinddowBG_updateCanvas()
              BG_ResizeImage()
              DrawCanvas()
              
            Case #G_Win_BtnOk
              quit = 1
              
            Case #G_Win_BtnCancel
              quit = 2
              
          EndSelect          
          
        Case #PB_Event_CloseWindow
          quit = 3
          
      EndSelect
      
    Until quit >= 1
    
    ; if cancel, set again the bg parameters to its previous state
    If quit =2
      VdOptions\BgImg\ClipOut\W = ClipOut\W
      VdOptions\BgImg\ClipOut\H = ClipOut\H
      VdOptions\BgImg\ClipOut\x = ClipOut\x
      VdOptions\BgImg\ClipOut\y = ClipOut\y
      VdOptions\BgImg\Resize = resize
      VdOptions\BgImg\Scale = Scale
    EndIf
    
    ;  then change the bg image
    BG_ResizeImage()
    DrawCanvas()
    ; close
    CloseWindow(#Win_VD_BGproperties)
  EndIf
  
EndProcedure

; window group
Procedure windowgroup_updatelist()
  
  If NbGroup>-1
    ClearGadgetItems(#G_win_group_list)
    For i=0 To ArraySize(ShapeGroup())
      AddGadgetItem(#G_win_group_list, i, ShapeGroup(i)\Name$)
    Next
  EndIf
  
EndProcedure
Procedure EventWindowGroup(EventGadget)
  Static groupId
  
  Select EventGadget
      
    Case #G_win_group_list
      groupid = GetGadgetState(#G_win_group_list)
      
    Case #G_win_group_NewButton
      If GetGadgetText(#G_win_group_NewString) <> #Empty$
        find=0
        For i=0 To ArraySize(ShapeGroup())
          If ShapeGroup(i)\Name$ = GetGadgetText(#G_win_group_NewString)
            find=1
            Break
          EndIf
        Next
        
        If find=0
          NbGroup+1
          ReDim ShapeGroup.Sgroup(NbGroup)
          ShapeGroup(NbGroup)\Name$ = GetGadgetText(#G_win_group_NewString) 
          windowgroup_updatelist()
        EndIf
      EndIf
      
    Case #G_win_group_Select
      For i=0 To ArraySize( obj(ObjId)\Shape())
        With obj(ObjId)\Shape(i)
          If \Group$ = GetGadgetItemText(#G_win_group_list,groupid)
            \selected = 1
          EndIf
        EndWith
      Next
     DrawCanvas()
      
    Case #G_win_group_Remove
      For i=0 To ArraySize( obj(ObjId)\Shape())
        With obj(ObjId)\Shape(i)
          If \Selected = 1
            \Group$ = #Empty$
          EndIf
        EndWith
      Next
      
    Case #G_win_group_set
      groupid = GetGadgetState(#G_win_group_list)
      For i=0 To ArraySize( obj(ObjId)\Shape())
        With obj(ObjId)\Shape(i)
          If \Selected = 1
            \Group$ = GetGadgetItemText(#G_win_group_list,groupid)
          EndIf
        EndWith
      Next
      
  EndSelect          
      
EndProcedure
Procedure WindowGroup()
  
  winW = 400
  winH = 500
  If OpenWindow(#Win_VD_Groups, 0, 0, winw, winH, Lang("Groups"), #PB_Window_ScreenCentered|#PB_Window_SystemMenu, WindowID(#Win_VD_main))
    
    x = 10 : y=10 : w=200 : h = winh-100 : h1 = 30 : w1 = 60: w2 =100
    ListViewGadget(#G_win_group_list, x,y,w,h) : x+210
    
    StringGadget(#G_win_group_NewString, x,y,w2,h1,"") : 
    ButtonGadget(#G_win_group_NewButton, x+w2+5,y,w1,h1,"+") : y +h1+5
    AddGadget(#G_win_group_set,#Gad_Btn,x,y,w2,h1,lang("Set"),0,0,lang("Set Group to shapes")) : y +h1+5
    AddGadget(#G_win_group_remove,#Gad_Btn,x,y,w2,h1,lang("Remove"),0,0,lang("Remove the shape for its group")) : y +h1+5
    AddGadget(#G_win_group_DeleteGroup,#Gad_Btn,x,y,w2,h1,lang("Delete"),0,0,lang("Delete selected Group")) : y +h1+5
    AddGadget(#G_win_group_Select,#Gad_Btn,x,y,w2,h1,lang("Select"),0,0,lang("Select shapes of the Group")) : y +h1+5
    windowgroup_updatelist()
    
    ; Add 2 buttons
    Addbuttons(#Win_VD_Groups)
    
  EndIf
  
EndProcedure

; window intro
Procedure WindowIntro()
  
  ; Need to be improved !
  
  ; Window introduction
  w = 1024
  h = 300
  OpenWindow(#Win_VD_Intro, 0, 0, w, h, "Cartoon your life ! "+ #ProgramNameVD+#ProgramVersionVD+#ProgramBitVD, #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  
  CreateImage(0,w,h)
  g = 0
  If StartVectorDrawing(ImageVectorOutput(g))
    AddPathBox(0,0, ImageWidth(g),ImageHeight(g))
    VectorSourceColor(RGBA(120,120,120,255))
    FillPath()
    x=60+(w-922)/2
    y =(h-235)/2
    Z.f = 0.5
    MovePathCursor((5+x)*Z, (5+y)*Z)
    AddPathLine((5+x)*Z, (5+y)*Z)
    AddPathLine((39+x)*Z, (475+y)*Z)
    AddPathLine((1739+x)*Z, (475+y)*Z)
    AddPathLine((1849+x)*Z, (95+y)*Z)
    ;     w = PathBoundsWidth()
    ;     h = PathBoundsHeight()
    
    VectorSourceColor(-15620098)
    FillPath()
    
    MovePathCursor((797+x)*Z, (233+y)*Z)
    AddPathCurve((773+x)*Z, (237+y)*Z, (742+x)*Z, (240+y)*Z, (722+x)*Z, (240+y)*Z)
    AddPathCurve((716+x)*Z, (220+y)*Z, (723+x)*Z, (198+y)*Z, (733+x)*Z, (146+y)*Z)
    AddPathCurve((773+x)*Z, (139+y)*Z, (853+x)*Z, (140+y)*Z, (988+x)*Z, (138+y)*Z)
    AddPathCurve((989+x)*Z, (144+y)*Z, (989+x)*Z, (211+y)*Z, (983+x)*Z, (232+y)*Z)
    AddPathCurve((974+x)*Z, (234+y)*Z, (948+x)*Z, (222+y)*Z, (881+x)*Z, (228+y)*Z)
    AddPathCurve((882+x)*Z, (281+y)*Z, (881+x)*Z, (341+y)*Z, (886+x)*Z, (365+y)*Z)
    AddPathCurve((843+x)*Z, (371+y)*Z, (800+x)*Z, (366+y)*Z, (780+x)*Z, (367+y)*Z)
    AddPathCurve((775+x)*Z, (327+y)*Z, (785+x)*Z, (292+y)*Z, (797+x)*Z, (233+y)*Z)
    VectorSourceColor(RGBA(0,0,0,255))
    StrokePath(3,#PB_Path_RoundEnd)
    ; N
    MovePathCursor((1444+x)*Z, (274+y)*Z)
    AddPathCurve((1441+x)*Z, (230+y)*Z, (1424+x)*Z, (194+y)*Z, (1498+x)*Z, (177+y)*Z)
    AddPathCurve((1506+x)*Z, (218+y)*Z, (1606+x)*Z, (259+y)*Z, (1627+x)*Z, (262+y)*Z)
    AddPathCurve((1648+x)*Z, (265+y)*Z, (1547+x)*Z, (165+y)*Z, (1683+x)*Z, (175+y)*Z)
    AddPathCurve((1734+x)*Z, (329+y)*Z, (1734+x)*Z, (359+y)*Z, (1721+x)*Z, (398+y)*Z)
    AddPathCurve((1722+x)*Z, (399+y)*Z, (1706+x)*Z, (420+y)*Z, (1608+x)*Z, (404+y)*Z)
    AddPathCurve((1599+x)*Z, (406+y)*Z, (1509+x)*Z, (242+y)*Z, (1521+x)*Z, (287+y)*Z)
    AddPathCurve((1530+x)*Z, (336+y)*Z, (1541+x)*Z, (369+y)*Z, (1546+x)*Z, (393+y)*Z)
    AddPathCurve((1508+x)*Z, (405+y)*Z, (1472+x)*Z, (400+y)*Z, (1452+x)*Z, (401+y)*Z)
    AddPathCurve((1447+x)*Z, (361+y)*Z, (1450+x)*Z, (333+y)*Z, (1444+x)*Z, (274+y)*Z)
    VectorSourceColor(-16777216)
    StrokePath(3,#PB_Path_RoundEnd)
    
    MovePathCursor((98+x)*Z, (383+y)*Z)
    AddPathCurve((27+x)*Z, (382+y)*Z, (2+x)*Z, (184+y)*Z, (76+x)*Z, (167+y)*Z)
    AddPathCurve((126+x)*Z, (155+y)*Z, (199+x)*Z, (167+y)*Z, (253+x)*Z, (177+y)*Z)
    AddPathCurve((254+x)*Z, (183+y)*Z, (233+x)*Z, (255+y)*Z, (227+x)*Z, (276+y)*Z)
    AddPathCurve((218+x)*Z, (278+y)*Z, (87+x)*Z, (232+y)*Z, (99+x)*Z, (277+y)*Z)
    AddPathCurve((111+x)*Z, (322+y)*Z, (218+x)*Z, (299+y)*Z, (252+x)*Z, (293+y)*Z)
    AddPathCurve((252+x)*Z, (318+y)*Z, (249+x)*Z, (347+y)*Z, (248+x)*Z, (375+y)*Z)
    AddPathCurve((210+x)*Z, (381+y)*Z, (169+x)*Z, (384+y)*Z, (98+x)*Z, (383+y)*Z)
    VectorSourceColor(RGBA(0,0,0,255))
    StrokePath(3,#PB_Path_RoundEnd)
    
    MovePathCursor((496+x)*Z, (218+y)*Z)
    AddPathCurve((493+x)*Z, (174+y)*Z, (476+x)*Z, (138+y)*Z, (550+x)*Z, (121+y)*Z)
    AddPathCurve((558+x)*Z, (162+y)*Z, (550+x)*Z, (90+y)*Z, (727+x)*Z, (131+y)*Z)
    AddPathCurve((728+x)*Z, (137+y)*Z, (707+x)*Z, (209+y)*Z, (701+x)*Z, (230+y)*Z)
    AddPathCurve((692+x)*Z, (232+y)*Z, (561+x)*Z, (186+y)*Z, (573+x)*Z, (231+y)*Z)
    AddPathCurve((582+x)*Z, (280+y)*Z, (593+x)*Z, (313+y)*Z, (598+x)*Z, (337+y)*Z)
    AddPathCurve((560+x)*Z, (349+y)*Z, (524+x)*Z, (344+y)*Z, (504+x)*Z, (345+y)*Z)
    AddPathCurve((499+x)*Z, (305+y)*Z, (502+x)*Z, (277+y)*Z, (496+x)*Z, (218+y)*Z)
    VectorSourceColor(RGBA(0,0,0,255))
    StrokePath(3,#PB_Path_RoundEnd)
    
    MovePathCursor((255+x)*Z, (337+y)*Z)
    AddPathCurve((265+x)*Z, (338+y)*Z, (329+x)*Z, (340+y)*Z, (332+x)*Z, (340+y)*Z)
    AddPathCurve((335+x)*Z, (340+y)*Z, (337+x)*Z, (300+y)*Z, (335+x)*Z, (270+y)*Z)
    AddPathCurve((335+x)*Z, (268+y)*Z, (394+x)*Z, (270+y)*Z, (397+x)*Z, (270+y)*Z)
    AddPathCurve((395+x)*Z, (303+y)*Z, (391+x)*Z, (322+y)*Z, (387+x)*Z, (344+y)*Z)
    AddPathCurve((407+x)*Z, (344+y)*Z, (454+x)*Z, (342+y)*Z, (474+x)*Z, (342+y)*Z)
    AddPathCurve((485+x)*Z, (322+y)*Z, (444+x)*Z, (135+y)*Z, (436+x)*Z, (113+y)*Z)
    AddPathCurve((410+x)*Z, (103+y)*Z, (294+x)*Z, (108+y)*Z, (289+x)*Z, (125+y)*Z)
    AddPathCurve((290+x)*Z, (154+y)*Z, (255+x)*Z, (337+y)*Z, (255+x)*Z, (337+y)*Z)
    MovePathCursor((340+x)*Z, (216+y)*Z)
    AddPathCurve((340+x)*Z, (216+y)*Z, (367+x)*Z, (219+y)*Z, (387+x)*Z, (219+y)*Z)
    AddPathCurve((392+x)*Z, (197+y)*Z, (393+x)*Z, (193+y)*Z, (389+x)*Z, (169+y)*Z)
    AddPathCurve((369+x)*Z, (169+y)*Z, (361+x)*Z, (172+y)*Z, (341+x)*Z, (174+y)*Z)
    AddPathCurve((342+x)*Z, (198+y)*Z, (340+x)*Z, (216+y)*Z, (340+x)*Z, (216+y)*Z)
    VectorSourceColor(RGBA(0,0,0,255))
    FillPath()
    
    MovePathCursor((1093+x)*Z, (330+y)*Z)
    AddPathCurve((1184+x)*Z, (319+y)*Z, (1263+x)*Z, (169+y)*Z, (1173+x)*Z, (129+y)*Z)
    AddPathCurve((1083+x)*Z, (89+y)*Z, (964+x)*Z, (90+y)*Z, (967+x)*Z, (180+y)*Z)
    AddPathCurve((970+x)*Z, (270+y)*Z, (1005+x)*Z, (353+y)*Z, (1093+x)*Z, (330+y)*Z)
    MovePathCursor((1348+x)*Z, (350+y)*Z)
    AddPathCurve((1444+x)*Z, (351+y)*Z, (1484+x)*Z, (218+y)*Z, (1428+x)*Z, (149+y)*Z)
    AddPathCurve((1372+x)*Z, (80+y)*Z, (1219+x)*Z, (110+y)*Z, (1222+x)*Z, (200+y)*Z)
    AddPathCurve((1224+x)*Z, (310+y)*Z, (1252+x)*Z, (349+y)*Z, (1348+x)*Z, (350+y)*Z)
    MovePathCursor((1327+x)*Z, (278+y)*Z)
    AddPathCurve((1294+x)*Z, (274+y)*Z, (1266+x)*Z, (220+y)*Z, (1298+x)*Z, (205+y)*Z)
    AddPathCurve((1330+x)*Z, (191+y)*Z, (1374+x)*Z, (191+y)*Z, (1372+x)*Z, (224+y)*Z)
    AddPathCurve((1371+x)*Z, (256+y)*Z, (1359+x)*Z, (286+y)*Z, (1327+x)*Z, (278+y)*Z)
    MovePathCursor((1105+x)*Z, (260+y)*Z)
    AddPathCurve((1072+x)*Z, (256+y)*Z, (1044+x)*Z, (202+y)*Z, (1076+x)*Z, (187+y)*Z)
    AddPathCurve((1108+x)*Z, (173+y)*Z, (1152+x)*Z, (173+y)*Z, (1150+x)*Z, (206+y)*Z)
    AddPathCurve((1149+x)*Z, (238+y)*Z, (1137+x)*Z, (268+y)*Z, (1105+x)*Z, (260+y)*Z)
    VectorSourceColor(RGBA(0,0,0,255))
    FillPath()
    StopVectorDrawing()
  EndIf
  g = #G_CanvasIntro
  ImageGadget(g,0,0,w,h, ImageID(0))
  Repeat
    Event = WaitWindowEvent()
    quit+5
  Until quit >=5

  
EndProcedure

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 646
; FirstLine = 27
; Folding = BAYAACAA5-nW-3i
; EnableXP
; DisableDebugger