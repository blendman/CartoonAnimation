
; gadgets 
Procedure FreeGadget2(i)
  If IsGadget(i) : FreeGadget(i) : EndIf
EndProcedure
Procedure SetGadgetColor2(gadget,color=-1)
  ;If VdOptions\UsethemeColor
  If color=-1
    c = RGB(VDOptions\ThemeColor, VDOptions\ThemeColor, VDOptions\ThemeColor )
  Else
    c = RGB(color,color,color)
  EndIf
  
  SetGadgetColor(gadget, #PB_Gadget_BackColor, c)
  ;EndIf
EndProcedure
Procedure SetGadgetState2(gad, state)
  If IsGadget(gad)
    SetGadgetState(gad, state)
  EndIf
EndProcedure


;{ to add easily gadgets
Procedure AddButonImage(gadg,x,y,w,h,img,flag,tip.s)
  If ButtonImageGadget(gadg,x,y,w,h, ImageID(img),flag) 
    GadgetToolTip(gadg, tip)
  EndIf
EndProcedure

Procedure AddGadget(id,typ,x,y,w,h,txt$="",min.d=0,max.d=0,tip$="",val.d=-65257,name$=#Empty$)
  
  ; pour ajouter plus facilement un gadget
  w_1 = VdOptions\PanelW/3-10
  If name$ <> #Empty$ 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,name$) 
    If G
      SetGadgetColor2(g)
    EndIf 
    If typ = #Gad_String And txt$ = #Empty$
      txt$ = StrD(val,3)
    EndIf
    
  ElseIf txt$ <>#Empty$  And typ <= #Gad_String 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,txt$) 
    If G
      SetGadgetColor2(g)
    EndIf 
  EndIf
  
  Select typ
    Case #Gad_spin
      If SpinGadget(id, x+w1,y,w,h,min,max,#PB_Spin_Numeric) : EndIf
      
    Case #Gad_String
      If min =1
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_Numeric) : EndIf
      ElseIf val = #PB_String_ReadOnly Or min = 2
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_ReadOnly) : EndIf  
      Else
        ;Debug txt$
        If StringGadget(id, x+w1,y,w,h,txt$) : EndIf                
      EndIf
      
    Case #Gad_Btn
      If min = 1
        If ButtonGadget(id,x+w1,y,w,h,txt$,#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonGadget(id,x+w1,y,w,h,txt$)  : EndIf    
      EndIf
      
    Case #Gad_BtnImg
      If min = 1
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max),#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max))  : EndIf    
      EndIf
      
    Case #Gad_Chkbox
      If CheckBoxGadget(id,x+w1+2,y,w,h,txt$) :  SetGadgetColor2(id) : EndIf    
      
    Case #Gad_Cbbox
      If ComboBoxGadget(id,x+w1,y,w,h) : EndIf    
      
    Case #Gad_ListV
      If ListViewGadget(id,x+w1,y,w,h) : EndIf    
      
      
  EndSelect
  
  If tip$ <> ""        
    If IsGadget(id)
      GadgetToolTip(id,tip$)
    EndIf
  EndIf
  
  If val <> -65257
    If typ = #Gad_String
      If txt$ <> #Empty$
        SetGadgetText(id,StrD(val))
      EndIf
    Else
      SetGadgetState(id,val)
    EndIf
  EndIf
  
EndProcedure
;}


; create the gadget and toolbar
Procedure Vd_CreateToolbar()
  
  ; d'abord, on le supprime
  If IsGadget(#G_ToolBarVD)
    FreeGadget(#G_ToolBarVD)
  EndIf
  If IsGadget(#G_ToolBarOptionVD)
    FreeGadget(#G_ToolBarOptionVD)
  EndIf
  
  
  x1 = 5 : a=1
  y1 = 0
  h2 = 25 : h1 =20
  w1 = 80 : w2 = 45
  winw =  VdOptions\WinW
  
  hh = VdOptions\ToolBarH
  winh =  VdOptions\WinH-25-hh - MenuHeight()
  ;min(winh,600)
  
  min(VdOptions\ToolBarNbCol,1)
  ww = VdOptions\ToolBarNbCol * (h2+5)
  min(hh,20)
  min(ww,30)
  VdOptions\ToolBarW = ww
  
  ; puis, on le recrée
  If VdOptions\ToolBarVertical = 0
    
    If ContainerGadget(#G_ToolBarVD,0,0,winw,hh)
      y1 = 0
      SetGadgetColor2(#G_ToolBarVD)
      
      ; create tools
      AddGadget(#G_ToolVDNew, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_New),Lang("New Document"))  : x1+h2+a
      AddGadget(#G_ToolVDOpen, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_open),Lang("Open Document"))  : x1+h2+a
      AddGadget(#G_ToolVDsave, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_save),Lang("Save Document"))  : x1+h2+a
      
      x1 + 5
      AddGadget(#G_ToolVDShape, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Shape),"Add a complex shape.")  : x1+h2+a
      AddGadget(#G_ToolVDBox, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Box),"Add a box.")            : x1+h2+a
      AddGadget(#G_ToolVDBoxRnd, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_BoxRnd),"Add a rounded box.")  : x1+h2+a
      AddGadget(#G_ToolVDCircle, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Circle),"Add a circle.")   : x1+h2+a
      AddGadget(#G_ToolVDLine, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Line),"Add a line.")         : x1+h2+a
      AddGadget(#G_ToolVDCurve, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Curve),"Add a curve.")      : x1+h2+a
      AddGadget(#G_ToolVDImage, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Image),"Add a image.")      : x1+h2+a
      AddGadget(#G_ToolVDText, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Text),"Add a text.")         : x1+h2+a
      
      x1 + 5
      ; transformations (shape)
      AddGadget(#G_ToolVDSelect, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Select),"Select the Shape.")   : x1+h2+a
      AddGadget(#G_ToolVDMove, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Move),"Move the Shape.")         : x1+h2+a
      ; ButtonImageGadget(#G_ToolVDTransform, x1,y1,h2,h2,ImageID(ImgVd(2)))  : x1+h2+2
      AddGadget(#G_ToolVDScale, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Scale),"Scale the shape.")      : x1+h2+a
      AddGadget(#G_ToolVDRot, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Rot),"Rotate the shape.")         : x1+h2+5
      AddGadget(#G_ToolVDMirorH, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_MirorH),"Miror the shape horizontaly.") : x1+h2
      AddGadget(#G_ToolVDMirorV, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_MirorV),"Miror the shape verticaly.") : x1+h2+5
      
      ; point tools
      ; AddGadget(#G_ToolVDMovePt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_MovePt),"Move point.")  : x1+h2+a
      AddGadget(#G_ToolVDAddPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Addpt),"Add a point.")     : x1+h2+a
      AddGadget(#G_ToolVDDelPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Delpt),"Delete a point.")  : x1+h2+a
      
      x1 + 5 : y1 + 2
      ; over the canvasDrawing
      ; Offset, snap
      ;         AddGadget(#G_ToolVDCenter, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,"Choose the offset for transformation.") : x1+w1+a+5
      ;         t$ ="Origin,Cursor,Bounding box,Selected shape"
      ;         For i = 0 To CountString(t$,",")
      ;           AddGadgetItem(#G_ToolVDCenter,i,StringField(t$,i+1,","))
      ;         Next
      ;         SetGadgetState(#G_ToolVDCenter,0)
      
      ;         AddGadget(#G_ToolVDSnap, #Gad_Chkbox, x1,y1,w2,h1,"Snap",0,0,"Set the Snap.",VdOptions\Snap) : x1+w2+a
      ;         AddGadget(#G_ToolVDSnapX, #Gad_Spin, x1,y1,w2,h1,"",1,100000,"Set the Snap X.",VdOptions\SnapX) : x1+w2+a
      ;         AddGadget(#G_ToolVDSnapY, #Gad_Spin, x1,y1,w2,h1,"",1,100000,"Set the Snap Y.",VdOptions\SnapY) : x1+w2+a
      
      y1-2
      
      CloseGadgetList()
    EndIf
    
    ;       If ContainerGadget(#G_ToolBarOptionVD,0,0,winw,hh)
    ;         ; SetGadgetColor2(#G_ToolBarOptionVD)
    ;         CloseGadgetList()
    ;       EndIf
    
  Else
    ;{ create toolbar on the left
    y1 = hh
    x1 = 0
    If ContainerGadget(#G_ToolBarVD,0,y1,ww,winH)
      SetGadgetColor2(#G_ToolBarVD)
      y1 = 0
      ; create tools
      AddGadget(#G_ToolVDShape, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Shape),"Add a complex shape.") : x1+h2 ; y1+h2+a
      AddGadget(#G_ToolVDBox, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Box),"Add a box.")        : x1 = 0  : y1+h2+a
      AddGadget(#G_ToolVDBoxRnd, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_BoxRnd),"Add a rounded box.")  : x1+h2;       : y1+h2+a
      AddGadget(#G_ToolVDCircle, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Circle),"Add a circle.") : x1 = 0 : y1+h2+a
      AddGadget(#G_ToolVDLine, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Line),"Add a line.")       : x1+h2;  : y1+h2+a
      AddGadget(#G_ToolVDCurve, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Curve),"Add a curve.")    : x1 = 0 : y1+h2+a
      AddGadget(#G_ToolVDImage, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Image),"Add a image.")    : x1+h2;   : y1+h2+a
      AddGadget(#G_ToolVDText, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Text),"Add a text.")       : x1 = 0 : y1+h2+a
      
      y1 + 5
      ; transformations
      AddGadget(#G_ToolVDSelect, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Select),"Select the Shape.")  : x1+h2
      AddGadget(#G_ToolVDMove, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Move),"Move the Shape or the points.")  : x1=0 : y1+h2+a
      ; ButtonImageGadget(#G_ToolVDTransform, x1,y1,h2,h2,ImageID(ImgVd(2)))  : x1+h2+2
      AddGadget(#G_ToolVDScale, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Scale),"Scale the shape.")  : x1+h2;
      AddGadget(#G_ToolVDRot, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Rot),"Rotate the shape.")  : x1=0 : y1+h2+a
      AddGadget(#G_ToolVDMirorH, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_MirorH),"Miror the shape horizontaly.") : x1+h2
      AddGadget(#G_ToolVDMirorV, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_MirorV),"Miror the shape verticaly.") : x1=0 : y1+h2+a
      
      y1 +5
      AddGadget(#G_ToolVDAddPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Addpt),"Add a point.")          : x1+h2;
      AddGadget(#G_ToolVDDelPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Delpt),"Delete a point.")       : x1=0 : y1+h2+a
      
      
      CloseGadgetList()
    Else
      Debug "erreur toolbar !" +ww+"/"+winH 
    EndIf
    
    If ContainerGadget(#G_ToolBarOptionVD,0,0,winw,hh) 
      ; SetGadgetColor2(#G_ToolBarOptionVD)
      CloseGadgetList()
      Vd_SetGadgetOption()
    EndIf
    ;}
  EndIf
  
  
EndProcedure
Macro Vd_SetGadgetstate(param)
  If shapeId> -1
    Obj(ObjId)\Shape(ShapeId)\param = GetGadgetState(EventGadget())
    DrawCanvas()
  EndIf
EndMacro
Procedure VD_CreateLayerUi()
  
  ; pour créer l'interface des objets (= layers)
  
  x1 = 5 : y1 = 10 : a= 5 : b = 3
  w1 = 50
  h1 = 25 : h2 = 20
  hh =200
  
  
  AddGadget(#G_ObjAlpha, #Gad_Spin,x1,y1,w1,h2,"",0, 255, LAng("Change the alpha of the layer.")) : x1+w1+a
  
  y1+h2+b : x1 = 5
  AddGadget(#G_ObjLock, #Gad_BtnImg,x1,y1,h2,h2,"",1, ImgLayer(#ivd_layerlock), lang("Lock the layer.")) : x1+h2+a
  
  y1 + h1+b : x1 = 5
  
  If ScrollAreaGadget(#G_ObjSA,x1,y1,VdOptions\PanelLayerW - 20,hh,VdOptions\PanelLayerW-42,300,#PB_ScrollArea_BorderLess)
    SetGadgetColor2(#G_ObjSA)
    If CanvasGadget(#G_ObjList,0,0,VdOptions\PanelLayerW, 500)
      VD_Layer_UpdateUI()
    EndIf
    CloseGadgetList()
  EndIf
  
  y1+hh+b
  
  AddGadget(#G_objAdd, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layeradd), Lang("Add a new layer.")) :x1 +h2+b
  AddGadget(#G_ObjDel, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerdel), LAng("Delete the current Layer.")) :x1 +h2+b
  AddGadget(#G_ObjUp, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerup), lang("Move the Layer up.")) :x1 +h2+b
  AddGadget(#G_ObjDown, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerdown), lang("Move the Layer down.")) :x1 +h2+b
  
  y1 + h1 +b
  
  ProcedureReturn y1
EndProcedure
Procedure VD_UpdateCanvasPath()
  
  If StartDrawing(CanvasOutput(#G_CanvasPathVDScene))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(200,200,200,255))
    DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
    Select Vd\PathId
      Case 0 ; scene
        DrawText(5,2,"Scene")
      Case 1 ; objet
        DrawText(5,2,"Scene | "+obj(ObjId)\Nom$)
      Case 2 ; Shape
        DrawText(5,2,"Scene | "+obj(ObjId)\Nom$+" | "+obj(ObjId)\Shape(ShapeId)\Nom$)
    EndSelect
    
    StopDrawing()
  EndIf
  
EndProcedure

Procedure CreateToolBarContainer()
  PanelVDW = VdOptions\PanelW
  BarVDH = VdOptions\ToolBarH
  winh = WindowHeight(#Win_VD_main)
  Hg = Winh-10-BarVDH
  If VdOptions\ToolBarVertical = 0
    If OpenGadgetList(#G_panelVD,1)
      Hg = GadgetHeight(#G_panelVD) - 63
      If ContainerGadget(#G_ToolBarOptionVD2,0,0,PanelVDW-8,Hg) 
        SetGadgetColor2(#G_ToolBarOptionVD2,VDOptions\ThemeColor+20)
        Vd_SetGadgetOption()
        CloseGadgetList()
      EndIf
      CloseGadgetList()
    EndIf
  Else
    If ContainerGadget(#G_ToolBarOptionVD2, 0,0,PanelVDW,Hg)
      SetGadgetColor2(#G_ToolBarOptionVD2)
      VD_CreateGadgetsBankShape()
      CloseGadgetList()
    EndIf
  EndIf
EndProcedure

Procedure VD_AddGadgetItem(gad,name$,state=0)
  nb = CountString(name$,",")-1
  For i=0 To nb
    AddGadgetItem(gad,i,StringField(name$,i+1,","))
  Next
  SetGadgetState(gad,state)
EndProcedure
Procedure VD_CreateTheGadgets()
  
  ; procedure to create the gadgets
  
  ;{ gadgets
  ;VdOptions\ToolBarH = 25
  winw = WindowWidth(#Win_VD_main) 
  winh = WindowHeight(#Win_VD_main)
 
  PanelVDW = VdOptions\PanelW
  If VdOptions\PanelW <=200
    VdOptions\PanelW =200
  EndIf
  If VdOptions\PanelLayerW <=180
    VdOptions\PanelLayerW =180
  EndIf
  PanelLayerW = VdOptions\PanelLayerW
  BarVDH = VdOptions\ToolBarH
  TimeLineH = VdOptions\TimeLineH
  If TimeLineH <50
    TimeLineH = 50
  EndIf
  
  x1 = 5 : a=1
  y1 = 0
  w1 = 130 : w2 = 30 : w7=70 : w8=40 : w3 = 50 : w4 = 60 : w5 = 20 : w6 = 80
  h1 = 20 : h2 = 25
  Hg = Winh-10-BarVDH
  VD_CreateToolBar()
  
  tbw = 0
  If VdOptions\ToolBarVertical = 1
    tbw = VdOptions\ToolBarW+a
  EndIf
  
  ; the panel and canvas, timeline
  x1 = 10 : y1 = 10
  a = 3 : b = 5 : c = 2
  canvasW =  winw-PanelVDW-PanelLayerW-10-tbw
  
  ; Left panel : tooloption, Shape, points, color, fx
  If PanelGadget(#G_panelVD,tbw,BarVDH,PanelVDW,Hg)
    ;SetGadgetColor2(#G_panelVD)
    
    ;{ Bank
    AddGadgetItem(#G_panelVD,-1,lang("Bank"))
     If ContainerGadget(#G_ToolBarOptionVD,0,0,PanelVDW-8,Hg) 
      SetGadgetColor2(#G_ToolBarOptionVD,VDOptions\ThemeColor+20)
      VD_CreateGadgetsBankShape(y1)
      CloseGadgetList()
    EndIf
    ;}
    
    ;{ Tools options
    AddGadgetItem(#G_panelVD,-1,lang("Tool"))
    If ContainerGadget(#G_ToolBarOptionVD2,0,0,PanelVDW-8,Hg) 
      SetGadgetColor2(#G_ToolBarOptionVD2,VDOptions\ThemeColor+20)
      Vd_SetGadgetOption()
      CloseGadgetList()
    EndIf
    ;}
    
    ;{ edit shape (properties)
    AddGadgetItem(#G_panelVD,-1,lang("Edit"))
    x1 = 10 : y1 = 10
    TextGadget(#PB_Any, x1,y1+3,w3,h1,lang("Name")) : x1+w3+2
    StringGadget(#G_shapeNom, x1,y1,w1,h1,"") : y1 +h1+a : x1 =10
    
    
    If ListViewGadget(#G_shapelist,x1,y1,130,100,#PB_ListView_ClickSelect) : y1+100+a  
    Else
      End
    EndIf
    AddGadget(#G_shapePosUp, #Gad_BtnImg, x1,y1,h1,h1,"",0,ImgLayer(#ivd_layerup),lang("Move the shape up.")) : x1+h1+a
    AddGadget(#G_shapePosDown, #Gad_BtnImg, x1,y1,h1,h1,"",0,ImgLayer(#ivd_layerdown),lang("Move the shape down.")) : x1+h1+a
    AddGadget(#G_shapeHide, #Gad_BtnImg, x1,y1,h1,h1,"",1, ImgLayer(#ivd_layerhide),lang("Hide the selected shape.")) : x1+h1+a
    AddGadget(#G_shapeLock, #Gad_BtnImg, x1,y1,h1,h1,"",1, ImgLayer(#ivd_layerlock),lang("Lock the selected shape.")) : x1+h1+a
    
    y1 + h1+a : x1 = 10
    AddGadget(#G_shapeLink, #Gad_Chkbox, x1,y1,w3,h1,lang("Link "),0,0,lang("To link the shape with the next shape and get 'hole' in shape if intersection instead of filled color.")) : x1 + w3+a
    AddGadget(#G_shapeClose, #Gad_Chkbox, x1,y1,w7,h1,lang("Open "),0,0,lang("Open or close the path (line, curve, complexe shape)")) : x1=10 : y1+h1+a
    
    AddGadget(#G_shapeShow, #Gad_Chkbox, x1,y1,w7,h1,lang("Show"),0,0,lang("Show the shape)"))
    x1=10 : y1+h1+a
    AddGadget(#G_shapeDepth, #Gad_Spin, x1,y1,w7,h1,lang("Depth"),0,1000,lang("Set the depth of the shape (the more depth is high, the more the shape is on the top)"))
    x1=10 : y1+h1+a
    
    AddGadget(#G_shapeX, #Gad_Spin, x1,y1,w7,h1,lang("X "),-100000,100000,Lang("Set the X position of the shape.")) : y1+h1+a
    AddGadget(#G_shapeY, #Gad_Spin, x1,y1,w7,h1,lang("Y "),-100000,100000,Lang("Set the Y position of the shape."))  : y1+h1+a
    AddGadget(#G_shapeSizeW, #Gad_Spin, x1,y1,w7,h1,lang("W "),0,10000,Lang("Set the width of the shape."))  : y1+h1+a
    AddGadget(#G_shapeSizeH, #Gad_Spin, x1,y1,w7,h1,lang("H "),0,10000,Lang("Set the height of the shape."))  : y1+h1+a
    If VdOptions\DebugOn
      AddGadget(#G_shapeIdUnik, #Gad_String, x1,y1,w7,h1,#Empty$,0,0,Lang("The Id unique of the shape.)"),#PB_String_ReadOnly  ,Lang("Id Unik "))  : y1+h1+a
    EndIf
    AddGadget(#G_shapeParent, #Gad_Cbbox, x1,y1,w7,h1,lang("Parent "),0,0,Lang("Set the parent of the shape."),-1,Lang("Parent "))  : y1+h1+a
    
    
    FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3+b,lang("Center")) : y1 +15
    AddGadget(#G_shapeCX, #Gad_Spin,x1,y1,w7,h1,lang("CX"),-10000,10000,Lang("Change the center X (offset)")) : y1+h1+a 
    AddGadget(#G_shapeCY, #Gad_Spin,x1,y1,w7,h1,lang("Cy"),-10000,10000,Lang("Change the center Y (offset)")) : y1+h1+b*3
    
    ; Point
    FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*4+b,Lang("Points")) : y1 +15
    AddGadget(#G_shapePtMenu,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Properties),Lang("Open the properties menu for the points")) : x1+h1+a
    AddGadget(#G_shapePtHard,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Hard),Lang("Set the point hard")) : x1+h1+a
    AddGadget(#G_shapePtSoft,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Soft),Lang("Set the point soft")) : x1+h1+a
    AddGadget(#G_shapePtMirored,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Soft),Lang("Set the point mirrored")) : x1+h1+a 
    AddGadget(#G_shapePtUseMirored,#Gad_Cbbox,x1,y1,w7,h1,lang("Move mode"),0,0,Lang("Use the mirrored or smooth move (only available For curve)")) 
;     line$ =lang( "Free,miror,smooth,")
;     For i=0 To 2
;       AddGadgetItem(#G_shapePtUseMirored,i,StringField(line$,i+1,","))
;     Next
;     SetGadgetState(#G_shapePtUseMirored,0)
    VD_AddGadgetItem(#G_shapePtUseMirored,lang("Free,miror,smooth,"))

    x1+w7+a
    AddGadget(#G_shapeNotRender,#Gad_Chkbox,x1,y1,w7,h1,Lang("Hide"),0,0,Lang("set selected curve (by point) visible Or Not")) :
    y1+h1+a
    x1=10
    AddGadget(#G_shapePtX,#Gad_Spin,x1,y1,w7,h1,lang("X "),-100000,100000,Lang("Position X of the point (or the shape for box, ellipse, image, text).")) :
    x1 = GadgetX(#G_shapePtX)+GadgetWidth(#G_shapePtX)+2
    AddGadget(#G_shapePtXlock,#Gad_Chkbox,x1,y1,w8,h1,lang("Lock"),0,0,Lang("Lock X")) : y1+h1+a
    x1=10
    AddGadget(#G_shapePtY,#Gad_Spin,x1,y1,w7,h1,lang("Y "),-100000,100000,Lang("Position Y of the point (or the shape for box, ellipse, image, text).")) : x1+w7+w2+a*2
    x1 = GadgetX(#G_shapePtY)+GadgetWidth(#G_shapePtY)+2
    AddGadget(#G_shapePtYLock,#Gad_Chkbox,x1,y1,w8,h1,lang("Lock"),0,0,Lang("Lock Y")) : y1+h1+a
    
    ;}
    
    ;{ Color
    AddGadgetItem(#G_panelVD,-1,lang("Color"))
    x1 = 10 : y1 = 10    
    
    If FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*4+10,lang("Color")) : y1 +15 
      AddGadget(#G_shapeColor, #Gad_Btn, x1,y1,W7,h1,lang("Color"),0,255,lang("Change the color of the shape."),0,lang("Color")) : y1+h1+a
      AddGadget(#G_shapeAlpha, #Gad_Spin, x1,y1,W7,h1,lang("Alpha"),0,255,lang("Change alpha of the shape.")) : y1+h1+a  
      AddGadget(#G_shapeColorTyp, #Gad_Cbbox, x1,y1,W7,h1,lang("Color Typ"),0,255,lang("Change color typ of the shape."),0,lang("Color Typ")) : y1+h1+10   
      VD_AddGadgetItem(#G_shapeColorTyp,lang( "color,linear gradient,circular gradient,texture,"))
    EndIf
       
    ; ButtonGadget(#G_shapeTexture, x1,y1,w7,h1,"Texture"): y1+h1+b*3 : x1=10
    
    If FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*6,lang("Style")) : y1+15
      AddGadget(#G_shapeTyp, #Gad_Cbbox, x1,y1,w1,h1,"",0,255,lang("Change the type of the shape (line, filled..).")) : y1+h1+a
      VD_AddGadgetItem(#G_shapeTyp,lang( "filled,line,dash,dot,custom"))
      AddGadget(#G_shapeLineW, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the width of the line shape."),0, lang("Width")) : y1+h1+a
      AddGadget(#G_shapeLineH, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the Height of the line shape."),0, lang("Height")) : y1+h1+a
      AddGadget(#G_shapeLineD, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the distance For the line shape (dot line)."),0, lang("Dist")) : y1+h1+a
      y1+h1        
      
    EndIf
    
    If FrameGadget(#PB_Any,5,y1,PanelVDW-15,(h1+a)+20,lang("Extra")) : y1+15  
      AddGadget(#G_shapeRnd, #Gad_Spin, x1,y1,w7,h1,lang("Rnd "),-10000,10000,lang("Change the corner (For round box)")) : y1+h1+a        
      y1+h1        
    EndIf
  
    If ContainerGadget(#G_shapeContText,0,y1,PanelVDW-10,h1*3+10)
      y2=y1 : y1 = 5
      FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3,lang("Text")) : y1+15   
      AddGadget(#G_shapeText, #Gad_Btn, x1,y1,w7,h1,lang("Text"),0,0,lang("Change the text")): y1+h1+a 
      AddGadget(#G_shapeTextFont, #Gad_Btn, x1,y1,w7,h1,lang("Font"),0,0,lang("Change the text font")): y1+h1+a
      CloseGadgetList()
      y1+y2
    EndIf
    
    y1+h1  
    If ContainerGadget(#G_shapeContImg,0,y1,PanelVDW-10,h1*3+10)
      y2=y1 : y1 = 5
      FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*8,lang("Image")) : y1+15
      AddGadget(#G_shapeImgChange, #Gad_Btn, x1,y1,w3,h1,lang("Image"),0,0,lang("Change the Shape Image")): y1+h1+a
      AddGadget(#G_shapeImgRepeat, #Gad_Chkbox, x1,y1,w3,h1,lang("Repeat"),0,0,lang("Repeat the image on the shape")): y1+h1+a
      AddGadget(#G_shapeImgX, #Gad_Spin, x1,y1,w7,h1,lang("X "),-100000,100000,lang("Change the Image position X on the shape")): y1+h1+a
      AddGadget(#G_shapeImgY, #Gad_Spin, x1,y1,w7,h1,lang("Y "),-100000,100000,lang("Change the Image position Y on the shape")): y1+h1+a
      AddGadget(#G_shapeImgW, #Gad_Spin, x1,y1,w7,h1,lang("W "),1,10000,lang("Change the Image width.")): y1+h1+a
      AddGadget(#G_shapeImgH, #Gad_Spin, x1,y1,w7,h1,lang("H "),1,10000,lang("Change the Image height.")): y1+h1+a
      ;AddGadget(#G_shapeImgRot, #Gad_Spin, x1,y1,w3,h1,"Angle ",-10000,10000,"Change the Image angle."): y1+h1+a
      CloseGadgetList()
      y1+y2
    EndIf
  

    ;}
    
    ;{ FX 
    
    AddGadgetItem(#G_panelVD,-1,lang("FX"))
    x1 = 10 : y1 = 10
    
    FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*2,lang("Presets"))
    y1 + 15
    AddGadget(#G_shapeFxPresetList, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select a preset for the Fx, if you prefer ;)."))  : x1+w1+2
    AddGadget(#G_shapeFxPresetAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,lang("Add a new FX to the shape."))  : x1+w5+2
    AddGadget(#G_shapeFxPresetSave, #Gad_Btn, x1,y1,w2,h1,lang("Save"),0,0,lang("Save the current parameter of the preset."))  : x1=10 : y1 +h1+10
    UpdateListPresetFx()
    
    FrameGadget(#PB_Any,5,y1,PanelVDW-15,a+h1*2+25,lang("Parameters"))
    y1+20
    AddGadget(#G_shapeFxList, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select the Fx to change."))  : x1+w1+2
    AddGadget(#G_shapeFxAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,lang("Add a new Fx for the shape.")) : x1+w5+2 ;: x1=10 ;: y1+h1+a
    AddGadget(#G_shapeFxDel, #Gad_Btn, x1,y1,w5,h1,"-",0,0,lang("Delete the current Fx from the shape.")) : x1=10 : y1+h1+a
    AddGadget(#G_shapeFxActif, #Gad_Chkbox, x1,y1,w3,h1,lang("Actif"),0,0,lang("Set the Fx actif.")) : x1+w3+2
    AddGadget(#G_shapeFxOpen, #Gad_Chkbox, x1,y1,w3,h1,lang("open"),0,0,lang("Set the Fx open.")) 
    
    y1+h1+10
    x1=10
    
    
    FrameGadget(#PB_Any,5,y1,PanelVDW-15,(a+h1)*10+35,lang("Style"))
    Y1 +20
    AddGadget(#G_shapeFxLineTyp, #Gad_Cbbox, x1,y1,w1,h1,lang("Type"),0,0,lang("Set the type of the Fx.")) : y1+h1+a
    VD_AddGadgetItem(#G_shapeFxLineTyp,lang( "filled,line,dash,dot,"))

;     For i=0 To 3
;       AddGadgetItem(#G_shapeFxLineTyp,i,StringField(line$,i+1,","))
;     Next
    
    AddGadget(#G_shapeFxLineW, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the width of the line Fx."),0, lang("Width")) : y1+h1+a
    AddGadget(#G_shapeFxLineH, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the height of the line Fx (only for dash line)."),0, lang("Height")) : y1+h1+a
    AddGadget(#G_shapeFxLineD, #Gad_String, x1,y1,w7,h1,"",0,0,lang("Change the distance For the line Fx (dot & dash line)."),0, lang("Dist")) : y1+h1+a
    
    y1 +10
    AddGadget(#G_shapeFxX, #Gad_Spin, x1,y1,w7,h1,lang("X "),-10000,10000,lang("Set the X of the Fx.")) : y1+h1+a 
    AddGadget(#G_shapeFxY, #Gad_Spin, x1,y1,w7,h1,lang("Y "),-10000,10000,lang("Set the Y of the Fx.")) : y1+h1+a 
    AddGadget(#G_shapeFxAlpha, #Gad_Spin, x1,y1,w7,h1,lang("Alpha"),0,255,lang("Set the alpha of the Fx.")) : y1+h1+a ;: x1+w3+w2+10
    ; x1 = GadgetX(#G_shapeFxAlpha)+GadgetWidth(#G_shapeFxAlpha)+2
    AddGadget(#G_shapeFxColor, #Gad_Btn, x1,y1,w7,h1,lang("Color"),0,0,lang("Set the color of the Fx."),0,lang("Color")) : y1+h1+a : x1 = 10
    AddGadget(#G_shapeFxScale, #Gad_Spin, x1,y1,w7,h1,lang("Scale"),-10000,10000,lang("Set the scale of the Fx.")) : y1+h1+a :
    
    AddGadget(#G_shapeFxDepth, #Gad_Cbbox, x1,y1,w1,h1,lang("Depth"),0,0,lang("Set the depth of the Fx.")) : y1+h1+a 
    depth$ = lang("Back,Front,All back,All front")
    For i=0 To 3
      AddGadgetItem(#G_shapeFxDepth,i,StringField(Depth$,i+1,","))
    Next
    ;}
    
    CloseGadgetList()
  EndIf
  
  ; timeline (scene, drawing)
  If CanvasGadget(#G_VDTimeline,tbw,Hg+10,winw-10-tbw,TimeLineH)
    Vd_UpdateTimeLine()
  EndIf
  
  ; option for path, snap, origin...
  If ContainerGadget(#G_CanvasPathVD,tbw+PanelVDW+5,BarVDH,canvasW,h2)
    ; SetGadgetColor2(#G_CanvasPathVD, 130)
    x1 = 5 : y1 = 2 : w7 = 60
    
    If CanvasGadget(#G_CanvasPathVDScene,x1,y1,250,h1) :X1+260 : EndIf 
    VD_UpdateCanvasPaTh()
    
    ; y1 = 2     
    ; Edit mode
    AddGadget(#G_ToolVDEditMode, #Gad_Cbbox, x1,y1,w6,h1,"",0,0,Lang("Choose the Edit mode.")) : x1+w6+a+5
    t$ =Lang("All,Object,Shape,Point")
    For i = 0 To CountString(t$,",")
      AddGadgetItem(#G_ToolVDEditMode,i,StringField(t$,i+1,","))
    Next
    SetGadgetState(#G_ToolVDEditMode,0)  
    
    ; Offset
    AddGadget(#G_ToolVDCenter, #Gad_Cbbox, x1,y1,w6,h1,"",0,0,Lang("Choose the center for transformation.")) : x1+w6+a+5
    VD_AddGadgetItem(#G_ToolVDCenter,lang("Bounding box,Origin,"))

    ;t$ =Lang("Bounding box,Origin") ;,Cursor,,Selected shape")
;     For i = 0 To CountString(t$,",")
;       AddGadgetItem(#G_ToolVDCenter,i,StringField(t$,i+1,","))
;     Next
;     SetGadgetState(#G_ToolVDCenter,0)
    
    ; snap
    AddGadget(#G_ToolVDSnap, #Gad_Chkbox, x1,y1,w7,h1,Lang("Snap"),0,0,Lang("Set the Snap."),VdOptions\Snap) : x1+w7+a
    AddGadget(#G_ToolVDSnapX, #Gad_Spin, x1,y1,w7,h1,"",1,100000,Lang("Set the Snap X"),VdOptions\SnapX) : x1+w7+a
    AddGadget(#G_ToolVDSnapY, #Gad_Spin, x1,y1,w7,h1,"",1,100000,Lang("Set the Snap Y"),VdOptions\SnapY) : x1+w7+a

    CloseGadgetList()
  EndIf
  
  ;{ main canvas (scene)
  If CanvasGadget(#G_canvasVector, tbw+PanelVDW+5, BarVDH+h2, canvasW, Hg-h2,#PB_Canvas_Keyboard|#PB_Canvas_Border) :EndIf
  ;     If ContainerGadget(#G_CanvasOptionVD,tbw+PanelVDW+5,Hg-h2,winw,h2)
  ;         CloseGadgetList()
  ;     EndIf
  ;}
  
  ; RIGHT panel (layer (objects), opetions, control)
  If PanelGadget(#G_panelVD_R,GadgetX(#G_canvasVector)+GadgetWidth(#G_canvasVector),BarVDH,PanelLayerW,Hg)
    SetGadgetColor2(#G_panelVD_R)
    
    ;{ Objet
    x1 = 10 : y1 = 10 : w7 = 60
    AddGadgetItem(#G_panelVD_R,-1,lang("Layer"))
    
    ; AddGadget(#G_ObjCreate, #Gad_Chkbox, x1,y1,w6+35,h1,"Create new object.",0,0,"Create a new object when you add a new shape, box, circle, line...") : y1+h1+a
    
    ; AddGadget(#G_ObjList, #Gad_ListV, x1,y1,w6+35,200,"",0,0,"Select the objet to modify.") : y1+200+a
    
    y1 +VD_CreateLayerUi()
    
    ; AddGadget(#G_ObjDepth, #Gad_Spin, x1,y1,w6,h1,"Depth",-10000,10000,"Change the depth of the objet.") : y1+h1+a
    ; AddGadget(#G_ObjName, #Gad_String, x1,y1,w6,h1,"Name ",0,0,"Change the name of the objet.") : y1+h1+a
    x1 =5 
    If FrameGadget(#PB_Any, x3,y1,PanelLayerW-x1*2,h1*6,lang("Properties")) : EndIf
    y1 +15 : x1 +10
    AddGadget(#G_ObjX, #Gad_Spin, x1,y1,w6,h1,"X ",-10000,10000,lang("Change the X of the objet.")) : y1+h1+a
    AddGadget(#G_ObjY, #Gad_Spin, x1,y1,w6,h1,"Y ",-10000,10000,lang("Change the Y of the objet.")) : y1+h1+a
    AddGadget(#G_ObjW, #Gad_Spin, x1,y1,w6,h1,"W ",0,100000,lang("Change the width of the objet.")) : y1+h1+a
    AddGadget(#G_ObjH, #Gad_Spin, x1,y1,w6,h1,"H ",0,100000,lang("Change the height of the objet.")) : y1+h1+a
    
    
    ;}
    
    ;{ options (background, imagebg, camera)
    
    x1 = 5 : y1 = 10
    AddGadgetItem(#G_panelVD_R,-1,LAng("Options"))
    
    If FrameGadget(#PB_Any, x3,y1,PanelLayerW-x1*2,(a+h1)*3,lang("Background")) :  y1 +15 : x1 +10 : EndIf
    AddGadget(#G_Vd_OptBGCheck, #Gad_Chkbox, x1,y1,w6,h1,lang("Checker BG "),0,0,lang("Add a checker to the Background."),VdOptions\BGChecker) : y1+h1+a
    AddGadget(#G_Vd_OptBGColor, #Gad_Btn, x1,y1,w6,h1,lang("Color BG "),0,0,lang("Change the background color."),VdOptions\BgColor)
    y1+h1+10
    
    ; background image
    x1 = 5
    If FrameGadget(#PB_Any, x3,y1,PanelLayerW-x1*2,(a+h1)*7+20,lang("Image BG")) :  y1 +15 : x1 +10 : EndIf
    AddGadget(#G_Vd_OptBGImgUse, #Gad_Chkbox, x1,y1,w7,h1,lang("BG image"),0,0,lang("Use an image as background"),VdOptions\ShowBGImg) : x1 + w7 +10; y1+h1+a
    AddGadget(#G_Vd_OptBGImgLoad, #Gad_Btn, x1,y1,w7,h1,lang("Load"),0,0,lang("Load the image for background"))  : x1 + w7 +5;  y1+h1+a
    AddGadget(#G_Vd_OptBGImgprop, #Gad_BtnImg, x1,y1,W2,h1,lang("Prop"),0, ImgVd(#Img_Properties),lang("Change properties of the image of background"))
    y1+h1+a : x1 = 15
    AddGadget(#G_Vd_OptBGImgX, #Gad_Spin, x1,y1,w7,h1,lang("X "),-10000,10000,lang(" X Position of the image for background"),VdOptions\BgImg\x) : y1+h1+a
    AddGadget(#G_Vd_OptBGImgY, #Gad_Spin, x1,y1,w7,h1,lang("Y "),-10000,10000,lang(" Y Position of the image for background"),VdOptions\BgImg\y)  :  y1+h1+a
    AddGadget(#G_Vd_OptBGImgAlpha, #Gad_Spin, x1,y1,w7,h1,lang("Transp"),0,255,lang(" Transparency of the image for background"),VdOptions\BgImg\Alpha)  :  y1+h1+a
    ; AddGadget(#G_Vd_OptBGImgW, #Gad_Spin, x1,y1,w7,h1,lang("width"),1,10000,lang(" Width of the image for background"),VdOptions\BgImg\w)  :  y1+h1+a
    ; AddGadget(#G_Vd_OptBGImgH, #Gad_Spin, x1,y1,w7,h1,lang("Height"),1,10000,lang("Height of the image for background"),VdOptions\BgImg\h) :  y1+h1+a
    AddGadget(#G_Vd_OptBGImgDepth, #Gad_spin, x1,y1,w7,h1,lang("Depth"),0,1,lang("Pepth of the image for background (0:bottom, 1:top)"),VdOptions\BgImg\depth)  
    y1+h1+10
    
    x1 = 5
    If FrameGadget(#PB_Any, x3,y1,PanelLayerW-x1*2,h1*3,lang("Camera")) :  y1 +15 : x1 +10 : EndIf
    AddGadget(#G_Vd_OptCamCachAlpha, #Gad_Spin, x1,y1,w7,h1,lang("Alpha"),0,255,lang("Change the transparency of the camera cache."),VdOptions\CameraCacheAlpha) 
    
    ;}
    
    ;{ Swatchs
    x1 =5 : y1 = 10
    AddGadgetItem(#G_panelVD_R,-1,lang("Swatch"))  
    CreateSwatchGadget()
    ;}
    
    ;{ control
    x1 =5 : y1 = 10
    
    AddGadgetItem(#G_panelVD_R,-1,lang("Control"))        
    
    ; Control butons 
    ;FrameGadget(#PB_Any,5,y1,PanelW-15,70,"Control") : y1 +20
    
    AddGadget(#G_VDAnimStart,#Gad_Btn,x1,y1,w2,h1,"<",0,0,lang("Start of the animation")) : x1 + w2 +2
    AddGadget(#G_VDAnimPlay,#Gad_Btn,x1,y1,w2,h1,lang("Play"),0,0,lang("Play the animation")) : x1+w2+2
    
    ;ButtonGadget(#G_AnimNext,x1,y1,w2,h2,">>") : x1 + w2 +2 
    ;GadgetToolTip(#G_AnimNext,"Next keyframe for the sprite")
    
    AddGadget(#G_VDAnimEnd,#Gad_Btn,x1,y1,w2,h1,">",0,0,lang("End of the animation")) : x1=5 : y1 +(h1+2)
    
    StringGadget(#G_VDAnimCurFrame, x1,y1,40,h1,"0",#PB_String_Numeric) : x1+42
    SetGadgetText(#G_VDAnimCurFrame,Str(CurrentFrame))
    GadgetToolTip(#G_VDAnimCurFrame,lang("Current Frame") )
    
    StringGadget(#G_VDAnimMaxFrame, x1,y1,40,h1,"300",#PB_String_Numeric) : x1+42
    SetGadgetText(#G_VDAnimMaxFrame,Str(Vd\FrameEnd))
    GadgetToolTip(#G_VDAnimMaxFrame,lang("Set the Max Frame for animation"))
    
    SpinGadget(#G_VDAnimFps,x1,y1,40,h1,1,1000,#PB_Spin_Numeric ) 
    SetGadgetState(#G_VDAnimFps,vd\FrameFps) :  GadgetToolTip(#G_VDAnimFps,lang("Set The FPS for animation"))
    
    ;}
    
    CloseGadgetList()
  EndIf
  
  ;}
  
  ;{ Status bar
  If CreateStatusBar(0,WindowID(#Win_VD_main))
    AddStatusBarField(110)
    AddStatusBarField(150)
    AddStatusBarField(150)
    StatusBarText(0, 0, lang("Zoom")+" "+Str(VdOptions\Zoom)+"%")
  EndIf
  
  
  ;}
  
  
EndProcedure


; bank shape gadget
Procedure UpdateListBank(updatefolder=0, ShapeFolder$=#Empty$)
  Protected i.w
  
  If shapefolder$ = #Empty$
    ShapeFolder$ = "shapes"
  EndIf
  
  ; pour mettre à jour la liste des shape qu'on peut ajouter (elle se trouve dans le dossier "data\shape")
  
  If updateFolder=1
    
    ; on vérifie  dans le dossier principal
    i=-1
    Dim name$(0)
    ClearGadgetItems(#G_shapeListFolderAdd)
    If ExamineDirectory(0, "data\shapes\", "")  
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
          n$=DirectoryEntryName(0)
          If n$ <> "." And n$ <> ".."
            i+1
            ReDim name$(i)
            name$(i) = n$
          EndIf
        EndIf
      Wend
      FinishDirectory(0)
    EndIf
    
    ; on trie le tableau et on ajoute les gadgets item
    SortArray(name$(),#PB_Sort_Ascending|#PB_Sort_NoCase)
    For i=0 To ArraySize(name$())
      AddGadgetItem(#G_shapeListFolderAdd,-1,name$(i))
    Next
    SetGadgetState(#G_shapeListFolderAdd,0)
    ShapeFolder$ = name$(0)
  EndIf
  
  ; On vérifie si on a des sous-dossier dans le dossier principale choisi (le "shapefolder$")
  ClearGadgetItems(#G_shapeListAdd)
  i=-1
  Dim name$(0)
  If ExamineDirectory(0, "data\shapes\"+ShapeFolder$, "")  
    While NextDirectoryEntry(0)
      If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
        n$=DirectoryEntryName(0)
        If n$ <> "." And n$ <> ".."
          i+1
          ReDim name$(i)
          name$(i)=n$
        EndIf
      EndIf
    Wend
    FinishDirectory(0)
  EndIf
  
  
  ; si on n'a aucun sous-dossiers
  If i=-1
    ; on vérifie si on a des shapes dans le dossier pricniape et on crée la liste des shapes de ce sous-dossier
    i=-1
    Dim name$(0)
    If ExamineDirectory(0, "data\shapes\"+ShapeFolder$, "*.txt")  
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = #PB_DirectoryEntry_File
          i+1
          ReDim name$(i)
          name$(i)=DirectoryEntryName(0)
        EndIf
      Wend
      FinishDirectory(0)
    EndIf
  EndIf

  ; on trie le tableau des noms de shape
  SortArray(name$(),#PB_Sort_Ascending|#PB_Sort_NoCase)
  
  ; et on ajoute les gadgets item
  For i=0 To ArraySize(name$())
    AddGadgetItem(#G_shapeListAdd,-1,name$(i))
  Next
  SetGadgetState(#G_shapeListAdd,0)
  
  FreeArray(name$())
  
  ; finish
  Vd\ShapeFileName$ = GetGadgetItemText(#G_shapeListAdd,0)
  VD_UpdateShapeBankCanvas()
  
EndProcedure
Procedure VD_UpdateShapeBankCanvas(createImage=0, updatefolder=1)
  Shared BankPosX, bankPosY
  
  ; taille préview d'une image (à mettre dans les options)
  If VdOptions\BankCaseW =0
    VdOptions\BankCaseW = 50
  ElseIf VdOptions\BankCaseW <10
    VdOptions\BankCaseW =10
  EndIf
  w1 = VdOptions\BankCaseW 
  
  
  If createimage >= 1
    ;{ on crée les miniatures des images s'il en manque ou si on a ajouté de nouveaux dossier
    ; d'abord, on compte le nombre de dossier à étudier
    ;If createimage = 1
      Folder$ =  GetCurrentDirectory()+"data\shapes\"
    ;EndIf
   ; Debug folder$
    
    If ExamineDirectory(0,  Folder$, "*.*") 
      i=-1
      While NextDirectoryEntry(0)
        
       ; Debug " -------------------------------- "
        If DirectoryEntryType(0) = #PB_DirectoryEntry_Directory
          
          ShapeFolder$ = DirectoryEntryName(0)
          If ShapeFolder$ <> "." And ShapeFolder$ <>".."
            
            ; on vérifie si on a des sous-dossier
            i=-1
            Dim name$(0)
            If ExamineDirectory(1, "data\shapes\"+ShapeFolder$, "")  
              While NextDirectoryEntry(1)
                If DirectoryEntryType(1) = #PB_DirectoryEntry_Directory
                  n$=DirectoryEntryName(1)
                  If n$ <> "." And n$ <> ".."
                    i+1
                    ReDim name$(i)
                    name$(i)=n$+"\"
                  EndIf
                EndIf
              Wend
              FinishDirectory(1)
            EndIf
            
            ; ensuite, on créé les images du folder et du sous-folder s'il existe.
            For subfold=0 To ArraySize(name$())
              
              ;{ on va créer les images pour chaque sous-dossier
              Dim tmpnameimg$(0)
              Dim tmpimg$(0)
              nbnameImg = -1
              nbImg = -1
              
              ; on récupère les noms des image dans le dossier
              Folder$ =  GetCurrentDirectory()+"data\shapes\"+ShapeFolder$+"\"+Name$(subfold)
              
              ; d'abord, on regardeles fichiers de ce dossier
              ;Debug "on vérifie les fichiers text dans : "+folder$
              If ExamineDirectory(1,  Folder$, "*.txt") 
                i=-1
                While NextDirectoryEntry(1)
                  If DirectoryEntryType(1) = #PB_DirectoryEntry_File
                    i+1
                    nbnameImg+1
                    ReDim tmpnameimg$(i)
                    tmpnameimg$(i) =  Folder$+DirectoryEntryName(1)
                  EndIf
                Wend
                FinishDirectory(1)
              EndIf 
              
              ; puis, on enregistre les images si elles n'existent pas
              ; Debug "on vérifie les images dans : "+folder$
              If ExamineDirectory(1,  Folder$, "*.png") 
                i=-1
                While NextDirectoryEntry(1)
                  If DirectoryEntryType(1) = #PB_DirectoryEntry_File
                    i+1
                    nbImg+1
                    ReDim tmpimg$(i)
                    tmpimg$(i) =  Folder$+DirectoryEntryName(1)
                  EndIf
                Wend
                FinishDirectory(1)
              EndIf
              
              ; on compare et on crée les images si besoin
              ; Debug "on compare dans : "+folder$
              For i=0 To ArraySize(tmpnameimg$())
                nametxt$ = GetFilePart(tmpnameimg$(i),#PB_FileSystem_NoExtension)
                ok=0
                For j=0 To ArraySize(tmpimg$())
                  nameimg$ = GetFilePart(tmpimg$(j),#PB_FileSystem_NoExtension)
                  ; on compare, si on a déjà l'image
                  If nameimg$ = nametxt$
                    ; on l'a trouvé, c'est ok
                    ok=1
                    Break
                  EndIf
                Next 
                
                ; si on n'a pas l'image, on la créé
                If ok=0
                  nametxt$ = tmpnameimg$(i)
                  If nametxt$<>#Empty$
                    ;Debug "fichier à ouvrir "+nametxt$
                    Doc_New()
                    Shape_Load(0,nametxt$,0)
                    path$ = GetPathPart(nametxt$)
                    file$ = GetFilePart(nametxt$,#PB_FileSystem_NoExtension)+".png"
                    ; Debug "onn'a pas l'image, on la crée : " +path$+file$
                    Scene_Export(0,1, path$+file$)
                    Doc_New()
                  EndIf
                EndIf
                
              Next
              ;}
              
            Next 
          
          EndIf
        EndIf
      Wend
      FinishDirectory(0)
    EndIf 
    
    ; puis on libére les array
    FreeArray(tmpimg$())
    FreeArray(tmpimg$())
    
    ;}
  Else
    
    If IsGadget(#G_shapeCanvasBank) 
      
      If updatefolder
        
        ; on verifie le dossier actuel s'il y a des fichiers et images.
        shapefolder$ = GetGadgetText(#G_shapeListFolderAdd)
        If ShapeFolder$=#Empty$
          ShapeFolder$="characters"
        EndIf
        
        ; on vérifie si on a un sous-dossier ou si ce sont des éléments.
        shapeSubfolder$ = GetGadgetText(#G_shapeListAdd)
        If GetExtensionPart(shapeSubfolder$ ) <> #Empty$
          shapeSubfolder$ = #Empty$
           vd\BankHasSubfolder =0
        Else
          shapeSubfolder$+"\"
           vd\BankHasSubfolder =1
        EndIf
        
        
        ; on redimensionne le tableau des nom des image du dossier actuel
        ReDim BankImage$(0)
        BankImage$(0) = ""
        NbBankImage=-1
        ; on récupère les image dans le dossier
        Folder$ =  GetCurrentDirectory()+"data\shapes\"+ShapeFolder$+"\"+shapeSubfolder$
        ; puis, on enregistre les images si elles n'existent pas
        If ExamineDirectory(0,  Folder$, "*.png") 
          i=-1
          While NextDirectoryEntry(0)
            If DirectoryEntryType(0) = #PB_DirectoryEntry_File
              i+1
              NbBankImage+1
              ReDim BankImage$(i)
              BankImage$(i) =  Folder$+DirectoryEntryName(0)
            EndIf
          Wend
          FinishDirectory(0)
        EndIf
        
        SortArray(BankImage$(),#PB_Sort_Ascending|#PB_Sort_NoCase)
        
        ; on vérifie si on doit agrandir le canvas et le scrollarea
        a = GadgetWidth(#G_shapeCanvasBank)/w1
        hpreview = (i/a+1)*(W1+1)+30
        If hpreview > GadgetHeight(#G_shapeCanvasBank)
          ResizeGadget(#G_shapeCanvasBank,#PB_Ignore,#PB_Ignore,#PB_Ignore,hpreview)
          SetGadgetAttribute(#G_shapeSABank, #PB_ScrollArea_InnerHeight, hpreview)
        EndIf
        
        ; then reset the bankposX/Y
        BankPosX = 0
        BankPosY = 0
        
        
      EndIf
    
      ; on affiche sur le canvas
      If StartDrawing(CanvasOutput(#G_shapeCanvasBank))
        w = OutputWidth()-5
        Box(0,0,OutputWidth(), OutputHeight(), RGBA(50,50,50,255))
        DrawingMode(#PB_2DDrawing_AllChannels)
        If NbBankImage>-1
          b = w/W1 ; nombre d'image en X
          For i=0 To ArraySize(BankImage$())
            a = Round(Mod(i, b),#PB_Round_Down)
            x = a * (w1+1)
            y = Round(i/b, #PB_Round_Down) * (w1+1) ; ((i* (w1+1))/W) * (w1+1)

            ;Debug " i : "+Str(i)+"/ modulo : "+Str(a)+"/ Y : "+Str(Y)+"/ X : "+Str(x);+"/"+Str(w/W1)
            
            DrawingMode(#PB_2DDrawing_AllChannels)
            Box(x,y,w1,W1, RGBA(100,100,100,255))
            ; load image and draw it on the canvas
            ;           Debug tmpimg$(i)
            ;           Debug Str(x)+"/"+Str(y)
            img = LoadImage(#PB_Any, BankImage$(i))
            ResizeImageProportion(img,w1,#PB_Image_Smooth)
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            DrawAlphaImage(ImageID(img),x+(w1-ImageWidth(img))/2,y+(W1-ImageHeight(img))/2)
            FreeImage(img)
          Next 
          DrawingMode(#PB_2DDrawing_Outlined)
          Box(bankposX*(w1+1), bankposY*(W1+1),w1,W1,RGBA(255,0,0,255))
        EndIf
        
        
        StopDrawing()
      EndIf
      
    EndIf
  EndIf

EndProcedure
Procedure VD_CreateGadgetsBankShape(y1=0)
  Protected w1,h1,x1
  
  PanelVDW = VdOptions\PanelW
  w1 = PanelVDW-15 :  h1 = 20 : x1 = 5 : a =3 : w5 = 20 
  
  If y1=0
    y1 = 10
  EndIf
  
  AddGadget(#G_shapeListFolderAdd, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select the type of shape.") )
  y1+h1+a
  AddGadget(#G_shapeListAdd, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select the shape to add."))
  UpdateListBank(1)  
  y1+h1+5
  
  AddGadget(#G_shapeAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,lang("Add a new complexe Shape.")) : x1+w5+2
  AddGadget(#G_shapeDel, #Gad_Btn, x1,y1,w5,h1,"-",0,0,lang("Delete the selected shape.")) :x1 =5 : y1+h1+a
  
  h2 = GadgetHeight(#G_panelVD) - y1 -50 - GadgetY(#G_panelVD)
  If ScrollAreaGadget(#G_shapeSABank, x1,y1,w1, h2,w1-25, h2+50)
    If CanvasGadget(#G_shapeCanvasBank, 0,0,W1,h2)
      VD_UpdateShapeBankCanvas()
    EndIf
    ; EnableGadgetDrop(#G_shapeCanvasBank, #PB_Drop_Image|#PB_Drop_Private)
    CloseGadgetList()
  EndIf
  
EndProcedure
Procedure VD_EventBangkGadget()
  Static leftclic, oldname$
  Protected x.d,y.d
  Shared BankPosX, bankPosY
  
   ; taille préview d'une image (à mettre dans les options)
  If VdOptions\BankCaseW =0
    VdOptions\BankCaseW = 50
  ElseIf VdOptions\BankCaseW <10
    VdOptions\BankCaseW =10
  EndIf
  w1 = VdOptions\BankCaseW 
  
  ; check the eventtype
  If EventType() = #PB_EventType_LeftButtonDown
    leftclic = 1  
  ElseIf EventType() = #PB_EventType_LeftButtonUp
    leftclic = 0
  EndIf
  
  If leftclic
    a = ((GadgetWidth(#G_shapeCanvasBank)-5)/w1) -1
    b = ArraySize(BankImage$()) /(a+1)
    ;If EventType() = #PB_EventType_MouseMove
    x = GetGadgetAttribute(#G_shapeCanvasBank, #PB_Canvas_MouseX)
    y = GetGadgetAttribute(#G_shapeCanvasBank, #PB_Canvas_MouseY)
    
    x = Round(x/w1,#PB_Round_Down   )                           
    y = Round(y/W1,#PB_Round_Down   )
    If x > a
      x = a
    EndIf
    If y >b
      y= b
    EndIf
    If x +y*(a+1) > ArraySize(BankImage$())
      x = ArraySize(BankImage$()) -y*(a+1)
    EndIf
    bankImageID = x +y*(a+1)
    ; Debug bankImageID
    BankPosX = x 
    BankPosY = Y 
    
    VD_UpdateShapeBankCanvas(0,0)
    If vd\BankHasSubfolder =0
      SetGadgetState(#G_shapeListAdd, bankImageID)
      Vd\ShapeFileName$ = GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))
    Else
      
      folder$ = GetGadgetItemText(#G_shapeListFolderAdd,GetGadgetState(#G_shapeListFolderAdd))+"\"
      ; check if file.fca exisst.
      FileName$ = GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))+"\"+GetFilePart(BankImage$(bankImageID),#PB_FileSystem_NoExtension)+".fca"
      file$ = "data\shapes\"+folder$+FileName$
      
     
      
      ; if not, check if file.txt exist
      If FileSize(file$) =-1
        filename$ = GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))+"\"+GetFilePart(BankImage$(bankImageID),#PB_FileSystem_NoExtension)+".txt"
        file$ = "data\shapes\"+folder$+FileName$
        ;Debug file$
        
        If oldname$ <> GetFilePart(file$,#PB_FileSystem_NoExtension)
          oldname$ = GetFilePart(file$,#PB_FileSystem_NoExtension)
          GadgetToolTip(#G_shapeCanvasBank, oldname$)
        EndIf
        
        If FileSize(file$) = -1
          Vd\ShapeFileName$ = ""
        Else
           Vd\ShapeFileName$ = filename$
        EndIf
      Else
        Vd\ShapeFileName$ = filename$
      EndIf
      
    EndIf
    ;Debug  Vd\ShapeFileName$
    
    
    ;EndIf
  EndIf
  
EndProcedure


; resize gadget
Procedure Vd_ResizeAll()
    
    
    ; pour redimensionner les gadgets
    tbw = 0
    If VdOptions\ToolBarVertical = 1
        tbw = VdOptions\ToolBarW+3
    EndIf
    a =0
    If VdOptions\TimeLineH = 0
        VdOptions\TimeLineH = 50
    EndIf
    
    St=0
    If IsStatusBar(0)
      st = 1
    EndIf
    
    w = WindowWidth(#Win_VD_main)
    h = WindowHeight(#Win_VD_main)-MenuHeight()-VdOptions\ToolBarH -(StatusBarHeight(0)*st)- VdOptions\TimeLineH*(VdOptions\showTimeLine)
    h1= 25
    
    ; on resize le panel gauche
    ResizeGadget(#G_panelVD,#PB_Ignore,#PB_Ignore,#PB_Ignore,h)
    
    
;     ResizeGadget(#G_PanelVDControl,#PB_Ignore,h-90,#PB_Ignore,120)
    
    ResizeGadget(#G_VDTimeline,#PB_Ignore,h+5+MenuHeight()+10 + 10000*(1-VdOptions\showTimeLine),w-10-tbw,VdOptions\TimeLineH)
    Vd_UpdateTimeLine()
    
    ; on resize le canvas
    ;ResizeGadget(#G_CanvasOptionVD,tbw+VdOptions\PanelW+a,#PB_Ignore,w-VdOptions\PanelW*2-a*2-tbw,#PB_Ignore)
    w1 = w-VdOptions\PanelW-VdOptions\PanelLayerW-a*2-tbw
    ResizeGadget(#G_CanvasPathVD,tbw+VdOptions\PanelW+a,#PB_Ignore,w1,#PB_Ignore)
    
    ResizeGadget(#G_canvasVector,tbw+VdOptions\PanelW+a,#PB_Ignore,w1,h-h1)
    Drawcanvas()
    
    ; on resize le panel droit
    ResizeGadget(#G_panelVD_R,GadgetX(#G_canvasVector)+a*2+GadgetWidth(#G_canvasVector),#PB_Ignore,#PB_Ignore,h)
    
   
    VdOptions\WinW = WindowWidth(#Win_VD_main)
    VdOptions\WinH = WindowHeight(#Win_VD_main)
    VdOptions\WinState = GetWindowState(#Win_VD_main)
    VD_SaveOptions()
    
    ; Vd_CreateToolbar()
    
EndProcedure



; Background
Procedure BG_ResizeImage()
  
  w = ImageWidth(#Img_BGimg)
  h = ImageHeight(#Img_BGimg)

  ; verify some variables
  If VDoptions\BGImg\Scale =0
    VDoptions\BGImg\Scale = 1
  EndIf
  If VdOptions\BgImg\Resize =0
    VdOptions\BgImg\Resize = 1
  EndIf
  If VdOptions\BgImg\ClipOut\W <= 0 
    VdOptions\BgImg\ClipOut\W = w
  EndIf
  If VdOptions\BgImg\ClipOut\H <= 0
    VdOptions\BgImg\ClipOut\H = h
  EndIf
  
  ; free the copyimage of Background
  FreeImage2(#Img_BGimgCopy)

  ; copy/grab the bg image
  If VdOptions\BgImg\ClipOut\W < w Or VdOptions\BgImg\ClipOut\h < h
    FreeImage2(#Img_BGimgCopy)
    GrabImage(#Img_BGimg, #Img_BGimgCopy, VdOptions\BgImg\ClipOut\X, VdOptions\BgImg\ClipOut\Y, VdOptions\BgImg\ClipOut\W, VdOptions\BgImg\ClipOut\H)
  Else
     CopyImage(#Img_BGimg, #Img_BGimgCopy)
   EndIf
   
  ; resize the image
  w = ImageWidth(#Img_BGimgCopy)
  If VdOptions\BgImg\Resize < 1
    ResizeImageProportion(#Img_BGimgCopy, w * VdOptions\BgImg\Resize)
  EndIf

EndProcedure
Procedure BG_LoadImage(name$, loadimage=0,reset=1)
  
  If name$ <> #Empty$ And (VdOptions\BgImg\filename$ <> name$ Or loadimage = 1)
    If FileSize(name$) >0
      If LoadImage(#Img_BGimg,name$)
        
        VdOptions\BgImg\filename$ = name$
        
        ; reset the parameters for new image
        If VdOptions\BgImg\Alpha = 0
          VdOptions\BgImg\Alpha = 255
          SetGadgetState2(#G_Vd_OptBGImgAlpha,VdOptions\BgImg\Alpha)
        EndIf
        
        ; Size, resize, scale...
        w = ImageWidth(#Img_BGimg)
        h = ImageHeight(#Img_BGimg)

        ;If VdOptions\BgImg\w=0
        VdOptions\BgImg\w = w
        SetGadgetState2(#G_Vd_OptBGImgW,VdOptions\BgImg\w)
        ; EndIf
        ; If VdOptions\BgImg\h=0
        VdOptions\BgImg\h = h
        SetGadgetState2(#G_Vd_OptBGImgH,VdOptions\BgImg\h)
        ; EndIf
        If reset = 1
          VdOptions\BgImg\Resize = 1
          VdOptions\BgImg\scale = 1
          VdOptions\BgImg\ClipOut\x =0
          VdOptions\BgImg\ClipOut\y =0
          VdOptions\BgImg\ClipOut\w =w
          VdOptions\BgImg\ClipOut\h =h
        EndIf
        BG_ResizeImage()
        drawcanvas()
      EndIf
    EndIf
  EndIf
EndProcedure


; procedure pour gadgets
Procedure VD_Update_ToolOption()
  ; update d'option de l'outil en fonction du type d'outil 
  ; ex line, type = Free ou polygon.
  ; Si polygon : pas de distance entre les points.
  ; Si free : gadgets : distance entre les points
  
  Select VdOptions\Action
    Case #VD_actionAddLine
      
   EndSelect
   
  
EndProcedure
Procedure Vd_SetGadgetOption()
  
  Shared oldaction
  ; pour changer les options des gadgets
  x0=15
  w4 = VdOptions\PanelW/3
  x1=x0 : h1=25 : a=3 : w1=150 : w2=w1-w4 : y1= 10
  x3=5 : h2=30 : w3 = w1+60
  
  If Oldaction <>VdOptions\Action
    Oldaction  = VdOptions\Action
    
    freegadget2(#G_ToolBarOptionVD2)
    CreateToolBarContainer()
    If OpenGadgetList(#G_ToolBarOptionVD2)
      ;     If IsGadget(#G_TBOptionToolSet) = 0
      ; ;       AddGadget(#G_TBOptionToolSet,#Gad_BtnImg,x1,0,h1,h1,"",0,ImgVd(#Img_Properties),"Tools preset") 
      ;     EndIf
      ;        If VdOptions\ToolBarVertical = 0 
      ;          y1+h1+a
      ;        Else
      ;          x1+h1+a
      ;          x1 + a*3
      ;        EndIf
      tbv = VdOptions\ToolBarVertical
      x2 = (w+a)*tbv
      y2 = (h1+a)*(1-tbv)
      e.d = 11
      wa1 =  GadgetWidth(#G_ToolBarOptionVD2)
      ha1 =  GadgetHeight(#G_ToolBarOptionVD2)
      If ScrollAreaGadget(#G_TBOptSA,0,0, wa1,ha1,wa1-25,ha1+200)
      
      ; add options for create tool
      If VdOptions\Action >= #VD_actionAddShape And VdOptions\Action<#VD_actionAddImage
        If FrameGadget(#PB_Any, x3,y1,w3,6*y2+h1*2,lang("Style Option")) : y1+h2
          
          AddGadget(#G_TBOpt_TypePreset,#Gad_Cbbox, x1,y1,w2,h1,lang("Presets"),0,0,lang("Select the Tool preset style."),0,lang("Presets"))
          x1+W2+10+w4
          AddGadget(#G_TBOpt_TypePresetAdd,#Gad_Btn, x1,y1,h1,h1,lang("+"),0,0,lang("Add a preset with those paramters."))
          y1+h2
          X1=x0
          AddGadget(#G_TBOpt_TypeOpen,#Gad_Chkbox, x1,y1,w2,h1,lang("Open"),0,0,lang("Use an open path (line is open, not closed for exemple)."),VdOptions\ToolOptions\Open,lang("Open"))
          y1+y2
          AddGadget(#G_TBOpt_TypeAlpha,#Gad_Spin, x1,y1,w2,h1,lang("Alpha"),0,255,lang("Set the transparency color for the shape."),VdOptions\ToolOptions\Alpha)
          y1+y2 
          AddGadget(#G_TBOpt_TypeColor,#Gad_Btn, x1,y1,w2,h1,lang("Color"),0,0,lang("Set the color for the shape."),VdOptions\ToolOptions\Color, lang("Color"))
          y1+y2 
          AddGadget(#G_TBOpt_TypeStyle,#Gad_Cbbox, x1,y1,w2,h1,lang("Style"),0,0,lang("Set the style for the shape."),VdOptions\ToolOptions\Style, lang("Style"))
          line$ =lang("Filled,Line,Dash,Point,")
          For i=0 To 3
            AddGadgetItem(#G_TBOpt_TypeStyle,i,StringField(line$,i+1,","))
          Next
          SetGadgetState(#G_TBOpt_TypeStyle,VdOptions\ToolOptions\Style)
          y1+y2  
          AddGadget(#G_TBOpt_TypeWidth,#Gad_String, x1,y1,w2,h1,"",0,0,lang("Set the Size For stroke."),VdOptions\ToolOptions\width, lang("Size"))
          y1+y2 
          
          Y1+h1
        EndIf
        If FrameGadget(#PB_Any, x3,y1,w3,5*y2+h1*2,lang("FX Option")) : y1+h2
          AddGadget(#G_TBOpt_TypeFXOpen,#Gad_Chkbox, x1,y1,w2,h1,lang("Open"),0,0,lang("Use an open path for FX."),VdOptions\ToolOptionsFX\Open,lang("Open"))
          y1+y2
          AddGadget(#G_TBOpt_TypeFXAlpha,#Gad_Spin, x1,y1,w2,h1,lang("Alpha"),0,255,lang("Set the transparency color for the shape FX."),
                    VdOptions\ToolOptionsFX\Alpha)
          y1+y2 
          AddGadget(#G_TBOpt_TypeFXColor,#Gad_Btn, x1,y1,w2,h1,lang("Color"),0,0,lang("Set the color for the shape FX."),
                    VdOptions\ToolOptionsFX\Color, lang("Color"))
          y1+y2 
          AddGadget(#G_TBOpt_TypeFXStyle,#Gad_Cbbox, x1,y1,w2,h1,lang("Style"),0,0,lang("Set the style for the shape FX."),
                    VdOptions\ToolOptionsFX\Style, lang("Style"))
         ; line$ =lang("Filled,Line,Dash,Point,")
          For i=0 To 3
            AddGadgetItem(#G_TBOpt_TypeFXStyle,i,StringField(line$,i+1,","))
          Next
          SetGadgetState(#G_TBOpt_TypeFXStyle,VdOptions\ToolOptionsFX\Style)
          y1+y2  
          AddGadget(#G_TBOpt_TypeFXWidth,#Gad_String, x1,y1,w2,h1,"",0,0,lang("Set the Size For stroke FX."),
                    VdOptions\ToolOptionsFX\width, lang("Size"))
          y1+y2 
          Y1+h1
          
        EndIf
        
      EndIf
      
      ; puis, on crée les gadget en fonction de l'action (autrement dit de l'outil sélectionné)
      Select VdOptions\Action
          
        Case #VD_actionAddShape
          ;           If VdOptions\ToolBarVertical = 0 
          ;             VD_CreateGadgetsBankShape(y1)
          ;           EndIf
          
        Case #VD_actionAddLine
          If FrameGadget(#PB_Any, x3,y1,w3,y2+h1*2,lang("Tool Options")) : Y1+h2 
            AddGadget(#G_TBOptToolType,#Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select the type for this tool. Polygon : create line and add points with Ctrl down. Free (Pen) : draw simply a line freely."),VdOptions\Tool(vdOptions\Action)\Type)
            line$ =lang("Polygon,free (Pen),")
            For i=0 To 1
              AddGadgetItem(#G_TBOptToolType,i,StringField(line$,i+1,","))
            Next
            SetGadgetState(#G_TBOptToolType,VdOptions\Tool(action)\Type)
             Y1+h2 
            AddGadget(#G_TBOptToolDistance,#Gad_Spin, x1,y1,w2,h1,lang("Distance"),0,100000,lang("Choose the distance between 2 points For the line simplification."),VdOptions\ToolOptions\distance) : Y1+h2 
            AddGadget(#G_TBOptToolAngle,#Gad_Spin, x1,y1,w2,h1,lang("Angle"),0,100000,lang("Choose the minimal Angle between 2 points For the line simplification."),VdOptions\ToolOptions\angle)
            y1+y2
            VD_Update_ToolOption()
          EndIf 
          
        Case #VD_actionAddcurve
          If FrameGadget(#PB_Any, x3,y1,w3,y2+h1*2,lang("Tool Options")) : Y1+h2 
            AddGadget(#G_TBOptToolType,#Gad_Cbbox, x1,y1,w1,h1,"",0,0,lang("Select the type for this tool. Bezier : create besier line and add points with Ctrl down. Pencil : draw simply a bezier line freely."),VdOptions\Tool(vdOptions\Action)\Type)
            line$ =lang("Bezier,Pencil,")
            For i=0 To 1
              AddGadgetItem(#G_TBOptToolType,i,StringField(line$,i+1,","))
            Next
            SetGadgetState(#G_TBOptToolType,VdOptions\Tool(action)\Type)
            Y1+h2 
            AddGadget(#G_TBOptToolDistance,#Gad_Spin, x1,y1,w2,h1,lang("Distance"),0,100000,lang("Choose the distance between 2 points For the line simplification."),VdOptions\ToolOptions\distance) : Y1+h2 
            AddGadget(#G_TBOptToolAngle,#Gad_Spin, x1,y1,w2,h1,lang("Angle"),0,100000,lang("Choose the minimal Angle between 2 points For the line simplification."),VdOptions\ToolOptions\angle)
            y1+y2
            VD_Update_ToolOption()
          EndIf
          
        Case #VD_actionAddBox
          If FrameGadget(#PB_Any, x3,y1,w3,y2+h1*2,lang("Tool Options")) : Y1+h2
            w = Len(lang("Proportionnal"))*e
            AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,y1,w,h1,lang("Proportionnal"),0,0,lang("Use the proportionnal for size"),VdOptions\Tool(vdOptions\Action)\LockX)
            : y1+y2
          EndIf
          
        Case #VD_actionAddCircle
          If FrameGadget(#PB_Any, x3,y1,w3,y2+h1*2,lang("Tool Options")) : Y1+h2
            w = Len(lang("Proportionnal"))*e
            AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,y1,w,h1,lang("Proportionnal"),0,0,lang("Use the proportionnal for size"),VdOptions\Tool(vdOptions\Action)\LockX) : y1+y2
          EndIf
          
        Case #VD_actionMove
          If FrameGadget(#PB_Any, x3,y1,W3,y2*2+h1*2,lang("Tool Options")) : Y1+h2
            w = Len(lang("Lock X "))*e
            AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,y1,w,h1,lang("Lock X"),0,0,lang("Lock X direction"),VdOptions\Tool(vdOptions\Action)\LockX,lang("Lock X")) : y1+y2
            AddGadget(#G_TBOptLockY,#Gad_Chkbox, x1,y1,w,h1,lang("Lock Y"),0,0,lang("Lock Y direction"),VdOptions\Tool(vdOptions\Action)\LockY,lang("Lock Y"))
          EndIf
          
        Case #VD_actionRot
          If FrameGadget(#PB_Any, x3,y1,w3,y2+h1*2,lang("Tool Options")) : Y1+h2
            w = Len(lang("Rotation"))*e
            AddGadget(#G_TBOptRotation,#Gad_String, x1,y1,w,h1,lang("Rotation"),1,0,lang("Set The rotation"),VdOptions\Tool(vdOptions\Action)\Rotation) 
          EndIf
          
        Case #VD_actionScale
          If FrameGadget(#PB_Any, x3,y1,w3,y2*4+h1*2,lang("Tool Options")) : Y1+h2
            w = Len(lang("Lock Width"))*e
            AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,y1,w,h1,lang("Lock Width"),0,0,lang("Lock Width direction"),VdOptions\Tool(vdOptions\Action)\LockX,lang("Lock Width")) : y1+y2
            AddGadget(#G_TBOptLockY,#Gad_Chkbox, x1,y1,w,h1,lang("Lock Height"),0,0,lang("Lock Height direction"),VdOptions\Tool(vdOptions\Action)\LockY, lang("Lock Height")) : y1+y2
            AddGadget(#G_TBOptWidth,#Gad_string, x1,y1,w,h1,"",-10000,10000,lang("Scale in width"),VdOptions\Tool(vdOptions\Action)\SizeW,lang("Width")) : y1+y2
            AddGadget(#G_TBOptHeight,#Gad_string, x1,y1,w,h1,"",-10000,10000,lang("Scale in height"),VdOptions\Tool(vdOptions\Action)\SizeH,lang("Height")) : y1+y2
          EndIf
          
        Default
          ;TextGadget(#G_TBOptionToolInfo,x1,4,w1,h1,"No options for this tool")
          
      EndSelect
      
      CloseGadgetList()
    EndIf
      CloseGadgetList()
    EndIf
    
  EndIf

 
EndProcedure


; timeline
Procedure Vd_TimeLineUpdate()
  
  
  ; Base par Micoute, modifié par Blendman
  gadget = #G_VDTimeline
  Protected HauteurPolice.i, X.i, Y.i, Hauteur.i
  Shared PositionAscenseurY.w, PosX.w, AutoriserAscenseur.i
  Shared selectedY.i,Bx.w,moveBx.a,movekey.a,keyId.i
  
  a=40 : b=150+bx : c=4 : d=60 : e=20 
  w1 = 8 :
  If StartDrawing(CanvasOutput(Gadget))
    
    ; d'abord, je définis certaines variables
    mx = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX) 
    my = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY) 
    X  = OutputWidth()-20
    Yb = OutputHeight()-20
    Xb = PosX
    
    ;{ 1- affichage
    ; le fond        
    Box(0, 0, OutputWidth(), OutputHeight(), RGBA(160,160,160,255))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    ;{ barre en longueur, en haut
    Box(0, 0, OutputWidth(), 38, RGBA(120,120,120,255))
    ;}
    
    ;{ les calques
    DrawingMode(#PB_2DDrawing_Transparent)
    HauteurPolice = TextHeight("#")
    
    ;{ Liste des Layers
    u = PositionAscenseurY : y1 =y
    Repeat
      Box(0,Y1+a,OutputWidth(),HauteurPolice,RGBA(120,120,120,255))
      Y1 + HauteurPolice+1
      u+1
    Until u>ArraySize(Scene(vd\SceneID)\layer()) Or Y1 > OutputHeight()
    ;}
    ;}
    
    ;{ on affiche la règle des keyframe
    x1=-Xb :   h1 = OutputHeight()
    For i=0 To WindowWidth(#Win_VD_main)
      If x1+b+c >= b
        If i%(12)=0  
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          Line(x1+b+c,0,1,h1,RGBA(200,200,200,255))
          DrawingMode(#PB_2DDrawing_Transparent)
          DrawText(x1+b+c+2,3,Str(i),#Black)
        Else
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          Line(x1+b+c,0,1,h1,RGBA(255,255,255,50))
        EndIf
      EndIf;
      x1+w1
    Next
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    ; frame Start
    x1 = -Xb+b+c+vd\FrameStart*w1
    If x1>=b
      Box(x1, 0, 1,OutputHeight(), RGBA(0,255,0,255))
    EndIf
    
    ; frame end
    x1 = -Xb+b+c+vd\FrameEnd*w1
    If x1 >=b
      Box(x1, 0, 1,OutputHeight(), RGBA(0,100,255,255))
    EndIf
    
    
    If EventType() <> #PB_EventType_LeftButtonDown Or mx < b Or my >a
      ; barre currentFrame
      x1 = -Xb+b+c+vd\CurrentFrame*w1
      If x1 >= b
        Box(x1, 0, 1,OutputHeight(), RGBA(255,100,100,255))
      EndIf
      
    EndIf
    ;}
    
    
    
    ;{ puis, on affiche les informations liées aux calques
    ; d'abord, un fond
    Box(0,0,b,a,RGBA(160,160,160,255))
    
    ;{ les boutons play, stop, end, start
    For i=0 To 3
      Box(1+e*i,1,e-2,e-2,RGBA(180,180,180,255))
    Next        
    DrawAlphaImage(ImageID(ImgVd(#Img_Start)),2,2)  
    DrawAlphaImage(ImageID(ImgVd(#Img_Play+vd\play)),2+e,2)        
    DrawAlphaImage(ImageID(ImgVd(#Img_End)),2+e*2,2)
    DrawAlphaImage(ImageID(ImgVd(#Img_Loop)),2+e*3,2,100+155 * vd\Loopiz)
    ;}
    
    ;{ les informations des calques : new, hide, lock
    DrawAlphaImage(ImageID(ImgLayer(#ivd_layerhide)),b-40,25)
    DrawAlphaImage(ImageID(ImgLayer(#ivd_layerlock)),b-20,20)
    ;}
    
    ; puis, les infos des calques (nom, view, lock...)
    u = PositionAscenseurY : y1 =y
    If u > ArraySize(Scene(vd\SceneID)\layer())
      u = ArraySize(Scene(vd\SceneID)\layer())
      PositionAscenseurY = u
    ElseIf u<0
      u=0
      PositionAscenseurY = u
    EndIf
    Repeat
      
      Box(0,Y1+a,b,HauteurPolice,RGBA(120,120,120,255))
      
      With Scene(vd\SceneID)\Layer(u)
        
        DrawingMode(#PB_2DDrawing_Transparent)
        DrawText(0, Y1+a, \Name$, $000000)
        
        If \hide = 0
          DrawAlphaImage(ImageID(ImgLayer(#ivd_layerhide)),b-40,Y1+5+a)        
        EndIf 
        If \Locked = 1
          DrawAlphaImage(ImageID(ImgLayer(#ivd_layerlock)),b-20,Y1+a)
        EndIf
        
        ; on affiche les keyframes
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        For j = 1 To ArraySize(\key())
          x1 = -Xb+b+(\key(j)\keyframe)*w1+c
          If x1 >= b
            Box(x1,Y1+a,w1,HauteurPolice,RGBA(200,0,0,255))
          EndIf
        Next
        
      EndWith 
      Y1 + HauteurPolice+1
      u+1
    Until u>ArraySize(Scene(vd\SceneID)\layer()) Or Y1 > OutputHeight()
    
    ; barre pour afficher le layer actif 
    If (mx >b Or EventType() <> #PB_EventType_LeftButtonDown) 
      
      yy = a+selectedY*(HauteurPolice+1)-(PositionAscenseurY * (HauteurPolice+1))
      If yy >= a
        Box(0,yy,OutputWidth(),HauteurPolice,RGBA(60,60,60,100))
      EndIf
    EndIf
    ;}
    
    
    ; barre centrale pour séparer les layer info des keyframe
    Box(b, 0, c,OutputHeight(), RGBA(210,210,210,255))
    Box(b+c-1, 0, 1,OutputHeight(), RGBA(120,120,120,255))
    
    ;- Ascenseur  : les fonds clairs des ascenseurs     
    Box(X, 0, 20,OutputHeight(), RGBA(220,220,220,255))
    Box(b+c, OutputHeight()-20, OutputWidth(),20, RGBA(220,220,220,255))
    ;}
    
    ;{ 2 - ensuite, on va vérifier si on ne clique pas sur un élement : 
    ; calque, ascenceur, timeline, keyframe, etc...
    
    Hauteur = 50 
    If Hauteur < OutputHeight()
      
      Y = (OutputHeight()-Hauteur) * (PositionAscenseurY * HauteurPolice) / ((ArraySize(Scene(vd\SceneID)\Layer()) - 1) * HauteurPolice)
      ;Xb = (OutputWidth()-Largeur) * (PosX * w1) / ((FrameEnd - 1) * w1)
      
      ; si on est au dessus de l'ascenseur du bas
      If my < Yb
        
        If mx < X
          ; on est dans la surface des infos de calques ou des keyframes
          
          If EventType() = #PB_EventType_LeftDoubleClick
            
            If mx < d And mx <= b
              If my >=a 
                selectedY = (GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)-a)/(HauteurPolice+1)+PositionAscenseurY
                If selectedY <0
                  selectedY=0
                ElseIf selectedY > ArraySize(Scene(vd\SceneID)\layer()) ; ListSize(Layer())-1
                  selectedY = ArraySize(Scene(vd\SceneID)\layer())      ; ListSize(Layer())-1
                EndIf
                yy = a+selectedY*(HauteurPolice+1)-(PositionAscenseurY * (HauteurPolice+1))
                
                If yy >= a
                  Box(0,yy,OutputWidth()-20,HauteurPolice,RGBA(60,60,60,100))
                EndIf
                
                nom$ = InputRequester(Scene(vd\SceneID)\Layer(selectedY)\Name$,"New name",Scene(vd\SceneID)\Layer(selectedY)\Name$)
                If nom$ <> ""
                  Scene(vd\SceneID)\Layer(selectedY)\Name$= nom$
                EndIf
              EndIf                        
            EndIf
            
          ElseIf EventType() = #PB_EventType_LeftButtonUp
            moveBx = 0
            movekey=0
            keyId=-1
            
          ElseIf EventType() = #PB_EventType_LeftButtonDown Or GetGadgetAttribute(Gadget, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton                     
            
            If moveBx =1
              
              ; on déplace la petite barre qui sépare les infos des calques et les keframes
              bx = mx-b
              If bx<0
                bx =0
              EndIf
              b=150+bx
              Box(b+c+vd\CurrentFrame*w1, 0, 1,OutputHeight(), RGBA(255,100,100,255))
              
            Else
              
              If (mx >= b And mx<=b+c)
                
                If EventType() = #PB_EventType_LeftButtonDown
                  movebx = 1
                EndIf
                
              ElseIf mx < b
                
                ;{ on est dans la zone des calques
                ; on change de layer ou on effectue une opération sur un layer (hide, lock...)
                selectedY = (GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)-a)/(HauteurPolice+1)+PositionAscenseurY
                If selectedY <0
                  selectedY=0
                ElseIf selectedY > ArraySize(Scene(vd\SceneID)\layer()) ; ListSize(Layer())-1
                  selectedY = ArraySize(Scene(vd\SceneID)\layer())      ; ListSize(Layer())-1
                EndIf
                yy = a+selectedY*(HauteurPolice+1)-(PositionAscenseurY * (HauteurPolice+1))
                
                If yy >= a                                
                  Box(0,yy,OutputWidth()-20,HauteurPolice,RGBA(60,60,60,100))                                
                EndIf
                
                If my >=a 
                  
                  If EventType() = #PB_EventType_LeftButtonDown
                    ; cache un layer
                    If mx >= b-40 And mx<=b-20
                      Scene(vd\SceneID)\layer(selectedY)\Hide = 1- Scene(vd\SceneID)\layer(selectedY)\Hide
                    ElseIf mx >b-20
                      ; lock the layer                                    
                      Scene(vd\SceneID)\layer(selectedY)\Locked = 1- Scene(vd\SceneID)\layer(selectedY)\Locked
                    EndIf
                  EndIf
                  
                ElseIf my <=25 
                  
                  If EventType() = #PB_EventType_LeftButtonDown
                    
                    If mx < 2+e
                      ; on appuie sur play
                      vd\CurrentFrame = vd\FrameStart
                      SetGadgetText(#G_VDAnimCurFrame,Str(vd\CurrentFrame))
                    ElseIf mx >= 2+e*2 And mx <2+3*e
                      vd\CurrentFrame = vd\Frameend
                      SetGadgetText(#G_VDAnimCurFrame,Str(vd\CurrentFrame))
                    ElseIf mx >= 2+e*3 And mx <2+4*e
                      vd\Loopiz = 1-vd\Loopiz
                    ElseIf mx >= 2+e*4 And mx <2+5*e
                      
                    ElseIf mx >= 2+e And mx <2+2*e 
                      ; on appuie sur play
                      vd\Play=1-vd\Play 
                      play$ ="play,stop"
                      SetGadgetText(#G_VDAnimPlay,StringField(play$,1+Vd\Play,","))
                      Vd\playTimer = ElapsedMilliseconds()                                             
                      Box(1+e,1,e-2,e-2,RGBA(180,180,180,255))
                      DrawAlphaImage(ImageID(ImgVd(#Img_Play+vd\play)),2+e,2) 
                    EndIf
                    
                    
                  EndIf
                EndIf
                
                ;}
                
              Else
                
                ;{ on est sur la zone des keyframes
                
                If my >=a
                  ; on sélectionne une keyframe
                  ; ici, mx est >= b, donc pas besoin de le revérifier
                  If EventType() = #PB_EventType_LeftButtonDown
                    For j = 0 To ArraySize(Scene(vd\SceneID)\layer(selectedY)\key())
                      x2=-Xb+b+(Scene(vd\SceneID)\Layer(selectedY)\key(j)\keyframe)*w1+c
                      If mx>= x2 And mx<=x2+w1                                                
                        If movekey=0
                          movekey=1
                          keyId=j
                          Break
                        EndIf
                      EndIf                                               
                    Next
                  Else
                    If KeyId >-1
                      Scene(vd\SceneID)\Layer(selectedY)\key(KeyId)\keyframe = (Xb+GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)-b-c)/w1                                            
                    EndIf                                        
                  EndIf
                  
                  
                  
                Else                            
                  ; on change la frame
                  vd\CurrentFrame = (Xb+GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)-b-c)/w1
                  If EventType() = #PB_EventType_LeftButtonDown
                    Box(-xb+b+c+vd\CurrentFrame*w1, 0, 1,OutputHeight(), RGBA(255,100,100,255))                               
                  EndIf
                  SetGadgetText(#G_VDAnimCurFrame,Str(vd\CurrentFrame))
                EndIf
                ;}
                
              EndIf
              
            EndIf                   
            
          EndIf
          
          ; on dessine l'ascenceur
          AutoriserAscenseur = #False
          Box(X+1, Y+1, 18, Hauteur-2, RGBA(180,180,180,255))                
          Box(B+Xb+1+c, OutputHeight()-19, 50-2,18, RGBA(180,180,180,255))
          
        Else
          
          ; on est sur l'aascenceur
          
          AutoriserAscenseur = #True
          Box(X+1, Y+1, 18, Hauteur-2, RGBA(120,120,120,255))
          Box(B+Xb+1+c, OutputHeight()-19, 50-2,18, RGBA(180,180,180,255))
          
          If GetGadgetAttribute(Gadget, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton
            
            y = my ;  PositionAscenseurY
            
            If Y<0
              ;Y =0
            ElseIf Y>GadgetHeight(Gadget)-hauteur
              ;Y=GadgetHeight(Gadget)-hauteur
            EndIf
            
            
            ; PositionAscenseurY = (ListSize(Layer())-1) * (GetGadgetAttribute(Gadget,
            PositionAscenseurY = (ArraySize(Scene(vd\SceneID)\Layer())-1) * (GetGadgetAttribute(Gadget,
                                                                                                #PB_Canvas_MouseY) - Hauteur / 2) / (OutputHeight() - Hauteur)
            If PositionAscenseurY < 0
              PositionAscenseurY = 0
            ElseIf PositionAscenseurY > ArraySize(Scene(vd\SceneID)\Layer()) - 1
              PositionAscenseurY = ArraySize(Scene(vd\SceneID)\Layer()) - 1 
              ;                     ElseIf PositionAscenseurY > ListSize(Layer()) - 1
              ;                         PositionAscenseurY = ListSize(Layer()) - 1
            EndIf
          EndIf
          
        EndIf
        
      Else
        ; on est sous l'ascenseur du bas.                
        If mx < b-c
          AutoriserAscenseur = #False
          Box(X+1, Y+1, 18, Hauteur-2, RGBA(180,180,180,255))       
          Box(B+Xb+1+c, OutputHeight()-19, 50-2,18, RGBA(180,180,180,255))
        Else
          
          If GetGadgetAttribute(Gadget, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton
            PosX = GetGadgetAttribute(Gadget,#PB_Canvas_MouseX)-b
            If PosX < 0
              PosX = 0
            ElseIf PosX > OutputWidth()-b-hauteur
              PosX = OutputWidth() -b-hauteur
            EndIf
            Debug PosX
          EndIf
          
          AutoriserAscenseurY = #True
          AutoriserAscenseur = #False
          Box(X+1, Y+1, 18, Hauteur-2, RGBA(180,180,180,255))       
          
          Box(B+Xb+1+c, OutputHeight()-19, 50-2,18, RGBA(120,120,120,255))
          
        EndIf
        
      EndIf
      
    Else
      AutoriserAscenseur = #False
    EndIf
    
    ;}
    
    
    
    StopDrawing()
  EndIf
  
EndProcedure
Procedure VD_TimeLineEvent(playanim=0)
  
  Shared PositionAscenseurY.w
  gadget = #G_VDTimeline
  
  If playanim = 0
    Select EventType()
        
      Case #PB_EventType_MouseWheel
        PositionAscenseurY - 3 * GetGadgetAttribute(Gadget, #PB_Canvas_WheelDelta)
        If PositionAscenseurY < 0
          PositionAscenseurY = 0
          ;             ElseIf PositionAscenseurY > ListSize(Layer()) - 1
          ;                 PositionAscenseurY = ListSize(Layer()) - 1 
        ElseIf PositionAscenseurY > ArraySize(Scene(vd\SceneID)\Layer()) - 1
          PositionAscenseurY = ArraySize(Scene(vd\SceneID)\Layer()) - 1
        EndIf
        VD_TimeLineUpdate()
        
      Case #PB_EventType_LeftButtonDown, #PB_EventType_LeftButtonUp, #PB_EventType_LeftDoubleClick   
        VD_TimeLineUpdate()
        
      Case #PB_EventType_MouseMove    
        VD_TimeLineUpdate()
        
    EndSelect
  Else
    If EventType() = #PB_EventType_LeftButtonDown
      VD_TimeLineUpdate()
    EndIf
    
  EndIf
  
EndProcedure
Procedure Vd_UpdateTimeLine()
  
  ; On peut avoir au moins 3 types de timelines :
  ; - timeline de la scene en cours
  ; - timeline de l'objet en cours
  ; - timeline du shape actuel (de l'objet sélectionné)
  
  
  ;If StartDrawing(CanvasOutput(#G_VDTimeline))
  
  ; Box(0,0,OutputWidth(),OutputHeight(),RGBA(120,120,120,255))
  ; le pathid, c'est soit scene, soit objet, soit shape, en fonction de ce qu'on fait 
  ; (on anime une scène, on modifie un objet ou on modifie un shape
  
  Select vd\PathId 
      
    Case #VD_PathScene
      VD_TimeLineUpdate()
      
    Default
      VD_TimeLineUpdate()
      
      
  EndSelect
  
  ;StopDrawing()
  ;EndIf
  
EndProcedure


; procedures for the shapes
Procedure SetPanelGadget(disable=0)
  
  ; si besoin, on peut cacher ou révéler les gadgets
  For i = #G_ObjFirst To #G_shapeLast
    If IsGadget(i)
      DisableGadget(i, disable)
    EndIf
  Next
  
  ; pour modifier le panel en fonction du type de shape sélectionné
  If ShapeId > -1
    If ShapeId > ArraySize(Obj(ObjId)\Shape())
      ShapeId = ArraySize(Obj(ObjId)\Shape())
    EndIf
    
    If Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeText
      DisableGadget(#G_shapeContText,0)
      HideGadget(#G_shapeContText,0)
      DisableGadget(#G_shapeContImg,1)
      HideGadget(#G_shapeContImg,1)
    ElseIf Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeImage
      DisableGadget(#G_shapeContText,1)
      HideGadget(#G_shapeContText,1) 
       DisableGadget(#G_shapeContImg,0)
      HideGadget(#G_shapeContImg,0)
    Else  
       DisableGadget(#G_shapeContText,1)
      HideGadget(#G_shapeContText,1) 
       DisableGadget(#G_shapeContImg,1)
      HideGadget(#G_shapeContImg,1)
    EndIf
  EndIf  
  
EndProcedure
Procedure ShapeSetGadget(Disable=1)
  
  Shared GadgetsAreDisabled
  
  For i=#G_shapeNom To #G_shapeLast
    If IsGadget(i)
      DisableGadget(i, disable)
    EndIf
  Next 
  GadgetsAreDisabled = Disable
EndProcedure
Procedure ShapeGetProperties(state=1)
  
  Shared GadgetsAreDisabled
  
  SetPanelGadget()
  
  If ObjId <=ArraySize(Obj()) 
    
    If shapeId > -1 And ShapeID <= ArraySize(Obj(ObjId)\shape())
      
      ; disable/enable some gadgets if needed (if shape\locked = 1)
      If GadgetsAreDisabled = 1
        If Obj(ObjId)\Shape(ShapeId)\Locked = 0
          ShapeSetGadget(0)
        EndIf
      Else
        If Obj(ObjId)\Shape(ShapeId)\Locked = 1
          ShapeSetGadget(1)
        EndIf
      EndIf
      GadgetsAreDisabled = Obj(ObjId)\Shape(ShapeId)\Locked
      
      ; Debug "ok !!!"
      ; pour afficher les information du shape en cours
      ;SetGadgetState(#G_ObjDepth,Obj(ObjId)\Depth)
      ;SetGadgetText(#G_ObjName,Obj(ObjId)\Nom$)
      
      
      SetGadgetState(#G_ObjAlpha,Obj(ObjId)\Alpha)
      SetGadgetState(#G_ObjLock,Obj(ObjId)\Locked)
      ; SetGadgetState(#G_ObjHide,Obj(ObjId)\Locked)
      SetGadgetState(#G_ObjX,Obj(ObjId)\X)
      SetGadgetState(#G_ObjY,Obj(ObjId)\Y)
      SetGadgetState(#G_ObjH,Obj(ObjId)\H)
      SetGadgetState(#G_ObjW,Obj(ObjId)\W)
      ;SetGadgetState(#G_ObjHide,Obj(ObjId)\Hide)
      ;SetGadgetState(#G_ObjLock,Obj(ObjId)\Locked)
      SetGadgetState(#G_shapeAlpha,Obj(ObjId)\Shape(ShapeId)\Alpha)
      SetGadgetState(#G_shapeTyp,Obj(ObjId)\Shape(ShapeId)\Typ)
      
      SetGadgetState(#G_shapelist,ShapeId)

      SetGadgetState(#G_shapeLink,Obj(ObjId)\Shape(ShapeId)\Linked)
      SetGadgetState(#G_shapeLock,Obj(ObjId)\Shape(ShapeId)\Locked)
      SetGadgetState(#G_shapeShow,1-Obj(ObjId)\Shape(ShapeId)\Hide)
      SetGadgetState(#G_shapeDepth,Obj(ObjId)\Shape(ShapeId)\pos)
      SetGadgetState(#G_shapeClose,Obj(ObjId)\Shape(ShapeId)\open)
      UpdateGadgetParent()
      SetGadgetState(#G_shapeParent,Obj(ObjId)\Shape(ShapeId)\Parent\id-1)
      
      
      SetGadgetState(#G_shapeRnd,Obj(ObjId)\Shape(ShapeId)\Rnd)
      
      SetGadgetText(#G_shapeLineW,StrD(Obj(ObjId)\Shape(ShapeId)\w,4))
      SetGadgetText(#G_shapeLineH,StrD(Obj(ObjId)\Shape(ShapeId)\h,4))
      SetGadgetText(#G_shapeLineD,StrD(Obj(ObjId)\Shape(ShapeId)\d,4))

      
      
      ; propertie of the shape 
      If state =1
        SetGadgetState(#G_shapeSizeW,Obj(ObjId)\Shape(ShapeId)\SizeW)
        SetGadgetState(#G_shapeSizeH,Obj(ObjId)\Shape(ShapeId)\SizeH)
        ;SetGadgetState(#G_shapeLineW,(Obj(ObjId)\Shape(ShapeId)\w))
        ;SetGadgetState(#G_shapeLineH,(Obj(ObjId)\Shape(ShapeId)\h))
        ;SetGadgetState(#G_shapeLineD,Obj(ObjId)\Shape(ShapeId)\d)
        SetGadgetState(#G_shapeCX,Obj(ObjId)\Shape(ShapeId)\Cx)
        SetGadgetState(#G_shapeCY,Obj(ObjId)\Shape(ShapeId)\Cy)
        SetGadgetState(#G_shapeX,(Obj(ObjId)\Shape(ShapeId)\X))
        SetGadgetState(#G_shapeY,(Obj(ObjId)\Shape(ShapeId)\Y))
      Else
        SetGadgetText(#G_shapeSizeW,Str(Obj(ObjId)\Shape(ShapeId)\SizeW))
        SetGadgetText(#G_shapeSizeH,Str(Obj(ObjId)\Shape(ShapeId)\SizeH))
        SetGadgetText(#G_shapeCX,Str(Obj(ObjId)\Shape(ShapeId)\Cx))
        SetGadgetText(#G_shapeCY,Str(Obj(ObjId)\Shape(ShapeId)\Cy))
        SetGadgetText(#G_shapeX,Str(Obj(ObjId)\Shape(ShapeId)\X))
        SetGadgetText(#G_shapeY,Str(Obj(ObjId)\Shape(ShapeId)\Y))
      EndIf
      SetGadgetText(#G_shapeNom,Obj(ObjId)\Shape(ShapeId)\Nom$ )
      If IsGadget(#G_shapeIdUnik)
        SetGadgetText(#G_shapeIdUnik,Obj(ObjId)\Shape(ShapeId)\idUnik$)
      EndIf
      
      
      ; info of the points of the shape
      If PtId > -1 And PtId <= ArraySize(Obj(ObjId)\shape(ShapeId)\pt())
        SetGadgetState(#G_shapePtX,Obj(ObjId)\Shape(ShapeId)\pt(ptId)\x)
        SetGadgetState(#G_shapePtY,Obj(ObjId)\Shape(ShapeId)\pt(ptId)\y)
      EndIf
      
      ; puis, on met à jour les effets de style (FX)
      If ShapeFxId > ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())
        ShapeFxId = 0
      EndIf        
      min(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\W,1)
      min(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\H,1)
      min(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Dist,1)
      UpdateListShapeFX()
      SetGadgetState(#G_shapeFxList,ShapeFxId)
      SetGadgetState(#G_shapeFxActif,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Actif)
      SetGadgetState(#G_shapeFxAlpha,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Alpha)
      SetGadgetState(#G_shapeFxDepth,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Depth)
      SetGadgetState(#G_shapeFxLineTyp,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Style)
      
      SetGadgetText(#G_shapeFxLineW,StrD(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\W, 4))
      SetGadgetText(#G_shapeFxLineH,StrD(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\H,4))
      SetGadgetText(#G_shapeFxLineD,StrD(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Dist,4))
      
      SetGadgetState(#G_shapeFxX,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\X)
      SetGadgetState(#G_shapeFxY,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Y)
      SetGadgetState(#G_shapeFxScale,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Scale)
      
    EndIf
    
  EndIf
  
EndProcedure
Procedure UpdateGadgetParent()
  
  ClearGadgetItems(#G_shapeParent)
  For i=0 To ArraySize(obj(ObjId)\Shape())
    AddGadgetItem(#G_shapeParent, i, obj(ObjId)\Shape(i)\Nom$)
  Next
  
EndProcedure


;{ update
Procedure UpdateListShape()
    
  ClearGadgetItems(#G_shapelist)
  If vd\NbShape >0
    For i = 0 To  ArraySize(Obj(ObjId)\Shape())
      AddGadgetItem(#G_shapelist,i,Obj(ObjId)\Shape(i)\Nom$) 
    Next
  EndIf

EndProcedure
Procedure UpdateListShapeFX()
    
    ; pour mettre à jour la combobox liste des fx du shape
    If shapeId >-1 And shapeId <= ArraySize(Obj(ObjId)\Shape())
        
        ClearGadgetItems(#G_shapeFxList)
        
        For i = 0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())
            AddGadgetItem(#G_shapeFxList,i,Obj(ObjId)\Shape(ShapeId)\Fx(i)\Nom$)    
        Next
        
    EndIf

EndProcedure
Procedure UpdateListPresetFx()
    
    ; pour mettre à jour la liste des shape qu'on peut ajouter (elle se trouve dans le dossier "data\shape")
    ClearGadgetItems(#G_shapeFxPresetList)
    
    If ExamineDirectory(0, "data\shapefx\", "*.sfx")  
        While NextDirectoryEntry(0)
            If DirectoryEntryType(0) = #PB_DirectoryEntry_File
                nom$=RemoveString(DirectoryEntryName(0),".sfx")
                AddGadgetItem(#G_shapeFxPresetList,i,nom$)
                i+1
            EndIf
        Wend
        FinishDirectory(0)
    EndIf
    
EndProcedure
;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 30
; Folding = CJobfAGAAIEyRm1BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAw9DA+
; EnableXP