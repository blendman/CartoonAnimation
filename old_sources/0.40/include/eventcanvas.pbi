
; key down
If EventType() = #PB_EventType_KeyDown ; Or EventType() = #PB_EventType_Focus 
 ; Debug "key "+GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Modifiers) & #PB_Canvas_Shift                            
    vd\Shift = 1                          
  EndIf  
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) = 17  ; Or  GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Modifiers)  & #PB_Canvas_Control                        
    vd\ctrl = 1 
    ; Debug "ok ctrl!!!!!"
  EndIf 
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) = 18                       
    vd\alt = 1 
   ; Debug "ok alt"
  EndIf                        
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) = #PB_Shortcut_Space                         
    Vd\Space = 1                            
  EndIf
  
ElseIf EventType() = #PB_EventType_KeyUp 
   ;{ key up
  
   ; Debug "key "+GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)
  ; enter 13
  ; altgr 18
  ; tab 9
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)= 18                      
    vd\alt = 0  
    vd\keypressed = 0   
  EndIf
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) = #PB_Shortcut_Space 
    Vd\space= 0                           
    vd\keypressed = 0                           
  EndIf                        
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)= 16 ; shift 
    Vd\shift= 0                           
    vd\keypressed = 0                          
  EndIf  
  If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)= 17 ; ctrl 
    Vd\ctrl= 0  
    vd\keypressed = 0                          
  EndIf 
  ;}
   
EndIf

; Debug "ctrl :"+Str(vd\Ctrl)
; Debug "shift : "+Str(vd\shift)
; Debug "Space : "+Str(vd\Space)

; If ObjId >-1 And objID<=ArraySize(Obj())
;   LayerIsOk = Layer_CheckIfOk(ObjId)
; EndIf 

   

If EventType() = #PB_EventType_LeftButtonDown Or
   (EventType() = #PB_EventType_MouseMove And                       
     GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
    
    If StartVectorDrawing(CanvasVectorOutput(#G_canvasVector))
    
    ; update coordonnate of the object
    ;VD_ShapeCoord(ObjId)
    
    x5 = GetGadgetAttribute(#G_canvasVector, #PB_Canvas_MouseX)                        
    y5 = GetGadgetAttribute(#G_canvasVector, #PB_Canvas_MouseY)
    
    x = (ConvertCoordinateX(x5,y5,#PB_Coordinate_Device, #PB_Coordinate_User)/Z) 
    y = (ConvertCoordinateY(x5,y5,#PB_Coordinate_Device, #PB_Coordinate_User)/z) 
    
    x2=x
    y2=y
    
    x1 = (x -VD\ViewX) 
    y1 = (y -VD\ViewY)
    
;     mouseX = x1
;     mouseY = y1
    
    ; StatusBarText(0,1,Str(x)+"/"+Str(y))
   
    If Vd\space = 1  ; on appuie sur espace 
      
      ;{ 
      If EventType() = #PB_EventType_LeftButtonDown
        If Vd\ClicLb = 0                                   
          Vd\cliclb = 1
          Vd\spaceX = X - VD\ViewX
          Vd\spaceY = Y - VD\ViewY
        EndIf 
      EndIf                               
      VD\viewX = x - Vd\spaceX
      VD\viewY = y - Vd\spaceY
      ; Debug "SPACE "+X5+"/"+Y5
      ;}
      
    Else ; on n'appuie pas sur espace
      
      mouseX = x1
      mouseY = y1
      
      If Layer_CheckIfOk(ObjId) =1
        vdOptions\DocHasChanged =1
      
        If EventType() = #PB_EventType_LeftButtonDown 

          vd\clicSelect=1
          
        ; on clique sur le canvas 
          If Vd\ClicLb = 0
            Vd\cliclb = 1
            ; on définit le start pour bouger le canvas plus tard.
            Vd\spaceX = X2 - VD\ViewX
            Vd\spaceY = Y2 - VD\ViewY
            Vd\move = 0
            start_Rot = 0
            
            startX = x1
            starty = y1
            
            ;{ on déslectionne tout (shapes et pts)
            If vdOptions\Action = #VD_actionMOve And vd\EditMode = #VD_Editmode_Shape
              If vd\Shift = 0
                ; on déslectionne tous les shapes
                For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                  With Obj(ObjId)\Shape(ki)
                    \selected = 0
                    For ip=0 To ArraySize(\pt())  
                      \pt(ip)\Selected = 0
                    Next
                  EndWith
                Next
                shapeID = -1
                PtId = -1
              EndIf
            EndIf
             ;}
            
            If vdOptions\Action = #VD_actionMirorH Or vdOptions\Action = #VD_actionMirorH 
              
            ElseIf vdOptions\Action = #VD_actionAddCurve Or vdOptions\Action = #VD_actionAddLine 
              ;{ add a shape (line or curve)
              Select vdOptions\Action 
                  
                Case #VD_actionAddCurve
                  If vd\ctrl = 0
                    Shape_Add(x1,y1)
                    vd\AddObjet=2
                  Else
                    Shape_Addpoint(x1,y1)
                  EndIf
                  
                Case #VD_actionAddLine
                  If vd\ctrl = 0 
                    Shape_Add(x1,y1)
                     vd\AddObjet=2
                  ElseIf vd\ctrl=1 
                    If ShapeId>-1
                      With Obj(ObjId)\Shape(ShapeId)
                        n = ArraySize(\pt())+1
                        ReDim \pt.sPoint(n)                                               
                        \pt(n)\x = x1 -\x - obj(objId)\x
                        \pt(n)\y = y1 -\y - obj(objId)\y 
                      EndWith
                      Shape_CheckBrokenPoint()
                      vd\AddObjet=2
                    EndIf
                  EndIf
                 
                  
              EndSelect
              ;}  
              
            ElseIf vdOptions\Action <= #VD_actionDelPt
              
              If vdOptions\Action = #VD_actionSelect
                vd\Selection\x = x1
                vd\Selection\y = y1
                vd\Selection\w = x1
                vd\Selection\h = y1
              EndIf
              
              If shapeId >-1 ; on a 1 shape sélectionné
                
                If vdOptions\Action = #VD_actionAddPt
                  ;Debug "add point"
                  If vd\move =0
                    Select Obj(ObjId)\Shape(ShapeId)\ShapTyp 
                        
                      Case #VD_ShapeShape, #VD_ShapeCurve
                        ; d'abord, je conserve la place du dernier point, 
                        ; car je vais ajouter mes nouveaux points (3), après cette place.
                        Shape_Addpoint(x1,y1,1)
                        Vd\move = 1
                        vd\AddObjet=2
                        
                      Case #VD_ShapeLine
                        With Obj(ObjId)\Shape(ShapeId)
                          n = ArraySize(\pt())+1
                          ReDim \pt.sPoint(n)                                               
                          \pt(n)\x = x1 - obj(objId)\x 
                          \pt(n)\y = y1 - obj(objId)\y  
                          If vd\ctrl = 0
                            Vd\move = 3
                          EndIf
                          Shape_CheckBrokenPoint()
                        EndWith
                        
                    EndSelect
                  EndIf
                ElseIf vdOptions\Action = #VD_actioninsertPt
                  ;Debug "insert point"
                  ;{ insert point
                  ;For i =0 To ArraySize(\pt())
                  ;If \pt(
                  ; endif
                  ;Next
                  ;InsertArrayElement(pt, element) 
                  ;}
                  
                ElseIf vdOptions\Action = #VD_actionRot
                  ;   Debug "leftclic GetShapeStartTransformation"
                  GetShapeStartTransformation(1,x,y)
                  
                ElseIf  vdOptions\Action = #VD_actionScale 
                   GetShapeStartTransformation(0,x,y)

                Else
                  
                  ;{ on fait une action sur les points du shape selectionné (bouger ou supprimer un point)                                                             
                  ok=0
                  
                  If shapeId > -1 And shapeId <=ArraySize(Obj(ObjId)\Shape())
                    ; on ne remet à zéro que si on n'appuie pas sur shift
                    If vd\Shift = 0
                      PtId = -1
                      For ip=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())  
                        Obj(ObjId)\Shape(ShapeId)\pt(ip)\Selected = 0
                      Next
                    Else
                      ; je dois recalculer la position \starts et \starty à chaque fois si on va le déplacer ^^
                      With Obj(ObjId)\Shape(ShapeId)
                        For ip=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt()) 
                          If \pt(ip)\Selected =1
                            \pt(ip)\startX = \pt(ip)\x 
                            \pt(ip)\startY = \pt(ip)\y
                          EndIf
                        Next
                      EndWith
                    EndIf
                     ; Debug "ok cherche point"
                    VD_PointGetSelected(x1,y1) ; macros in shape.pbi
                  EndIf
                  
                  If ptid = -1
                    If vdOptions\Action = #VD_actionMove Or vdOptions\Action = #VD_actionSelect
                      startSelectX = x1
                      StartSelectY = y1
                    EndIf
                  EndIf
                  ;}
                  
                EndIf
                
              Else ; on n'a aucun shape sélectionné
                
                For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                  
                  With Obj(ObjId)\Shape(ki)
                    
                    If \ShapTyp =#VD_ShapeImage 
                      
                      ;If x1>=\x+Obj(ObjId)\x And x1<=\x+\w+Obj(ObjId)\x And 
                      ;y1>=\y+Obj(ObjId)\y And y1<=\y+\h+Obj(ObjId)\y
                      If x1>=\x And x1<=\x+\w And y1>=\y And y1<=\y+\h
                        
                        \Selected = 1
                        ShapeId = ki
                        vd\TestShapeOk = 1
                        update = 1
                        ; vd\move = 0
                        If vdOptions\Action= #VD_actionMove                                                                               
                          Vd\move = 2
                          \startX = x - \X ;+ Obj(ObjId)\x
                          \startY = y - \Y ;+ Obj(ObjId)\y
                        EndIf
                        
                        Break
                      EndIf
                      
                    EndIf
                    
                  EndWith
                  
                Next
                
              EndIf
              
            Else
              ;{ on ajoute un nouvel objet  
              ;If vdOptions\Action <> #VD_actionAddBoxRnd
              x = ((WindowMouseX(#Win_VD_main) - GadgetX(#G_canvasVector))*100)/VdOptions\Zoom - VD\ViewX 
              y = ((WindowMouseY(#Win_VD_main) - GadgetY(#G_canvasVector))*100)/VdOptions\Zoom - VD\ViewY
              ; update = Shape_Add(x1,y1)
              update = Shape_Add(x,y)
              PointId = ArraySize(Obj(ObjId)\Shape(shapeId)\pt())
              If vdOptions\Action = #VD_actionAddCurve
                pointId -2
              EndIf  
              If vdOptions\action >= #VD_actionAddBox And vdOptions\action <= #VD_actionAddCircle
                vd\AddObjet=2
              EndIf
              ;}
            EndIf
            
          EndIf                                
        
        ElseIf EventType() = #PB_EventType_MouseMove ; on bouge la souris
          
          If  Vd\cliclb = 1
            
          If vdOptions\action = #VD_actionSelect
            vd\Selection\w = x1 - vd\Selection\x
            vd\Selection\h = y1 - vd\Selection\y
          EndIf
            
          If ShapeId >-1  And (vdOptions\Action = #VD_actionAddLine Or vdOptions\Action = #VD_actionAddCurve Or vdOptions\action<#VD_actionAddShape)
            
            x1 * (1-VdOptions\Tool(vdOptions\Action)\LockX)
            y1 * (1-VdOptions\Tool(vdOptions\Action)\LockY)
            
            If VdOptions\Snap = 1
              Snap(x1,VdOptions\SnapX)  
              Snap(y1,VdOptions\SnapY) 
            EndIf
            
            If vd\LockSelection
              If vdOptions\Action = #VD_actionMove
                vd\move = 2
              EndIf
            EndIf
            
            If vdOptions\Action = #VD_actionAddLine 
              
              If VdOptions\Tool(action)\Type = #VD_Action_Type_1
                If ShapeId>-1
                  With Obj(ObjId)\Shape(ShapeId)
                    n = ArraySize(\pt())
                    x1 = x1 - obj(objId)\x 
                    y1 = y1  - obj(objId)\y
                    If vdOptions\ToolOptions\distance >0
                      dist.d = point_distance(x1,y1,\pt(n)\x,\pt(n)\y)
                      angle.d= GetAngle(x1,y1,\pt(n)\x,\pt(n)\y)
                      If dist > vdOptions\ToolOptions\distance ; * z  ;Or angle> 45
                        n = ArraySize(\pt())+1
                        ReDim \pt.sPoint(n)                                               
                        \pt(n)\x = x1 
                        \pt(n)\y = y1  
                        update = 2
                      EndIf
                    Else
                      n = ArraySize(\pt())+1
                      ReDim \pt.sPoint(n)                                               
                      \pt(n)\x = x1 
                      \pt(n)\y = y1 
                      update = 2
                    EndIf
                  
                  EndWith
                EndIf
              EndIf
              
            ElseIf vdOptions\action = #VD_actionAddCurve
              
              If VdOptions\Tool(action)\Type = #VD_Action_Type_1
                ; pencil
                With Obj(ObjId)\Shape(ShapeId)
                  n = ArraySize(\pt())-2
                  If n >=0
                    ; on doit recalculer les angles des points tangent jusqu'à ce qu'on dépasse la distance (10 pour 40 de distance entre les points)              
                    ptid = n
                    If ptid>=2
                      
                      sx = \pt(PtId)\x 
                      sy = \pt(PtId)\y 
                      dist2.d = point_distance((x1-obj(ObjID)\x),(y1-obj(ObjID)\y),sx,sy)
                      ; Debug Str(dist2)+" / "+Str(vdOptions\ToolOptions\distance)
                      If dist2< (vdOptions\ToolOptions\distance/3)
                        
                        ; point tangeant 0
                        \pt(PtId-1)\x = sx -(x1-obj(ObjID)\x -sx)
                        \pt(PtId-1)\y = sy -(y1-obj(ObjID)\y -sy)
                        ; point tangeant 2
                        \pt(PtId+1)\x =  x1-obj(ObjID)\x
                        \pt(PtId+1)\y =  y1-obj(ObjID)\y
                        update =1
                      Else
                       
                        dist.d = point_distance((x1-obj(ObjID)\x),(y1-obj(ObjID)\y),\pt(n)\x,\pt(n)\y)
                        angle.d= point_direction((x1-obj(ObjID)\x),(y1-obj(ObjID)\y),\pt(n)\x,\pt(n)\y) ; GetAngle(x1,y1,\pt(n)\x,\pt(n)\y)
                        ;Debug Str(dist)+" / "+Str(vdOptions\ToolOptions\distance)
                        
                        If dist > (vdOptions\ToolOptions\distance) 
                          
                          Shape_Addpoint(x1,y1,2)
                          
                          n = ArraySize(\pt())-5
                          ptid = n
                          If ptid>=3
                            x1 = \pt(n)\x 
                            y1 = \pt(n)\y 
                            
                            dist.d = point_distance(x1,y1,\pt(n+3)\x,\pt(n+3)\y)/3
                            angle.d= point_direction(\pt(n+3)\x,\pt(n+3)\y,x1,y1)
                            a.a = dist
                            
                            \pt(PtId-1)\x = (x1 + Cos(angle) * a) ;(sx -(x1 -sx))
                            \pt(PtId-1)\y = (y1 + Sin(angle) * a) ;(sy -(y1 -sy))
                            ; point tangeant 2
                            \pt(PtId+1)\x = (x1 - Cos(angle) * a)
                            \pt(PtId+1)\y = (y1 - Sin(angle) * a)
                          EndIf

                          vd\AddObjet=2
                        EndIf
                      EndIf
                    Else
                      Debug "ok curve pencil3"
                       dist.d = point_distance(x1,y1,\pt(n)\x,\pt(n)\y)
                        angle.d= GetAngle(x1,y1,\pt(n)\x,\pt(n)\y)
                        ;Debug Str(dist)+" / "+Str(vdOptions\ToolOptions\distance)
                        
                        If dist > vdOptions\ToolOptions\distance
                          Shape_Addpoint(x1,y1,2)
                          vd\AddObjet=2
                        EndIf
                    EndIf
                    
                  Else
                    ;Dist = vdOptions\ToolOptions\distance+1
                    Debug "ok cruve add point4"
                    Shape_Addpoint(x1,y1)
                    vd\AddObjet=2
                  EndIf
                EndWith
              Else
                ; bezier
                ;Debug "ok bezier on bouge"
                x1 = x1 - obj(ObjID)\x
                y1 = y1 - obj(ObjID)\y
                
                With Obj(ObjId)\Shape(shapeId)
                  If ptid<3
                    sx = \pt(PtId+1)\x 
                    sy = \pt(PtId+1)\y 
                    \pt(PtId)\x = X1 
                    \pt(PtId)\y = y1 
                    ;\pt(PtId+2)\x = sX -x1
                    ;\pt(PtId+2)\y = sY -y1
                  Else
                    ;x1 *z
                    ;y1 *z
                    sx = \pt(PtId)\x 
                    sy = \pt(PtId)\y 
                    ; Debug Str(sx)+"/"+Str(sy)
                    ;Debug Str(x1)+"/"+Str(y1)
                    ;Debug Str(x1*z)+"/"+Str(y1*z)
                    ; point tangeant 0
                    \pt(PtId-1)\x = (2*sx) -(x1 -\X)
                    \pt(PtId-1)\y = (2*sy) -(y1 -\y)
                    ; point encrage
                    ;\pt(PointId+1)\x = startX
                    ;\pt(PointId+1)\y = startX
                    ; point tangeant 2
                    \pt(PtId+1)\x =  x1 -\X
                    \pt(PtId+1)\y =  y1 -\y
                  EndIf
                EndWith
              EndIf
              
            Else
              
              If Vd\move = 1  Or (vd\EditMode = #VD_Editmode_Point And vd\LockSelection=0 And vdOptions\Action = #VD_actionMove)
                ; on bouge le/les pts sélectionné(s) 
                Select vdOptions\Action
                    
                  Case #VD_actionMove
                    
                    i = PtId
                    If i >-1
                      With Obj(ObjId)\Shape(ShapeId)
                        If \Locked = 0 And \hide =0
                          
                          Select \ShapTyp
                              
                            Case #VD_shapeLine
                              If i <= ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                                If vd\Shift =0
                                  ;{ on ne bouge qu'un point
                                  \pt(i)\x = x1 -\x  - Obj(ObjId)\x
                                  \pt(i)\y = y1 -\y  - Obj(ObjId)\y
                                  SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
                                  SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
                                  ;}
                                Else
                                  For i=0 To ArraySize(\pt())
                                    If \pt(i)\Selected = 1
                                      \pt(i)\x = x1 +\pt(i)\StartX -\StartX  - Obj(ObjId)\x
                                      SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
                                      \pt(i)\y = y1 +\pt(i)\startY -\StartY  - Obj(ObjId)\y                                                                                                                                                                                       
                                      SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
                                    EndIf 
                                  Next                                                                                    
                                EndIf
                              EndIf
                              
                            Case #VD_ShapeShape, #VD_ShapeCurve
                              If i <= ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                                If vd\PtUsemirored >= 1 And VD\shift=0
                                  ;{
                                  ;                             If ptid<3
                                  ;                               sx = \pt(PtId+1)\x 
                                  ;                               sy = \pt(PtId+1)\y 
                                  ;                               \pt(PtId)\x = X1 
                                  ;                               \pt(PtId)\y = y1
                                  ;                               ;\pt(PtId+2)\x = sX -x1
                                  ;                               ;\pt(PtId+2)\y = sY -y1
                                  ;                             Else
                                  ; si on bouge un point central, c'est comme le mode normal
                                  If \pt(ptid)\Center
                                    VD_MovePoint(i,x1,y1)
                                  Else
                                    
                                    Debug "ici, ok on bouge la courbe"
                                    ; je dois enlever la position du shape et du layer (obj) aux coordonnées mouse.
                                    x1 - \x -obj(objID)\x
                                    y1 - \y -obj(objID)\y
                                    ; on doit vérifier sur quel point on est ainsi que le point d'après et le point d'avant.
                                    pt_c = i+1
                                    pt_c1 = i-1
                                    
                                    ; then, we can verify the points
                                    If pt_c<ArraySize(\pt()) And \pt(pt_c)\center = 1
                                      ;{
                                      ; i -> i-1
                                      ; i+2 -> i+1
                                      sx = \pt(pt_c)\x
                                      sy = \pt(pt_c)\y 
                                      If Mod(pt_c,3)=0 ; on est sur un point principal
                                        u = pt_c+1
                                        If u > ArraySize(\pt())
                                          u=0
                                        EndIf
                                        v =pt_c-1
                                        If v <0
                                          v =ArraySize(\pt())
                                        EndIf
                                      EndIf
                                      ;}
                                    ElseIf pt_c1 >=0 And \pt(pt_c1)\center = 1
                                      If i<>ArraySize(\pt())
                                        ;{ si on n'est pas sur le dernier point
                                        ; i-2 -> i-1
                                        ; i -> i+1
                                        pt_c= pt_c1
                                        sx = \pt(pt_c)\x
                                        sy = \pt(pt_c)\y 
                                        If Mod(pt_c,3)=0 ; on est sur un point principal
                                          u = pt_c+1
                                          If u > ArraySize(\pt())
                                            u=0
                                          EndIf
                                          v =pt_c-1
                                          If v <0
                                            v =ArraySize(\pt())
                                          EndIf
                                          v1=u
                                          u=v
                                          v=V1
                                        EndIf
                                        ;}
                                      EndIf
                                    Else
                                      ;{ on est sur le dernier, on va bouger le point 1 au lieu du point i-1
                                      pt_c= 0
                                      sx = \pt(pt_c)\x
                                      sy = \pt(pt_c)\y 
                                      If Mod(pt_c,3)=0 ; on est sur un point principal
                                        u = pt_c+1
                                        If u > ArraySize(\pt())
                                          u=0
                                        EndIf
                                        v =pt_c-1
                                        If v <0
                                          v =ArraySize(\pt())
                                        EndIf
                                      EndIf
                                      ;}
                                    EndIf
                                    ; then, we can move the points
                                    ; point tangeant 0
                                    If vd\PtUsemirored = 1
                                      \pt(u)\x = sx -(x1 -sx)
                                    EndIf
                                    \pt(u)\y = sy -(y1 -sy)
                                    ; point tangeant 2
                                    \pt(v)\x =  x1
                                    \pt(v)\y =  y1 
                                    SetGadgetText(#G_shapePtX,Str(\pt(v)\x))
                                    SetGadgetText(#G_shapePtY,Str(\pt(v)\y))
                                  EndIf
                                  ;}
                                Else
                                  If vd\Shift =0
                                    ;{ on ne bouge qu'un point
                                    VD_MovePoint(i,x1,y1)
                                    ;}
                                  Else
                                    For i=0 To ArraySize(\pt())
                                      If \pt(i)\Selected = 1
                                        \pt(i)\x = x1 +\pt(i)\StartX -\StartX ; - Obj(ObjId)\x
                                        SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
                                        \pt(i)\y = y1 +\pt(i)\startY -\StartY ; - Obj(ObjId)\y                                                                                                                                                                                       
                                        SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
                                        
                                        If \ShapTyp <> #VD_shapeLine
                                          If Mod(i,3)=0 ; on est sur un point principal
                                            u = i+1
                                            If u > ArraySize(\pt())
                                              u=0
                                            EndIf
                                            v =i-1
                                            If v <0
                                              v =ArraySize(\pt())
                                            EndIf
                                            \pt(u)\x = x1 + \pt(u)\startX -\StartX
                                            \pt(v)\x = x1 + \pt(v)\startX -\StartX
                                            \pt(v)\y = y1 + \pt(v)\startY -\StartY
                                            \pt(u)\y = y1 + \pt(u)\startY -\StartY
                                          EndIf 
                                        EndIf 
                                        
                                      EndIf 
                                    Next                                                                                    
                                  EndIf
                                EndIf
                              EndIf
                              
                            Default
                              i = PtId
                              ;For i=0 To ArraySize(\pt())
                              ;If i =PtId Or \pt(i)\Selected = 1
                              If i <= ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                                \pt(i)\x = x1 -\x - Obj(ObjId)\x
                                \pt(i)\y = y1 -\y - Obj(ObjId)\y
                                SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
                                SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
                              EndIf
                              ;Next 
                          EndSelect
                          
                        EndIf
                      EndWith
                    EndIf
                EndSelect
                
              ElseIf Vd\move= 2  ;Or vd\EditMode <= #VD_Editmode_Shape ; move/scale/rotate all
                ;Debug "ok ici vd\move=2"
                
                If VdOptions\Snap
                  Snap(x,VdOptions\SnapX)  
                  Snap(y,VdOptions\SnapY) 
                EndIf
                
                For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                  
                  With Obj(ObjId)\Shape(ki) 
                    If \Locked = 0 And \hide=0
                      
                      If \Selected = 1 Or ki = shapeId 
                        
                        Select vdOptions\Action
                            
                          Case #VD_actionMove
                            ;{ move
                            ;Select \ShapTyp                                                                           
                            
                            ;Case #VD_ShapeCurve,#VD_ShapeCurve,#VD_ShapeBox,#VD_ShapeBoxRnd,#VD_ShapeCircle,#VD_ShapeImage,#VD_ShapeText
                            \X = (x - \startX) * (1-VdOptions\Tool(vdOptions\Action)\LockX) + \X * VdOptions\Tool(vdOptions\Action)\LockX 
                            \Y = (y - \startY) * (1-VdOptions\Tool(vdOptions\Action)\LockY) + \Y * VdOptions\Tool(vdOptions\Action)\LockY 
                            SetGadgetText(#G_shapeX,Str(\x))
                            SetGadgetText(#G_shapeY,Str(\y))
                            
                            ; Default
                            ; For k = 0 To ArraySize(\pt())                                                               
                            ; \pt(k)\x = x - \pt(k)\startX
                            ;\pt(k)\y = y - \pt(k)\startY                                                          
                            ;
                            ;Next
                            ;
                            ;\CurX = \pt(0)\x
                            ;\CurY = \pt(0)\y
                            ;
                            ;EndSelect
                            ;}
                            
                          Case #VD_actionScale
                            ;{ action scale
                                If start_Rot = 0
                                  start_Rot = 1
                                  GetShapeStartTransformation(0,x,y)
                                  ; ajouter la position du centre de rotation (pt(0) ou autre)
                                  
                                  ; center position for transformation with boundingbox
                                  centerX.d = vd\bbox\x ;+20 ;+vd\bbox\w/2 ; 10
                                  centerY.d = vd\bbox\y ;+20 ;+vd\bbox\h/2 ; 10
                                  ;                                   If shapeID >-1 And shapeID<=ArraySize(Obj(ObjId)\Shape())
                                  ;                                       centerX.d =  Obj(ObjId)\Shape(shapeiD)\cx ;+ Obj(ObjId)\Shape(shapeiD)\x
                                  ;                                       centerY.d =  Obj(ObjId)\Shape(shapeiD)\cy ;+ Obj(ObjId)\Shape(shapeiD)\y
                                  ;                                   Else
                                  ;                                     For kki = 0 To ArraySize(Obj(ObjId)\Shape())
                                  ;                                       If Obj(ObjId)\Shape(kki)\Selected
                                  ;                                           centerX.d = Obj(ObjId)\Shape(kki)\cx ;+ Obj(ObjId)\Shape(kki)\x
                                  ;                                           centerY.d = Obj(ObjId)\Shape(kki)\cy ;+ Obj(ObjId)\Shape(kki)\y
                                  ;                                         Break
                                  ;                                       EndIf
                                  ;                                     Next
                                  ;                                   EndIf
                                  startx = x1
                                  starty = y1
                                  ; use an arbitrary width and height (w=10, h=10), to help to calcul the ratio to use it on the shapes.
                                  nw.d = 10
                                  nh.d = 10
                                  sw.f = nw
                                  sh.f = nh
                                  nw = sw +(x1-startx)*0.1
                                  ratio.d = nw/ sw
                                  size.d = ratio
                                  
                                EndIf
                                
                                ; we calcul the ratio with the new width nw and old with sw
                                nw = sw +(x1-startx)*0.1
                                ratio.d = nw/ sw
                                ;Debug Str(x)+"/"+Str(startx)
                                ;Debug ratio
                                
                                ;{ set shape scale
                                ; calcul the new size for the shape 
                                newW = \startw * ratio
                                newH = \starth * ratio
                                If vd\ctrl
                                  If vd\Alt =0
                                    newH = newW
                                  Else
                                    newH = \startH +(y1-starty)*0.1
                                  EndIf
                                EndIf
                                \SizeW = newW
                                \SizeH = newH
                                
                                ; then move the position if center of transformation = boundingbox
                                If vdoptions\CenterTransformation = 0
                                  ; if the center of transformation = boundingbox
                                  ; need to calcul the new position because we want to keep the same space between all shape, so we have to update it.
                                  \x = centerX+(\startx -centerX)*ratio 
                                  \y = centerY+(\starty -centerY)*ratio
                                  
                                  Select \ShapTyp
                                      
                                    Case #VD_ShapeShape, #VD_ShapeCurve, #VD_ShapeLine
                                      ; only for curve and line, need to calcul the position of each points of shape()\pt().
                                      For k=0 To ArraySize(\pt())
                                        \pt(k)\x = ( \pt(k)\startx)*ratio ; centerX+( \pt(k)\startx -centerX)*ratio 
                                        \pt(k)\y = ( \pt(k)\starty)*ratio ; centerY+( \pt(k)\starty -centerY)*ratio 
                                      Next
                                  EndSelect
                                Else
                                   ; if the center of transformation = origin
                                  Select \ShapTyp
                                      
                                    Case #VD_ShapeShape, #VD_ShapeCurve, #VD_ShapeLine
                                      ; only for curve and line, need to calcul the position of each points of shape()\pt().
                                      s.d = ratio -size
                                      For k=0 To ArraySize(\pt())
                                        \pt(k)\x = \pt(k)\startX * (1+s) ;-\X * (s)
                                        \pt(k)\y = \pt(k)\startY * (1+s) ;-\Y * (s)
                                      Next
                                  EndSelect
                                EndIf
                                ;}
                                
                            ;}
                            
                          Case #VD_actionRot
                            ;{ action rotation
                            Select \ShapTyp
                              
                              Case #VD_ShapeShape, #VD_ShapeCurve, #VD_ShapeLine
                                ;{ rotate les points
                                ; Debug Str(\CurX)+"/"+Str(\CurY); +" | "+Str(\x)+"/"+Str(\y)
                                n =0
                                ; pour essayer de corriger un bug avec les rotations
                                
                                If start_Rot = 0
                                  start_Rot = 1
                                  GetShapeStartTransformation(1,x,y)
                                EndIf
                                
                                
                                Rot = (x-\StartRot) ; *0.1
                                If vd\ctrl
                                  ;\rot =\rot/90
                                  rot = rot *10
                                EndIf
                                
                                ; Debug "ok rotation "+StrD(\rot)
                                ;If use_forpoint = 1
                                  Cos.f = Cos(Radian(rot))
                                  Sin.f = Sin(Radian(rot))
                                  
                                  ; on garde les coordonnées du premier point
                                  x1 = \CurX + \Cx
                                  y1 = \CurY + \Cy
                                  ; Debug "depart rot : "+x1+"/"+y1
                                  If vd\EditMode = #VD_Editmode_Point
                                    For k = 0 To ArraySize(\pt()) 
                                      If \pt(k)\Selected
                                        Xx = \pt(k)\startRotX ;-x1                                         
                                        Yy = \pt(k)\startRotY ;-y1
                                        
                                        \pt(k)\x = Xx*Cos - Yy*Sin + x1 
                                        \pt(k)\y = Xx*Sin + Yy*Cos + y1
                                      EndIf
                                    Next 
                                  Else
                                    For k = 0 To ArraySize(\pt()) 
                                      Xx = \pt(k)\startRotX ;-x1                                         
                                      Yy = \pt(k)\startRotY ;-y1
                                      
                                      \pt(k)\x = Xx*Cos - Yy*Sin + x1 
                                      \pt(k)\y = Xx*Sin + Yy*Cos + y1
                                    Next 
                                  EndIf
                                ;EndIf
                                ;}
                                
                              Case #VD_ShapeBox, #VD_ShapeBoxRnd, #VD_ShapeCircle, #VD_ShapeImage, #VD_ShapeText
                                ;{ Rotation on the shape --> not finishe  at all !!!! , after rotation, we can move or change shape as before rotation
                                n =0
                                ; pour essayer de corriger un bug avec les rotations
                                If start_Rot = 0
                                  start_Rot = 1
                                  GetShapeStartTransformation(1,x,y)
                                EndIf
                                
                                \Rot = (x-\StartRot);*0.1
                                If vd\ctrl
                                  ;\rot =\rot/90
                                  \rot = \rot *10
                                EndIf
                                ;}
                                
                            EndSelect 
                            ;}
                            
                        EndSelect
                        
                      EndIf
                    EndIf
                  EndWith
                Next
                
              EndIf
            EndIf
          
          Else ; on a ajouté un shape, on augmente sa taille
            
            ; on a ajouté 1 objet, on change sa taille
            If vd\AddObjet=2 
              
              ; x1 * (1-VdOptions\LockX)
              ; y1 * (1-VdOptions\LockY)
              
              If VdOptions\Snap = 1
                Snap(x1,VdOptions\SnapX)  
                Snap(y1,VdOptions\SnapY) 
              EndIf
              
              x1 = x1 - obj(ObjId)\x
              y1 = y1 - obj(ObjId)\y
              
              With Obj(ObjId)\Shape(shapeId)
                
                startX = \StartX
                startY = \StartY
                
                Select \ShapTyp ; vdOptions\Action
                    
                  Case #VD_ShapeLine ;#VD_actionAddLine
                    \pt(PointId)\x = X1
                    \pt(PointId)\y = Y1
                    
                  Case #VD_ShapeCurve
                    ; #VD_actionAddCurve 
                    
                    ; For i=0 To 2
                    ;   \pt(PointId+i)\x = X1-5+i*5
                    ;   \pt(PointId+i)\y = Y1-5+i*5
                    ; Next
                    If ptid<3
                      sx = \pt(PtId+1)\x 
                      sy = \pt(PtId+1)\y 
                      \pt(PtId)\x = X1 
                      \pt(PtId)\y = y1
                      ;\pt(PtId+2)\x = sX -x1
                      ;\pt(PtId+2)\y = sY -y1
                    Else
                      sx = \pt(PtId)\x 
                      sy = \pt(PtId)\y 
                      Debug Str(sx)+"/"+Str(sy)
                      ; point tangeant 0
                      \pt(PtId-1)\x = sx -(x1 -sx)
                      \pt(PtId-1)\y = sy -(y1 -sy)
                      ; point encrage
                      ;\pt(PointId+1)\x = startX
                      ;\pt(PointId+1)\y = startX
                      ; point tangeant 2
                      \pt(PtId+1)\x =  x1
                      \pt(PtId+1)\y =  y1
                    EndIf
                    
                  Case #VD_ShapeBox, #VD_ShapeBoxRnd  ;#VD_actionAddBox, #VD_actionAddBoxRnd 
                    \SizeW = X1 - StartX
                    If vd\ctrl
                       \SizeH = \SizeW
                    Else
                       \SizeH = y1 - StartY
                    EndIf
                    
                  Case #VD_ShapeText
                    \SizeW = Abs(X1 - Startx )                                                   
                    \SizeH = Abs(y1 - StartY)
                    Min(\SizeW,1)
                    
                  Case #VD_ShapeCircle
                    \SizeW = Abs(X1 - StartX)  
                    If vd\ctrl
                       \SizeH = \SizeW
                    Else
                       \SizeH = Abs(y1 - StartY)
                    EndIf
                    min(\SizeW,1)
                    min(\SizeH,1)
                    
                EndSelect
                
                update =1
                
              EndWith
              
            EndIf
          
          EndIf                                
          
        EndIf
        
        EndIf
      
      EndIf
      
    EndIf
    
    StopVectorDrawing() 
  EndIf
  
  If Vd\move >= 1 Or Vd\cliclb = 1 Or update >= 1 Or vd\ClicSelect =1 Or Vd\space = 1
    
    If Vd\space = 1 Or update>1
      Drawcanvas(x,y,0) 
    Else
      Drawcanvas(x,y,1) 
    EndIf
    update = 0
  EndIf
  
Else
  
  If (vd\EditMode = #VD_Editmode_Point And vdOptions\Action = #VD_actionMove) And Vd\space =0 And vd\shift = 0
    Vd\cliclb = 0
  EndIf

  If EventType() = #PB_EventType_LeftButtonUp
  ;{ left button UP
  
  Vd\move = 0
  Vd\TestShapeOk = 0 
  Vd\cliclb = 0
  vd\clicSelect=0
  start_Rot = 0
  
  If vdOptions\Action = #VD_actionSelect
    If vd\Selection\w <> vd\Selection\x And  vd\Selection\h <> vd\Selection\y
      Shape_GetRectangleSelection()
      update=1
    EndIf
  ElseIf vdOptions\Action = #VD_actionAddLine Or  vdOptions\Action = #VD_actionAddCurve
    Shape_SetOrigin(1,0,0,0)
  EndIf
  vd\Selection\x = 0
  vd\Selection\y = 0
  vd\Selection\w = vd\Selection\x
  vd\Selection\h = vd\Selection\y
  If update = 1
    update = 0
    Drawcanvas(0,0,0) 
  EndIf
  
  If Vd\AddObjet >=1
    VD\AddObjet = 0
    ;     vdOptions\Action = #VD_actionMove
    ;     For i =#G_ToolVDMove To #G_ToolVDLast
    ;       If IsGadget(i)
    ;         SetGadgetState(i,0)
    ;       EndIf                        
    ;     Next
    ;     SetGadgetState(#G_ToolVDMove,1)
    ;     Vd_SetGadgetOption()
  EndIf
  ;}

  
  ElseIf EventType() = #PB_EventType_MouseWheel
    ;{ zoom
  delta = GetGadgetAttribute(#G_canvasVector, #PB_Canvas_WheelDelta)
  If delta =1
    If VdOptions\Zoom<10
      VdOptions\Zoom + 1
    ElseIf VdOptions\Zoom<100
      VdOptions\Zoom + 10
    Else
      VdOptions\Zoom + 20
    EndIf
  ElseIf delta = -1
    If VdOptions\Zoom > 100
      VdOptions\Zoom -20
    ElseIf VdOptions\Zoom > 10
      VdOptions\Zoom -10
    ElseIf VdOptions\Zoom > 1
      VdOptions\Zoom -1
    EndIf
  EndIf
  Drawcanvas()
  StatusBarText(0, 0, lang("Zoom")+" "+Str(VdOptions\Zoom)+"%")
  ;}
  EndIf

EndIf




; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 22
; Folding = h-06884f2ucX+80+--2HP-4-604h
; EnableXP
; DisableDebugger