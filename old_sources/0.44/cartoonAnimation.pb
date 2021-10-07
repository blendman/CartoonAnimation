
; XIncludeFile "include\infos.pbi"

#ProgramVersionVD = "0.44"
#ProgramNameVD = "Cartoon Animation "
#PB_Compiler_Backend = 0

XIncludeFile "include\enumeration.pbi"

XIncludeFile "include\structures.pbi" ; structure & variables global

XIncludeFile "include\lang.pbi" ; for langage localisation

XIncludeFile "include\init.pbi" ; init encoder/decoder

XIncludeFile "include\macros.pbi" 

XIncludeFile "include\procedures.pbi" 
; XIncludeFile "include\declaration.pbi" 
; XIncludeFile "include\menu.pbi" 
; XIncludeFile "include\swatch.pbi"
; XIncludeFile "include\gadgets.pb" 
; XIncludeFile "include\GadgetR.pbi" ; by guillot & naheulf
; XIncludeFile "include\procedure_draw.pb"
; XIncludeFile "include\layer.pbi"
; XIncludeFile "include\shape.pbi"
; XIncludeFile "include\window.pbi"
; autres: 
; XIncludeFile "include\eventcanvas.pbi"



Procedure OpenWinVectorDrawing()
  
  ; create a window intro, to have the time to load gadgets, menu and hide the main window until all loading are finished
  WindowIntro()
  
  ; init, loadoptions...
  InitVectorDrawing()   
  
  ; open the main window
  If ExamineDesktops()
    winw = DesktopWidth(0)
    winh = DesktopHeight(0)
  EndIf
 
  flag = #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_Maximize
  If OpenWindow(#Win_VD_main, 0, 0, winw, winh, #ProgramNameVD+#ProgramVersionVD+#ProgramBitVD, flag)
    
    ;{ menu, gadgets, misc...
    HideWindow(#Win_VD_main,1)
    VDOptions\ThemeColor = 150
    c = 100 
    SetWindowColor(#Win_VD_main, RGB(c,c,c))
    VDOptions\ToolBarVertical =0
    
    ;{ menu, gadgets...
    VD_Init()
    VD_CreateTheMenu()
    VD_CreatePopUpMenu()
    VDOptions\WinW = WindowWidth(#Win_VD_main)
    VDOptions\WinH = WindowHeight(#Win_VD_main)

    VD_CreateTheGadgets()
    ;}

    ;{ le reste
    ;{ puis, on lance l'initialisation
    
    ; ShapeNew() 
    BG_LoadImage(VdOptions\BgImg\filename$,1,0)
    SetPanelGadget(1)
    ; SetWindowState(#Win_VD_main,VdOptions\WinState)
    Vd_ResizeAll()
    Vd_LayerAdd(0)
    VD_CameraADd(Lang("Camera Default"),0,0,VdOptions\CameraW,VdOptions\CameraH,100,1)
    
    Drawcanvas()
    VDOptions\DocHasChanged = 0
    
    ; pour l'autosave
    rand = Random(1000000)
    TimerAutosave = ElapsedMilliseconds() + VdOptions\AutosaveTime * 1000
    
    BindEvent(#PB_Event_SizeWindow,@Vd_ResizeAll(),#Win_VD_main)
    BindEvent(#PB_Event_Gadget, @MainSwatchEvent(),#Win_VD_main) 
    ;{ Tips
    Tp$ = "To create a line or a curve,select the line or curve tool, then clic and move the mouse./To move,rotate,scale a shape, first : select the object which contain this Shape, then move the mouse./"
    Tp$ + "To add point to the shape, curve or line, use 'addpoint' tool./To create a new object, when creating a new shape, set the checkbox 'Create new objet', in object panel./'"
    n = CountString(tp$,"/")-1
    Dim tip$(n)
    For i =0 To ArraySize(tip$())        
      tip$(i) = StringField(tp$,i+1,"/")
    Next   
    If VdOptions\ShowTip = 1
      MessageRequester("Tips ! ",tip$(Random(n)),32)
    EndIf
    ;}
    ;}
    ; CreateThread(@VD_CheckForUpdate(),23 ); on vérifie si une nouvelle version existe
    
    VD_UpdateShapeBankCanvas(1)

    FreeImage(0)
    FreeGadget(#G_CanvasIntro)
    CloseWindow(#Win_VD_Intro)
    HideWindow(#Win_VD_main,0)
    
    ;}
    
    ;}
    
    IncludeFile "include\loop.pbi"
    
    VD_SaveOptions()
    UnbindEvent(#PB_Event_SizeWindow,@Vd_ResizeAll(),#Win_VD_main)
    
  EndIf
  
  ; RestartScreen()
  
EndProcedure

OpenWinVectorDrawing()


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 3
; Folding = F0
; EnableAsm
; EnableXP
; EnableOnError
; UseIcon = spriteanimation.ico
; Executable = _released\carton0.36.8\cartoon.exe
; DisableDebugger
; EnablePurifier
; EnableUnicode