; procedures 

XIncludeFile "declaration.pbi"

;{ init (init, Images, options)
; init 
Procedure ErrorHandler()
 
  ErrorMessage$ = "A program error was detected:" + Chr(13) 
  ErrorMessage$ + Chr(13)
  ErrorMessage$ + "Error Message:   " + ErrorMessage()      + Chr(13)
  ErrorMessage$ + "Error Code:      " + Str(ErrorCode())    + Chr(13)  
  ErrorMessage$ + "Code Address:    " + Str(ErrorAddress()) + Chr(13)
 
  Select ErrorCode() 
      Case #PB_OnError_InvalidMemory   
          ErrorMessage$ + "Error IMA :  " + Str(ErrorTargetAddress()) + Chr(13)
          
      Case #PB_OnError_DivideByZero 
          ErrorMessage$ + "Error divide by zero :  " + Str(ErrorTargetAddress()) + Chr(13)
          
      ;Case #PB_OnError_IllegalInstruction    
          
  EndSelect
 
  If ErrorLine() = -1
    ; ErrorMessage$ + "Sourcecode line: Enable OnError lines support to get code line information." + Chr(13)
  Else
    ErrorMessage$ + "Sourcecode line: " + Str(ErrorLine()) + Chr(13)
    ErrorMessage$ + "Sourcecode file: " + ErrorFile() + Chr(13)
  EndIf
 
  ErrorMessage$ + Chr(13)
;   ErrorMessage$ + "Register content:" + Chr(13)
;  
;   CompilerSelect #PB_Compiler_Processor 
;     CompilerCase #PB_Processor_x86
;       ErrorMessage$ + "EAX = " + Str(ErrorRegister(#PB_OnError_EAX)) + Chr(13)
;       ErrorMessage$ + "EBX = " + Str(ErrorRegister(#PB_OnError_EBX)) + Chr(13)
;       ErrorMessage$ + "ECX = " + Str(ErrorRegister(#PB_OnError_ECX)) + Chr(13)
;       ErrorMessage$ + "EDX = " + Str(ErrorRegister(#PB_OnError_EDX)) + Chr(13)
;       ErrorMessage$ + "EBP = " + Str(ErrorRegister(#PB_OnError_EBP)) + Chr(13)
;       ErrorMessage$ + "ESI = " + Str(ErrorRegister(#PB_OnError_ESI)) + Chr(13)
;       ErrorMessage$ + "EDI = " + Str(ErrorRegister(#PB_OnError_EDI)) + Chr(13)
;       ErrorMessage$ + "ESP = " + Str(ErrorRegister(#PB_OnError_ESP)) + Chr(13)
;  
;     CompilerCase #PB_Processor_x64
;       ErrorMessage$ + "RAX = " + Str(ErrorRegister(#PB_OnError_RAX)) + Chr(13)
;       ErrorMessage$ + "RBX = " + Str(ErrorRegister(#PB_OnError_RBX)) + Chr(13)
;       ErrorMessage$ + "RCX = " + Str(ErrorRegister(#PB_OnError_RCX)) + Chr(13)
;       ErrorMessage$ + "RDX = " + Str(ErrorRegister(#PB_OnError_RDX)) + Chr(13)
;       ErrorMessage$ + "RBP = " + Str(ErrorRegister(#PB_OnError_RBP)) + Chr(13)
;       ErrorMessage$ + "RSI = " + Str(ErrorRegister(#PB_OnError_RSI)) + Chr(13)
;       ErrorMessage$ + "RDI = " + Str(ErrorRegister(#PB_OnError_RDI)) + Chr(13)
;       ErrorMessage$ + "RSP = " + Str(ErrorRegister(#PB_OnError_RSP)) + Chr(13)
;       ErrorMessage$ + "Display of registers R8-R15 skipped."         + Chr(13)
;  
;   CompilerEndSelect
 
  MessageRequester("Error", ErrorMessage$)
  End
 
EndProcedure

Procedure InitVectorDrawing()
  ; LoadFont(0, "Times New Roman", 20, #PB_Font_Bold)
  ;on charge les préférences
  VD_LoadOptions()
  
  OnErrorCall(@ErrorHandler())
EndProcedure

Procedure VD_CheckForUpdate(*param)
    
    ; init the netwrok for update and other cool things
    If InitNetwork() = 0
        MessageRequester("Error","Unable to init the network. It's used for some features (like update or futur render farming")
    Else
        
        VersionFile$ = GetCurrentDirectory() + "data\version.txt"
        file = ReceiveHTTPFile("https://raw.githubusercontent.com/blendman/CartoonAnimation/master/version.txt", VersionFile$)
        
        If file <> 0
            
            If ReadFile(7,VersionFile$)
                
                line$ = ReadString(7)
                
                NewVersion.d = ValD(line$)
               
                txt$ =""
                
                While Eof(7) =0
                    txt$ + ReadString(7)+Chr(10)
                Wend
                CloseFile(7)
                
                If NewVersion > ValD(#ProgramVersionVD)
                    
                    VD\UpdateOk = 1
                    VD\NewVersionTxt$ = txt$
                    VD\NewVersion = NewVersion
                    
                EndIf
                
                
               
            EndIf
        EndIf
        
    EndIf
    
    
EndProcedure

Procedure Vd_OpenWinUpdate()
    
    If OpenWindow(#Win_VD_update,0,0,400,300,"New version available",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
        
        
        If EditorGadget(#G_VD_UpdateEdit,5,5,WindowWidth(#Win_VD_update)-10,250,#PB_Editor_ReadOnly|#PB_Editor_WordWrap) : EndIf
        AddGadgetItem(#G_VD_UpdateEdit,0,"")
        
        Nw0$ = StrD(Vd\NewVersion,2)
        Nw1$ = StrD(Vd\NewVersion,3)                
        If Vd\NewVersion>ValD(Nw0$) 
            n = 1
        EndIf
        If Vd\NewVersion>ValD(Nw1$)
            n = 2
        EndIf
                
        AddGadgetItem(#G_VD_UpdateEdit,1,"A new version is available : "+StrD(Vd\NewVersion,n+2))
        AddGadgetItem(#G_VD_UpdateEdit,2,"")
        AddGadgetItem(#G_VD_UpdateEdit,3,Vd\NewVersionTxt$)
        
        h1 = 25
        If ButtonGadget(#G_VD_UpdateBtnOk,170,270,50,h1,"Ok") : EndIf
        If ButtonGadget(#G_VD_UpdateBtnCancel,GadgetX(#G_VD_UpdateBtnOk)+GadgetWidth(#G_VD_UpdateBtnOk)+10,270,50,h1,"Cancel") : EndIf
        
        Repeat
            
            event = WaitWindowEvent(1)
            If event = #PB_Event_Gadget
                
                If EventGadget() = #G_VD_UpdateBtnOk
                    RunProgram("https://github.com/blendman/CartoonAnimation")
                    quit = 1 
                ElseIf EventGadget() = #G_VD_UpdateBtnCancel
                    quit = 1
                EndIf
            ElseIf event = #PB_Event_CloseWindow    
                quit = 1
            EndIf
            
            
        Until quit = 1
        
        CloseWindow(#Win_VD_update)
        
    EndIf
    
EndProcedure


; images
Procedure LoadImage2(id,file$)
    
    If FileSize(file$) > 0
        temp  = LoadImage(id,file$)
                
        If temp <> 0 
            
        Else
            ; MessageRequester(StringField(Dico\Error$,2,"|"),StringField(Dico\Error$,5,"|") +file$+".",#MR_error)
            MessageRequester("Error","Unable to load the image file "+file$,#MR_error)
        EndIf
        
        ProcedureReturn temp
    Else
        ; MessageRequester(StringField(Dico\Error$,2,"|"),StringField(Dico\Error$,8,"|")+file$,#MR_error)
        MessageRequester("Error","The Image file doesn't exists :  "+file$,#MR_error)
        ProcedureReturn -1
    EndIf

EndProcedure

Procedure FreeImage2(Img)
    If IsImage(Img)
        FreeImage(img)
    EndIf    
EndProcedure

Procedure InitImages()
    
    ; chargement des images 
    
    Global Dim ImgVD.i(#Img_VdLast)
   
    ImgVd(#Img_New)    = LoadImage2(#PB_Any,"data\editor\new.png")
    ImgVd(#Img_open)    = LoadImage2(#PB_Any,"data\editor\open.png")
    ImgVd(#Img_Save)    = LoadImage2(#PB_Any,"data\editor\save.png")
    
    
    ImgVd(#Img_Move)    = LoadImage2(#PB_Any,"data\editor\move.png")
    ImgVd(#Img_Rot)     = LoadImage2(#PB_Any,"data\editor\rotate.png")
    ImgVd(#Img_Scale)   = LoadImage2(#PB_Any,"data\editor\scale.png")
    ImgVd(#Img_Addpt)   = LoadImage2(#PB_Any,"data\editor\addpt.png")
    ImgVd(#Img_Delpt)   = LoadImage2(#PB_Any,"data\editor\delpt.png")
    ImgVd(#Img_MovePt)   = LoadImage2(#PB_Any,"data\editor\movept.png")
    ImgVd(#Img_Select)  = LoadImage2(#PB_Any,"data\editor\select.png")
    
    ImgVd(#Img_Zoom)    = LoadImage2(#PB_Any,"data\editor\zoom.png")
    ImgVd(#Img_Pan)     = LoadImage2(#PB_Any,"data\editor\pan.png")
    
    ImgVd(#Img_Shape)   = LoadImage2(#PB_Any,"data\editor\shape.png")
    ImgVd(#Img_Box)     = LoadImage2(#PB_Any,"data\editor\box.png")
    ImgVd(#Img_BoxRnd)  = LoadImage2(#PB_Any,"data\editor\boxround.png")
    ImgVd(#Img_Circle)  = LoadImage2(#PB_Any,"data\editor\circle.png")
    ImgVd(#Img_Line)    = LoadImage2(#PB_Any,"data\editor\line.png")
    ImgVd(#Img_Curve)   = LoadImage2(#PB_Any,"data\editor\curve.png")
    ImgVd(#Img_Image)   = LoadImage2(#PB_Any,"data\editor\image.png")
    ImgVd(#Img_Text)    = LoadImage2(#PB_Any,"data\editor\text.png")
    ImgVd(#Img_MirorH)    = LoadImage2(#PB_Any,"data\editor\mirorh.png")
    ImgVd(#Img_MirorV)    = LoadImage2(#PB_Any,"data\editor\mirorv.png")
    ;ImgVd(#Img_FreeForm) = LoadImage2(#PB_Any,"data\editor\freeform.png")
    ;ImgVd(#Img_Polygon) = LoadImage2(#PB_Any,"data\editor\polygon.png")
    
    ImgVd(#Img_Properties) = LoadImage2(#PB_Any,"data\editor\properties.png")
    ImgVd(#Img_Hard)    = LoadImage2(#PB_Any,"data\editor\hard.png")
    ImgVd(#Img_Soft)  = LoadImage2(#PB_Any,"data\editor\soft.png")
    
    ImgVd(#Img_Play)  = LoadImage2(#PB_Any,"data\editor\play.png")
    ImgVd(#Img_Stop)  = LoadImage2(#PB_Any,"data\editor\stop.png")
    ImgVd(#Img_Start)  = LoadImage2(#PB_Any,"data\editor\start.png")
    ImgVd(#Img_End)  = LoadImage2(#PB_Any,"data\editor\end.png")
    ImgVd(#Img_Loop)  = LoadImage2(#PB_Any,"data\editor\loop.png")
    
    
    Global Dim ImgLayer.i(10)
    
    ImgLayer(#ivd_layer)        = LoadImage(#PB_Any,"data\editor\layer.jpg")
    ImgLayer(#ivd_layersel)     = LoadImage(#PB_Any,"data\editor\layerSel.jpg")
    ImgLayer(#ivd_layeradd)     = LoadImage(#PB_Any,"data\editor\layerbtn1.jpg")
    ImgLayer(#ivd_layerdel)     = LoadImage(#PB_Any,"data\editor\layerbtn2.jpg")
    ImgLayer(#ivd_layerhide)    = LoadImage(#PB_Any,"data\editor\layerEye.jpg")
    ImgLayer(#ivd_layerlock)    = LoadImage(#PB_Any,"data\editor\locked.png")
    ImgLayer(#ivd_layerup)      = LoadImage(#PB_Any,"data\editor\up.png")
    ImgLayer(#ivd_layerdown)    = LoadImage(#PB_Any,"data\editor\down.png")
    
    If LoadImage(#ico_Image,"data\editor\image.png") : EndIf
    
    
    If LoadFont(0,"arial",30) : EndIf
    If LoadFont(#FontArial20Bold,"arial",20,#PB_Font_Bold) : EndIf
   
EndProcedure

Procedure ResizeImageProportion(image,width,mode=#PB_Image_Raw)
  s = width
  t = image
  w = ImageWidth(t)
  h = ImageHeight(t)
  If w>h And w>0
    nw = s
    nh = (h * s)/w
    ok=1
  Else
    If h>0
      nh = s
      nw = (w * s)/h
      ok=1
    EndIf
  EndIf
  If ok=1
    ResizeImage(image, nw, nh, mode)
  EndIf
EndProcedure



;{ unpremultiply
;{ module unpremultiply

CompilerIf #PB_Compiler_Backend = 0
; MOdule by Wilbert
DeclareModule Premultiply
  
  ; 32 bits RGBA or BGRA pixel buffer
  
  Declare PremultiplyPixels(*PixelBuffer32, NumPixels)
  Declare UnpremultiplyPixels(*PixelBuffer32, NumPixels)
  
EndDeclareModule

Module Premultiply
  
  EnableASM
  DisableDebugger
    
  CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
    Macro rax : eax : EndMacro
    Macro rbx : ebx : EndMacro
    Macro rcx : ecx : EndMacro
    Macro rdx : edx : EndMacro
    Macro rsi : esi : EndMacro
  CompilerEndIf
  
  Procedure PremultiplyPixels(*PixelBuffer32, NumPixels)
    LEA rax, [premultiply.l_premultiplyTable]
    MOV rdx, *PixelBuffer32
    MOV rcx, NumPixels
    PUSH rbx
    PUSH rsi
    MOV rsi, rax
    !premultiply.l_premul0:
    MOVZX eax, word [rdx + 2]
    CMP ah, 255
    !je premultiply.l_premul1
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 2], bl
    MOV al, [rdx + 1]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 1], bl
    MOV al, [rdx]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx], bl
    !premultiply.l_premul1:
    ADD rdx, 4
    SUB rcx, 1
    !jnz premultiply.l_premul0
    POP rsi
    POP rbx   
  EndProcedure
  
  Procedure UnpremultiplyPixels(*PixelBuffer32, NumPixels)
    LEA rax, [premultiply.l_premultiplyTable + 0x10000]
    MOV rdx, *PixelBuffer32
    MOV rcx, NumPixels
    PUSH rbx
    PUSH rsi
    MOV rsi, rax
    !premultiply.l_unpremul0:
    MOVZX eax, word [rdx + 2]
    CMP ah, 255
    !je premultiply.l_unpremul1
    CMP ah, 0
    !je premultiply.l_unpremul1
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 2], bl
    MOV al, [rdx + 1]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx + 1], bl
    MOV al, [rdx]
    MOVZX ebx, byte [rsi + rax]
    MOV [rdx], bl
    !premultiply.l_unpremul1:
    ADD rdx, 4
    SUB rcx, 1
    !jnz premultiply.l_unpremul0
    POP rsi
    POP rbx
  EndProcedure
  
  Procedure FillTable()
    LEA rdx, [premultiply.l_premultiplyTable]
    PUSH rbx
    MOV ebx, 255
    SUB ecx, ecx
    !premultiply.l_filltable0:
    MOVZX eax, ch
    MUL cl
    ADD eax, 127
    DIV bl
    MOV [rdx + rcx], al
    ADD cx, 1
    !jnz premultiply.l_filltable0
    ADD rdx, 0x10000
    MOV ecx, 0x100
    SUB bx, bx
    !premultiply.l_filltable1:
    MOV eax, 255
    CMP cl, ch
    !jae premultiply.l_filltable2
    MUL cl
    ADD ax, bx
    DIV ch
    !premultiply.l_filltable2:
    MOV [rdx + rcx], al
    ADD cl, 1
    !jnz premultiply.l_filltable1
    MOVZX bx, ch
    ADD bx, 1
    SHR bx, 1
    ADD ch, 1
    !jnz premultiply.l_filltable1
    POP rbx
  EndProcedure
  
  FillTable()
  
  DataSection
    !premultiply.l_premultiplyTable: times 131072 db 0
  EndDataSection
  
  
EndModule
CompilerEndIf
;}

Procedure UnPreMultiplyAlpha(image)
  ; by Chi, english forum
  c = 255
  tmp = CopyImage(image,#PB_Any)
  
  If StartDrawing(ImageOutput(image))
    DrawingMode(#PB_2DDrawing_AllChannels)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
    DrawAlphaImage(ImageID(tmp),0,0)
    
    DrawingMode(#PB_2DDrawing_AlphaClip)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
   ; DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(tmp),0,0)
    
    For y=0 To ImageHeight(image)-1
      For x=0 To ImageWidth(image)-1
        color = Point(x, y)
        alpha = Alpha(color)
        
        alpha2 = Alpha(color)
        If alpha=0 : alpha=1 : EndIf
        If alpha2>0
          ;r = (255 * Red(color) + (alpha2 /2)) /alpha
          r = (c * Red(color) ) /alpha
          If r>255
            r=255
          EndIf
          ;g = (255 * Green(color) + (alpha2 /2)) /alpha
          g = (c * Green(color)) /alpha
          If g>255
            g=255
          EndIf
          ;b = (255 * Blue(color) + (alpha2 /2)) /alpha
          b = (c * Blue(color) ) /alpha
          If b>255
            b = 255
          EndIf
          Plot(x, y, RGBA( r, g, b, alpha2))
        Else
          Plot(x, y, RGBA(Red(color), Green(color), Blue(color), alpha2))
        EndIf
      Next
    Next
    StopDrawing()
  EndIf
  
  FreeImage2(tmp)
  
  ; MessageRequester("", "unpremul ok : "+Str(image))
  
  ProcedureReturn image
EndProcedure

;}



Procedure VD_Init()
    
    InitImages()
    
    With Vd
        \ShapeFileName$="1-defaut.txt"        
        \FrameEnd = 300
        \FrameFps  = 24
    EndWith
        
EndProcedure

;}

XIncludeFile "menu.pbi" 

XIncludeFile "swatch.pbi" 
 
XIncludeFile "GadgetR.pbi"
UseModule GadgetR
 
XIncludeFile "gadgets.pb" 

XIncludeFile "procedure_draw.pb"

;{ Scene, camera
Procedure VD_CameraAdd(name$,x,y,w,h,scale,zoom.d)
  NBcamera+1
  i = NBcamera
  ReDim VD_camera.sVDCamera(i)
  With VD_camera(i)
    \w = w
    \h = h
    \x = x
    \y = y
    \name$ = name$
    \scale = scale
    \zoom = zoom
  EndWith
EndProcedure
;}
 

XIncludeFile "layer.pbi"

XIncludeFile "shape.pbi"

XIncludeFile "window.pbi"


;{ Animation

Procedure ScreenFPS()
    
    Static s.i, PGL_Fps.i, PGL_NewFps.i
    Define ss.i
    
    ss = Second(Date())
    PGL_Fps + 1
    
    If s <> ss
        s=ss
        PGL_NewFps = PGL_fps
        PGL_fps=0
    EndIf
    
    ProcedureReturn PGL_NewFps
EndProcedure

Procedure VdDrawAnimation()
    
     ; pour dessiner le canvas
    z.d
    z = VdOptions\Zoom*0.01
    vx = Vd\viewX
    vy = Vd\viewY
    
    If StartVectorDrawing(CanvasVectorOutput(#G_canvasVector))
   
        ; je reset les coordonnées
        ResetCoordinates()
        
        
        ; ClipOutput(VD_camera(cameraId)\x, VD_camera(cameraId)\y, VD_camera(cameraId)\w, VD_camera(cameraId)\h)
        
        ; J'efface avec un simple Background, pour gagner du temps
        AddPathBox(0,0, GadgetWidth(#G_canvasVector),GadgetHeight(#G_canvasVector))
        VectorSourceColor(VdOptions\BgColor)
        FillPath()
        
        VD_ResetCoord()
        VD_DrawScene(0,0,0, 1)
        
        ; cache camera
        AddPathBox(0,0, GadgetWidth(#G_canvasVector)/Z,GadgetHeight(#G_canvasVector)/Z)
        AddPathBox(vx,vy, VD_camera(cameraId)\W, VD_camera(cameraId)\H)
        VectorSourceColor(RGBA(0,0,0,255))
        FillPath()
        
        ResetCoordinates()
        ; on vérifie qu'on est dans le bon timing, si oui, on affiche
        If ElapsedMilliseconds() > Vd\playTimer + vd\FrameFPS *0.001
            Vd\playTimer = ElapsedMilliseconds()
            
            ; on modifie la frame courante
            vd\CurrentFrame +1 
            If vd\CurrentFrame > vd\FrameEnd
                vd\CurrentFrame = 0
            EndIf
            
        EndIf
    
        MovePathCursor(0,0)
        VectorFont(FontID(0), 20)
        AddPathText("Frame : "+Str(Vd\CurrentFrame)+" / End : "+Str(Vd\FrameEnd)+" | FPS : "+Str( ScreenFPS()))
        VectorSourceColor(RGBA(255,255,255,255))
        FillPath()
         
        StopVectorDrawing()
    EndIf

EndProcedure

Procedure PlayAnimation()
  
  VdDrawAnimation()
  
EndProcedure

;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 278
; FirstLine = 77
; Folding = BA8A+-7DocH9
; EnableXP
; EnableOnError
; DisableDebugger