




; Layer
; Procedure Vd_Layer_Add(new= 1)
;   
; EndProcedure  


; objet
Procedure VD_Layer_ResetClipping(n)
  With Obj(n)
    \ClipW = 1075
    \ClipH = 983
    \ClipAlpha = 255
    \ClipColor = RGB(255,255,255)
    \ClipBorder = 0
    \ClipBorderAlpha = 255
    \ClipBorderStroke = 10
    \ClipBorderColor = 0
  EndWith
EndProcedure
Procedure Vd_LayerAdd(new= 1)
  
  ; pour ajouter un objet (layer)
  ; d'abord, on déselectionne tous les autres shapes
  ;For i=0 To ArraySize(Obj())
    For j=0 To ArraySize(obj(ObjId)\Shape())
      With obj(ObjId)\Shape(j)
        \selected = 0
      EndWith
    Next
  ;Next
    
  ShapeId = 0
    
  n = ArraySize(Obj())+new
  ReDim Obj(n)
  With Obj(n)
    \Alpha = 255
    \Depth = n
    \w = 100
    \h = 100
    \x = 0
    \y = 0
    \Nom$ = "Layer"+Str(n)
    ; clip
   VD_Layer_ResetClipping(n)
  EndWith
  
  ObjId = n
  SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
  VD_Layer_UpdateUI(1)
  
EndProcedure


Procedure Layer_CheckIfOk(i)
  
  If obj(i)\Locked = 0 And obj(i)\Hide = 0
    ProcedureReturn 1
  EndIf
  
EndProcedure

Procedure VD_Layer_UpdateUI(update = 0)
  
  
  ; pour mettre à jour la liste des layer actuellement disponibles (donc, les dessiner sur le canvas des layers)
  n = ArraySize(Obj())
  ; Debug n
  If StartDrawing(CanvasOutput(#G_ObjList))
    
    Box(0,0,OutputWidth(),OutputHeight(),RGB(100,100,100))
    
    For i=0 To n  ;To 0 Step -1
      
      j = n-i
      
      If i = ObjId
        DrawImage(ImageID(ImgLayer(#ivd_layersel)),0,25*j) 
      Else                
        DrawImage(ImageID(ImgLayer(#ivd_layer)),0,25*j) 
      EndIf
      
      If Obj(i)\Hide = 0
        DrawImage(ImageID(ImgLayer(#ivd_layerhide)),5,8+25*j) 
      EndIf
      
      
      DrawingMode(#PB_2DDrawing_Transparent)
      nom${12} = Obj(i)\Nom$
      DrawText(25,4+25*j,nom$)
      
      DrawingMode(#PB_2DDrawing_Default)
      If Obj(i)\Locked = 1
        DrawImage(ImageID(ImgLayer(#ivd_layerlock)),90,6+25*j) 
      EndIf
    Next
    
    StopDrawing()
  EndIf
  
  ; puis, on met à jour
  If update =1
    UpdateListShape()
    UpdateListShapeFX()
    ShapeGetProperties()
    DrawCanvas()
  EndIf
  
EndProcedure


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 49
; FirstLine = 19
; Folding = -7-
; EnableXP