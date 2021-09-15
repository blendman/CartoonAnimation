
Repeat
  
  z.d = VdOptions\Zoom * 0.01
  
  Repeat 
    
    Event = WaitWindowEvent(1)
    EventGadget = EventGadget()
    EventMenu = EventMenu()
    
;      xa1 = WindowMouseX(#Win_VD_main) - GadgetX(#G_canvasVector) ; VdOptions\PanelW
;      ya1 = WindowMouseY(#Win_VD_main) - GadgetY(#G_canvasVector) ; vdoptions\ToolBarH
;      xa = (WindowMouseX(#Win_VD_main) - GadgetX(#G_canvasVector))*100)/VdOptions\Zoom ;- VD\ViewX 
;      ya = (WindowMouseY(#Win_VD_main) - GadgetY(#G_canvasVector))*100)/VdOptions\Zoom ;- VD\ViewY
;      StatusBarText(0,2,Str(xa)+"/"+Str(Ya)+" | "+Str(xa1)+"/"+Str(ya1))
    Z.d = VdOptions\Zoom*0.01
    mx = WindowMouseX(0)
    my = WindowMouseY(0)
    Mouseincanvas = 0
    If mx > GadgetX(#G_canvasVector) And mx< GadgetX(#G_canvasVector)+GadgetWidth(#G_canvasVector) And my> GadgetY(#G_canvasVector) And 
       my < GadgetY(#G_canvasVector)+GadgetHeight(#G_canvasVector)
      Mouseincanvas=1
      ; Debug "ok mouseincanvas"
    EndIf
    othergadgethasfocus = 0
    
    
    If event = #PB_Event_Gadget
      
      If IsGadget(EventGadget)
        result = GadgetType(EventGadget)
        If result = #PB_GadgetType_Spin Or result = #PB_GadgetType_String          
          If EventType() = #PB_EventType_Focus           
            ChangeShortCut(0)
          ElseIf EventType() = #PB_EventType_LostFocus   
            ChangeShortCut()
          EndIf
        EndIf
      EndIf
      
      If vd\Play = 0
        othergadgethasfocus = 1
        
        If eventgadget<#G_GadgetLastFormainwindow
          ;{ MAIN WINDOW
          Select EventGadget
              
              ;{ * canvas 
            Case #G_canvasVector 
              othergadgethasfocus = 0
              IncludeFile "eventcanvas.pbi"
              ;}
              
              ;{ * toolbar
            Case #G_ToolVDnew
              Doc_New()
              DrawCanvas() 
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ToolVDOpen
              Doc_Open()
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ToolVDSAve 
              Shape_Save()
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ToolVDMove To #G_ToolVDLast
              vdOptions\Action = EventGadget - #G_ToolVDMove
              For i =#G_ToolVDMove To #G_ToolVDLast
                If IsGadget(i)
                  SetGadgetState(i,0)
                EndIf                        
              Next
              SetGadgetState(EventGadget,1)
              Vd_SetGadgetOption()
              If EventGadget = #G_ToolVDMirorH
                Shape_Mirror()
              ElseIf EventGadget = #G_ToolVDMirorV
                Shape_Mirror(0,1)
              EndIf
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ToolVDSnapY, #G_ToolVDSnapX, #G_ToolVDSnap   
              VdOptions\Snap = GetGadgetState(#G_ToolVDSnap)
              VdOptions\SnapX = GetGadgetState(#G_ToolVDSnapX)
              VdOptions\SnapY = GetGadgetState(#G_ToolVDSnapY)
              min(VdOptions\SnapX,1)
              min(VdOptions\SnapY,1)
              DrawCanvas()
              
            Case #G_ToolVDCenter
              VdOptions\CenterTransformation = GetGadgetState(#G_ToolVDCenter)
              ;}
              
              ;{ * panel Left
            Case #G_panelVD
              If EventType()=#PB_EventType_Change
                vd\PanelLeftName$ =  GetGadgetItemText(#G_panelVD, GetGadgetState(#G_panelVD))
                vd\PanelLeftItem =   GetGadgetState(#G_panelVD)
              EndIf
              
              ;}
              
              ;{ * bank shapes
            Case #G_shapeCanvasBank
              VD_EventBangkGadget()
              
              ;{ add, list                            
            Case #G_shapeListFolderAdd 
              ShapeFolder$ = GetGadgetText(#G_shapeListFolderAdd)
              UpdateListBank(0, ShapeFolder$)
              
            Case #G_shapeAdd 
              If Doc_New(#DocFileMergeFromBank) = 0
                MessageRequester(lang("Error"), Lang("it seems the image preview exists, but the file doesn't exists : "+ 
                                                     GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))+
                                                     "\"+GetFilePart(BankImage$(bankImageID),#PB_FileSystem_NoExtension)+".txt"))
              EndIf
              SetActiveGadget(#G_canvasVector)
              
            Case #G_shapeDel
              Shape_Delete()
              SetActiveGadget(#G_canvasVector)   
              
            Case #G_shapeListAdd
              name$ = GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))
              If GetExtensionPart(name$) = #Empty$
                VD_UpdateShapeBankCanvas()
              Else
                vd\BankHasSubfolder =0
                Vd\ShapeFileName$ = name$
              EndIf
             
              ;}
              
              
              ;}
              
              ;{ * option tool
              ; option fx
            Case #G_TBOpt_TypeFXColor
              Color = ColorRequester(VdOptions\ToolOptionsFX\Color)
              If color <> -1
                VdOptions\ToolOptionsFX\Color = color
              EndIf
              
            Case #G_TBOpt_TypeFXOpen
              VdOptions\ToolOptionsFX\Open = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeFXAlpha
              VdOptions\ToolOptionsFX\Alpha = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeFXStyle
              VdOptions\ToolOptionsFX\Style = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeFXWidth
              VdOptions\ToolOptionsFX\Width = ValD(GetGadgetText(EventGadget))
              
              ; shape
            Case #G_TBOpt_TypeOpen
              VdOptions\ToolOptions\Open = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeAlpha
              VdOptions\ToolOptions\Alpha = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeColor
              Color = ColorRequester(VdOptions\ToolOptions\Color)
              If color <> -1
                VdOptions\ToolOptions\Color = color
              EndIf
              
            Case #G_TBOpt_TypeStyle
              VdOptions\ToolOptions\Style = GetGadgetState(EventGadget)
              
            Case #G_TBOpt_TypeWidth
              VdOptions\ToolOptions\Width = ValD(GetGadgetText(EventGadget))
              
            Case #G_TBOptToolType, #G_TBOptToolDistance, #G_TBOptToolAngle
              ; VdOptions\Action_Type = GetGadgetState(#G_TBOptToolType)
              VdOptions\Tool(action)\Type = GetGadgetState(#G_TBOptToolType)
              VdOptions\ToolOptions\angle = GetGadgetState(#G_TBOptToolAngle)
              VdOptions\ToolOptions\distance = GetGadgetState(#G_TBOptToolDistance)
              VD_Update_ToolOption()
              
            Case #G_TBOptLockX,#G_TBOptLockY
              If IsGadget(#G_TBOptLockX)
                VdOptions\Tool(vdOptions\Action)\LockX = GetGadgetState(#G_TBOptLockX)
              EndIf
              If IsGadget(#G_TBOptLockY)
                VdOptions\Tool(vdOptions\Action)\LockY = GetGadgetState(#G_TBOptLockY)
              EndIf
              
            Case #G_TBOptRotation
              GetShapeStartTransformation(1)
              rot = Val(GetGadgetText(#G_TBOptRotation))
              ;Debug Rot
              ; VdOptions\Tool(vdOptions\Action)\Rotation = Rot
              Shape_SetAngle(Rot)
              
            Case #G_TBOptHeight
              VdOptions\Tool(vdOptions\Action)\SizeH = GetGadgetState(#G_TBOptHeight)
              ; SetShapeScale()
              
            Case #G_TBOptWidth
              VdOptions\Tool(vdOptions\Action)\SizeW = GetGadgetState(#G_TBOptWidth)
              
              ;}
              
              ;{ * Layer (objet)
            Case #G_ObjAlpha
              Obj(ObjId)\Alpha = GetGadgetState(#G_ObjAlpha)
              DrawCanvas()
              
            Case #G_ObjDown
              ; c'est inversé, car les calques sont affichés de bas en haut
              If ObjId>0
                newpos = ObjId-1
                pos = ObjId  
                CopyObj\depth = Obj(ObjId)\Depth
                Obj(ObjId)\Depth = Obj(newpos)\depth   
                Obj(newpos)\depth = CopyObj\depth                        
                SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
                objID = newpos
                VD_Layer_UpdateUI(1)
              EndIf
              
            Case #G_ObjUp
              ; c'est inversé, car les calques sont affichés de bas en haut
              If ObjId<ArraySize(Obj())
                newpos = ObjId+1
                pos = ObjId  
                CopyObj\depth = Obj(ObjId)\Depth
                Obj(ObjId)\Depth = Obj(newpos)\depth   
                Obj(newpos)\depth = CopyObj\depth                        
                SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
                objID = newpos
                VD_Layer_UpdateUI(1)
              EndIf
              
            Case #G_ObjList
              okupdateObjUI = 0
              ; attention, c'est inversé car les calques vont de bas en haut et non de haut en bas
              If StartDrawing(CanvasOutput(#G_ObjList))
                x = GetGadgetAttribute(#G_ObjList, #PB_Canvas_MouseX)
                y = GetGadgetAttribute(#G_ObjList, #PB_Canvas_MouseY)
                If EventType() = #PB_EventType_LeftButtonDown
                  ; Debug ObjId
                  Vd\PathId = 1                                    
                  ; ShapeId = 0
                  oldObjId = ObjId
                  v_id = y/25
                  n = ArraySize(Obj())
                  If x > 25
                    ; je suis obligé de faire n - calque actuel
                    ; car pour afficher les calque-objet, je dois inverser, car ils se créent de haut en bas 
                    ; et moi, je les veux de bas en haut ^^                                
                    ObjId = n-v_id
                    If ObjId > ArraySize(Obj())
                      ObjId = ArraySize(Obj())
                    ElseIf ObjId <0
                      ObjId = 0
                    EndIf                                
                  ElseIf x<25
                    u = n-v_id
                    If u > ArraySize(Obj())
                      u = ArraySize(Obj())
                    ElseIf u <0
                      u=0
                    EndIf  
                    Obj(u)\Hide = 1 - Obj(u)\Hide                                
                  EndIf
                  okupdateObjUi = 1
                ElseIf EventType() = #PB_EventType_LeftDoubleClick                            
                  If x > 25
                    nom${20} = InputRequester(Lang("New Name"),Lang("Set the name for this object"),#Empty$)
                    If nom$ <> #Empty$
                      Obj(ObjId)\Nom$ = nom$
                      okupdateObjUI=1
                    EndIf
                  EndIf
                EndIf
                StopDrawing()
              EndIf
              If okupdateObjUI = 1
                VD_Layer_UpdateUI(1)
                If VD\pathId=1
                  VD_UpdateCanvasPath()
                EndIf
              EndIf
              
            Case #G_ObjClipColor, #G_ObjClipBorderColor
              color = ColorRequester(obj(obji)\ClipColor)
              If color >-1
                If eventgadget= #G_ObjClipColor
                  obj(obji)\ClipColor= color
                ElseIf eventgadget = #G_ObjClipBorderColor
                  obj(obji)\ClipBorderColor = color
                EndIf
              EndIf
              SetActiveGadget(#G_canvasVector)
              Drawcanvas()
               
            Case #G_ObjClip,#G_ObjClipHide,#G_ObjClipBorder
              Obj(objid)\Clip = GetGadgetState(#G_ObjClip)
              Obj(objid)\ClipHide = GetGadgetState(#G_ObjClipHide)
              Obj(objid)\ClipBorder = GetGadgetState(#G_ObjClipBorder)
              SetActiveGadget(#G_canvasVector)
              Drawcanvas()
              
            Case #G_ObjClip To #G_ObjClipBorderStroke
              Obj(objid)\Clip = GetGadgetState(#G_ObjClip)
              Obj(objid)\ClipW= GetGadgetState(#G_ObjClipW)
              Obj(objid)\ClipH = GetGadgetState(#G_ObjClipH)
              Obj(objid)\ClipHide = GetGadgetState(#G_ObjClipHide)
              Obj(objid)\ClipAlpha = GetGadgetState(#G_ObjClipAlpha)
              Obj(objid)\ClipBorder = GetGadgetState(#G_ObjClipBorder)
              Obj(objid)\ClipBorderAlpha = GetGadgetState(#G_ObjClipBorderAlpha)
              Obj(objid)\ClipBorderStroke = GetGadgetState(#G_ObjClipBorderStroke)
              Drawcanvas()
              
            Case #G_ObjDel 
              DeleteArrayElement(Obj,ObjId)
              ObjId = 0                    
              VD_Layer_UpdateUI(1)
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ObjAdd    
              Vd_LayerAdd()
              SetActiveGadget(#G_canvasVector)
              
            Case #G_ObjLock
              Obj(ObjId)\Locked = GetGadgetState(#G_ObjLock)
              VD_Layer_UpdateUI(1)
              
              ; Case #G_ObjCreate
              ; vd\createObj = GetGadgetState(#G_ObjCreate)
              
            Case #G_ObjH, #G_ObjW
              Obj(ObjId)\H = GetGadgetState(#G_ObjH)
              Obj(ObjId)\W = GetGadgetState(#G_ObjW)                    
              Drawcanvas()
              
            Case #G_ObjHide
              Obj(ObjId)\Hide = GetGadgetState(#G_ObjHide)
              Drawcanvas()
              
            Case #G_ObjName
              Obj(ObjId)\Nom$ = GetGadgetText(#G_ObjName)
              VD_Layer_UpdateUI()
              
            Case #G_ObjX, #G_ObjY 
              Obj(ObjId)\x = GetGadgetState(#G_ObjX)
              Obj(ObjId)\y = GetGadgetState(#G_ObjY)
              Drawcanvas()
              
            Case #G_ObjDepth
              Obj(ObjId)\Depth = GetGadgetState(#G_ObjDepth)
              SortStructuredArray(Obj(),#PB_Sort_Ascending ,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
              VD_Layer_UpdateUI()
              
              ;}
              
              ;{ * Shape properties 
              
              ;{ parameters : nom, link, hide, close, lock, x,y,w,h
            Case #G_shapeNom
              If EventType() = #PB_EventType_Focus           
                ChangeShortCut(0)
              ElseIf EventType() = #PB_EventType_LostFocus   
                ChangeShortCut()
              EndIf
              If ShapeId > -1
                Name$ = GetGadgetText(#G_shapeNom)
                If name$ <> #Empty$
                  Obj(ObjId)\Shape(ShapeId)\Nom$ = name$
                EndIf
                UpdateListShape()
              EndIf
               
            Case #G_shapelist
              If vd\NbShape >=0
                ShapeId = GetGadgetState(#G_shapelist)
                If shapeID >-1
                  If ShapeId<= ArraySize(Obj(ObjId)\Shape()) 
                    Ze_idunik$ = Obj(ObjId)\Shape(ShapeId)\idunik$
                  EndIf
                  ShapeFxId = 0
                  For i = 0 To CountGadgetItems(#G_shapelist)-1
                    If GetGadgetItemState(#G_shapelist,i) <> 0
                      Obj(ObjId)\Shape(i)\Selected = 1
                      Debug "select "+i
                    Else
                      Obj(ObjId)\Shape(i)\Selected = 0
                    EndIf 
                  Next
                  ;If EventType() = #PB_EventType_LeftDoubleClick
                  ;Obj(ObjId)\Shape(ShapeId)\Nom$ = 
                  Drawcanvas()
                  If shapeId >-1
                    ShapeGetProperties()  ; in gadget.pbi                     
                  EndIf
                  SetActiveGadget(#G_canvasVector)
                EndIf
              EndIf
              
            Case #G_shapeClose
              If shapeid >-1
                Obj(ObjId)\Shape(ShapeId)\open = GetGadgetState(#G_shapeClose)
                DrawCanvas()
              EndIf
              
            Case #G_shapeShow
              If shapeid >-1
                Obj(ObjId)\Shape(ShapeId)\Hide =1-GetGadgetState(#G_shapeShow)
                DrawCanvas()
              EndIf   
              
            Case #G_shapeDepth
              If EventType() = #PB_EventType_Change
                If shapeid >-1
                  ; keep the current idunik of the shape, to set the shapeid to this shape after change
                  
                  Ze_Name$ = Obj(ObjId)\Shape(ShapeId)\Nom$
                  Debug Ze_idunik$ +" / "+Obj(ObjId)\Shape(ShapeId)\Nom$
                  ; get the order/depth position
                  Obj(ObjId)\Shape(ShapeId)\Pos =GetGadgetState(#G_shapeDepth)
                  ; on trie en fonction du depth
                  SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending, OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
                  ; on reselectionne le shape
                  For i = 0 To ArraySize(obj(ObjId)\Shape())
                    If obj(ObjId)\Shape(i)\idUnik$ = Ze_idunik$ ; And Ze_Name$ = Obj(ObjId)\Shape(i)\Nom$
                      shapeId = i
                      Debug Ze_idunik$+" / "+"shapeid : "+Str(i)+" / "+Obj(ObjId)\Shape(ShapeId)\Nom$
                      Break
                    EndIf
                  Next
                  UpdateListShape()
                  ;ShapeGetProperties()     
                  DrawCanvas()
                EndIf
              EndIf
              
            Case #G_shapeParent
              If ShapeId > -1
                PreviousId = Obj(ObjId)\Shape(ShapeId)\Parent\id
                id = GetGadgetState(#G_shapeParent)
                If id =ShapeId
                  id = -1
                  If id <> PreviousId And PreviousId >0
                    Shape_SetPropertie(#ShapePropertie_DeParenting)
                  EndIf
                EndIf
                Obj(ObjId)\Shape(ShapeId)\Parent\id = id+1
                Obj(ObjId)\Shape(ShapeId)\Parent\startx = Obj(ObjId)\Shape(id)\x
                Obj(ObjId)\Shape(ShapeId)\Parent\starty = Obj(ObjId)\Shape(id)\y
                Obj(ObjId)\Shape(ShapeId)\Parent\idUnik$ = Obj(ObjId)\Shape(id)\idUnik$
                DrawCanvas(0,0,0)
              EndIf
              
            Case #G_shapeLink
              If ShapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Linked = GetGadgetState(#G_shapeLink)
                DrawCanvas()
              EndIf
              
            Case #G_shapeLock 
              If ShapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Locked = GetGadgetState(#G_shapeLock)
                ShapeSetGadget(Obj(ObjId)\Shape(ShapeId)\Locked )
              EndIf
              
            Case #G_shapeHide
              If ShapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Hide = GetGadgetState(#G_shapeHide)
                DrawCanvas()
              EndIf
              
            Case #G_shapeSizeW, #G_shapeSizeH 
              If ShapeId > -1
                Obj(ObjId)\Shape(ShapeId)\SizeW = GetGadgetState(#G_shapeSizeW)
                Obj(ObjId)\Shape(ShapeId)\SizeH = GetGadgetState(#G_shapeSizeH)
                Drawcanvas()
              EndIf
              
            Case #G_shapeX, #G_shapeY
              If ShapeId >-1
                Obj(ObjId)\Shape(ShapeId)\x = GetGadgetState(#G_shapeX)
                Obj(ObjId)\Shape(ShapeId)\y = GetGadgetState(#G_shapeY)
                Drawcanvas()
              EndIf
              
              ;}
              
              ;{ text
            Case #G_shapeTextFont
              If ShapeId > -1
                font         = Obj(ObjId)\Shape(ShapeId)\Font
                FontName$    = Obj(ObjId)\Shape(ShapeId)\FontName$
                FontStyle    = Obj(ObjId)\Shape(ShapeId)\FontStyle
                FontFx       = Obj(ObjId)\Shape(ShapeId)\FontFx
                FontSize     = Obj(ObjId)\Shape(ShapeId)\SizeW
                If IsFont(Font)
                  FreeFont(Font)
                  FontRequester(FontName$,20,#PB_FontRequester_Effects,0,FontStyle)
                  FontName$ = SelectedFontName()
                  FontStyle = SelectedFontStyle()
                  
                  Obj(ObjId)\Shape(ShapeId)\FontName$ = FontName$
                  Obj(ObjId)\Shape(ShapeId)\FontStyle = FontStyle
                  Obj(ObjId)\Shape(ShapeId)\Font = LoadFont(#PB_Any,FontName$,20,FontStyle) 
                  
                EndIf   
                Drawcanvas()
              EndIf
              
            Case #G_shapeText
              If ShapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Text$ =InputRequester("Text","Change the text",Obj(ObjId)\Shape(ShapeId)\Text$)
                Drawcanvas()
              EndIf
              ;}
              
              ;{ style 
            Case #G_shapeTyp
              Shape_SetPropertie(#ShapePropertie_Style)
              
            Case #G_shapeLineW
              Shape_SetPropertie(#ShapePropertie_StrokeWidth)
              
            Case #G_shapeLineH
              Shape_SetPropertie(#ShapePropertie_LineH)
              
            Case #G_shapeLineD
              Shape_SetPropertie(#ShapePropertie_LineD)
              ;}
              
              ;{ offset & edit mode
            Case #G_ToolVDEditMode
              vd\EditMode = GetGadgetState(#G_ToolVDEditMode)
              DrawCanvas() 
              
            Case #G_shapeCX, #G_shapeCY
              If ShapeId >-1
                Obj(ObjId)\Shape(ShapeId)\Cx = GetGadgetState(#G_shapeCX)
                Obj(ObjId)\Shape(ShapeId)\Cy = GetGadgetState(#G_shapeCY)
                Drawcanvas()
              EndIf
              ;}
              
              ;{ points
            Case #G_shapeNotRender
              If shapeId> -1
                If PtID >=0 And ptID <=ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                  With Obj(ObjId)\Shape(ShapeId)\pt(PtId)
                    \hide = GetGadgetState(#G_shapeNotRender)
                  EndWith
                  DrawCanvas()
                EndIf
              EndIf
              
            Case #G_shapePtX, #G_shapePtY,#G_shapePtXLock, #G_shapePtY
              If shapeId> -1
                If PtID >=0 And ptID <=ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                  With Obj(ObjId)\Shape(ShapeId)\pt(PtId)
                    \LockX = GetGadgetState(#G_shapePtXlock)
                    \LockY = GetGadgetState(#G_shapePtYlock)
                    \x = GetGadgetState(#G_shapePtX)
                    \y = GetGadgetState(#G_shapePtY)
                  EndWith
                  DrawCanvas()
                EndIf
              EndIf
              
            Case #G_shapePtHard
              Vd_SetPoint(0)
              
            Case #G_shapePtMirored
              Vd_SetPoint(2)
              
            Case #G_shapePtUseMirored
              Vd\PtUsemirored = GetGadgetState(#G_shapePtUseMirored)
              
            Case #G_shapePtSoft
              Vd_SetPoint(1)
              
            Case #G_shapePtMenu
              If ShapeId > -1                        
                DisplayPopupMenu(#MenuVDPopUpPt,WindowID(#Win_VD_main),GadgetX(#G_shapePtMenu)+5,WindowMouseY(#Win_VD_main))  
                ;GadgetY(#G_panelVD)+GadgetY(#G_shapePtMenu))
              EndIf
              
              ;}
              
              ;{ extra
            Case #G_shapeRnd
              If shapeid > -1
                Obj(ObjId)\Shape(ShapeId)\Rnd = GetGadgetState(#G_shapeRnd)
                Drawcanvas()
              EndIf
              
              ;}
              
              ;{ color, alpha 
            Case #G_shapeColorTyp
              Shape_SetPropertie(#ShapePropertie_ColorTyp)
              
            Case #G_shapeColor
              Shape_SetPropertie(#ShapePropertie_Color)
              
            Case #G_shapeAlpha
              Shape_SetPropertie(#ShapePropertie_Alpha)
              ;}
              
              ;{ depth
            Case #G_shapePosDown
              Shape_SetDepth(-1)
              
            Case #G_shapePosUp
              Shape_SetDepth()
              ;{
              ;                      ; c'est inversé, car les calques sont affichés de bas en haut
              ;                     If ObjId<ArraySize(Obj())
              ;                         newpos  = ObjId+1
              ;                         pos     = ObjId 
              ;                         
              ;                         CopyObj\depth = Obj(ObjId)\Depth
              ;                         Obj(ObjId)\Depth = Obj(newpos)\depth   
              ;                         Obj(newpos)\depth = CopyObj\depth                        
              ;                         
              ;                         ;SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
              ;                         ;UpdateUiObjetVD(1)
              ;                     EndIf
              ;}
              
              ;}
              
              ;{ image
            Case #G_shapeImgRepeat
              If shapeId>-1
                If GetGadgetState(#G_shapeImgRepeat) =0
                  Obj(ObjId)\Shape(ShapeId)\ImgRepeat = #PB_VectorImage_Default
                Else
                  Obj(ObjId)\Shape(ShapeId)\ImgRepeat = #PB_VectorImage_Repeat
                EndIf
                DrawCanvas()
              EndIf
              
            Case #G_shapeImgChange
              VD_Shape_ChangeImage()
              
            Case #G_shapeImgW
              VD_SetGadgetState(ImgW)
              
            Case #G_shapeImgH
              VD_SetGadgetState(ImgH)
              
            Case #G_shapeImgx
              VD_SetGadgetState(ImgX)
              
            Case #G_shapeImgY
              VD_SetGadgetState(ImgY)
              
              ;Case #G_shapeImgRot
              ;VD_SetGadgetState(ImgRot)
              
              
              ;}
              
              
              ;}
              
              ;{ * Shape FX
              
            Case #G_shapeFxScale
              If shapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Scale = GetGadgetState(#G_shapeFxScale)
                Drawcanvas()
              EndIf                    
              
            Case #G_shapeFxPresetList
              nom$ = GetGadgetItemText(#G_shapeFxPresetList,GetGadgetState(#G_shapeFxPresetList))
              ShapeLoadFxLayer(nom$)
              
            Case #G_shapeFxList  
              ShapeFxId = GetGadgetState(#G_shapeFxList)
              ShapeGetProperties()
              
            Case #G_shapeFxPresetSave
              ShapeExportFxLayer() 
              
            Case #G_shapeFxAdd 
              If shapeId > -1
                n = ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())+1
                ReDim Obj(ObjId)\Shape(ShapeId)\Fx(n)
                ShapeFxId = n
                ShapeAddFx(n)                     
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxDel
              If shapeId > -1
                If ShapeFxId<= ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx()) 
                  If ShapeFxId >=1
                    DeleteArrayElement(Obj(ObjId)\Shape(ShapeId)\Fx, ShapeFxId)
                    ShapeFxId = ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())
                  Else
                    
                  EndIf
                  UpdateListShapeFX()
                  Drawcanvas()
                EndIf
              EndIf
              
            Case #G_shapeFxOpen
              If shapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\open = GetGadgetState(#G_shapeFxOpen)
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxActif 
              Shape_SetFXpropertie(#ShapePropertie_ActiveFx,0)
              
            Case #G_shapeFxLineTyp
              Shape_SetFXpropertie(#ShapePropertie_Style,0)
              
            Case #G_shapeFxLineW
              Shape_SetFXpropertie(#ShapePropertie_StrokeWidth,0)
              
            Case #G_shapeFxLineH,#G_shapeFxLineD
              If shapeId > -1
                ; W = ValD(GetGadgetText(#G_shapeFxLineW)) : min(w,0.001)
                ; Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\w =w                    
                H = ValD(GetGadgetText(#G_shapeFxLineH)) : min(h,0.001)
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\h=h
                Dist = ValD(GetGadgetText(#G_shapeFxLineD)) : min(dist,0.001)
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\dist=dist
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxDepth
              If shapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Depth = GetGadgetState(#G_shapeFxDepth)
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxAlpha
              Shape_SetFXpropertie(#ShapePropertie_Alpha,0)
              
            Case #G_shapeFxX
              If shapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\X = GetGadgetState(#G_shapeFxX)
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxY
              If shapeId > -1
                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Y = GetGadgetState(#G_shapeFxY)
                Drawcanvas()
              EndIf
              
            Case #G_shapeFxColor
              Shape_SetFXpropertie(#ShapePropertie_Color,0)
              ;}
              
              ;{ * BG options (color, img, alpha...)
            Case #G_Vd_OptBGImgX,#G_Vd_OptBGImgY,#G_Vd_OptBGImgW, #G_Vd_OptBGImgh, #G_Vd_OptBGImgAlpha, #G_Vd_OptBGImgDepth
              VdOptions\BgImg\x =  GetGadgetState(#G_Vd_OptBGImgX)
              VdOptions\BgImg\y =  GetGadgetState(#G_Vd_OptBGImgY)
              VdOptions\BgImg\w =  GetGadgetState(#G_Vd_OptBGImgW)
              VdOptions\BgImg\h =  GetGadgetState(#G_Vd_OptBGImgH)
              VdOptions\BgImg\Alpha =  GetGadgetState(#G_Vd_OptBGImgAlpha)
              VdOptions\BgImg\depth =  GetGadgetState(#G_Vd_OptBGImgDepth)
              drawcanvas()
              
            Case #G_Vd_OptBGImgprop
              WindowBackgroundPropertie()
              
            Case #G_Vd_OptBGImgUse
              VdOptions\ShowBGImg = GetGadgetState(#G_Vd_OptBGImgUse)
              drawcanvas()
              
            Case #G_Vd_OptBGImgLoad
              Filter$ = "Images|*.png;*.jpg;*.bmp"
              name$ = OpenFileRequester(Lang("Image"),GetCurrentDirectory(),Filter$,0)
              BG_LoadImage(name$) ; in gadgets.pb
              
            Case #G_Vd_OptBGColor
              Col = ColorRequester(VdOptions\BgColor)
              VdOptions\BgColor=RGBA(Red(col),Green(col),Blue(col),255)
              drawcanvas()
              
            Case #G_Vd_OptCamCachAlpha                            
              VdOptions\CameraCacheAlpha=GetGadgetState(#G_Vd_OptCamCachAlpha)
              drawcanvas()
              
            Case #G_Vd_OptBGCheck
              VdOptions\BGChecker = GetGadgetState(#G_Vd_OptBGCheck)
              DrawCanvas()
              ;}
              
              ;{ * Timeline
            Case #G_VDTimeline
              VD_TimeLineEvent()   
              ;}
              
              ;{ * Animation control                            
            Case #G_VDAnimMaxFrame
              Vd\FrameEnd  = Val(GetGadgetText(#G_VDAnimMaxFrame))
              If vd\CurrentFrame > Vd\FrameEnd
                vd\CurrentFrame =0
              EndIf 
              
              
            Case #G_VDAnimStart
              vd\CurrentFrame = 0
              SetGadgetText(#G_VDAnimCurFrame,"0")
              
            Case #G_VDAnimEnd
              vd\CurrentFrame = Vd\FrameEnd
              SetGadgetText(#G_VDAnimCurFrame,Str(Vd\FrameEnd))
              
            Case #G_VDAnimFps
              Vd\FrameFps = GetGadgetState(#G_VDAnimFps)
              
            Case #G_VDAnimPlay                          
              vd\play = 1-vd\play
              play$ ="play,stop"
              SetGadgetText(#G_VDAnimPlay,StringField(play$,1+Vd\Play,","))
              Vd\playTimer = ElapsedMilliseconds()
              Debug "ok "+Vd\Play
              ;}
              
              ;{ * canvas path
            Case #G_CanvasPathVDScene
              If StartDrawing(CanvasOutput(#G_CanvasPathVDScene))
                x = GetGadgetAttribute(#G_CanvasPathVDScene, #PB_Canvas_MouseX)
                y = GetGadgetAttribute(#G_CanvasPathVDScene, #PB_Canvas_MouseY)
                If EventType() = #PB_EventType_LeftButtonDown
                  If X< 80
                    Vd\PathId = 0 
                  ElseIf X>=80 And x<160
                    Vd\PathId = 1
                  Else
                    ;Vd\PathId = 2
                  EndIf
                  okpath = 1
                EndIf
                StopDrawing()
              EndIf
              If okpath=1
                okpath=0
                VD_UpdateCanvasPath()
              EndIf
              
              ;}
              
          EndSelect
          ;}
        ElseIf eventgadget = #G_Win_BtnOk Or eventgadget = #G_Win_BtnCancel
          CloseWindow(GetActiveWindow())
          
        ElseIf eventgadget >= #G_win_group_list And EventGadget<=#G_win_group_DeleteGroup
          ;{ window group
          EventWindowGroup(EventGadget)
          ;}
        EndIf        
            
      Else ; si on joue l'animation, on ne doit plus pouvoir bouger le reste, sauf certains gadgets (lié à l'animation par exemple)
        
        Select EventGadget
            
          Case #G_VDTimeline
            VD_TimeLineEvent(1)
            
          Case #G_VDAnimPlay
            Vd\Play = 1 - Vd\Play
            play$ ="play,stop"
            SetGadgetText(#G_VDAnimPlay,StringField(play$,1+Vd\Play,","))
            DrawCanvas()
            
            
        EndSelect
        
      EndIf
      
    ElseIf  event = #PB_Event_Menu

      Select EventMenu
          
          ;{ shortcut GUI
        Case #menuVD_EditPoint
          If vd\EditMode = #VD_Editmode_Point
            vd\EditMode = #VD_Editmode_Object
            SetGadgetState(#G_ToolVDEditMode,  vd\EditMode)
          Else
            vd\EditMode = #VD_Editmode_Point
            SetGadgetState(#G_ToolVDEditMode,  vd\EditMode)
          EndIf
          DrawCanvas() 
          
        Case #menuVD_PointMirored
          Vd\PtUsemirored = 1-Vd\PtUsemirored
          SetGadgetState(#G_shapePtUseMirored, Vd\PtUsemirored)
          ;}
          
          ;{ files
        Case #menuVD_ShapeOpen
          Doc_Open()
          
        Case #menuVD_ShapeSaveAs 
          Shape_Save()
          
        Case #menuVD_ShapeSaveselected
          Shape_Save(#Empty$,0,1)
          
        Case #menuVD_ShapeSave 
          Shape_Save(VD\DocFilename$)
          
        Case #menuVD_ShapeNew 
          Doc_New()
          DrawCanvas()
          
        Case #menuVD_ShapeMergeShape
          Shape_Load(1)
          
        Case #menuVD_ExportScene
          Scene_Export(1)
          
        Case #menuVD_ExportImageObj
          Scene_Export()
          
        Case #menuVD_ExportImageSelected
          Scene_Export(0,0,"",1)
          
        Case #menuVD_ExportPb
          VD_ExportPbCommand()
          
        Case #menuVD_ExportSVG  
          VD_ExportInSVG()
          
        Case #menuVD_ProjProperties
          OpenWindow_Sceneproperties()
          
        Case #menuVD_Preference
          WindowPref()
          
        Case #menuVD_ShapeQuit
          quit = 1
          ;}
          
          ;{ Edit
        Case #menuVD_ShapeSelectAll
          Shape_SelectAll(1)
          DrawCanvas(0,0,0)
          
        Case #menuVD_ShapeDeselectAll
          Shape_SelectAll(0)
          DrawCanvas()
          
        Case #menuVD_ShapeCopy                    
          If ShapeId>-1 Or ArraySize(obj(ObjId)\Shape())>=0
            nb=-1
            For i=0 To ArraySize(obj(ObjId)\Shape())
              With obj(ObjId)\Shape(i)
                If \Selected Or i = shapeid
                  nb+1
                  ReDim CopyObj\shape.sShape(nb)
                  CopyObj\Shape(nb)=Obj(ObjId)\Shape(i)
                  CopyObj\Shape(nb)\Nom$ = "Copy_"+Str(ArraySize(Obj(ObjId)\Shape())+1)
                EndIf
              EndWith
            Next
;             CopyObj\Shape(0)=Obj(ObjId)\Shape(ShapeId)
;             CopyObj\Shape(0)\Nom$ = "Shape_"+Str(ArraySize(Obj(ObjId)\Shape())+1)
          EndIf 
          
        Case #menuVD_ShapePast 
          ;{
          x = ((WindowMouseX(#Win_VD_main) - GadgetX(#G_canvasVector))*100)/VdOptions\Zoom - VD\ViewX 
          y = ((WindowMouseY(#Win_VD_main) - GadgetY(#G_canvasVector))*100)/VdOptions\Zoom - VD\ViewY
          Shape_SelectAll(0) 
          For k = 0 To ArraySize(CopyObj\Shape())
            n = ArraySize(Obj(ObjId)\Shape())+1
            ReDim Obj(ObjId)\Shape.sShape(n)
            ShapeId = n
            Doc_New(0,1)
            Obj(ObjId)\Shape(ShapeId) = CopyObj\Shape(k)                   
            Obj(ObjId)\Shape(ShapeId)\idUnik$ = Shape_CreateIdUnik()                 
            Obj(ObjId)\Shape(ShapeId)\X =x +CopyObj\Shape(k)\X - CopyObj\Shape(0)\x  
            Obj(ObjId)\Shape(ShapeId)\y =y +CopyObj\Shape(k)\y - CopyObj\Shape(0)\y
            ; Debug "X " + Obj(ObjId)\Shape(ShapeId)\X+ "/"+ x
          Next
          Ze_idunik$ = obj(ObjId)\shape(shapeId)\idUnik$
          Shape_SortDepth(Ze_idunik$)
          ShapeGetProperties()
          ;Debug "alpha "+Obj(ObjId)\Shape(ShapeId)\Alpha
          ;Debug Obj(ObjId)\Shape(ShapeId)\Nom$ 
          ;}
          
        Case #menuVD_ShapePastToshape
          If ShapeId>-1  
            Ze_idunik$ = obj(ObjId)\shape(shapeId)\idUnik$
            Obj(ObjId)\Shape(ShapeId)= CopyObj\Shape(0)
            obj(ObjId)\shape(shapeId)\idUnik$ = Ze_idunik$
            Shape_SortDepth(Ze_idunik$)
          EndIf
          
          ;}
          
          ;{ View
        Case #menuVD_ShowOrigin
          Vd_ShowMenu(#menuVD_ShowOrigin,VdOptions\ShowOrigin)
          
        Case #menuVD_ShowCamCache
          Vd_ShowMenu(#menuVD_ShowCamCache,VdOptions\ShowCameraCache)
          
        Case #menuVD_ShowCamBorder
          Vd_ShowMenu(#menuVD_ShowCamBorder,VdOptions\ShowCameraBorder)
          
        Case #menuVD_ShowGrid
          Vd_ShowMenu(#menuVD_ShowGrid,VdOptions\ShowGrid)
          
        Case #menuVD_ShowSelection
          Vd_ShowMenu(#menuVD_ShowSelection,VdOptions\ShowSelection)
          
        Case #menuVD_ShowBoundingboxShape
          Vd_ShowMenu(#menuVD_ShowBoundingboxShape,VdOptions\ShowShapeBoundingBox)
          
        Case #menuVD_ShowBoundingboxSelection
          Vd_ShowMenu(#menuVD_ShowBoundingboxSelection,VdOptions\ShowBoxselect)
          
        Case #menuVD_ShowAncreSelected
          Vd_ShowMenu(#menuVD_ShowAncreSelected,VdOptions\ShowAncreSelected)
          
        Case #menuVD_HideAncre
          Vd_ShowMenu(#menuVD_HideAncre,VdOptions\HideAncre)
          
        Case #menuVD_ShowOnlySelected
          Vd_ShowMenu(#menuVD_ShowOnlySelected,VdOptions\ShowOnlySel)
          
        Case #menuVD_ViewCenter
          VD\ViewX = (GadgetWidth(#G_canvasVector)*0.5) - (VdOptions\CameraW *0.5)*z
          VD\Viewy = (GadgetHeight(#G_canvasVector)*0.5) - (VdOptions\CameraH *0.5)*z
          Debug "View "+vd\ViewX+"/"+vd\ViewY
          Drawcanvas()
          
        Case #menuVD_ViewReset
          VD\ViewX = 0
          VD\ViewY = 0
          Drawcanvas()
          
        Case #menuVD_Zoom50 To #menuVD_Zoom1500
          Select EventMenu() 
            Case #menuVD_ZoomReset
              VdOptions\Zoom = 100 
            Case #menuVD_Zoom500
              VdOptions\Zoom = 500
            Case #menuVD_Zoom1500
              VdOptions\Zoom = 1500 
            Case #menuVD_Zoom1000
              VdOptions\Zoom = 1000
            Case #menuVD_Zoom200
              VdOptions\Zoom = 200
            Case #menuVD_Zoom50
              VdOptions\Zoom = 50
          EndSelect
          Drawcanvas()
          StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
          
        Case #menuVD_ZoomPlus
          If VdOptions\Zoom<10
            VdOptions\Zoom + 1
          ElseIf VdOptions\Zoom<100
            VdOptions\Zoom + 10
          Else
            VdOptions\Zoom + 20
          EndIf
          Drawcanvas()
          StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
          
        Case #menuVD_ZoomMoins
          If VdOptions\Zoom > 100
            VdOptions\Zoom -20
          ElseIf VdOptions\Zoom > 10
            VdOptions\Zoom -10
          ElseIf VdOptions\Zoom > 1
            VdOptions\Zoom -1
          EndIf
          Drawcanvas()
          StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
          
          ;}
          
          ;{ Layers
        Case #menuVD_AddObjet
          Vd_LayerAdd()
          
        Case #menuVD_DeleteObjet
          DeleteArrayElement(Obj,ObjId)
          ObjId = 0                    
          VD_Layer_UpdateUI(1)
          ;}
          
          ;{ Shapes 
        Case #menuVD_ShapeSetGroup
          WindowGroup()
          
        Case #menuVD_ShapeSetParent
          Shape_SetPropertie(#ShapePropertie_SetParent)
          
        Case #menuVD_ShapeDeParenting
          Shape_SetPropertie(#ShapePropertie_DeParenting)
          
        Case #menuVD_LockSelected
          Shape_Lock()
          
        Case #menuVD_UnLockAll
          Shape_Lock(0)
          
        Case #menuVD_LockAllExceptSelected
          Shape_Lock(2)
          
        Case #menuVD_HideAllExceptSelected
          Shape_Hide(2) 
          
        Case #menuVD_HideSelected
          If Mouseincanvas = 1 And othergadgethasfocus = 0
            Shape_Hide() 
          EndIf
          
        Case #menuVD_UnHideAll
          Shape_Hide(0)
          
        Case #menuVD_ShapeDelete
          ;If Mouseincanvas = 1 And othergadgethasfocus = 0
          If GetActiveGadget() = #G_canvasVector
             Shape_Delete()
          EndIf
          
        Case #menuVD_ShapeLockSelect
          Vd\LockSelection = 1-Vd\LockSelection
          SetMenuItemState(#MenuWinVD,#menuVD_ShapeLockSelect, Vd\LockSelection)

        Case #menuVD_SetShapeToTop
          If Shape_GetShapeIDselected(1) = 1
            
            ; on échange uniquement les positions
            NewShapeId = ArraySize(Obj(ObjId)\Shape())                       
            Obj(ObjId)\Shape(ShapeId)\pos =NewShapeId
            
            ; puis, on échange
            For i= 1 To NewShapeId
              Obj(ObjId)\Shape(i)\pos-1 
            Next
            
            ShapeId = NewShapeId
            
            SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending,OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
            UpdateListShape()
            SetGadgetItemState(#G_shapelist,ShapeId,1)
            Drawcanvas()
          EndIf
          
        Case #menuVD_SetShapeToBottom
          If ShapeId >0 
            
            ; on échange uniquement les positions                                         
            Obj(ObjId)\Shape(ShapeId)\pos = -1
            
            ; puis, on échange
            For i= 0 To ArraySize(Obj(ObjId)\Shape())      
              Obj(ObjId)\Shape(i)\pos + 1 
            Next
            
            ShapeId = 0
            
            SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending,OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
            UpdateListShape()
            SetGadgetItemState(#G_shapelist,ShapeId,1)
            Drawcanvas()
          EndIf
          
        Case #menuVD_SetShapeToOrigin
          Shape_SetOrigin()
          
        Case #menuVD_SetOriginToMouse
          Shape_SetOrigin(2,mouseX,mouseY)
          
        Case #menuVD_SetOriginToShape
          Shape_SetOrigin(1)
          ;}
          
          ;{ Windows
        Case #menuVD_CharacterEditor
          WindowCharacterEditor()
          
        Case #menuVD_ShowTimeLine
          Vd_ShowMenu(#menuVD_ShowTimeLine,VdOptions\showTimeLine)                    
          Vd_ResizeAll()
          ;}
          
          ;{ Help
        Case #menuVD_HelpHtml
          VD_OpenTheHelp(1)
          
        Case #menuVD_Update
          RunProgram("https://github.com/blendman/CartoonAnimation")
          
        Case #menuVD_Wiki
          RunProgram("https://github.com/blendman/CartoonAnimation/wiki/Home/")
          
        Case #menuVD_Help
          VD_OpenTheHelp()
          
        Case #menuVD_About
          MessageRequester("Info",#ProgramNameVD+" is a software made by Blendman, to create vectoriel Shapes and animation."+Chr(10)+
                                  "The software is made in purebasic."+Chr(10)+                                            
                                  "Version : "+#ProgramVersionVD+#ProgramBitVD+Chr(10)+
                                  "Date : "+FormatDate("%dd/%mm/%yyyy",#PB_Compiler_Date))
          ;}
          
          ;{ popup point
        Case #menuVD_PtSelectAll
          If shapeId >-1
            If Vd\EditMode <> #VD_Editmode_Point
              MessageRequester(lang("Info"), Lang("You have to be in editMode 'point edition' To Select points."))
            Else
              For i=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                Obj(ObjId)\Shape(ShapeId)\pt(i)\Selected =1
              Next
              Vd\Shift = 1
              Drawcanvas()
            EndIf
          EndIf
          
        Case #menuVD_ConvertToCurve
          VD_ConvertShape(1,2)
          
        Case #menuVD_ConvertToline
          VD_ConvertShape(1,1)
          
        Case #menuVD_ConvertToShape
          VD_ConvertShape()
          
        Case #menuVD_SeparateShape
          If shapeID >-1
            For ip=0 To ArraySize(obj(ObjId)\Shape(ShapeID)\pt())
              Debug "point: "+Str(ip) + " /broken : "+Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\broken)+" / center : "+Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\Center)
            Next
          EndIf
        
        Case #menuVD_JointShape
          VD_ShapeMerge()
          
        Case #menuVD_AddPtAtMiddle
          VD_Addpoint(0)
          
        Case #menuVD_DeletePt
          If PtId>-1
            Vd_DeletePoint(PtId)
            DrawCanvas()
          Else
            If Vd\EditMode <> #VD_Editmode_Point
              info$ = " You have To be in editMode 'point edition' To Select points."
            EndIf
            MessageRequester(lang("Info"), Lang("You need at least 1 point selected, And the shape should have at least 2 points to use this feature."+info$))
          EndIf
          ;}
          
        Default
          MessageRequester(lang("Infos"), lang("Not implemented"))
          
      EndSelect
       
    ElseIf event =#PB_Event_CloseWindow
      
      If EventWindow() = #Win_VD_main
        quit = 1
      Else
        CloseWindow(GetActiveWindow())
      EndIf
      
    EndIf
    
    
  Until event = 0 Or quit = 1
  
  If Vd\Play = 0
    
    If Vd\UpdateOk = 1
      Vd\UpdateOk = 0
      VD_OpenWinUpdate()
    EndIf
    
    AutoSave()
    
  Else
    
    PlayAnimation()
    
  EndIf
  
Until quit = 1

; save options and autosave file
If VdOptions\Autosave = 1
  Date$ = FormatDate("%yyyy%mm%dd%hh%ii%ss", Date()) 
  t$="data\save\_autosave\autosave"+vd\ShapeFileName$+Date$ +".txt"
  Debug t$
  Shape_Save(t$,1)            
EndIf  

VD_SaveOptions()

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 1185
; FirstLine = 81
; Folding = LUAPAWaxPeAAAAAeAAIAA1Aeh
; EnableXP
; DisableDebugger