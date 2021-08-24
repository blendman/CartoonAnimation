; code from animatoon, adapted for cartoon in july 2021
; pb 5.22, 5.31 / 5.71
; dev : blendman

; prop
Procedure SwatchUpdatePropCanvas(x1=0,y1=0,Selected=0)
  
  If IsGadget(#G_WinSwatchCanvas)
    
    column = VdOptions\SwatchColumns
    
    u = Round((GadgetWidth(#G_WinSwatchCanvas)-25) / column, #PB_Round_Down)
    n = ArraySize(SwatchColor()) -1
    
   ;  Debug "Swatch : "+Str(column)+"/"+Str(u)
    
    y = (1+n/column) *u
    If n> 0 And y < 32000
      ;If GadgetHeight(#G_WinSwatchCanvas) <> y Or 
      ResizeGadget(#G_WinSwatchCanvas,#PB_Ignore,#PB_Ignore,#PB_Ignore,y+25)
      SetGadgetAttribute(#G_WinSwatchScroll,#PB_ScrollArea_InnerHeight,y+50)
      ;EndIf
    EndIf
    
    If StartDrawing(CanvasOutput(#G_WinSwatchCanvas))
      Box(0,0,GadgetWidth(#G_WinSwatchCanvas),GadgetHeight(#G_WinSwatchCanvas),RGB(150,150,150))
      For i = 0 To ArraySize(SwatchColor()) -1
        
        With SwatchColor(i)
          x = (i%column) * u
          y = (i/column) *u
          Box(x,y,u,u,RGB(\col\R,\col\G,\col\B))
          
        EndWith
        
      Next 
      
      If Selected = 1
        DrawingMode(#PB_2DDrawing_Outlined)
        Box(x1*u,y1*u,u,u,RGB(255,0,0))
        Box(x1*u+1,y1*u+1,u-2,u-2,RGB(0,0,0))
      EndIf   
      StopDrawing()
      
    EndIf
  EndIf
  
EndProcedure

; swatch
Procedure AddRandomSwatchColor()
  
  
  n = ArraySize(SwatchColor())
  w = GetGadgetAttribute(#G_SA_Swatch,#PB_ScrollArea_InnerWidth)
  ;Debug "taille areascroll"+Str(w)
  u = 10
  
  With SwatchColor(n)
    
    If n > 0
      If n*u > w
        \x = (n*u)% w
        \x = Round(\x/ 10,#PB_Round_Down) * 10
      Else
        \x = n*u
      EndIf      
      \y = n/(w/u) * u
      ; Debug Str(\x)+"/"+Str(\y)
    EndIf
    
    ;\gadImg = n + #G_LastGadget
    If OpenGadgetList(#G_SA_Swatch)
      \img = CreateImage(#PB_Any,u,u)
      h = n/40
      ;r = 255
      ;g = 255
      ;b = 255
      Select h             
        Case 0
          r = (n*10)
          g = n*20
        Case  1
          g = (n*10)
        Case  2            
          b = (n*10) 
        Case 3            
          r = (n*10)
          g = (n*10)
        Case 4            
          r = (n*10)
          b = (n*10)
        Case 5
          g = (n*10)
          b = (n*10)
          r = n*10
      EndSelect
      SetMaximum(r,255)
      SetMaximum(g,255)
      SetMaximum(b,255)
      \Color = RGB(r,g,b)
      \col\R = r
      \col\G = g
      \col\B = b
      If StartDrawing(ImageOutput(\img))
        Box(0,0,u,u,\Color)
        StopDrawing()
      EndIf
      \gadImg = ImageGadget(#PB_Any,\x,\y,u,u,ImageID(\img))
      GadgetToolTip(\gadImg, Str(\color))
      CloseGadgetList()
    EndIf
    
  EndWith
  
  ReDim SwatchColor(n+1)
  
EndProcedure
Procedure AddSwatchColor(r,g,b, name$="",id=-1)
  
  If id=-1
    n = ArraySize(SwatchColor())
  Else
    n = id
    m = ArraySize(SwatchColor())-1
    For i=m To n Step-1
      SwatchColor(i) = SwatchColor(i-1)
    Next  
  EndIf
  
  ; w = GetGadgetAttribute(#G_SA_Swatch,#PB_ScrollArea_InnerWidth)
  ;w = GadgetWidth(#G_SwatchCanvas)
  ;u = 10
  ;col = VDOptions\SwatchColumns
  ;   If col = 0
  ;     col = 7
  ;   EndIf
  
  With SwatchColor(n)
    
    ;     If n > 0
    ;       If n >= col
    ;         \x = n%col * 10
    ;         ; \x = Round(\x/ 10,#PB_Round_Down) * 10
    ;       Else
    ;         \x = n*u
    ;       EndIf      
    ;       \y = Round(n/col,#PB_Round_Down) * u
    ;     EndIf
    ;     
    ;     If OpenGadgetList(#G_SA_Swatch)
    ;       \img = CreateImage(#PB_Any,u,u)
    
    \Color = RGB(r,g,b)
    \col\R = r
    \col\G = g
    \col\B = b
    \name$ = name$
    ; Debug \name$ + "/"+Str(\color)
    ;         If StartDrawing(ImageOutput(\img))
    ;           Box(0,0,u,u,\Color)
    ;           StopDrawing()
    ;         EndIf
    ;       \gadImg = ImageGadget(#PB_Any,\x,\y,u,u,ImageID(\img))
    ;       GadgetToolTip(\gadImg, name$)
    ;       
    ;CloseGadgetList()
    ;EndIf
    
  EndWith
  
  ReDim SwatchColor(n+1)
  
EndProcedure
Procedure SwatchDeleteColor(id,x,y)
  
  If id < ArraySize(SwatchColor())
    n = id
    m = ArraySize(SwatchColor())-1
    For i=n To m
      SwatchColor(i) = SwatchColor(i+1)
    Next 
    ReDim SwatchColor(m)
    SwatchUpdatePropCanvas(x,y,1)
  EndIf
  
EndProcedure
Procedure SwatchSort()
  
  typ = Val(InputRequester("Type of sorting ?", "Typ of sorting ? 0 = by color, 1 = by name","0"))
  
  Select typ 
    Case 0  
      SortStructuredArray(SwatchColor(),#PB_Sort_Descending,OffsetOf(sSwatch\color),  TypeOf(sSwatch\color))
      
    Case 1
      SortStructuredArray(SwatchColor(),#PB_Sort_Ascending,OffsetOf(sSwatch\name$),  TypeOf(sSwatch\name$))
  EndSelect
  
  SwatchUpdatePropCanvas()
  
EndProcedure

; open 
Procedure SwatchUpdate()
  
  Shared ScrolSwInt
  
  If VDOptions\SwatchColumns = 0
     VDOptions\SwatchColumns = 7
  EndIf
  u = Round((GadgetWidth(#G_SwatchCanvas)-ScrolSwInt) / VDOptions\SwatchColumns, #PB_Round_Down)
  
  col = VDOptions\SwatchColumns
  ; Debug "swatch 1 width column :"+Str(col)+"/ largeur case : "+Str(u)
  n = ArraySize(SwatchColor()) -1
  
  y = (1+n/col) *u
  
  If GadgetHeight(#G_SwatchCanvas) < y
    ResizeGadget(#G_SwatchCanvas,#PB_Ignore,#PB_Ignore,#PB_Ignore,y)
    SetGadgetAttribute(#G_SA_Swatch,#PB_ScrollArea_InnerHeight,y)
  EndIf
  
  If StartDrawing(CanvasOutput(#G_SwatchCanvas))
    Box(0,0,GadgetWidth(#G_SwatchCanvas) ,GadgetHeight(#G_SwatchCanvas) ,RGB(150,150,150))
    
    For i = 0 To n
      
      With SwatchColor(i)
        x = (i%col) * u
        y = (i/col) *u
        Box(x,y,u, u,RGB(\col\R,\col\G,\col\B))
        
      EndWith
      
    Next i 
    
    StopDrawing()
    
  EndIf
  
EndProcedure
Procedure SwatchOpen(load=0)
  
  ; load = 0 >
  ; load = 1 > open  swatch
  ; load = 2 > merge swatch
  ; load = 3 > new swatch (clear all)
  
  If load >= 1 ; on demande à ouvrir un fichier
    
    If load<> 3
      file$ = OpenFileRequester(Lang("Open a swatch file"),GetCurrentDirectory() + "data\Presets\Swatch","GPL (Gimp, Krita, Inkscape, Animatoon)|*.gpl|KDE (Koffice)|*.colors",0)
      
      If file$ <> ""
        VDOptions\Swatch$ = File$
        If load = 1 ; open, not merge ;)
          ReDim SwatchColor(0)
        EndIf      
        load = 0
      EndIf
    Else
      ReDim SwatchColor(0)
    EndIf
    
  EndIf
  
;   If load = 2 ; not merge
;     ReDim SwatchColor(0)
;   EndIf
  
  If load = 0
    
    If VDOptions\Swatch$ = #Empty$
      VDOptions\Swatch$ = GetCurrentDirectory()+"data\presets\swatch\Tango.gpl"
    EndIf
    
    ext$ = LCase(GetExtensionPart(VDOptions\Swatch$))
    
    If ext$ = "gpl"
      
      If ReadFile(0,VDOptions\Swatch$)
        
        Editor$ = ReadString(0)     
        VDOptions\SwatchName$ = RemoveString(ReadString(0),"Name: ")
        line$ = ReadString(0)
        st$ = StringField(line$,2," ")
        VDOptions\SwatchColumns = Val(st$)
        
        While Eof(0) = 0    
          line$ = ReadString(0)
          char$ = Mid(line$,1,1)
          
          If char$ <> "#" And line$ <> ""            
            line$ = ReplaceString(line$,Chr(9),Chr(32)) 
            While char$ = Chr(32)
              char$ = Mid(line$,1,1)
              line$ = Right(line$,Len(line$)-1)
            Wend            
            While FindString(line$,Chr(32)+Chr(32)) >= 1
              line$ = ReplaceString(line$,Chr(32)+Chr(32),Chr(32))
            Wend
            RGB$ = line$
            count = CountString(line$,Chr(32))
            R = Val(StringField(RGB$, 1, " "))
            G = Val(StringField(RGB$, 2, " "))
            B = Val(StringField(RGB$, 3, " "))
            Name$ =""          
            For i = 0 To count 
              Name$ + StringField(RGB$, 4+i, " ")            
            Next i
            Name$ = ReplaceString(Name$,Chr(9),"")
            AddSwatchColor(r,g,b,name$)
          EndIf           
        Wend
        CloseFile(0)
      EndIf   
      
;     ElseIf ext$ = "colors"
;       
;       MessageRequester(Lang("Info"),Lang("Not implemented"),4)
;       
    EndIf
    
  EndIf
  
  SwatchUpdatePropCanvas()
  SwatchUpdate()
  
EndProcedure

; save
Macro SwatchSet(Rs,col)  
  If col < 10
    Rs = "  "+Str(col)
  ElseIf col < 100
    Rs = " "+Str(col)
  Else
    Rs = Str(col)
  EndIf
  
EndMacro
Procedure SwatchSave(export=0)
  
  ; for save a swatch.
  ; several format supported : GPL (gimp palette, krita...)
  
  If export = 1 ; save as 
    File$ = SaveFileRequester(Lang("Save Swatch"),"","GPL (Gimp, Krita, Inkscape, Animatoon...)|*.gpl",0);|KDE (Koffice)|*.colors",0)
    If File$ <> ""
      
      ext$  = LCase(GetExtensionPart(File$))
      Pattern = SelectedFilePattern()  
      If pattern = 0
        If ext$ <> "gpl"
          file$ = RemoveString(file$,ext$)
          file$ + ".gpl"
        EndIf
      ElseIf pattern = 1
        If ext$ <> "colors"
          file$ = RemoveString(file$,ext$)
          file$ + ".colors"
        EndIf
      EndIf
      
      VDOptions\Swatch$ = File$
      export = 0
    EndIf
  EndIf
  
  If export =0
    
    ext$  = GetExtensionPart(VDOptions\Swatch$)
    
    If ext$ = "gpl"
      
      If CreateFile(0,VDOptions\Swatch$)
        
        WriteStringN(0, "Cartoon Palette")
        WriteStringN(0, "Name: "+ VDOptions\SwatchName$)
        WriteStringN(0, "Columns: "+ Str(VDOptions\SwatchColumns))
        WriteStringN(0, "# ")
        
        For i = 0 To ArraySize(SwatchColor())-1
          
          SwatchSet(R$,SwatchColor(i)\col\R)
          SwatchSet(G$,SwatchColor(i)\col\G)
          SwatchSet(B$,SwatchColor(i)\col\B)             
          WriteStringN(0, R$+" "+G$+" "+B$+"	"+SwatchColor(i)\name$)
          
        Next i
        
        CloseFile(0)
        
      EndIf
      
;     ElseIf ext$ = "colors"
;       
;       MessageRequester(Lang("Info"),Lang("Not implemented"),4)
    EndIf
    
  EndIf
  
EndProcedure


; create
Macro CreateSwatch()
  ;   For i = 0 To 200
  ;     AddRandomSwatchColor()
  ;   Next i
  SwatchOpen()
EndMacro

; create swatch from image
Procedure SwatchCreateFromImage()
  
  File$ = OpenFileRequester(Lang("Open Image"),"","IMAGE|*.jpg;*.png;*.bmp",0)
  
  If file$ <> ""
    
    w = Val(InputRequester(Lang("Max colors"), Lang("Set the maximum number of colors (for the palette)"),""))
    
    If w > 0
      If LoadImage(0,file$)
        
        ReDim SwatchColor(0)
        width = Round(Sqr(w),#PB_Round_Down)
        ResizeImage(0,width,width,1)
        
        If StartDrawing(ImageOutput(0))
          For i= 0 To width-1
            For j = 0 To width-1
              color = Point(i,j)
              name$ = "color"+Str(a)
              ok = 1
              For aa = 0 To ArraySize(SwatchColor())
                If color = SwatchColor(aa)\Color
                  ok = 0
                  Break
                EndIf
              Next aa
              If ok = 1
                AddSwatchColor(Red(color),Green(color),Blue(color),Name$)
                a+1
              EndIf 
              
            Next j
          Next i
          StopDrawing()
        EndIf
        
        SwatchUpdatePropCanvas()
      EndIf                  
    EndIf
  EndIf
  
EndProcedure

; gadget on main window
Procedure CreateSwatchGadget()
  
  Shared ScrolSwInt
  ; add swatch gagdet for the tab panel of the main window
  PanelLayerW = VdOptions\PanelLayerW
  
  ; create the gadgets
  yy = 5 : i = 5 : bw = 22 : wbt = 23
  AddButonImage(#G_SwatchNew,i,yy,bw,bw,  ImgVd(#Img_New),#PB_Button_Default,    lang("Create a new swatch")) :  i=i+wbt
  AddButonImage(#G_SwatchOpen,i,yy,bw,bw, ImgVd(#Img_Open),#PB_Button_Default,  lang("Open a swatch"))       :  i=i+wbt
  AddButonImage(#G_SwatchMerge,i,yy,bw,bw,ImgVd(#Img_Open),#PB_Button_Default,lang("Merge a swatch"))      :  i=i+wbt
  AddButonImage(#G_SwatchSave,i,yy,bw,bw, ImgVd(#Img_Save),#PB_Button_Default,  lang("Save the swatch"))     :  i=i+wbt
  AddButonImage(#G_SwatchExport,i,yy,bw,bw,ImgVd(#Img_Save),#PB_Button_Default,lang("Export the swatch")) :  i=i+wbt
  AddButonImage(#G_SwatchEdit,i,yy,bw,bw,  ImgVd(#Img_Properties),#PB_Button_Default,  lang( "Edit the swatch"))    :  i=i+wbt
  
  wsa = PanelLayerW-20
  i=5
  ScrolSwInt = 25
  h = 400
  If ScrollAreaGadget(#G_SA_Swatch,i,30,wsa,h-180,wsa-ScrolSwInt,h-180)
    If CanvasGadget(#G_SwatchCanvas,0,0,wsa, h-180)
      CreateSwatch()        
    EndIf      
    CloseGadgetList()
  EndIf
    
EndProcedure

; event on canvas of the main window
Procedure SwatchEvent(EventType)
  
  Shared ScrolSwInt
  Static idd
   ; event for swatch in main window
   
  u = (GadgetWidth(#G_SwatchCanvas)-ScrolSwInt)/VDOptions\SwatchColumns
  ;Debug "taille case : "+Str(u)
  nb = GadgetWidth(#G_SwatchCanvas)/u
  x1 = GetGadgetAttribute(#G_SwatchCanvas, #PB_Canvas_MouseX)
  y1 = GetGadgetAttribute(#G_SwatchCanvas, #PB_Canvas_MouseY)
  x = Round(x1/u,#PB_Round_Down)
  y = Round(y1/u,#PB_Round_Down)
  
  newidd = x+ y*nb
  If newidd <> idd
    If newidd < ArraySize(SwatchColor())-1 And newidd >=0
      idd = newidd
      GadgetToolTip(#G_SwatchCanvas,SwatchColor(idd)\name$)
    EndIf
  EndIf
  
  If EventType = #PB_EventType_LeftButtonDown
    ; Debug SwatchColor(idd)\name$
    If StartDrawing(CanvasOutput(#G_SwatchCanvas))
      color = Point(x1,y1)
      ; getcolor(
      ; SetColor()
      StopDrawing()
      ; BrushUpdateColor() 
    EndIf
    ; Debug "id "+Str(newidd)+"/"+Str(x)+"/"+Str(y)
    If vd\PanelLeftItem<> 4 And vd\PanelLeftName$ <> lang("FX")
      Shape_SetPropertie(#ShapePropertie_Color,color)
    Else
      Debug color
      Shape_SetFXpropertie(#ShapePropertie_Color,0,color)
    EndIf
    
  Else    
    
  EndIf
  
EndProcedure



; window swatch editor
Procedure SwatchEditProp()
  
  If OpenWindow(#Win_Swatch,0,0,550,460,Lang("Swatch properties"),
                #PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_Tool|#PB_Window_ScreenCentered, WindowID(#Win_VD_main))
    
    ; SetWindowColor(#Win_Swatch,VDOptions\ThemeColor)
    i = 5
    column = VDOptions\SwatchColumns
    ; butons
    w1 = 80 ; size 
    xb = WindowWidth(#Win_Swatch) - w1 - 10 ; x  
    
    If StringGadget(#G_WinSwatchName,10,i,150,20,VDOptions\SwatchName$) : EndIf
    GadgetToolTip(#G_WinSwatchName, Lang("Swatch global name"))
    If SpinGadget(#G_WinSwatchNbCol,170,i,40,20,1,64,#PB_Spin_Numeric) : EndIf
    SetGadgetState(#G_WinSwatchNbCol,column)
    i +25
    GadgetToolTip(#G_WinSwatchNbCol, Lang("Number of Columns for the swatch"))
    
    If ScrollAreaGadget(#G_WinSwatchScroll, 10,i,xb-20,400,xb-20-25,400)
      SetGadgetColor(#G_WinSwatchScroll,#PB_Gadget_BackColor,RGB(150,150,150))
      If CanvasGadget(#G_WinSwatchCanvas,0,0,xb-20,400) : EndIf
      i + 405 
      CloseGadgetList()
    EndIf
    
    If StringGadget(#G_WinSwatchNameSwatch,10,i,150,20,Lang("Swatch name")) : EndIf
    ;If ButtonGadget(#G_WinSwatchBtnOk,10,i,150,20,Lang("Swatch name")) : EndIf
    
    i = 5
    If ButtonGadget(#G_WinSwatchNew,xb,i,w1,20,   Lang("New"))    : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchOpen,xb,i,w1,20,  Lang("Open"))   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchMerge,xb,i,w1,20, Lang("Merge"))  : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchSave,xb,i,w1,20,  Lang("Save"))   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchExport,xb,i,w1,20,Lang("Export")) : i + 35  : EndIf
    If ButtonGadget(#G_WinSwatchSort,xb,i,w1,20,  Lang("Sort"))   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchFromImg,xb,i,w1,20,Lang("From Image"))   : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchInsert,xb,i,w1,20,Lang("Insert")) : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchAdd,xb,i,w1,20,   Lang("Add"))    : i + 25  : EndIf
    If ButtonGadget(#G_WinSwatchDel,xb,i,w1,20,   Lang("Delete")) : i + 25  : EndIf
    
    SwatchUpdatePropCanvas()
    
    Repeat
      
      Event       = WaitWindowEvent(1)
      EventType   = EventType()
      EventGadget = EventGadget()
      
      Select Event
          
        Case #PB_Event_Gadget
          
          Select EventGadget()
              
            Case #G_WinSwatchCanvas
              
              If EventType = #PB_EventType_LeftButtonDown 
                u = Round((GadgetWidth(#G_WinSwatchCanvas)-25) / VDOptions\SwatchColumns, #PB_Round_Down)
                xsw = Round(GetGadgetAttribute(#G_WinSwatchCanvas, #PB_Canvas_MouseX)/u,#PB_Round_Down)
                ysw = Round(GetGadgetAttribute(#G_WinSwatchCanvas, #PB_Canvas_MouseY)/u,#PB_Round_Down)
                id = xsw +ysw * VDOptions\SwatchColumns             
                If StartDrawing(CanvasOutput(#G_WinSwatchCanvas))
                  If id <= ArraySize(SwatchColor())-1
                    SetGadgetText(#G_WinSwatchNameSwatch,SwatchColor(id)\name$)
                  EndIf
                  StopDrawing()
                  SwatchUpdatePropCanvas(xsw,ysw,1)  
                EndIf
              ElseIf EventType = #PB_EventType_LeftDoubleClick
                Color = ColorRequester(SwatchColor(id)\Color)
                SwatchColor(id)\col\R = Red(color)
                SwatchColor(id)\col\G = Green(color)
                SwatchColor(id)\col\B = Blue(color)
                SwatchColor(id)\Color  = color
                SwatchUpdatePropCanvas(xsw,ysw,1)                
              EndIf
              
            Case #G_WinSwatchNbCol
              VDOptions\SwatchColumns = GetGadgetState(#G_WinSwatchNbCol)              
              SwatchUpdatePropCanvas(xsw,ysw,1)
              
            Case #G_WinSwatchName
              If EventType = #PB_EventType_Focus  Or EventType = #PB_EventType_Change  
                VDOptions\SwatchName$ = GetGadgetText(#G_WinSwatchName)        
              EndIf
              
            Case #G_WinSwatchNameSwatch
              If EventType = #PB_EventType_Focus  Or EventType = #PB_EventType_Change  
                If id <=ArraySize(SwatchColor())
                  SwatchColor(id)\name$ = GetGadgetText(#G_WinSwatchNameSwatch)     
                EndIf
              EndIf
              
            Case #G_WinSwatchNew
              ReDim SwatchColor(0)
              SwatchUpdatePropCanvas()
              
            Case #G_WinSwatchFromImg
              SwatchCreateFromImage() 
              
            Case #G_WinSwatchAdd
              color = ColorRequester()
              Name$ = InputRequester("Name","Name of the new swatch : ","Untitled")
              AddSwatchColor(Red(color),Green(color),Blue(color),Name$)
              SwatchUpdatePropCanvas(xsw,ysw,1)
              
            Case #G_WinSwatchOpen
              SwatchOpen(2) 
              
            Case #G_WinSwatchmerge
              SwatchOpen(1)
              
            Case #G_WinSwatchExport
              SwatchSave(1)
              
            Case #G_WinSwatchSave
              SwatchSave()
              
            Case #G_WinSwatchDel
              SwatchDeleteColor(id,xsw,ysw)
              
            Case #G_WinSwatchInsert
              color = ColorRequester()
              Name$ = InputRequester("Name","Name of the new swatch : ","Untitled")
              AddSwatchColor(Red(color),Green(color),Blue(color),Name$,id)
              SwatchUpdatePropCanvas(xsw,ysw,1)
              
            Case #G_WinSwatchSort
              SwatchSort() 
              
          EndSelect
          
      EndSelect
    Until event = #PB_Event_CloseWindow
    
    CloseWindow(#Win_Swatch)
    SwatchUpdate()
  EndIf
EndProcedure

; event
Procedure MainSwatchEvent()
  
  Select EventGadget()
    Case #G_SwatchOpen
      SwatchOpen(1) 
      
    Case #G_SwatchMerge
      SwatchOpen(2)
      
    Case #G_SwatchSave
      SwatchSave()
      
    Case #G_SwatchExport
      SwatchSave(1)
      
    Case #G_SwatchEdit
      SwatchEditProp()
      
    Case #G_SwatchCanvas
      SwatchEvent(EventType())
  EndSelect
  
EndProcedure


; IDE Options = PureBasic 5.61 (Windows - x86)
; CursorPosition = 523
; FirstLine = 45
; Folding = AAAAAAAAAAAkz+-Bg-
; EnableXP
; EnableUnicode