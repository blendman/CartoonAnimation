

; macro utilisied for shape drawing
Macro ShapeSetParentingPosition(i,j)
  vo = i
  If Obj(vo)\Shape(j)\Parent\id >0 And Obj(vo)\Shape(j)\parent\id-1 <> j
    px = Obj(vo)\Shape(Obj(vo)\Shape(j)\Parent\id-1)\X - Obj(vo)\Shape(j)\Parent\startx
    pY = Obj(vo)\Shape(Obj(vo)\Shape(j)\Parent\id-1)\Y - Obj(vo)\Shape(j)\Parent\starty
    Obj(vo)\Shape(j)\Parent\x = px
    Obj(vo)\Shape(j)\Parent\y = py
  EndIf
  Obj(vo)\Shape(j)\FinalX = Obj(vo)\Shape(j)\x +px
  Obj(vo)\Shape(j)\FinalX = Obj(vo)\Shape(j)\y +py
EndMacro


; draw
Procedure VD_ResetCoord()
  Shared ExportImage
 
  ResetCoordinates()
  
  If ExportImage = 0
     z.d = VdOptions\Zoom * 0.01
    ScaleCoordinates(z,z)
  Else
    ScaleCoordinates(VD_camera(cameraId)\scale*0.01,VD_camera(cameraId)\scale*0.01)
  EndIf
EndProcedure

Procedure VD_ShapeCoord(i)
  
  z.d = VdOptions\Zoom * 0.01
  
  With Obj(i)
    
    ScaleCoordinates(\w*0.01,\h*0.01)
    RotateCoordinates(\RotX,\RotY,\Rot)
    TranslateCoordinates(\x,\y)
    
  EndWith
    
EndProcedure

Procedure ShapeDrawFx(Obj,Shape,fx)
   
    a = Obj
    j = shape
    k = fx
    
    z.d = VdOptions\Zoom * 0.01
    
    ;ScaleCoordinates(Z,Z)
    
    ; pour dessiner les tyle de fx des shapes (ombres, stroke...)
    With Obj(a)\Shape(j)
        
;       If \Parent\id >0 And \parent\id-1 <> j
;         px = Obj(a)\Shape(\Parent\id-1)\X - Obj(a)\Shape(j)\Parent\startx
;         pY = Obj(a)\Shape(\Parent\id-1)\Y - Obj(a)\Shape(j)\Parent\starty
;       EndIf
      
      ShapeSetParentingPosition(a,j)
      
        sc.f = \Fx(k)\Scale*0.01
        vx = vd\ViewX + \Fx(k)\X + \X +px ;+ Obj(a)\x ;+ \pt(0)\x*(1-0.5*sc)
        vy = vd\ViewY + \Fx(k)\Y + \Y +py ;+ Obj(a)\y ;+ \pt(0)\y*(1-0.5*sc)
        
        ; scu.f = sc
        ; scv.f = sc
        ; scw.f = sc
        ; ScaleCoordinates(sc,sc)
        ; TranslateCoordinates(\pt(0)\x*sc,\pt(0)\y*sc)
        
        x0 = \pt(0)\x
        y0 = \pt(0)\y
        
        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
        
        Select \ShapTyp
            Case #VD_ShapeShape, #VD_ShapeCurve
                xo0 = x0
                yo0 = y0
                MovePathCursor(x0+vx,y0+vy)
                
                For i =0 To ArraySize(\pt()) Step 3
                    close = 1
                    u = 1+i
                    If u > ArraySize(\pt())
                        u =0                
                    EndIf
                    x1 = (\pt(u)\x-x0)
                    y1 = (\pt(u)\y-y0)
                    v = u+1
                    If v > ArraySize(\pt())
                        v =0                
                    EndIf
                    x2 = (\pt(v)\x-x0)
                    y2 = (\pt(v)\y-y0)
                    w = v+1              
                    If w > ArraySize(\pt())
                      x3 = - xfin3 ;-(\pt(w-3)\x-xo0)
                      y3 = - yfin3 ;-(\pt(w-3)\y-yo0)
                      
                      w=0 
                      
                      ; check if the fx is open or close.
                       ; I use the shape\Open of fx\open ?
                      ;If \fx(k)\UseOwnopen 
                        ; if I use the fx\open
                        If \Fx(k)\open =1 
                           close = 0
                           Break
                        EndIf
;                       Else
;                         If \open
;                           close = 0
;                           Break
;                         EndIf
;                       EndIf
                    Else
                        x3 = (\pt(w)\x-x0)
                        y3 = (\pt(w)\y-y0)
                        xfin3 + x3
                        yfin3 + y3
                        xo0 = x0
                        yo0 = y0  
                    EndIf
                    
                    AddPathCurve(x1* sc,y1*sc,x2*sc,y2*sc,x3*sc,y3*sc,#PB_Path_Relative)
                    
                    x0 = x3 + xo0
                    y0 = y3 + yo0
                Next
                 If close = 0 ; \Fx(k)\open =0
                    ClosePath()
                EndIf
                
                
            Case #VD_ShapeBoxRnd
                AddPathRoundBox(x0+vx,y0+vy,\SizeW * sc,\SizeH * sc, \rnd)
                
            Case #VD_ShapeBox, #VD_ShapeImage
                AddPathBox(x0+vx,y0+vy,\SizeW * sc,\SizeH * sc)
                
            Case #VD_ShapeText
                MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
                VectorFont(FontID(\Font), \SizeW)
                AddPathText(\text$)
                
            Case #VD_ShapeCurve               
                For i =1 To ArraySize(\pt())-1 Step 3
                    u = i
                    v = i+1
                    w = i+2
                    If w > ArraySize(\pt())
                      w =0
                      If \Fx(k)\open =1
                        Break
                      EndIf
                    EndIf                    
                    AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                Next
                If \Fx(k)\open =0
                    ClosePath()
                EndIf
                
            Case #VD_ShapeLine              
                For i =0 To ArraySize(\pt()) 
                    AddPathLine(\pt(i)\x+vx,\pt(i)\y+vy)
                Next
                If \Fx(k)\open =0
                    ClosePath()
                EndIf
                
            Case #VD_ShapeCircle
                AddPathEllipse(x0+vx,y0+vy,\SizeW * sc,\SizeH * sc)
                
                
        EndSelect


        If \Linked = 0 Or j = ArraySize(Obj(ObjId)\Shape())
                
            VectorSourceColor(\Fx(k)\color) 
            
            Select \Fx(k)\Style
                Case 0
                    FillPath()                                        
                Case 1
                    StrokePath(\Fx(k)\w,#PB_Path_RoundEnd)                                         
                Case 2
                    DashPath(\Fx(k)\w,\Fx(k)\h)                                        
                Case 3
                    DotPath(\Fx(k)\w,\Fx(k)\Dist,#PB_Path_RoundEnd)
            EndSelect
            
        EndIf
    
    EndWith
    
    ;ResetCoordinates()
   
EndProcedure

Procedure VDDrawFx(vo,j,dessus=0)
  
  ; Pour dessiner les fx
  With Obj(vo)\Shape(j)
    If \UseFx =1
      For k =0 To ArraySize(\Fx())
        
        If \Fx(k)\Depth = dessus
          
          If \Fx(k)\Actif = 1 
            
            ShapeDrawFx(vo,j,k)
            
          EndIf                        
          
        EndIf
        
      Next
    EndIf
  EndWith
  
EndProcedure



Procedure VdDrawShape1(vo,j)
    
    ; pour dessiner le chemin , avant les opérations de remplissage 
    ; (donc pour la couche normal et éventuellement d'autres couche (fx...)
    z.d
    z = VdOptions\Zoom*0.01
    
    With Obj(vo)\Shape(j)
      
        ShapeSetParentingPosition(vo,j)
        
        vx = Vd\viewX + \x + px ; + Obj(ObjId)\x 
        vy = Vd\viewY + \y + pY ; + Obj(ObjId)\y
        
        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
        
        If \rot <> 0
          RotateCoordinates(\pt(0)\x+\Cx+vx, \pt(0)\y+\cy+vy, \rot) 
          ; faire la rotation par rapport à un centre de l'objet \centerX+vx et \centerY+vy
          ; de base : \centerX = \pt(0)\x+\Cx et \centerY =  \pt(0)\y+\cy
        EndIf
        
        Select \ShapTyp
                
          Case #VD_ShapeShape
            MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
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
              If \pt(i)\hide=0   
                AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
              Else
                MovePathCursor(\pt(w)\x+vx,\pt(w)\y+vy)
              EndIf
              
            Next
            
         
          Case #VD_ShapeCurve
            For i =1 To ArraySize(\pt())-1 Step 3
              u = i
              v = i+1
              w = i+2
              If w > ArraySize(\pt())
                w =0
                If \Open
                  Break
                EndIf
              EndIf 
              If \pt(w)\hide =0 
                AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
              Else
                MovePathCursor(\pt(w)\x+vx,\pt(w)\y+vy)
                breakdown = 1
              EndIf
            Next
            If \open=0 And  breakdown = 0
              ClosePath()
            EndIf
                
          Case #VD_ShapeLine
            For i =1 To ArraySize(\pt()) 
              AddPathLine(\pt(i)\x+vx,\pt(i)\y+vy)
            Next
            If \open=0
              ClosePath()
            EndIf
            
           Case #VD_ShapeBoxRnd
            AddPathRoundBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\sizeH,\rnd)
            
          Case #VD_ShapeBox
            AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\sizeH)
            
          Case #VD_ShapeCircle
            AddPathEllipse(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\sizeH)
            
          Case #VD_ShapeImage
            If IsImage(\img) 
              If \ImgRepeat = 0
                DrawVectorImage(ImageID(\img),\Alpha,\SizeW,\SizeH)
              Else
                VD_ResetCoord()
                ScaleCoordinates(Obj(vo)\w*0.01,Obj(vo)\h*0.01)
                TranslateCoordinates(\ImgX-\pt(0)\x-\x,\imgY-\pt(0)\y-\y)
                MovePathCursor(0,0)
                AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\SizeH)
                VectorSourceImage(ImageID(\img),\Alpha,\ImgW,\ImgH,\ImgRepeat)
                VD_ShapeCoord(vo)   
              EndIf                    
            EndIf
            
          Case #VD_ShapeText
            ; MovePathCursor(vx,vy)
            MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
            VectorSourceColor(RGBA(Red(\color),Green(\color),Blue(\color),\Alpha))
            VectorFont(FontID(\Font), \SizeW)
            DrawVectorParagraph(\text$,\d,\h,#PB_VectorParagraph_Center)
                  
            
        EndSelect
        
        If \rot <> 0
          VD_ResetCoord()
        EndIf
        
    EndWith
    
    
EndProcedure

Procedure VDDrawShapeColor(vo,j)
  
  ; pour remplir le chemin, avec le style souhaité : filled, line, dash, dot
  Protected  d.d  
  
  With Obj(vo)\Shape(j)
    
    ; the color or gradient
    If \ShapTyp <> #VD_ShapeImage
      ; puis, on remplit avec la couleur du shape
      ; <----------------- !!!!!!!!!! temporaire, je dois ajouter des paramètres : 
      ; position des dégradé, position x,y du dégradé circulaire, couleur dégradé, etc...
      Select \ColorGrad
          
        Case 0
          VectorSourceColor(RGBA(Red(\color),Green(\color),Blue(\color),\Alpha)) ;* Obj(vo)\Alpha)*0.0039215)) ; 0.0039215 = 1/255
          
        Case 1 ; gradient lineaire
          n = ArraySize(\ColGrad())
          p = ArraySize(\pt())
          VectorSourceLinearGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,\pt(p)\x,\pt(p)\y)         
          For i=0 To n
            d = i/n
            VectorSourceGradientColor(\ColGrad(i),d) 
          Next
          
        Case 2 ; gradient circulaire
          n = ArraySize(\ColGrad())
          VectorSourceCircularGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,w/2) 
          For i=0 To n
            d = i/n
            VectorSourceGradientColor(\ColGrad(i),d)                    
          Next
          
        Case 3 ; image texture 
          n = ArraySize(\ColGrad())
          VectorSourceImage(ImageID(\Img))    
          For i=0 To n
            d = i/n
            VectorSourceGradientColor(\ColGrad(i),d) 
          Next
          
      EndSelect
      
    EndIf
    
    ; on choisit le type (line, dash, dot, filled..)
    Select \Typ
      Case 0
        FillPath()
      Case 1
        StrokePath(\w,#PB_Path_RoundEnd) 
      Case 2
        DashPath(\w,\h)
      Case 3
        DotPath(\w,\d,#PB_Path_RoundEnd)
    EndSelect
    
  EndWith
  
EndProcedure

Procedure Grid3D()
  
;   Z.d = VdOptions\Zoom * 0.01
;   
;   w =( GadgetWidth(#G_canvasVector)/VdOptions\GridW) * z
;   h = (GadgetHeight(#G_canvasVector)/VdOptions\GridH) * z
;   m = VdOptions\GridW
;   n = VdOptions\GridH
;   For j = 0 To h 
;     ; MovePathCursor(vx,j*n + vy)
;     MovePathCursor(vx,j*n)
;     AddPathLine(GadgetWidth(#G_canvasVector)*z,j*n + vy)
;   Next        
;   For i = 0 To w
;     ; MovePathCursor(i*m + vx,vy)
;     MovePathCursor(i*m,vy)
;     AddPathLine(i*m + vx, GadgetHeight(#G_canvasVector)*z)
;   Next 
;   VectorSourceColor(VdOptions\GridColor)
;   StrokePath(1)        
;     
EndProcedure

Procedure VDDrawBG(depth=0)
  
  vx = Vd\viewX
  vy = Vd\viewY
  If VdOptions\ShowBGImg
    If VdOptions\BGImg\depth = depth
      img = #Img_BGimgCopy
      If IsImage(img)
        MovePathCursor(VDoptions\BGImg\X+vx,VDoptions\BGImg\Y+vy)
        w = ImageWidth(img) * VDoptions\BGImg\Scale/VDoptions\BGImg\Resize
        h = ImageHeight(img) * VDoptions\BGImg\Scale/VDoptions\BGImg\Resize
        If IsImage(img)
          DrawVectorImage(ImageID(img), VDoptions\BGImg\Alpha, W , h)
        EndIf
      EndIf
    EndIf
  EndIf
EndProcedure
Procedure VDDrawUtil()
    
    ; draw UTILES : 
    ; - lignes points tillés (sélection) 
    ; - puis j'affiche les elements utiles : dashpath de selection, centre, droites & points d'ancrage...
    ; - grille
    ; - taille de la "camera" ou export (x,y,w,h)
  
  a = 3 ; taille point tillé, et des points centraux
  b = 2 ; centre du shape
  c = 2
  d = 2 ;  center du point
  
  z.d = VdOptions\Zoom * 0.01 
  If z<=0.3
    z1.d = 0.3*0.5
  Else
    z1.d = z*0.5
  EndIf
  
  
  ; if the background is on the top
  vx = vd\ViewX
  vy = vd\ViewY
  VD_ResetCoord()
  VDDrawBG(1)
  
  ; Then, we display the dash stroke and other utilities for shapes (anchors, node).. //puis on affiche les points tillé ou autre des shapes
  If  vd\NbShape >=1
    If Obj(ObjId)\Hide = 0
      ; VD_ShapeCoord(ObjId)
      
      ; on doit mettre la view
;       vx = vd\ViewX
;       vy = vd\ViewY
;       VD_ResetCoord()

      ; pour voir les anchors
      If Vd\EditMode = #VD_Editmode_Point  Or 
         (VdOptions\Tool(action)\Type = #VD_Action_Type_0 And (VdOptions\Action = #VD_actionAddLine Or VdOptions\Action=#VD_actionAddCurve))
        
        If VdOptions\HideAncre = 0 
          
          If ShapeId >- 1
            With Obj(ObjId)\Shape(ShapeId)
              px = 0
              py = 0
              If \Parent\id >0 And \parent\id-1 <> ShapeId
                px = Obj(ObjId)\Shape(\Parent\id-1)\X - Obj(ObjId)\Shape(ShapeId)\Parent\startx
                pY = Obj(ObjId)\Shape(\Parent\id-1)\Y - Obj(ObjId)\Shape(ShapeId)\Parent\starty
              EndIf
              
              vx = Vd\viewX + \X +px; + Obj(ObjId)\x
              vy = Vd\viewY + \y +py; + Obj(ObjId)\y
              
              If \rot <> 0
                RotateCoordinates(\pt(0)\x+\Cx+vx, \pt(0)\y+\cy+vy, \rot) 
              EndIf
              
              ; on dessine les points du shape
              Select \ShapTyp
                  
                Case #VD_ShapeShape, #VD_ShapeCurve
                  MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
                  For i =0 To ArraySize(\pt())
                    ;AddPathLine(pt(i)\x, pt(i)\y) 
                    If Mod(i,3)=0  
                      ; center point
                      \pt(i)\Center = 1
                      AddPathBox(\pt(i)\x-a/Z1+vx,\pt(i)\y-a/Z1+vy,(a*2)/Z1,(a*2)/Z1)
                      VectorSourceColor(RGBA(0,0,255,100))
                      StrokePath(1/Z1)
                    Else
                      \pt(i)\Center = 0
                      If Mod(i,3)=1
                        u = i-1
                        If u<0
                          u = ArraySize(\pt())
                        EndIf
                        MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                        AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                        AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy) 
                        VectorSourceColor(RGBA(0,0,0,100))
                        ;StrokePath(1/Z1)
                        DashPath(1/Z1,1.5/Z1)
                      Else
                        u = i+1
                        If u>ArraySize(\pt())
                          u = 0
                          ;If \open = 0
                          ;Break
                          ;EndIf
                        EndIf
                        MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                        AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                        AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy)
                        VectorSourceColor(RGBA(0,0,0,100))
                        ; StrokePath(1/Z1)
                        DashPath(1/Z1,1.5/Z1)
                      EndIf
                      AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,(c*2.2)/Z1)
                      VectorSourceColor(RGBA(0,0,0,100))
                      StrokePath(1/Z1)
                    EndIf
                    
                    
                    ; test
                    ;                   If \pt(i)\Center
                    ;                     AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,d/Z1)
                    ;                     VectorSourceColor(RGBA(0,255,255,255))
                    ;                     FillPath()
                    ;                   EndIf
                    
                    If \pt(i)\Selected = 1 Or i=PtId
                      ;                     AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,c/Z1)
                      ;                     VectorSourceColor(RGBA(255,0,0,120))
                      ;                     FillPath() 
                      If \pt(i)\Center
                        AddPathBox(\pt(i)\x-a/Z1+vx,\pt(i)\y-a/Z1+vy,(a*2)/Z1,(a*2)/Z1)
                        VectorSourceColor(RGBA(0,255,255,120))
                        ;DashPath(1/Z1,1.5/Z1)
                        FillPath()
                      Else
                        AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,(c*2.2)/Z1)
                        VectorSourceColor(RGBA(255,120,0,120))
                        ;DashPath(1/Z1,1.5/Z1)
                        FillPath()
                      EndIf
                      
                    EndIf
                    
                    
                  Next
                  
                Default
                  For i =0 To ArraySize(\pt())
                    AddPathBox(\pt(i)\x-a/Z1+vx,\pt(i)\y-a/Z1+vy,(a*2)/z1,(a*2)/Z1)
                    If i=PtId Or \pt(i)\Selected = 1
                      AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,a/Z1)
                      VectorSourceColor(RGBA(255,0,0,120))
                      FillPath()
                    Else
                      VectorSourceColor(RGBA(0,255,255,100))
                      FillPath()
                    EndIf
                    
                  Next                            
                  ; VectorSourceColor(RGBA(0,255,255,100))
                  ;FillPath()
                  
              EndSelect
              
              If \rot <> 0
                VD_ResetCoord()
              EndIf
        
            EndWith
          EndIf
          
          If VdOptions\ShowAncreSelected
            
            For j=0 To ArraySize(obj(ObjId)\Shape())
              With Obj(ObjId)\Shape(j)
                
                ;               If \Parent\id >0 And \parent\id-1 <> j
                ;                 px = Obj(ObjId)\Shape(\Parent\id-1)\X - Obj(ObjId)\Shape(j)\Parent\startx
                ;                 pY = Obj(ObjId)\Shape(\Parent\id-1)\Y - Obj(ObjId)\Shape(j)\Parent\starty
                ;               EndIf
                
                ShapeSetParentingPosition(ObjId,j)
                
                vx = Vd\viewX + \X +px ; + Obj(ObjId)\x
                vy = Vd\viewY + \y +py ; + Obj(ObjId)\y
                
                If \Hide = 0
                  If \Selected = 1
                    ; on dessine les points du shape
                    Select \ShapTyp
                        
                      Case #VD_ShapeShape
                        
                        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
                        For i =0 To ArraySize(\pt())
                          ;AddPathLine(pt(i)\x, pt(i)\y) 
                          If Mod(i,3)=0                   
                            AddPathBox(\pt(i)\x-a+vx,\pt(i)\y-a+vy,(a*2)/z1,(a*2)/z1)
                            VectorSourceColor(RGBA(255,0,216,200))
                            FillPath()
                          Else
                            If Mod(i,3)=1
                              u = i-1
                              If u<0
                                u = ArraySize(\pt())
                              EndIf
                              MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                              AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                              AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy) 
                              VectorSourceColor(RGBA(0,0,0,100))
                              StrokePath(1/Z1)
                            Else
                              u = i+1
                              If u>ArraySize(\pt())
                                u = 0
                              EndIf
                              MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                              AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                              AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy)
                              VectorSourceColor(RGBA(0,0,0,100))
                              StrokePath(1/Z1)
                            EndIf
                            AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,a/z1)
                            VectorSourceColor(RGBA(255,0,216,200))
                            FillPath()
                          EndIf
                          
                          If i=PtId Or \pt(i)\Selected = 1
                            AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,c/z1)
                            VectorSourceColor(RGBA(255,0,0,120))
                            FillPath()
                          EndIf
                          
                          
                        Next
                        
                      Default
                        For i =0 To ArraySize(\pt())
                          AddPathBox(\pt(i)\x-a/Z1+vx,\pt(i)\y-a/Z1+vy,(a*2)/Z1,(a*2)/Z1)
                          ; VectorSourceColor(RGBA(0,255,255,100))
                          ; FillPath()
                          If i=PtId Or \pt(i)\Selected = 1
                            AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,6/Z1)
                            ;VectorSourceColor(RGBA(255,0,0,120))
                            ;FillPath()
                          EndIf
                        Next                            
                        VectorSourceColor(RGBA(0,255,255,100))
                        FillPath()
                        
                    EndSelect
                  EndIf
                  
                EndIf                       
                
              EndWith                    
            Next
            
          EndIf
          
        EndIf
      EndIf
    
      ; puis, j'affiche des points tillés autour du shape selectionné
      If VdOptions\ShowSelection
        
        ; pour les shapes sélectionnés qui ne sont pas shapeID (le dernier selectionné)
        For kk = 0 To ArraySize(Obj(ObjId)\Shape())
          
          With Obj(ObjId)\Shape(kk)
            px = 0
            py = 0
;             If \Parent\id >0 And \parent\id-1 <> kk
;               px = Obj(ObjId)\Shape(\Parent\id-1)\X - Obj(ObjId)\Shape(kk)\Parent\startx
;               pY = Obj(ObjId)\Shape(\Parent\id-1)\Y - Obj(ObjId)\Shape(kk)\Parent\starty
;             EndIf
            ShapeSetParentingPosition(ObjId,kk)
            
            vx = vd\ViewX + \X +px ;+ Obj(ObjId)\x 
            vy = vd\ViewY + \Y +py ;+ Obj(ObjId)\y
            
            If \Selected = 1 ;And kk<> shapeId
              
              MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
              Select \ShapTyp
                  
                Case #VD_ShapeShape, #VD_ShapeCurve                               
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
                    AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                  Next
                  
                Case #VD_ShapeText
                  sizeW = \d ; VectorTextWidth(\text$, #PB_VectorText_Visible)
                  sizeH = VectorParagraphHeight(\text$, \d,\h)
                  AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,SizeW,SizeH)
                  
                Case #VD_ShapeImage 
                  AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\SizeH)
                  
                Default
                  VdDrawShape1(ObjId, kk)
                  
              EndSelect
              
              AddPathBox(PathBoundsX(),PathBoundsY(),PathBoundsWidth(),PathBoundsHeight())
              VectorSourceColor(RGBA(15,15,15,255)) 
              ;DashPath(0.5/Z1,5/Z1)
              DashPath(0.5,5)
            EndIf
            
          EndWith                
          
        Next
        ;VectorSourceColor(RGBA(15,15,15,255)) 
        ;DashPath(0.5/Z1,5/Z1)
      
        px = 0
        py = 0
        ; puis, on dessine le contour en point tillés
        If shapeId > -1
          With Obj(ObjId)\Shape(shapeId)
            
;             If \Parent\id >0 And \parent\id-1 <> ShapeId
;               px = Obj(ObjId)\Shape(\Parent\id-1)\X - Obj(ObjId)\Shape(ShapeId)\Parent\startx
;               pY = Obj(ObjId)\Shape(\Parent\id-1)\Y - Obj(ObjId)\Shape(ShapeId)\Parent\starty
;             EndIf
            ShapeSetParentingPosition(ObjId,shapeId)
            
            vx = vd\ViewX + \X +px ;+ Obj(ObjId)\x 
            vy = vd\ViewY + \Y +py ;+ Obj(ObjId)\y
            
            MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
            
            Select \ShapTyp
                
              Case #VD_ShapeShape, #VD_ShapeCurve                               
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
                  
                  AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                Next
                
              Case #VD_ShapeText
                 sizeW = \d ; VectorTextWidth(\text$, #PB_VectorText_Visible)
                  sizeH = VectorParagraphHeight(\text$, \d,\h)
                AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,SizeW,SizeH)
                
              Case #VD_ShapeImage 
                AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\SizeH)
                
              Default
                VdDrawShape1(ObjId, ShapeId)
                
            EndSelect
            VectorSourceColor(RGBA(60,30,40,255)) 
            ;DashPath(1/Z1,5/Z1)
            DashPath(1,5)
            
            ; le centre du shape en bleu
            MovePathCursor(vx,vy)
            ;AddPathCircle(\Cx,\cy,b/Z1,0,360,#PB_Path_Relative)
            AddPathCircle(\Cx,\cy,b,0,360,#PB_Path_Relative)
            VectorSourceColor(RGBA(255,0,216,255))
            FillPath()
          EndWith
        EndIf     
        
        
      EndIf
      
    EndIf
  EndIf
  
  
  ;{ other utilities to show
  ; là il faut le remettre
  vx = vd\ViewX
  vy = vd\ViewY
  VD_ResetCoord()
  
  ; puis, on affiche la grille
  If VdOptions\ShowGrid = 1
    m = VdOptions\SnapX
    n = VdOptions\SnapY
    w = (VD_Camera(cameraid)\W/m)
    h = (VD_Camera(cameraid)\H/n)
   
    For j = 0 To h 
      MovePathCursor(vx,j*m+vy)            
      AddPathLine(vx+VD_Camera(cameraid)\W,j*m+vy)
    Next        
    For i = 0 To w
      MovePathCursor(i*n+vx,vy)
      AddPathLine(i*n+vx, vy+VD_Camera(cameraid)\H)
    Next 
    VectorSourceColor(RGBA(Red(VdOptions\GridColor),Green(VdOptions\GridColor),Blue(VdOptions\GridColor),100))
    If z <1
      u = 1
    Else
      u = 100/VdOptions\Zoom
    EndIf
    
    If u<=0 
      u=1
    EndIf
    
    StrokePath(u)        
  EndIf
  
  ; on affiche la bordure camera
  If VdOptions\showCameraBorder
    MovePathCursor(vx,vy)
    AddPathBox(vx+VD_camera(CameraID)\x,vy+VD_camera(CameraID)\Y, VD_camera(CameraID)\W,VD_camera(CameraID)\H)
    VectorSourceColor(RGBA(255,120,120,255))
    StrokePath(2/Z1)
  EndIf
  
  If VdOptions\ShowCameraCache
    AddPathBox(0,-1,GadgetWidth(#G_canvasVector)/z,2+GadgetHeight(#G_canvasVector)/z)
    AddPathBox(vx+VD_camera(CameraID)\X,vy+VD_camera(CameraID)\Y, VD_camera(CameraID)\W,VD_camera(CameraID)\H)
    VectorSourceColor(RGBA(0,0,0,VdOptions\CameraCacheAlpha))
    FillPath()
  EndIf
  
  
  If vd\Selection\x<> vd\Selection\w And vd\Selection\y <> vd\Selection\h
    AddPathBox(vd\Selection\x+ VD\ViewX, vd\Selection\y+ VD\ViewY, vd\Selection\w, vd\Selection\h)
    VectorSourceColor(RGBA(255,0,0,255))
    DashPath(0.5/Z1,6/Z1)
  Else
    ; show mouse cible
    If VdOptions\Action = #VD_actionSelect
      a = 30
      AddPathCircle(MouseX + VX, MouseY+ VY, 7/Z1)
      MovePathCursor(vx-a+MouseX,vy+MouseY)
      AddPathLine(vx+a+MouseX,vy+MouseY)
      MovePathCursor(vx+MouseX,vy-a+MouseY)
      AddPathLine(vx+MouseX,vy+a+MouseY)
      VectorSourceColor(RGBA(255,0,0,255))
      DashPath(0.5/Z1,2/Z1)
    EndIf
  EndIf
  ;}
  
EndProcedure
Procedure VDDrawOrigin()
  
  Protected a
  
  If VdOptions\ShowOrigin
    
    z.d
    z = VdOptions\Zoom*0.01
    a = 10000/z
    vx = Vd\viewX 
    vy = Vd\viewY 
    VD_ResetCoord()
    MovePathCursor(vx-a,vy)
    AddPathLine(vx+a,vy)
    MovePathCursor(vx,vy-a)
    AddPathLine(vx,vy+a)
    VectorSourceColor(RGBA(20,20,20,100))
    StrokePath(3)
  EndIf

EndProcedure
Procedure VD_DrawScene(x,y,Selected=0, playanim=0)
  
  ; puis, on affiche les objets (et les shapes qui les composent)
  For m = 0 To ArraySize(Obj())
    
    If Obj(m)\Hide = 0
      
      VD_ShapeCoord(m)
      
      ; for selection
      If Selected = 1 And objid = m
        If EventType() = #PB_EventType_LeftButtonDown
          If vd\EditMode <> #VD_Editmode_Point
          If vdoptions\Action = #VD_actionMove Or vdoptions\action = #VD_actionSelect
            For j =ArraySize(Obj(m)\Shape()) To 0 Step -1
              If Obj(m)\Shape(j)\Hide = 0
                VdDrawShape1(m,j)
                
                If Vd\space = 0  And Vd\LockSelection =0
                  With Obj(m)\Shape(j)
                    
                    If (\ShapTyp = #VD_ShapeText Or \ShapTyp = #VD_ShapeImage) And MouseOnShape(m,j,x,y) 
                      mouseOn_shape = 1
                      Debug "ok mouse on shape"
                    EndIf
                    
                    If vd\shift = 0
                      \selected= 0
                      If shapeId = j
                        shapeId = -1
                        Ze_idunik$=""
                      EndIf
                    EndIf
                    If vd\ClicSelect =1  
                      If (IsInsidePath(x, y) Or IsInsideStroke(x, y, \w) Or mouseOn_shape = 1) And Vd\move = 0   
                        vd\ClicSelect=0
                        Vd\TestShapeOk = -1  
                        ;\selected= 1
                        \selected = 1 -\selected
                        If \selected 
                          ShapeID = j
                          Ze_idunik$ = Obj(ObjId)\Shape(ShapeId)\idunik$
                          ShapeGetProperties()  
                          Select vdOptions\Action 
                            Case #VD_actionMove
                              \startY = y - \Y                                                               
                              \startX = x - \X
                            Case #VD_actionScale
                              \startX = x -\SizeW
                              \startY = y +\SizeH
                          EndSelect
                        Else
                          If shapeId = j
                            shapeId = -1
                            Ze_idunik$=""
                          EndIf
                        EndIf
                      EndIf
                    EndIf
                    ResetPath()
                  EndWith
                EndIf
              EndIf
            Next
          EndIf
          EndIf
       EndIf
      EndIf
      
      ; then draw
      BeginVectorLayer(Obj(m)\Alpha)
      For j =0 To ArraySize(Obj(m)\Shape())
       ; If VdOptions\ShowOnlySel = 0 Or j = ShapeId Or playanim=1 Or selected =1
          
          If Obj(m)\Shape(j)\Hide = 0
            ; si clippath
            ; SaveVectorState()
            ; VdDrawShape1(m,j)
            ; ClipPath()    
            
            ; on dessine les fx en dessous
            VdDrawFx(m,j,0)
            
            ;{ le shape
            VdDrawShape1(m,j)
            
            If Obj(m)\Shape(j)\Linked = 0 Or j = ArraySize(Obj(m)\Shape())
              VDDrawShapeColor(m,j) ; color et fillpath()/strokepath()                                    
            EndIf
            ;}
            
            ; si fx au dessus
            VdDrawFx(m,j,1)                    
            ; RestoreVectorState()
            
          EndIf
          
        ; EndIf
      Next
      EndVectorLayer()
      
    EndIf
  Next 

EndProcedure

Procedure DrawCanvas(x=0,y=0,Selected=0, gad=#G_canvasVector)
    
    ; pour dessiner le canvas
    z.d
    z = VdOptions\Zoom*0.01
    vx = Vd\viewX
    vy = Vd\viewY
    
    If StartVectorDrawing(CanvasVectorOutput(gad))
        
        ResetCoordinates()
        
        ;{ Background
        AddPathBox(0,0, GadgetWidth(gad),GadgetHeight(gad))
        VectorSourceColor(VdOptions\BgColor)
        FillPath()
        If VdOptions\BGChecker
          
          u = 32            
          c = 120
          a = 120
          yy = Round(GadgetHeight(#G_canvasVector)/u,1) 
          xx = Round(GadgetWidth(#G_canvasVector)/u,1)
          
          For y=0 To  yy   
            For x=0 To xx
              AddPathBox(x*u,y*u,u,u)
              VectorSourceColor(RGBA(c,c,c,255))
              FillPath()
              If c=a
                c=192        
              Else
                c=a
              EndIf      
            Next
            If xx%2=1
              If c=a
                c=192 
              Else        
                c=a                
              EndIf
            EndIf      
          Next
        EndIf 
        
        VD_ResetCoord()
        VDDrawBG()
        ;}
        
              
        VDDrawOrigin()

        ;zoom
        ; VD_ResetCoord()
        If vd\NbShape >=1 ; il faut avoir au moins un shape actif !!
            
            ;{ si on affiche les Fx tous en dessous
            
            ;}
          
            VD_DrawScene(x,y,Selected)
          
            ; pour vérifier si on clique sur un shape, pour le sélectionner par exemple (
            ; si on cliqué sur un shape, on garde en mémoire certaines choses
            If vd\EditMode <> #VD_Editmode_Point And selected =1
              If vd\AddObjet = 0 And Vd\space = 0  
                If (Vd\TestShapeOk = -1 Or vd\move = 2)
                  Vd\TestShapeOk = 1
                  Vd\move = 2            
                  ; ShapeGetProperties()
                  If vdOptions\Action <> #VD_actionScale And vdOptions\Action <> #VD_actionRot ; And vdOptions\Action <> #VD_actionMove
                    For j =0 To  ArraySize(Obj(ObjId)\Shape())
                      With Obj(ObjId)\Shape(j)                                
                        If \selected = 1
                          
                          Select vdOptions\Action 
                            Case #VD_actionMove
                              \startY = y - \Y                                                               
                              \startX = x - \X
;                             Case #VD_actionScale
;                               \startX = x -\SizeW
;                               \startY = y +\SizeH
                          EndSelect
                          
                          For k = 0 To ArraySize(\pt())
                            \pt(k)\startX = x-\pt(k)\x
                            \pt(k)\startY = y-\pt(k)\y
                          Next
                        EndIf
                      EndWith  
                    Next
                  EndIf
                ElseIf vd\TestShapeOk = 0
                  If vdOptions\Action = #VD_actionSelect
                    Shape_SelectAll(0)
                  EndIf
                EndIf
              EndIf
            EndIf
          
        EndIf
        
        ; Utilitaire (grille, selection, etc.. )
        VdDrawUtil()
        
        StopVectorDrawing()
    EndIf
    
EndProcedure




; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 221
; FirstLine = 9
; Folding = Ul---80b-6d---v-DcBP7+---A6--
; EnableXP
; DisableDebugger