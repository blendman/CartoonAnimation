; procedures for shapes


;{ fx
Procedure ShapeExportFx()
EndProcedure
Procedure ShapeLoadFx()
EndProcedure
Procedure ShapeExportFxLayer()
    
    ; export FX layer (just un layer par le fx complet)
    
    If ShapeId >- 1
        nom$ = InputRequester("Name","Set the name for the layer FX","")
        ;nom$ = Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Nom$
        ;If nom$ = ""
            
        ;EndIf
        
        
        
        If nom$ <> ""
            
            Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Nom$ = nom$
            
            File$ = "data\shapefx\"+Nom$+".sfx"
            d$ =","
            
            If OpenFile(1,file$)
                
                With Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)
                    
                    txt$= "gen,"+\Nom$+d$+StrD(ValD(#ProgramVersionVD),2)+d$
                    WriteStringN(1,txt$)
                    
                    txt$ = "shapefx,"+ShapeFxId+d$+\X+d$+\y+d$+\Color+d$+\Alpha+d$+\Depth+d$+\Style+d$+\w+d$+\h+d$+\Dist+d$+\Scale+d$+\SizeW+d$+\SizeH
                    WriteStringN(1,txt$)
                    
                EndWith
                CloseFile(1)
            EndIf
            UpdateListPresetFx()
        EndIf
        
    EndIf
    
;     Typ.a ; le typ 0=normal, 1 = shadow ext, 2 = stroke, 3 = glow int, 4 =glow ext, 5 = reflet (rond ?), 6 = light int, 7 = rimlight
    
EndProcedure
Procedure ShapeLoadFxLayer(nom$)
    
    ; pour charger un FX layer (just un layer par le fx complet)
    If ShapeId >- 1
        
        If nom$ <> ""
            
            ; Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Nom$ = nom$
            
            File$ = "data\shapefx\"+Nom$+".sfx"
            d$ =","
            
            If OpenFile(1,file$)
                With Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)
                    
                    While Eof(1) = 0
                        
                        line$ = ReadString(1)
                        index$ = StringField(line$,1,d$)
                        
                        Select index$
                                
                            Case "gen" 
                                nom$ = StringField(line$,2,d$)
                                If nom$ = ""
                                    nom$ = "fx_"+ShapeFxId
                                EndIf                            
                                \Nom$ =nom$
                                version.d = Val(StringField(line$,3,d$))
                                
                            Case "shapefx"
                                ; ShapeFxId
                                u = 3
                                \X      = Val(StringField(line$,u,d$)) : u+1
                                \y      = Val(StringField(line$,u,d$)) : u+1
                                \Color  = Val(StringField(line$,u,d$)) : u+1
                                \Alpha  = Val(StringField(line$,u,d$)) : u+1
                                \Depth  = Val(StringField(line$,u,d$)) : u+1
                                \Style  = Val(StringField(line$,u,d$)) : u+1
                                \w      = Val(StringField(line$,u,d$)) : u+1
                                \h      = Val(StringField(line$,u,d$)) : u+1
                                \Dist   = Val(StringField(line$,u,d$)) : u+1
                                \Scale  = Val(StringField(line$,u,d$)) : u+1
                                \SizeW  = Val(StringField(line$,u,d$)) : u+1
                                \SizeH  = Val(StringField(line$,u,d$)) : u+1
                                
                        EndSelect
                        
                    Wend
                    
                EndWith
                CloseFile(1)
            EndIf
            
            
            UpdateListShapeFX()
            DrawCanvas()
            
        EndIf
        
    EndIf
    
;     Typ.a ; le typ 0=normal, 1 = shadow ext, 2 = stroke, 3 = glow int, 4 =glow ext, 5 = reflet (rond ?), 6 = light int, 7 = rimlight
    
EndProcedure
Procedure ShapeAddFx(i=0)
    
    ; pour ajouter un Fx au shape
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Nom$ = "FX_"+Str(i)
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Alpha = vdoptions\ToolOptionsFX\Alpha
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Color = vdoptions\ToolOptionsFX\Color ; RGBA(255,120,0,255)
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\W = vdoptions\ToolOptionsFX\Width
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\H = 5
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Dist = 5
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Scale = 100
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Style = vdoptions\ToolOptionsFX\Style
    
    ; puis, on update
    UpdateListShapeFX()
    ShapeGetProperties()
    
EndProcedure

;}

; utiles
Procedure.a Shape_GetShapeIdSelected(max=0)
  If ShapeId <= ArraySize(Obj(ObjId)\Shape())-max And ShapeId > -1
    ProcedureReturn 1
  Else
    MessageRequester(lang("Info"), Lang("You need at least 1 shape selected to use this feature"))
    ProcedureReturn 0
  EndIf
  
EndProcedure


;{ Edit point 
Procedure Vd_DeletePoint(i)
  ; pour supprimer le point sélectionné
  If Layer_CheckifOk(ObjId) = 1
    If ShapeId> -1 And shapeId <= ArraySize(Obj(ObjId)\Shape())
      With Obj(ObjId)\Shape(ShapeId)
        If \ShapTyp = #VD_ShapeShape Or \ShapTyp =#VD_ShapeCurve
          u=i-1
          If u<0
            u=ArraySize(\pt())
          EndIf
          v=i+1
          If v > ArraySize(\pt())
            v=0
          EndIf
          
          DeleteArrayElement(\pt,u)
          If v>-1
            DeleteArrayElement(\pt,v)
          EndIf
        EndIf
        ; delete the point for the other shape type (line)
        If ArraySize(\pt()) >0
          DeleteArrayElement(\pt,i)
          
          ; change the next point
          If i <=ArraySize(\pt()) 
            \pt(i)\center = 0
          EndIf
          ; je dois vérifier les broken points
          Shape_CheckBrokenPoint()
          ; et update le canvas
          DrawCanvas()
        EndIf
      EndWith
    EndIf
  EndIf
EndProcedure

Procedure VD_ResetAllPoints()
  ; to reset all point of a  shape
  If shapeId >-1
    With Obj(ObjId)\Shape(ShapeId) 
      For k=0 To ArraySize(\pt())
        \pt(k)\center = 0
        \pt(k)\broken = 0 ; ??
      Next
    EndWith
  EndIf
  
EndProcedure

Procedure Vd_SetPoint(param=0,draw=1)
  
  ; param = 0 : hard
  ; param = 1 : soft
  ; param = 2 : Mirored (like a tangent) need improvements.
  
  If Vd\EditMode <> #VD_Editmode_Point
    MessageRequester(lang("Info"), Lang("You have to be in editMode 'point edition' To Select points."))
  Else
    
    ; TO change the hardness of a point // pour changer la dureté d'un point 
    ; hard (line) ou smooth (curve)
    If shapeId > -1 And shapeid <= ArraySize(Obj(ObjId)\Shape())
      If ptid=-1
        MessageRequester(lang("Info"), Lang("You need at least 1 center point selected to use this feature (center points are displayed with blue square)."))
      Else
        With Obj(ObjId)\Shape(ShapeId)
          
          u = PtId-1
          If u < 0
            u =ArraySize(\pt())
          EndIf  
          v = PtId+1
          If v > ArraySize(\pt())
            v =0
          EndIf   
          
          Select param 
              
            Case 2 ; point mirored
              If \pt(PtId)\Center
                x1 = \pt(u)\x
                y1 = \pt(u)\y
                ;If ptid<3
                ; sx = \pt(v)\x 
                ;sy = \pt(v)\y 
                ;\pt(PtId)\x = X1 
                ;\pt(PtId)\y = y1
                ;Else
                sx = \pt(PtId)\x 
                sy = \pt(PtId)\y 
                ; point tangeant 0
                ;\pt(u)\x = sx -(x1 -sx)
                ;\pt(u)\y = sy -(y1 -sy)
                ; point tangeant 2
                \pt(v)\x = sx -(x1 -sx)
                \pt(v)\y = sy -(y1 -sy)
                ; EndIf
              EndIf
              
            Case 0 ; point hard
              \pt(u)\hard = 1
              \pt(u)\x = \pt(PtId)\x
              \pt(u)\y = \pt(PtId)\y 
              
              \pt(v)\x = \pt(PtId)\x
              \pt(v)\y = \pt(PtId)\y
              \pt(v)\hard = 1
              
            Case 1; point soft
              \pt(u)\hard = 0
              \pt(u)\x = \pt(PtId)\x+20
              \pt(u)\y = \pt(PtId)\y 
              
              \pt(v)\x = \pt(PtId)\x-20
              \pt(v)\y = \pt(PtId)\y
              \pt(v)\hard = 0
              
          EndSelect
          
        EndWith
      EndIf
    EndIf
    
    If draw=1
      Drawcanvas()
    EndIf
    
  EndIf
EndProcedure  

Procedure VD_MovePoint(i,x1,y1)
  
  With obj(objID)\shape(ShapeId)
    
    sx0 = \pt(i)\x + \x - Obj(ObjId)\x
    sy0 = \pt(i)\y + \y - Obj(ObjId)\y
    
    \pt(i)\startX = \pt(i)\x ;- x1 
    \pt(i)\startY = \pt(i)\y ;- y1
    
    \pt(i)\x = x1 -\x  - Obj(ObjId)\x
    \pt(i)\y = y1 -\y  - Obj(ObjId)\y
    SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
    SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
    ; move the tangent points
    If Mod(i,3)=0 ; on est sur un point principal
      u = i+1
      If u > ArraySize(\pt())
        u=0
      EndIf
      v =i-1
      If v <0
        v =ArraySize(\pt())
      EndIf
       j=ip
    
       
       sx1 = \pt(u)\x + \x - Obj(ObjId)\x
       sy1 = \pt(u)\y + \y - Obj(ObjId)\y
       sx2 = \pt(v)\x + \x - Obj(ObjId)\x
       sy2 = \pt(v)\y + \y - Obj(ObjId)\y
      
      
      \pt(u)\x = sx1+(\pt(i)\x-sx0)
      \pt(u)\y = sy1+(\pt(i)\y-sy0)
      \pt(v)\x = sx2+(\pt(i)\x-sx0)
      \pt(v)\y = sy2+(\pt(i)\y-sy0)
    EndIf 
  EndWith
                            
EndProcedure

Macro VD_PointGetSelected(x1,y1)
  
 ; Z.d = VdOptions\Zoom * 0.01
  
  ; puis, je vérifie si on clique sur un point (pour le sélectionner)
  ; c=3 ; 8 ; c=3
  ;With Obj(ObjId)\Shape(ShapeId)
  If vd\EditMode = #VD_Editmode_Point
    PtId = -1
    ip=-1
    For ip=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())  
      ;{
      ;                       xa = \pt(ip)\x - c + \FinalX ;+ Obj(ObjId)\x
      ;                       ya = \pt(ip)\y - c + \FinalY ;+ Obj(ObjId)\y 
      ;                       wa = \pt(ip)\x + c + \FinalX ;+ Obj(ObjId)\x
      ;                       ha = \pt(ip)\y + c + \FinalY ;+ Obj(ObjId)\y
      ;                         
      ;                         xa = \pt(ip)\x - c + \X ;+ Obj(ObjId)\x
      ;                         ya = \pt(ip)\y - c + \Y ;+ Obj(ObjId)\y 
      ;                         wa = \pt(ip)\x + c + \X ;+ Obj(ObjId)\x
      ;                         ha = \pt(ip)\y + c + \Y ;+ Obj(ObjId)\y
      ;                         
      ;                       If (x1>=xa And x1<=wa And y1>=ya And y1<=ha) Or 
      ;                          Sqr(Pow(\pt(ip)\x-x1,2)+Pow(\pt(ip)\y-y1,2))<=c*2    ; <=6
      ;}
      ;If (x1>=xa And x1<=wa And y1>=ya And y1<=ha) Or 
      xa_1 =  Obj(ObjId)\Shape(ShapeId)\pt(ip)\x+ Obj(ObjId)\Shape(ShapeId)\X + Obj(ObjId)\x
      ya_1 =  Obj(ObjId)\Shape(ShapeId)\pt(ip)\y+ Obj(ObjId)\Shape(ShapeId)\Y + Obj(ObjId)\y
      
      ;dist.d = point_distance(x1,y1,xa_1,ya_1)
      
      ; Debug Str(ip)+" : "+Str(dist)+" / "+Str(20/z)
      
      dist.D = Sqr(Pow(xa_1 - X1, 2) + Pow(ya_1 - Y1, 2))
      
      
      If dist <=10/Z  Or (x1>=xa_1-5/z And x1<=xa_1+5/Z And y1>=ya_1-5/Z And y1<=ya_1+5/z); 20/Z  ; <=6 , c*2
      ; If  (x1>=xa_1-5/z And x1<=xa_1+5/Z And y1>=ya_1-5/Z And y1<=ya_1+5/z) ; 20/Z  ; <=6 , c*2
        PtId = ip
       

        Obj(ObjId)\Shape(ShapeId)\pt(ip)\Selected = 1
        ok = 1 
        SetGadgetText(#G_shapePtX,Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\x))
        SetGadgetText(#G_shapePtY,Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\y))
        SetGadgetState(#G_shapeNotRender,Obj(ObjId)\Shape(ShapeId)\pt(ptId)\hide)
        ; ShapeGetProperties()
        Obj(ObjId)\Shape(ShapeId)\startY = y1                                                      
        Obj(ObjId)\Shape(ShapeId)\startX = x1
        
        Debug "point: "+Str(ip) + " /broken : "+Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\broken)+" / center : "+Str(Obj(ObjId)\Shape(ShapeId)\pt(ip)\Center)
        
        Select vdOptions\Action
            
          Case #VD_actionMove 
            
            Vd\move = 1
            sx0 = Obj(ObjId)\Shape(ShapeId)\pt(ip)\x + Obj(ObjId)\Shape(ShapeId)\x ;+ Obj(ObjId)\x
            sy0 = Obj(ObjId)\Shape(ShapeId)\pt(ip)\y + Obj(ObjId)\Shape(ShapeId)\y ;+ Obj(ObjId)\y
            
            Obj(ObjId)\Shape(ShapeId)\pt(ip)\startX = Obj(ObjId)\Shape(ShapeId)\pt(ip)\x ;- x1 
            Obj(ObjId)\Shape(ShapeId)\pt(ip)\startY = Obj(ObjId)\Shape(ShapeId)\pt(ip)\y ;- y1
            j=ip
            
            If Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeShape Or Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeCurve
              If  Obj(ObjId)\Shape(ShapeId)\pt(ip)\Center = 1
                u = j+1
                If u > ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                  u=0
                EndIf
                v =j-1
                If v <0
                  v =ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                EndIf  
                
                sx1 = Obj(ObjId)\Shape(ShapeId)\pt(u)\x + Obj(ObjId)\Shape(ShapeId)\x ;+ Obj(ObjId)\x
                sy1 = Obj(ObjId)\Shape(ShapeId)\pt(u)\y + Obj(ObjId)\Shape(ShapeId)\y ;+ Obj(ObjId)\y
                sx2 = Obj(ObjId)\Shape(ShapeId)\pt(v)\x + Obj(ObjId)\Shape(ShapeId)\x ;+ Obj(ObjId)\x
                sy2 = Obj(ObjId)\Shape(ShapeId)\pt(v)\y + Obj(ObjId)\Shape(ShapeId)\y ;+ Obj(ObjId)\y
                If vd\shift
                  Obj(ObjId)\Shape(ShapeId)\pt(u)\Selected = 1
                  Obj(ObjId)\Shape(ShapeId)\pt(v)\Selected = 1
                EndIf
                Obj(ObjId)\Shape(ShapeId)\pt(u)\startX = Obj(ObjId)\Shape(ShapeId)\pt(u)\x ;- x1  ;+ Obj(ObjId)\x
                Obj(ObjId)\Shape(ShapeId)\pt(u)\startY = Obj(ObjId)\Shape(ShapeId)\pt(u)\y ;- y1  ;+ Obj(ObjId)\y
                Obj(ObjId)\Shape(ShapeId)\pt(v)\startX = Obj(ObjId)\Shape(ShapeId)\pt(v)\x ;- x1  ;+ Obj(ObjId)\x
                Obj(ObjId)\Shape(ShapeId)\pt(v)\startY = Obj(ObjId)\Shape(ShapeId)\pt(v)\y ;- y1  ;+ Obj(ObjId)\y
                
              EndIf
            EndIf
            
          Case #VD_actionDelPt
            Vd_DeletePoint(ip)
            
          Default
            
        EndSelect
        Break
      EndIf
    Next
    
    If ok = 0 ; on n'a pas cliqué sur un point, on vérifie pour les images ou les textes si on a cliqué dessus
      
      If  vdOptions\Action = #VD_actionMove 
        
        ;                         If OldShapeId <> ShapeID
        ;                           ; Debug Str(OldShapeId)+"/"+Str(ShapeID)
        ;                           ShapeGetProperties()
        ;                           OldShapeId = ShapeID
        ;                         EndIf
        
        ; Debug "start move "+Str(Obj(ObjId)\Shape(ShapeId)\x)+"/"+Str(Obj(ObjId)\Shape(ShapeId)\y)
        If Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeImage Or Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeText
          Vd\move = 2 
          Obj(ObjId)\Shape(ShapeId)\startY = y - Obj(ObjId)\Shape(ShapeId)\Y ;+ Obj(ObjId)\x                                                              
          Obj(ObjId)\Shape(ShapeId)\startX = x - Obj(ObjId)\Shape(ShapeId)\X ;+ Obj(ObjId)\y
        EndIf
        
      EndIf
      
    EndIf
    
  EndIf
    
  ; EndWith
  
  
  
EndMacro

Procedure VD_Addpoint(Mode=0)
  ; mode = 0 : add point at middle of selected points
  ; mode = 1 : at point at mouse coordinates
  If shapeId >-1
    
    If mode = 0
      
      With obj(objID)\Shape(SHapeId)
        For i=0 To ArraySize(\pt())
          If \pt(i)\Selected And \pt(i)\Center
            ;             Debug "ok point 1"
            If i<ArraySize(\pt())-2
              If \pt(i+3)\Selected And \pt(i+3)\Center
                ; Debug "ok point 2"=Str(i)+"/"+Str(i+3)
                ; ok, we have two points selected
                okpointselected = 1
                If StartVectorDrawing(CanvasVectorOutput(#G_canvasVector))
                  MovePathCursor(\pt(i)\x,\pt(i)\y)
                  AddPathCurve(\pt(i)\x,\pt(i)\y,\pt(i+1)\x,\pt(i+1)\y,\pt(i+2)\x,\pt(i+3)\y)
                  m = PathLength()/2
                  x = PathPointX(m)
                  y = PathPointY(m)
                  
                  ; create the new point
                  newid = i+2
                  n = newid +1
                  InsertArrayElement(\pt,newid)
                  InsertArrayElement(\pt,newid)
                  InsertArrayElement(\pt,newid)
                  ; then change position of points
                  
                  ; puis je crée les points en n-1, n (point centre) et n+1
                  \pt(n)\x = x
                  \pt(n)\y = y
                  \pt(n)\Center = 1
                  PtId = n
                  ; et les ancres
                  \pt(n-1)\x =  \pt(n)\x-1
                  \pt(n-1)\y =  \pt(n)\y-1  
                  \pt(n+1)\x = x + 1
                  \pt(n+1)\y = y + 1
                  StopVectorDrawing()
                EndIf
                DrawCanvas()
                Break
              Else
                ;Debug "pas ok point 2 "+Str(i) +"/"+Str(i+3) 
              EndIf
            Else
            EndIf
          Else
             ;Debug "pas ok point 1 "+Str(i)
          EndIf
        Next
      EndWith
      
      If okpointselected = 0
        If Vd\EditMode <> #VD_Editmode_Point
          info$ = " You have To be in editMode 'point edition' To Select points."
        EndIf
        
        MessageRequester(LAng("Info"), lang("You need at least 2 points selected."+info$))
      EndIf
      

    ElseIf mode = 1
      
    EndIf
    ; ensuite, je dois véirfier les broken point (pour les différentes parties du shapes
    Shape_CheckBrokenPoint()
  EndIf
  
EndProcedure
;}


; Create
Procedure.s Shape_CreateIdUnik()
  
  t$ ="ABCDEFGHIJKLMNOPQRSTUVWXYabcdefghijklmnopqrstuvwxz12345678908@çà%.§$)&(-_=+*"
  For i= 0 To 12
    tt$+Mid(t$,1+Random(Len(t$)),1)
  Next
  
  idunik$ = tt$; +FormatDate("%yyyy%mm%dd%hh%ii%ss", Date())
  
  ProcedureReturn idunik$
EndProcedure


; Add a shape
Procedure AddPathRoundBox(x, y, w, h, r)
    ;by diskay
    MovePathCursor(x+w/2, y)
    AddPathArc(x+w, y, x+w, y+h, r)
    AddPathArc(x+w, y+h, x, y+h-0.0000000001, r)
    ;AddPathArc(x+w, y+h, x, y+h, r) Fail,Why?
    AddPathArc(x, y+h, x, y, r)
    AddPathArc(x, y, x+w, y, r)
    AddPathLine(x+w/2, y)
EndProcedure
Procedure Shape_Add(x,y)
  
  ; pour ajouter un shape (une forme) sur le calque courant (appelé "objet")
  ok = 1
  PtId = 0
  
  If vdOptions\Action = #VD_actionAddShape
    ;{ add complex or saved shape
    ; Debug "ok shape complex"
    
    If Obj(ObjId)\Actif = 0            
      ShapeID= 0
      n = 0
      Obj(ObjId)\Shape(0)\Nom$ = ""
    Else
      n = ArraySize(Obj(ObjId)\Shape())+1
      ReDim Obj(ObjId)\Shape(n)
      ShapeId = n  
      Obj(ObjId)\Shape(n)\Nom$ = ""
    EndIf
    
    Doc_New(2,0,0,x,y) ;<-- !!!! pas de draw, sinon, ça plante, car il faudrait fermer le startdrawing du canvas ;) 
    Vd\NbShape = 1
    
    ShapeId = ArraySize(Obj(ObjId)\Shape())
    Obj(ObjId)\Actif = 1
    
    
    ;         For i = n To ArraySize(Obj(ObjId)\Shape())            
    ;             Obj(ObjId)\Shape(i)\X = x
    ;             Obj(ObjId)\Shape(i)\y = y
    ;         Next 
    ;}
    
  Else
    
    ;{ On créé un autre type d'objet
    
    ; Set the name of the Shape
    Select vdOptions\Action
        
      Case #VD_actionAddBox            
        nom$ ="Box_"
        
      Case #VD_actionAddBoxRnd                
        nom$ ="RoundBox_"
        
      Case #VD_actionAddCircle
        nom$ ="Circle_"
        
      Case #VD_actionAddShape
        nom$ ="Shape_"
        
      Case #VD_actionAddCurve
        nom$ ="Curve_"
        
      Case #VD_actionAddLine
        nom$ ="Line_"
        
      Case #VD_actionAddImage                
        file$ = OpenFileRequester("Image","","Png(.png)|*.png|Jpg|*.jpg",0)
        If file$ = ""
          ok =0
        Else
          img = LoadImage(#PB_Any, file$)
          If img = 0
            MessageRequester("Error","Unable to load the image "+file$)                
            ok = 0
          Else
            Nom$ = GetFilePart(file$)
            ext$ = "."+GetExtensionPart(file$)
            Nom$ = RemoveString(Nom$,ext$)
          EndIf                
        EndIf
        
      Case #VD_actionAddText
        nom$="Text_"
        
    EndSelect
    
    ; add the object
    If ok = 1
      
      If VD\CreateObj = 1 And old = 1 
        ;{ ce n'est plus utilisé, je garde au cas où ?
        ; on crée un nouvel Shape, on doit donc ajouter un Shape au tableau des Shape
        ; on crée le shape sur le calque (ou objet), si on n'a pas encore de créer de shape, le tableau est à 0, donc on doit utiliser le 1er objet.
        ; sinon, on peut créer un autre objet.
        If vd\NbShape >0
          n = ArraySize(Obj())+1  
          ReDim Obj.sObj(n)
          m = 0
        Else
          n = ArraySize(Obj())  
          ReDim Obj.sObj(n)
          m = 0
        EndIf
        ;}
      Else 
        ;{ on crée un nouveau shape dans l'objet courrant,
        ; on ajoute un shape dans le tableau des shape de cet objet

        ; si l'objet n'est pas encore actif (il n'a pas encorede shape), on utilise le shape 0
        If Obj(ObjId)\Actif = 0
          Obj(ObjId)\Actif = 1
          n = ObjId        
          m = ArraySize(Obj(n)\Shape())
          ReDim Obj(n)\Shape.sShape(m) 
          Obj(n)\Shape(m)\Nom$ = ""
        Else
          ; sinon, on crée un nouveau shape.
          ; If Obj(ObjId)\Actif = 1; vd\NbShape >0
          n = ObjId        
          m = ArraySize(Obj(n)\Shape())+1
          ReDim Obj(n)\Shape.sShape(m) 
          Obj(n)\Shape(m)\Nom$ = ""
        EndIf        
        ;}
      EndIf
      
      x = x - obj(objid)\x
      y = y - obj(objid)\y
      
      ; on crée le shape
      vd\NbShape =1
      ObjId = n    
      ShapeId = m
      
      ; on va initiliaser ses points
      ReDim Obj(n)\Shape(m)\pt.sPoint(0)
      ; on définit certains paramètre par défaut (dimension et taille du remplissage (si ligne))
      Obj(n)\Shape(m)\w = vdoptions\ToolOptions\Width
      Obj(n)\Shape(m)\h = 5
      Obj(n)\Shape(m)\d = 5
      ; add the idunik
      Obj(n)\Shape(m)\idUnik$ = Shape_CreateIdUnik()
      
      If vdOptions\Action = #VD_actionAddLine 
        ReDim Obj(n)\Shape(m)\pt.sPoint(0)
        Obj(n)\Shape(m)\pt(0)\x = x 
        Obj(n)\Shape(m)\pt(0)\y = y 
        Obj(n)\Shape(m)\pt(0)\Center = 1
        Obj(n)\Shape(m)\Typ = 1
      ElseIf vdOptions\Action = #VD_actionAddCurve
        ReDim Obj(n)\Shape(m)\pt.sPoint(2)
        For i = 0 To 2                
          Obj(n)\Shape(m)\pt(i)\x = x+i*5-10 
          Obj(n)\Shape(m)\pt(i)\y = y+i*5-10
        Next
        PtId = 1
        ; Obj(n)\Shape(m)\pt(1)\Center = 1
        Obj(n)\Shape(m)\Typ = 1
      EndIf
      
      ; puis, on définit les autres paramètres du shapes
      With Obj(n) 
        \Actif = 1
        \Shape(m)\open = vdoptions\ToolOptions\Open
        \Shape(m)\StartX = x
        \Shape(m)\StartY = y
        \Shape(m)\Typ = vdoptions\ToolOptions\Style
        \Shape(m)\Rnd   = 20
        \Shape(m)\depth = (m+1)*20
        \Shape(m)\pos = (m+1)*20
        \Shape(m)\SizeW = 5
        \Shape(m)\SizeH = 5              
        \Shape(m)\Nom$ = nom$+Str(m)
        \Shape(m)\Alpha = vdoptions\ToolOptions\Alpha
        \Shape(m)\Color = vdoptions\ToolOptions\Color; RGBA(220,220,120,255)
        c = vdoptions\ToolOptions\Color
        \Shape(m)\ColGrad(0) = RGBA(Red(c),Green(c),Blue(c),vdoptions\ToolOptions\Alpha)
        \Shape(m)\pt(0)\x = x
        \Shape(m)\pt(0)\y = y
        \Shape(m)\pt(0)\MaxPt = ArraySize(\Shape(m)\pt())
        \Shape(m)\pt(0)\broken = 1
        \Shape(m)\ShapTyp = vdOptions\Action - #VD_actionAddShape
        \Shape(m)\Selected = 1
        
        Select vdOptions\Action 
            
          Case #VD_actionAddText
            \Shape(m)\SizeW = 40
            \Shape(m)\text$ = nom$+Str(m)
            \shape(m)\FontName$ = "Times New roman"
            \shape(m)\FontStyle = #PB_Font_Bold
            \Shape(m)\Font = LoadFont(#PB_Any, \shape(m)\FontName$,20, \shape(m)\FontStyle) 
            \Shape(m)\x = x
            \Shape(m)\y = y
            \Shape(m)\pt(0)\x = 0
            \Shape(m)\pt(0)\y = 0
            
          Case #VD_actionAddBox,#VD_actionAddBoxRnd,#VD_actionAddCircle
            \Shape(m)\x = x
            \Shape(m)\y = y
            \Shape(m)\pt(0)\x = 0
            \Shape(m)\pt(0)\y = 0
        EndSelect
        
        If img <> 0 And vdOptions\Action = #VD_actionAddImage
          \Shape(m)\Img = img
          \Shape(m)\SizeW = ImageWidth(img)
          \Shape(m)\ImgW = ImageWidth(img)
          \Shape(m)\ImgH = ImageHeight(img)
          
          ;\Shape(m)\W =  \Shape(m)\SizeW
          \Shape(m)\SizeH = ImageHeight(img)
          ;\Shape(m)\H =  \Shape(m)\SizeH
          \Shape(m)\Filename$ = File$
          \Shape(m)\x = x
          \Shape(m)\y = y
          \Shape(m)\pt(0)\x = 0
          \Shape(m)\pt(0)\y = 0
        EndIf
        
        ShapeAddFx()
        
        VD_Layer_UpdateUI()
        If VD\CreateObj = 0
          UpdateListShape()
        EndIf
        
      EndWith
      
    EndIf
    ;}
    
  EndIf
  
  ProcedureReturn  ok 
EndProcedure


; Edit 
Procedure Shape_SelectAll(Selection=1) 
    
  For j =0 To  ArraySize(Obj(ObjId)\Shape())
    With Obj(ObjId)\Shape(j)
      If \Hide = 0
        If vd\EditMode <>#VD_Editmode_Point
          \selected = Selection
          If shapeID=-1
            shapeid = j
          EndIf
          
        EndIf
      EndIf
      
      If selection = 0
        For ip=0 To ArraySize(\pt())  
          \pt(ip)\Selected = 0
        Next
      Else
        If \Hide = 0
          If vd\EditMode <>#VD_Editmode_Point
            Select vdOptions\Action 
              Case #VD_actionMove
                \startY = y - \Y                                                               
                \startX = x - \X
              Case #VD_actionScale
                \startX = x -\SizeW
                \startY = y +\SizeH
            EndSelect
          Else
            For ip=0 To ArraySize(\pt())  
              \pt(ip)\Selected = 1
            Next
          EndIf
        EndIf
      EndIf
    EndWith
  Next
  
  If selection = 0
    If vd\EditMode <>#VD_Editmode_Point
      shapeID = -1
    EndIf
    PtId = -1
    VD\Shift = 0
  Else
    VD\Shift = 1
  EndIf
        
EndProcedure        
Procedure Shape_Delete()
  ; pour supprimer the selected shape
  
  Debug ObjId
  
  If Layer_CheckifOk(ObjId) = 1 And  Obj(ObjId)\Actif > 0 
    If Vd\EditMode = #VD_Editmode_Point
      Vd_DeletePoint(ptid)
    Else
      For i=0 To ArraySize(obj(ObjId)\Shape())
        If( Obj(ObjId)\Shape(i)\Selected Or shapeID = i) And Obj(ObjId)\Shape(i)\hide = 0 And Obj(ObjId)\Shape(i)\Locked = 0
          If i > -1
            If ArraySize(Obj(ObjId)\Shape()) >0 
              shapeid = i
              DeleteArrayElement(Obj(ObjId)\Shape,shapeId)
              ShapeId = -1                          
            Else 
              ;shapeId = i
              ;DeleteArrayElement(Obj(ObjId)\Shape,shapeId)
              ShapeId = -1
              If ArraySize(Obj()) = 0
                vd\NbShape = -1
              EndIf
              Dim Obj(ObjId)\Shape.sShape(0)
              Obj(ObjId)\Actif = 0
              Break
            EndIf
            i-1
          EndIf
        EndIf
      Next
    
    EndIf
  EndIf
  
 
  
  ;If ArraySize(Obj(ObjId)\Shape()) >=0 And Obj(ObjId)\Actif <> 0
    ShapeGetProperties()  
    UpdateListShape()
    Drawcanvas()
 ; EndIf

EndProcedure
Procedure VD_Shape_ChangeImage()
  ; pour changer l'image du shape-image
  If ShapeId>-1 And shapeid <=ArraySize(Obj(ObjId)\Shape())
    
    file$ = OpenFileRequester("Change Image","","Png(.png)|*.png|Jpg|*.jpg|Bmp|*.bmp",0)
    
    If file$ <> ""            
      img = LoadImage(#PB_Any, file$)
      If img = 0
        MessageRequester("Error","Unable to load the image "+file$)               
      Else
        With Obj(ObjId)
          
          FreeImage2( \Shape(m)\Img)                     
          
          Nom$ = GetFilePart(file$)
          ext$ = "."+GetExtensionPart(file$)
          \Shape(m)\Nom$ = RemoveString(Nom$,ext$)
          
          m =ShapeId
          \Shape(m)\Img = img
          \Shape(m)\SizeW = ImageWidth(img)
          \Shape(m)\ImgW = ImageWidth(img)
          \Shape(m)\ImgH = ImageHeight(img)
          \Shape(m)\SizeH = ImageHeight(img)
          \Shape(m)\Filename$ = File$
        EndWith
        DrawCanvas()
      EndIf                
    EndIf
    
  EndIf
    
EndProcedure
Procedure GetShapeStartTransformation(action=0,x=0,y=0)
  
  If action= 0 ; scale
    Vd\move = 2  
    For ki = 0 To ArraySize(Obj(ObjId)\Shape())
      
      With Obj(ObjId)\Shape(ki)
        
        If \Selected = 1 Or ki = ShapeId 
          ; Debug "ok scale on garde start"
          
          ; we should keep the start point for each point of the curve/line
          For k = 0 To ArraySize(\pt())
            \pt(k)\startX = \pt(k)\x
            \pt(k)\startY = \pt(k)\y                                               
          Next 
          
          ; keep the "start" position and size, for each shape()
          \startX = \X 
          \startY = \y 
          \startW = \SizeW
          \startH = \SizeH
          ;                \sx= \x
          ;                \sy= \y
          ;                \sw = \w
          ;                \sh = \h
          
          ;           Select \ShapTyp
          ;             Case #VD_ShapeCurve, #VD_ShapeLine
          ;               ; we should keep the start point for each point of the curve/line
          ;               For k=0 To ArraySize(\pt())
          ;                 \pt(k)\startX = \pt(k)\x 
          ;                 \pt(k)\startY = \pt(k)\y 
          ;               Next
          ;           EndSelect
          
        EndIf
        
      EndWith
      
    Next
                
  ElseIf action = 1 ; rotation
    
    ; Debug "GetShapeStartTransformation" 
    Vd\move = 2  
    For ki = 0 To ArraySize(Obj(ObjId)\Shape())
      
      With Obj(ObjId)\Shape(ki)
        
        If ki = ShapeId Or \Selected = 1
           
          \StartRot = x - \Rot
          ; \StartRot = x  ; + \Rot
          ;           For k = 0 To ArraySize(\pt())
          ;            Debug "point "+Str(k)+" : "+Str( \pt(k)\x )+"/"+Str( \pt(k)\y )      
          ;           Next 
          
          For k = 0 To ArraySize(\pt())
            \pt(k)\startRotX = \pt(k)\x 
            \pt(k)\startRotY = \pt(k)\y                                           
          Next  
          
        EndIf 
        
      EndWith
      
    Next
  EndIf
  
EndProcedure
Procedure Shape_SetAngle(Rot)
  
  For i=0 To ArraySize(obj(objId)\Shape())
    
;     If rot >0
;       Rot = 0.01
;     Else
;       Rot = -0.01
;     EndIf
    ; rot = rot*0.01
    
    With obj(objId)\Shape(i)
      Cos.f = Cos(Radian(rot))
      Sin.f = Sin(Radian(rot))
      
      ; on garde les coordonnées du premier point
      x1 = \CurX + \Cx
      y1 = \CurY + \Cy
     ; Debug "depart rot : "+x1+"/"+y1
      
      For k = 0 To ArraySize(\pt()) 
        
       ; \pt(k)\x = \pt(k)\x*Cos - \pt(k)\y*Sin + x1 
       ; \pt(k)\y = \pt(k)\x*Sin + \pt(k)\y*Cos + y1
        
;          \pt(k)\startX =  \pt(k)\x
;          \pt(k)\startY =  \pt(k)\y
;          
;         ;X*Cos-Y*Sin, X*Sin+Y*Cos,
        Xx = \pt(k)\startX -x1                                         
        Yy = \pt(k)\startY -y1
        
        \pt(k)\x = Xx*Cos - Yy*Sin + x1 
        \pt(k)\y = Xx*Sin + Yy*Cos + y1
      Next 
    EndWith
  Next
  
  Drawcanvas() 
  
EndProcedure


; Convert
Procedure VD_ConvertShape(to_Pt=1, typ=0)
  ; typ = 0 convert to shapecomplex (=curve)
  ; typ = 1 convert to line
  ; typ = 2 convert to curve
  
  ; pour convertir un shape vers des points ou vers une forme prédéfinies (elipse, rectangle...)
  If shapeId > -1
    
    With obj(ObjId)\Shape(ShapeId)
      ok =1
      If typ = 1 ; to line
        If \shaptyp <> #VD_ShapeBox
          MessageRequester(lang("Info"), lang("For the moment, You can only convert box to line"))
          ok = 0
        EndIf
        
      ElseIf typ = 0 ; to shape complexe.
        
      ElseIf typ = 2 ; to curve
        
      EndIf
      
      If ok = 1
        
        If To_Pt =1 ; convert ellipse to curve or box to line
          
          Select \ShapTyp
              
            Case #VD_ShapeLine
              If typ<> 1
                \ShapTyp = #VD_ShapeCurve
                n = ArraySize(\pt()) * 3 +2
                Dim TempPt.sPoint(0)
                CopyArray(\pt(), TempPt())
                ReDim \pt.sPoint(n)
                VD_ResetAllPoints()
                For k=0 To ArraySize(\pt()) Step 3
                  u = k/3
                  \pt(k) = TempPt(u)
                  \pt(k+1) = TempPt(u)
                  If k >0
                    \pt(k-1) = TempPt(u)
                  ElseIf k >= ArraySize(\pt())-2
                    ; if last point, we set it to TemPt(u)
                     \pt(k) = TempPt(u)
                  EndIf
                Next
                FreeArray(TempPt())
              EndIf
              
            Case #VD_ShapeCircle 
              ;{ 
              \ShapTyp = #VD_ShapeCurve
              ReDim \pt.sPoint(5)
              \pt(0)\x = 0
              \pt(0)\y = -\SizeH 
              \pt(1)\x = -1.325* \SizeW
              \pt(1)\y = -\SizeH 
              \pt(2)\x = -1.325* \SizeW
              \pt(2)\y = \SizeH
              
              \pt(3)\x = 0
              \pt(3)\y = \SizeH                          
              \pt(4)\x = 1.325* \SizeW
              \pt(4)\y = \SizeH
              \pt(5)\x = 1.325* \SizeW
              \pt(5)\y = -\SizeH 
              ;}
              
            Case #VD_ShapeBox
              ;{ 
              If typ = 1
                \ShapTyp = #VD_ShapeLine
                ReDim \pt.sPoint(3)
                \pt(0)\x = 0
                \pt(0)\y = 0
                \pt(1)\x = \SizeW 
                \pt(1)\y = 0
                \pt(2)\x = \SizeW 
                \pt(2)\y = \SizeH
                \pt(3)\x = 0 
                \pt(3)\y = \SizeH
              Else
                \ShapTyp = #VD_ShapeCurve
                ReDim \pt.sPoint(11)
                ; reset all point
                VD_ResetAllPoints()
                
                \pt(0)\x = 0
                \pt(0)\y = 0
                \pt(0)\Center = 1
                \pt(3)\x = \SizeW 
                \pt(3)\y = 0
                \pt(3)\Center = 1
                \pt(6)\x = \SizeW ; \pt(6)\x
                \pt(6)\y = \SizeH
                \pt(6)\Center = 1
                \pt(9)\x = 0 ; \pt(9)\x
                \pt(9)\y = \SizeH
                \pt(9)\Center = 1
                
                ; puis, je mets tous les points en hard
                PtId = 0 : Vd_SetPoint(0,0)
                PtId = 3 : Vd_SetPoint(0,0) 
                PtId = 6 : Vd_SetPoint(0,0)
                PtId = 9 : Vd_SetPoint(0,0)
              EndIf
              ;}
              
          EndSelect
          
        Else
          
        EndIf
        
      EndIf
    EndWith
    
    Shape_CheckBrokenPoint()
    
  EndIf
  
  Drawcanvas()
EndProcedure
Procedure VD_ShapeMerge()
  
  ; to add shapes to another shape
  ; it merge all points for the selected shape to the current Shape (shapeID)
  
  If shapeID>-1
    For i= 0 To ArraySize(obj(ObjId)\Shape())
      If i<> shapeId 
        If obj(objid)\Shape(i)\Selected
          
          With obj(objid)\Shape(shapeId)
            
            ; on vérifie le nombre max de point pour la Première partie (donc le pt 0)
            ; si c'est la première fois qu'on merge, on va ajouter le nombre de point du tableau avant le merge
            ; car on en aura besoin
            If \pt(0)\broken = 0
              \pt(0)\broken = 1
              \pt(0)\MaxPt = ArraySize(\pt())
            EndIf
            n0 = ArraySize(\pt())
            
            ; on ajoute le nombre de point du shape qu'on merge
            ; ça c'est le prochain point "broken", pour le movepathcursor
            n1 = ArraySize(\pt())+1
            ; ça c'est le nouveau nombre de point de ce shape (on merge 2 shape, donc additionne le nb de point de chacun +1)
            n2 = ArraySize(\pt())+1+ArraySize(obj(objid)\Shape(i)\pt())
            ReDim obj(objid)\Shape(shapeId)\pt(n2)
            
            ; on ajoute le point "broken", pour savoir où on va mettre le "movepathcursor"
            \pt(n1)\broken = 1
            \pt(n1)\x = obj(objid)\Shape(i)\X - obj(objid)\Shape(shapeID)\X
            \pt(n1)\y = obj(objid)\Shape(i)\y - obj(objid)\Shape(shapeID)\Y
            ; on doit aussi indiqué le nouveau nombre de points du tableau (car ce sera pour la prochaine "partie"
            ; si on merge encore un autre shape
            \pt(n1)\MaxPt = n2
            
            ; puis on ajoute les points
            For k=0 To ArraySize(obj(objid)\Shape(i)\pt())
              ; on modifie certains paramètres des point qu'on ajouté.
              n = n1+k
              \pt(n) = obj(objid)\Shape(i)\pt(k)
              ;\pt(n)\center = 0
              \pt(n)\x = obj(objid)\Shape(i)\pt(k)\x + obj(objid)\Shape(i)\X - obj(objid)\Shape(shapeID)\X
              \pt(n)\y = obj(objid)\Shape(i)\pt(k)\y + obj(objid)\Shape(i)\y - obj(objid)\Shape(shapeID)\y
            Next
            
            
;             For k=0 To ArraySize(obj(objid)\Shape(i)\pt()) Step 3
;               ; on definit les centres
;               n = n1+k
;               \pt(n)\Center = 1
;             Next
            
            ; puis, je vérifie les points par partie
            Shape_CheckBrokenPoint()
            
          EndWith
        EndIf
      EndIf
    Next
  EndIf
  
   ; update
  ShapeGetProperties()
  DrawCanvas()
  
  
EndProcedure



; origin
Procedure Shape_SetOrigin(Mode=0,x=0,y=0,update=1)
  
  If Layer_CheckIfOk(ObjId) =1
    
    If mode=0
      ; set shape to origin
      For i=0 To ArraySize(obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(i) 
          If i = shapeId Or \Selected =1 
            For j= 1 To ArraySize(\pt())
              \pt(j)\x - \pt(0)\x
              \pt(j)\y - \pt(0)\y
            Next 
            \pt(0)\x = 0
            \pt(0)\y = 0
          EndWith                           
        EndIf
      Next 
      
    ElseIf mode =1
      ; set origin to shape
      For i=0 To ArraySize(obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(i) 
          If i = shapeId Or \Selected =1 
            x6 = \pt(0)\x
            y6 = \pt(0)\y
            For j= 0 To ArraySize(\pt())
              \pt(j)\x - x6
              \pt(j)\y - y6
            Next                                
            \x + x6
            \y + y6                           
          EndWith                          
        EndIf
      Next 
  
    ElseIf mode = 2
      ; set origin to mouse
      For i=0 To ArraySize(obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(i) 
          If i = shapeId Or \Selected =1 
            For j= 0 To ArraySize(\pt())
              \pt(j)\x -x + \x 
              \pt(j)\y -y + \y
            Next                                
            \x = x
            \y = y
            \cx = 0
            \cy = 0
          EndWith                          
        EndIf
      Next 
      
    ElseIf mode = 3
      ; set origin to center
      
    EndIf
    If update=1
      Drawcanvas()
    EndIf
    
  EndIf
  
EndProcedure

; Save, load
Procedure Shape_Save(file$ = #Empty$,autosave=0, selection=0)
    
    ; pour sauvegarder le document
    d$ = ","
    e$ = ";"
    
    If file$ = #Empty$
      If VdOptions\PathSave$ =#Empty$
        VdOptions\PathSave$ = GetCurrentDirectory()+"save\"
      EndIf
        file$ = SaveFileRequester(lang("Save"), VdOptions\PathSave$,"txt|*.txt|fca|*.fca*",0)
    EndIf
    
    If file$ <> #Empty$
        
        If autosave = 0
          Vd\DocFilename$ = file$
          VdOptions\PathSave$ = GetPathPart(file$)
        EndIf
        
        file$ = RemoveString(file$,".txt")+".txt"
        
        If CreateFile(0,file$)
            
            txt$= "gen,"+" "+d$+StrD(ValD(#ProgramVersionVD),4)+d$+FormatDate("%yyyy%mm%dd%hh%ii%ss", Date())+d$
            WriteStringN(0,txt$)
            
            ; camera
            txt$ = VD_GetCameratext(CameraId)
            WriteStringN(0,txt$)
          
            For m=0 To ArraySize(Obj())
              
              If selection =0 Or m=ObjId
                With Obj(m)
                  
                  txt$= "obj,"+\Nom$+d$+\x+d$+\y+d$+\w+d$+\h+d$+\Depth+d$+\Hide+d$+\Locked+d$+\Alpha+d$+\Bm+d$                
                  txt$ +\Clip+d$+\ClipW+d$+\ClipH+d$+\ClipHide+d$+\ClipColor+d$+\ClipAlpha+d$
                  txt$ +\ClipBorder+d$+\ClipBorderAlpha+d$+\ClipBorderColor+d$+\ClipBorderStroke+d$          
                  WriteStringN(0,txt$)
                  
                  For j =0 To ArraySize(\Shape())
                    If selection =0 Or j=shapeId Or \shape(j)\Selected = 1
                      ; on sauve le shape (paramètres généraux
                      txt$= "shape,"+Str(j)+d$+\Shape(j)\Color+d$+\Shape(j)\Nom$+d$+Str(\Shape(j)\Alpha)+d$
                      txt$ +Str(\Shape(j)\Typ)+d$+Str(\Shape(j)\w)+d$+Str(\Shape(j)\h)+d$+Str(\Shape(j)\d)+d$ 
                      txt$ +Str(\shape(j)\ShapTyp)+d$+Str(\shape(j)\SizeW)+d$+Str(\shape(j)\SizeH)+d$
                      
                      Select \shape(j)\ShapTyp 
                        Case #VD_ShapeText
                          txt$ +ReplaceString(\shape(j)\Text$,",","{-virg-}")+e$+\shape(j)\FontName$+e$+\shape(j)\FontStyle+e$
                          
                        Case #VD_ShapeImage
                          txt$ +\Shape(j)\Filename$+e$+\shape(j)\ImgRepeat+e$+\shape(j)\ImgX+e$+
                                \shape(j)\ImgY+e$+\shape(j)\ImgW+e$+\shape(j)\ImgH+e$+\shape(j)\ImgRot+e$
                          
                      EndSelect
                      txt$ + d$
                      txt$ +Str(\Shape(j)\X)+d$+Str(\Shape(j)\Y)+d$
                      txt$ +Str(\Shape(j)\open)+d$+\Shape(j)\idUnik$+d$+Str(\Shape(j)\Depth)+d$+Str(\Shape(j)\Pos)+d$+\Shape(j)\Parent\idUnik$+d$
                      
                      WriteStringN(0,txt$)
                      
                      ; puis, on sauve les fx
                      For k=0 To ArraySize(\Shape(j)\Fx())
                        txt$ = "shapefx,"+k+d$+\Shape(j)\Fx(k)\X+d$+\Shape(j)\Fx(k)\y+d$
                        txt$ + \Shape(j)\Fx(k)\Color+d$+\Shape(j)\Fx(k)\Alpha+d$+\Shape(j)\Fx(k)\Depth+d$
                        txt$ + \Shape(j)\Fx(k)\Style+d$+\Shape(j)\Fx(k)\w    +d$+\Shape(j)\Fx(k)\h    +d$+\Shape(j)\Fx(k)\Dist+d$
                        txt$ + \Shape(j)\Fx(k)\Scale+d$+\Shape(j)\Fx(k)\SizeW+d$+\Shape(j)\Fx(k)\SizeH+d$+\Shape(j)\Fx(k)\Actif
                        WriteStringN(0,txt$)
                      Next
                      
                      ; puis, on sauve les points
                      For i = 0 To ArraySize(\Shape(j)\pt())
                        txt$ = "pt,"+Str(i)+d$+Str(\Shape(j)\pt(i)\x)+d$+Str(\Shape(j)\pt(i)\y)+d$
                        txt$+Str(\Shape(j)\pt(i)\broken)+d$+Str(\Shape(j)\pt(i)\MaxPt)+d$+Str(\Shape(j)\pt(i)\center)+d$+Str(\Shape(j)\pt(i)\hide)+d$
                        WriteStringN(0,txt$)
                      Next
                    EndIf
                  Next 
                  
                EndWith
              EndIf
              
            Next
            
            CloseFile(0)
            
        EndIf
        
        If autosave=0
          SetWindowTitle(#Win_VD_main,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD+" - "+GetFilePart(file$))
          ; on sauvegarde un preview du fichier (en 64x64)
          path$ = GetPathPart(file$)
          file$ = GetFilePart(file$,#PB_FileSystem_NoExtension)+".png"
          Scene_Export(0,1, path$+file$)
        EndIf
        
    EndIf
    
EndProcedure
Procedure Shape_Load(merge=0, file$ ="",draw=1)
  Shared posX, posY, openmenu
  
  ; pour ouvrir un shape
  If file$ = ""
    If VdOptions\PathOpen$ =#Empty$
      VdOptions\PathOpen$ = GetCurrentDirectory()
    EndIf
    file1$ = VdOptions\PathOpen$
    ; Debug file1$
    file$ = OpenFileRequester(lang("Open"),file1$,"txt|*.txt",0)
  EndIf
  
  If file$ <> #Empty$
    
    ext$ = GetExtensionPart(file$)
    
    If ext$ <> "txt" And ext$ <> "fca"
      MessageRequester(lang("infos"), lang("The file should be compatible with this software. Extension should be .txt or .cfa. Extension is : ")+ext$)
      ProcedureReturn 0
    Else
      
      If ReadFile(10,file$)
        
        ; Debug"openfile shape : "+file$
        Vd\DocFilename$ = file$
        
        If merge = 0 ; on ne merge pas, on efface donc tout
          ReDim Obj.sObj(0)
          k = 0
          Doc_New(1,1)
        Else ; on merge, on garde nos objets
          k = ArraySize(Obj()) 
          nbObj = k
          ReDim Obj.sObj(k)
        EndIf
        ; Debug "1-arraysize : "+Str(ArraySize(Obj()) )
        While Eof(10) = 0
          
          line$ = ReadString(10)
          index$ = StringField(line$,1,",")
          
          Select index$
              
            Case "gen"
              Nom$ = StringField(line$,2,",")
              If merge = 0
                ReDim Obj(ObjId)\Shape.sShape(0)
              Else
                nbShape = ArraySize(Obj(ObjId)\Shape())+1
                ReDim Obj(ObjId)\Shape.sShape(NbShape)
              EndIf
              Version.d = ValD(StringField(line$,3,","))
              ; Debug ""+ValD(#ProgramVersionVD)
              If version < 0.14
                If Obj(ObjId)\nom$ ="" 
                  If nom$ <> ""
                    Obj(ObjId)\nom$ =nom$
                  Else
                    Obj(ObjId)\nom$ ="Object"+Str(k)
                  EndIf                                
                EndIf
                If Obj(ObjId)\h <= 0
                  Obj(ObjId)\h = 100
                EndIf
                If Obj(ObjId)\w <= 0
                  Obj(ObjId)\w = 100
                EndIf
                
                If merge = 0
                  Obj(ObjId)\h = 100
                  Obj(ObjId)\w = 100 
                EndIf
              EndIf
              
            Case "camera"
              NBcamera = -1
              Global Dim VD_camera.sVDCamera(0)
              ; 
              u = 2
              ID    = Val(StringField(line$,u,",")) : u+1
              name$    = StringField(line$,u,",") : u+1
              VdOptions\CameraX   = Val(StringField(line$,u,",")) : u+1
              VdOptions\CameraY   = Val(StringField(line$,u,",")) : u+1
              VdOptions\CameraW   = Val(StringField(line$,u,",")) : u+1
              VdOptions\CameraH   = Val(StringField(line$,u,",")) : u+1
              scale   = Val(StringField(line$,u,",")) : u+1
              zoom.d   = ValD(StringField(line$,u,",")) : u+1
              optionoutput   = Val(StringField(line$,u,",")) : u+1
              crop.Srectangle
              crop\x   = Val(StringField(line$,u,",")) : u+1
              crop\y   = Val(StringField(line$,u,",")) : u+1
              crop\w   = Val(StringField(line$,u,",")) : u+1
              crop\h   = Val(StringField(line$,u,",")) : u+1
              VD_CameraAdd(name$,VdOptions\CameraX,VdOptions\CameraY,VdOptions\CameraW,VdOptions\CameraH,scale,zoom)
                
              
            Case "obj"
              If Vd\NbShape >=1 And merge <> 2 And nbObj >-1 ; Obj(ObjId)\Actif = 0
                k = ArraySize(Obj())+1 
                NbObj = k
              Else
                k = ArraySize(Obj())
                Vd\NbShape = 1
              EndIf
              ; Debug "2-arraysize : "+Str(ArraySize(Obj()) )
              If merge <> 2 ; on load un shape dans l'objet courant
                nbObj +1
                ReDim Obj.sobj(k)
                ObjId = k
                Nom$ = StringField(line$,2,",")
                If Obj(k)\nom$ ="" Or Obj(k)\nom$ ="Object"+Str(k)
                  If nom$ <> ""
                    Obj(k)\nom$ =nom$
                  Else
                    Obj(k)\nom$ ="Object"+Str(k)
                  EndIf                                
                EndIf
                u = 3
                Obj(k)\x    = Val(StringField(line$,u,",")) : u+1
                Obj(k)\y    = Val(StringField(line$,u,",")) : u+1
                Obj(k)\w    = Val(StringField(line$,u,",")) : u+1
                Obj(k)\h    = Val(StringField(line$,u,",")) : u+1
                Obj(k)\Depth= Val(StringField(line$,u,",")) : u+1
                Obj(k)\Hide = Val(StringField(line$,u,",")) : u+1
                Obj(k)\Locked = Val(StringField(line$,u,",")) : u+1
                Obj(k)\Alpha= Val(StringField(line$,u,",")) : u+1
                Obj(k)\Bm   = Val(StringField(line$,u,",")) : u+1
                If version < 0.14
                  Obj(k)\Alpha = 255
                  If Obj(k)\nom$ ="" 
                    If nom$ <> ""
                      Obj(k)\nom$ =nom$
                    Else
                      Obj(k)\nom$ ="Object"+Str(k)
                    EndIf                                
                  EndIf
                  If Obj(k)\h <= 0
                    Obj(k)\h = 100
                  EndIf
                  If Obj(k)\w <= 0
                    Obj(k)\w = 100
                  EndIf
                EndIf
                nbShape = 0
                
                ; clip 
                 Obj(k)\Clip   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipW   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipH   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipHide   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipColor   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipAlpha   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipBorder   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipBorderAlpha   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipBorderColor   = Val(StringField(line$,u,",")) : u+1
                 Obj(k)\ClipBorderStroke   = Val(StringField(line$,u,",")) : u+1
                 If Obj(k)\ClipW=0 Or Obj(k)\ClipH=0
                   VD_Layer_ResetClipping(k)
                 EndIf

              Else
                k=ObjId
                nbShape = ArraySize(Obj(ObjId)\Shape())+1
              EndIf                   
              
            Case "shape" 
              ;{ 
              j = Val(StringField(line$,2,",")) + nbShape
              If j > ArraySize(Obj(ObjId)\Shape())
                ReDim Obj(ObjId)\Shape.sShape(j)
              EndIf
              Obj(ObjId)\Shape(j)\pos = j*10
              Obj(ObjId)\Shape(j)\Depth = j*10
              ;Obj(ObjId)\Shape(j)\idUnik = ShapeIdUnik
              ;ShapeIdUnik+1
              Obj(ObjId)\Shape(j)\color = Val(StringField(line$,3,","))
              Obj(ObjId)\Shape(j)\Nom$ = StringField(line$,4,",")
              If Obj(ObjId)\Shape(j)\Nom$=""
                Obj(ObjId)\Shape(j)\Nom$ = "shape_"+Str(j)
              EndIf
              
              u = 5
              Obj(ObjId)\Shape(j)\Alpha = Val(StringField(line$,u,",")) : u+1
              If Version < 0.14; ValD(#ProgramVersionVD)
                If Obj(ObjId)\Shape(j)\Alpha =0
                  Obj(ObjId)\Shape(j)\Alpha =255
                EndIf
                Debug ""+Version+" / "+ValD(#ProgramVersionVD)
              EndIf
              
              ; Style
              Obj(ObjId)\Shape(j)\Typ = Val(StringField(line$,u,",")) : u+1                       
              Obj(ObjId)\Shape(j)\w = Val(StringField(line$,u,",")) : u+1
              min(Obj(ObjId)\Shape(j)\w,1)
              Obj(ObjId)\Shape(j)\h = Val(StringField(line$,u,",")) : u+1
              min(Obj(ObjId)\Shape(j)\h,1)
              Obj(ObjId)\Shape(j)\d = Val(StringField(line$,u,",")) : u+1
              min(Obj(ObjId)\Shape(j)\d,1)
              
              ; type de shape (box, circle...
              ShapTyp = Val(StringField(line$,u,",")) : u+1
              Obj(ObjId)\Shape(j)\ShapTyp = ShapTyp
              
              ; je dois modifier le nombre de points ensuite ! 
              Select ShapTyp
                Case #VD_ShapeLine, #VD_ShapeBox, #VD_Shapecircle, #VD_ShapeText, #VD_ShapeImage,#VD_ShapeBoxRnd
                  ReDim Obj(ObjId)\Shape(j)\pt.sPoint(0)
              EndSelect
              
              Obj(ObjId)\Shape(j)\SizeW   = Val(StringField(line$,u,",")) : u+1
              Obj(ObjId)\Shape(j)\SizeH   = Val(StringField(line$,u,",")) : u+1
              
              ; text ou image
              With Obj(ObjId)\Shape(j)
                txtinfo$        =   StringField(line$,u,",") : u+1
                If  \ShapTyp    = #VD_ShapeText 
                  text$ = StringField(txtinfo$,1,";")
                  text$ = ReplaceString( text$, "{-virg-}", ",")
                  \Text$      =  text$
                  \FontName$  = StringField(txtinfo$,2,";") 
                  \FontStyle  = Val(StringField(txtinfo$,3,";"))
                  \font       = LoadFont(#PB_Any, \FontName$,\SizeW,\FontStyle)
                ElseIf \ShapTyp = #VD_ShapeImage 
                  \Filename$  = StringField(txtinfo$,1,";") 
                  \Img        = LoadImage2(#PB_Any,\Filename$)
                  \ImgRepeat  = Val(StringField(txtinfo$,2,";")) 
                EndIf
              EndWith
              
              ; x, y  shape
              Obj(ObjId)\Shape(j)\x   = posX+Val(StringField(line$,u,",")) : u+1
              Obj(ObjId)\Shape(j)\y   = posY+Val(StringField(line$,u,",")) : u+1
              
              ; other
              Obj(ObjId)\Shape(j)\open = Val(StringField(line$,u,",")) : u+1
              Obj(ObjId)\Shape(j)\idunik$ = StringField(line$,u,",") : u+1
              If Obj(ObjId)\Shape(j)\idunik$ = #Empty$
                Obj(ObjId)\Shape(j)\idunik$ = Shape_CreateIdUnik()
              EndIf
              
              
              old_depth = Val(StringField(line$,u,",")) : u+1
              old_pos = Val(StringField(line$,u,",")) : u+1
              Obj(ObjId)\Shape(j)\Parent\idUnik$ = StringField(line$,u,",") : u+1
              
              Obj(ObjId)\Actif = 1
              i=0
              ;}
              
            Case "shapefx"
              k = Val(StringField(line$,2,","))
              If k > ArraySize(Obj(ObjId)\Shape(j)\Fx())
                ReDim Obj(ObjId)\Shape(j)\Fx(k)
              EndIf
              
              u = 3
              With Obj(ObjId)\Shape(j)
                \fx(k)\Nom$ = "fx_"+Str(k)
                \Fx(k)\X        = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\Y        = Val(StringField(line$,u,",")) : u+1
                \fx(k)\color    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\alpha    = Val(StringField(line$,u,",")) : u+1
                ;  = RGBA(Red(color),Green(color),Blue(color),255)
                \Fx(k)\Depth    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\Style    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\w        = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\h        = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\Dist     = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\Scale    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\SizeW    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\SizeH    = Val(StringField(line$,u,",")) : u+1
                \Fx(k)\Actif    = Val(StringField(line$,u,",")) : u+1
                If \fx(k)\actif
                  \UseFx =1
                EndIf
                
              EndWith
              UpdateListShapeFX()
              
            Case "pt"
              u = 3
              i = Val(StringField(line$,2,","))
              If i > ArraySize(Obj(ObjId)\Shape(j)\pt())
                ReDim Obj(ObjId)\Shape(j)\pt.sPoint(i)
              EndIf
              With  Obj(ObjId)\Shape(j)\pt(i)
                \x = Val(StringField(line$,u,",")) : u+1
                \y = Val(StringField(line$,u,",")) : u+1
                \broken = Val(StringField(line$,u,",")) : u+1
                \MaxPt = Val(StringField(line$,u,",")) : u+1
                \Center = Val(StringField(line$,u,",")) : u+1
                \hide = Val(StringField(line$,u,",")) : u+1
              EndWith
              
          EndSelect           
          
        Wend
        
        ; on doit vérifie si on les points "broken et \maxpt, pour les shapes en plusieurs parties
        For i=0 To ArraySize(Obj())
          For j= 0 To ArraySize(obj(i)\shape())
            With obj(i)\Shape(j)
              If \pt(0)\broken = 0
                \pt(0)\broken = 1
                \pt(0)\MaxPt = ArraySize(\pt())
              EndIf
            EndWith
          Next
        Next
        
        If openmenu = 1
          Debug "ok"
          SetWindowTitle(#Win_VD_main,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD+" - "+GetFilePart(file$))
          VdOptions\PathOpen$ = file$
        EndIf
      
        Vd\NbShape = 1
        ShapeGetProperties()
        VD_Layer_UpdateUI()
        
        Debug "ok fin readfile shape"
        CloseFile(10)
        If draw= 1
          Drawcanvas()
        EndIf
        
      EndIf
      
    EndIf
    
    VD_Layer_UpdateUI(1)
    UpdateListShape()
    ShapeId = 0
    
  EndIf
  
  ;Debug "3-arraysize : "+Str(ArraySize(Obj()) )
  
  ; reset the position :
  posX = 0
  posY = 0
  openmenu = 0
  
  ProcedureReturn 1
EndProcedure


; add point
 Procedure Shape_CheckBrokenPoint()
  
  If shapeId>-1
     ; je dois vérifier les pt()\broken et pt()\maxpt
    With obj(objId)\Shape(ShapeId)
      For i=0 To ArraySize(\pt())
        If \pt(i)\broken = 1
          oldId = i
          maxpt = i-1
          If i >0 And oldid >i
            \pt(oldId)\MaxPt = maxpt
          EndIf
        ElseIf i=ArraySize(\pt())
          \pt(oldId)\MaxPt = i
        EndIf
      Next
    EndWith
  EndIf
  
EndProcedure
Procedure Shape_AddPoint(x1,y1,mode=0)
  
  ; mode = 0 : add a point at the end of the curve
  ; mode = 1 : add a point between the nearest point and its neighbour
  ; mode = 2 : add a point at the end of the curve, but with the "pencil mode", so need to calcule the angle to place correctly the anchor of the new point.
  
  If ShapeId>-1
    
    If mode = 0
      
      With Obj(ObjId)\Shape(ShapeId)
        
        w = ArraySize(\pt())
        x6 =\pt(w)\x
        y6 =\pt(w)\y
        
        ; ensuite, j'augmente la taille de mon tableau de points de 3
        n = ArraySize(\pt())+3
        ReDim \pt.sPoint(n)  
        
        ; je commence donc au n-2
        n-2
        ; je définis les autres points que je vais modifier : n+1, n-1 et n+2 (l'avant dernier point)
        u=n+1
        If u>ArraySize(\pt())
          u=0
        EndIf
        v =n-1
        If v<0
          v=ArraySize(\pt())
        EndIf
        w=n+2
        If w>ArraySize(\pt())
          w=0
        EndIf  
        ; puis, je change la position des points.
        ; A revoir <----------- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ; NOTE : ici, je devrais vérifier la tangeante des points précédents 
        ; pour placer en X/Y en fonction de cette tangeante.
        x4 = x1 -\x - obj(objId)\x
        y4 = y1 -\y - obj(objId)\y
        
        \pt(u)\x = x4+20
        \pt(u)\y = y4 
        \pt(v)\x = x4-20                                                                                    
        \pt(v)\y = y4 
        ; je définis la position du point n étant à x & y
        \pt(n)\x = x4
        \pt(n)\y = y4 
        \pt(n)\Center = 1
        PtId = n
        ; puis, je dois replacer notre ancien dernier point à sa place initiale
        \pt(w)\x = x6
        \pt(w)\y = y6
      EndWith
      
    ElseIf mode = 1
      
      ; find the nearest point of the mouse coordonates
      distmin = 10000
      With Obj(ObjId)\Shape(ShapeId)
        For i=0 To ArraySize(\pt()) ;Step 3
          If \pt(i)\Center =1
            dist.d = point_distance(x1,y1,\pt(i)\x+ \X,\pt(i)\y+ \Y)
            If dist < distmin
              distmin =dist
              id = i
            EndIf
          EndIf
        Next
        
        ; then get its neighbour
        u = id-3
        If u <0
          u = (id-3)+(ArraySize(\pt())+1)
        EndIf
        v = id+3
        If v > ArraySize(\pt())
          v = 0 ; (id+3)-(ArraySize(\pt())+1)
        EndIf
        ; je vais vérifier la distance avec le milieu des segments formé par :
        ; - le point ID et son précédent
        ; - le point ID et son suivant.
        
        ; notre point Id
        xO =\pt(id)\x+\x
        yO =\pt(id)\y+\y
        ; le précédent
        xA =\pt(u)\x+\x
        yA =\pt(u)\y+\y
        ; le suivant
        xb =\pt(v)\x+\x
        yb =\pt(v)\y+\y
        ; the midle
        md_x1 = (xa+xO)/2
        md_y1 = (ya+yO)/2
        md_x2 = (xO+xb)/2
        md_y2 = (yO+yb)/2
        ; je compare les distance entre la souris et le milieu de ces segments et je place mon nouveau point sur le plus proche
        dist_u.d = point_distance(x1,y1,md_x1,md_y1)
        dist_V.d = point_distance(x1,y1,md_x2,md_y2)
        
        If Dist_U < dist_V
          id-3
          newid = id+1
          n=id+3
          If newId <0
            newID=ArraySize(\pt())
            n= newID+1
          EndIf
          ; nextX = md_x1-\x
          ; nextY = md_y1-\y
        Else
          newid = id+1
          n = id +3
          ; nextX = md_x2-\x
          ; nextY = md_y2-\y
        EndIf
        
        InsertArrayElement(\pt,newid)
        InsertArrayElement(\pt,newid)
        InsertArrayElement(\pt,newid)
        
        ; j'ai donc les coordonnées de là où je vais ajouter mon point.
        ; ensuite, j'augmente la taille de mon tableau de points de 3
        ;       k = ArraySize(\pt())+3
        ;       ReDim \pt.sPoint(k) 
        
        
        ; je copie les points qui sont après mon point id 
        ;       For i = ArraySize(\pt()) To id+3 Step -1
        ;        \pt(i) = \pt(i-3)
        ;       Next
        
        ; puis je crée les points en n-1, n (point centre) et n+1
        \pt(n)\x = x1-\x - obj(objId)\x
        \pt(n)\y = y1-\y - obj(objId)\y
        \pt(n)\Center = 1
        PtId = n
        ; et les ancres
        \pt(n-1)\x =  \pt(n)\x-1
        \pt(n-1)\y =  \pt(n)\y-1  
        \pt(n+1)\x = x1-\x + 1
        \pt(n+1)\y = y1-\y + 1
      EndWith
      
    ElseIf mode = 2
      
      With Obj(ObjId)\Shape(ShapeId)
        
        w = ArraySize(\pt())
        x6 =\pt(w)\x
        y6 =\pt(w)\y
        
        x7 =\pt(w-1)\x 
        y7 =\pt(w-1)\y 
        
        ; ensuite, j'augmente la taille de mon tableau de points de 3
        n = ArraySize(\pt())+3
        ReDim \pt.sPoint(n)  
        
        ;{ je commence donc au n-2
        n-2
        ; je définis les autres points que je vais modifier : n+1, n-1 et n+2 (l'avant dernier point)
        u=n+1
        If u>ArraySize(\pt())
          u=0
        EndIf
        v =n-1
        If v<0
          v=ArraySize(\pt())
        EndIf
        w=n+2
        If w>ArraySize(\pt())
          w=0
        EndIf 
        ;}
        ; puis, je change la position des points.
        ; A revoir <----------- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ; NOTE : ici, je devrais vérifier la tangeante des points précédents 
        ; pour placer en X/Y en fonction de cette tangeante.
        x4 = x1 -\x - obj(objId)\x
        y4 = y1 -\y - obj(objId)\y
        
        ;       x5 = x4
        ;       Y5 = y4 
        
        ;       x5 = (x4+x7-\x)/2
        ;       Y5 = (y4+y7-\y)/2
        ;       x5 = (x4+\x+x7+\x)/2
        ;       Y5 = (y4+\y+y7+\y)/2
        x5=x4
        y5=y4
        
        
        
        \pt(u)\x = x5 ;x5 -(x4 -x5) ; x5 ; x4+20
        \pt(u)\y = y5 ;y5 -(y4 -y5) ; y5 ; y4 
        \pt(v)\x = x5 ; 2*x6 - x4                                                                                   
        \pt(v)\y = y5 ; 2*y6 - y4
                      ; je définis la position du point n étant à x & y
        \pt(n)\x = x4
        \pt(n)\y = y4 
        \pt(n)\Center = 1
        PtId = n
        
        
        ; puis, je dois replacer notre ancien dernier point à sa place initiale
        \pt(w)\x = x6
        \pt(w)\y = y6
      EndWith
      
    EndIf
    vd\AddObjet=2
    ; je dois vérifier les pt()\broken et pt()\maxpt
   Shape_CheckBrokenPoint()
    
  EndIf

EndProcedure


; transform shape
Procedure Shape_Mirror(horizontal=1,vertical=0,cx=0,cy=0)
  ; mirror a shape
  If horizontal Or vertical
    
    For i=0 To ArraySize(obj(ObjId)\Shape())
      With obj(ObjId)\Shape(i)
        ; get origin of shape
        x1 = \X + Obj(ObjId)\X
        y1 = \y + Obj(ObjId)\y
        ; then miror the point
        If (\Selected Or shapeID = j) And \Hide = 0
          For j=0 To ArraySize(\pt())
            If horizontal
              \pt(j)\x = - \pt(j)\x
            EndIf
            If vertical
              \pt(j)\y = - \pt(j)\y
            EndIf
          Next
        EndIf
      EndWith
    Next
    
  EndIf
  ; update
  ShapeGetProperties()
  DrawCanvas()
  
EndProcedure
Procedure Shape_SetTransformation(action,ratio.d)
  
  
  
  
EndProcedure




; Shape propertie
Procedure Shape_Hide(hide=1)
  
  ; hide = 0 : unhide all
  ; hide =1 : hide selectd
  ; hide= 2 : hide all, except selected
  ;If othergadgethasfocus = 0
    For i=0 To ArraySize(obj(ObjId)\Shape())
      With obj(ObjId)\Shape(i)
        If hide < 2
          ; hide selected or unhide all
          If \Selected Or ShapeId = i Or hide = 0
            \hide = hide
            \Selected = 0
            If i = shapeid And hide=1
              shapeid = -1
            EndIf
          EndIf
        Else
          ; hide all except selected shape
          If \Selected=0 And ShapeId <> i 
            \hide = 1
          Else
            \hide =0
          EndIf
        EndIf
      EndWith
    Next
    ShapeGetProperties()
    DrawCanvas()
    ;EndIf
    
EndProcedure
Procedure Shape_SortDepth(Ze_idunik$)
  SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending,OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
  ; on reselectionne le shape
  For i = 0 To ArraySize(obj(ObjId)\Shape())
    If obj(ObjId)\Shape(i)\idUnik$ = Ze_idunik$
      shapeId = i
      Break
    EndIf
  Next                    
  UpdateListShape()
  SetGadgetItemState(#G_shapelist,ShapeId,1)
  Drawcanvas()
EndProcedure
Procedure Shape_SetDepth(up=1)
  
  ; to change the depth\position (in order drawing) of a shape
  If ShapeId >-1 And ShapeId <= ArraySize(Obj(ObjId)\Shape())
    
    If up=1
      If shapeId > 0                        
        ; on échange uniquement les positions
        ; keep the current idunik of the shape, to set the shapeid to this shape after change
        Ze_idunik$ = Obj(ObjId)\Shape(ShapeId)\idunik$
        ; CopyObj\depth = Obj(ObjId)\Depth
        Depth = Obj(ObjId)\Shape(ShapeId)\pos
        ;Obj(ObjId)\Depth = Obj(newpos)\depth   
        Obj(ObjId)\Shape(ShapeId)\pos =  Obj(ObjId)\Shape(newpos)\pos
        ;Obj(newpos)\depth = CopyObj\depth        
        Obj(ObjId)\Shape(NewPos)\pos =  depth
        ok = 1
      EndIf
    Else
      If ShapeId < ArraySize(Obj(ObjId)\Shape()) And ShapeId > -1
        ; keep the current idunik of the shape, to set the shapeid to this shape after change
        Ze_idunik$ = Obj(ObjId)\Shape(ShapeId)\idunik$
        ; on échange uniquement les positions
        Obj(ObjId)\Shape(ShapeId)\pos+1 
        ; puis, on échange                        
        Obj(ObjId)\Shape(ShapeId+1)\pos-1 
        ok = 1
      EndIf      
    EndIf
    
    Shape_SortDepth(Ze_idunik$)
  EndIf

EndProcedure
Procedure Shape_Lock(lock=1)
  ; lock = 0 : unlock all
  ; lock = 1 : lock selectd
  ; lock = 2 : lock all, except selected
  ;If othergadgethasfocus = 0
    For i=0 To ArraySize(obj(ObjId)\Shape())
      With obj(ObjId)\Shape(i)
        If lock < 2
          ; lock selected or unlock all
          If \Selected Or ShapeId = i Or lock = 0
            \Locked = lock
            \Selected = 0
            If i = shapeid And lock=1
              ok = 1
              shapeid = -1
            EndIf
          EndIf
        Else
          ; lock all except selected shape
          If \Selected=0 And ShapeId <> i 
            \Locked = 1
          Else
            \Locked =0
            ok = 1
          EndIf
        EndIf
      EndWith
    Next
    If lock = 1 And ok
      ShapeSetGadget(1)
    Else
      ShapeSetGadget(0)
    EndIf
    
    ShapeGetProperties()
    DrawCanvas()
    ;EndIf

EndProcedure
Procedure Shape_SetPropertie(propertie=#ShapePropertie_Color, value=-1)
  
  If shapeid > -1
    Select propertie
        
      Case #ShapePropertie_ColorTyp
        For i=0 To ArraySize(obj(ObjId)\Shape())
          If  Obj(ObjId)\Shape(i)\Selected Or i = shapeid
            Obj(ObjId)\Shape(i)\ColorGrad = GetGadgetState(#G_shapeColorTyp)
            If GetGadgetState(#G_shapeColorTyp) >0 And GetGadgetState(#G_shapeColorTyp)<3
            EndIf
          EndIf
        Next 
        
      Case #ShapePropertie_Color
        c = Obj(ObjId)\Shape(ShapeId)\Color
        If value <>-1
          col = value
        Else
          col = ColorRequester(RGB(Red(c),Green(c),Blue(c)))
        EndIf
        If col >-1
          For i=0 To ArraySize(obj(ObjId)\Shape())
            With Obj(ObjId)\Shape(i)
              If \Selected Or i = shapeid
                \Color=RGBA(Red(col),Green(col),Blue(col),Obj(ObjId)\Shape(i)\alpha)
                \ColGrad(0)=RGBA(Red(col),Green(col),Blue(col),Obj(ObjId)\Shape(i)\alpha)
              EndIf
            EndWith
          Next 
        EndIf
        
      Case #ShapePropertie_DeParenting
        If MessageRequester(lang("Infos"), 
                            lang("Apply the parenting ? If not, the shape will return at its previous position."),
                            #PB_MessageRequester_YesNo) = #PB_MessageRequester_Yes    
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If Obj(ObjId)\Shape(i)\Selected Or i = shapeId
              p_id =  Obj(ObjId)\Shape(i)\Parent\id 
              Obj(ObjId)\Shape(i)\x + Obj(ObjId)\Shape(p_id)\x - Obj(ObjId)\Shape(i)\Parent\startX
              Obj(ObjId)\Shape(i)\y + Obj(ObjId)\Shape(p_id)\y - Obj(ObjId)\Shape(i)\Parent\startY
            EndIf
          Next
        EndIf
        
      Case #ShapePropertie_SetParent
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If  Obj(ObjId)\Shape(i)\Selected And shapeid <> i
              id = shapeId
              Obj(ObjId)\Shape(i)\Parent\id = id+1
              Obj(ObjId)\Shape(i)\Parent\startx = Obj(ObjId)\Shape(id)\x
              Obj(ObjId)\Shape(i)\Parent\starty = Obj(ObjId)\Shape(id)\y
              Obj(ObjId)\Shape(i)\Parent\idUnik$ = Obj(ObjId)\Shape(id)\idUnik$
            EndIf
          Next 
        
      Case #ShapePropertie_StrokeWidth ; lineW
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If  Obj(ObjId)\Shape(i)\Selected Or i = shapeid
              Obj(ObjId)\Shape(i)\w = ValD(GetGadgetText(#G_shapeLineW))
              min(Obj(ObjId)\Shape(i)\w,0.001)
            EndIf
          Next 
        
      Case #ShapePropertie_LineD
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If  Obj(ObjId)\Shape(i)\Selected Or i = shapeid
              Obj(ObjId)\Shape(i)\d = ValD(GetGadgetText(#G_shapeLineD))
              min(Obj(ObjId)\Shape(i)\d,0.001)
            EndIf
          Next 
        
      Case #ShapePropertie_LineH
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If  Obj(ObjId)\Shape(i)\Selected Or i = shapeid
              Obj(ObjId)\Shape(i)\h = ValD(GetGadgetText(#G_shapeLineH))
              min(Obj(ObjId)\Shape(i)\h,0.001)
            EndIf
          Next 
        
      Case #ShapePropertie_Style
          For i=0 To ArraySize(obj(ObjId)\Shape())
            If  Obj(ObjId)\Shape(i)\Selected Or i = shapeid
              Obj(ObjId)\Shape(i)\Typ = GetGadgetState(#G_shapeTyp)
            EndIf
          Next 
        
      Case #ShapePropertie_Alpha
        For i=0 To ArraySize(obj(ObjId)\Shape())
          With  Obj(ObjId)\Shape(i)
            If \Selected Or i = shapeid
              \alpha = GetGadgetState(#G_shapeAlpha)
              col = \Color
              \Color = RGBA(Red(col),Green(col),Blue(col),\alpha)
              \ColGrad(0)=\Color
            EndIf
          EndWith
        Next 
        
    EndSelect
  EndIf
  Drawcanvas(0,0,0)
  
EndProcedure


; Shape FX
Procedure Shape_SetFXpropertie(propertie=#ShapePropertie_Color,mode=0,value=-1,i=-1)
  ; mode = 1 to set a propertie by its own propertie
  ; mode = 0 to change propertie by a gadget for example. for all selected shapes
  
  If shapeid > -1
    
    If mode = 0
      ;{ changer avec un gadget pour tous les shapes selected

      ; d'abord, on définit ShapeFxId en fonction du shapeId
      If ShapeFxId > ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())
        ShapeFxId = 0
      EndIf  
      
      Select propertie
        Case #ShapePropertie_Color
          color = value
          If value = -1
            color1 = Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Color
            Color = ColorRequester(RGB(Red(color1),Green(color1),Blue(color1)))
          EndIf
          
          If color<>-1
            For i =0 To ArraySize(Obj(ObjId)\Shape())
              With Obj(ObjId)\Shape(i)
                If \Selected And \Hide = 0 And \Locked = 0
                  alpha = \Fx(ShapeFxId)\Alpha
                  \Fx(ShapeFxId)\color=RGBA(Red(color),Green(color),Blue(color),alpha)
                EndIf
              EndWith
            Next 
          EndIf
          
        Case #ShapePropertie_StrokeWidth
          W = ValD(GetGadgetText(#G_shapeFxLineW)) : min(w,0.001)
          
        Case #ShapePropertie_ActiveFx
          Actif = GetGadgetState(#G_shapeFxActif)
          
        Case #ShapePropertie_Alpha
          Alpha = GetGadgetState(#G_shapeFxAlpha)
          
      EndSelect
      
      ; then set to all selected and not locked shapes
      If propertie <> #ShapePropertie_Color
        For i =0 To ArraySize(Obj(ObjId)\Shape())
          With Obj(ObjId)\Shape(i)
            If \Selected And \Hide = 0 And \Locked = 0
              
              Select propertie
                  
                Case #ShapePropertie_StrokeWidth
                  \Fx(ShapeFxId)\w =w                    
                  
                Case #ShapePropertie_ActiveFx
                  \Fx(ShapeFxId)\Actif = actif
                  If Actif = 1
                    Shape_SetFXpropertie(#ShapePropertie_Color,1,0,i)
                    \UseFx =1
                  Else
                    ; verify if the shape use fx
                    \UseFx =0
                    For k=0 To ArraySize(\Fx())
                      If \fx(k)\Actif
                        \UseFx =1
                        Break
                      EndIf
                    Next
                  EndIf
                  
                Case #ShapePropertie_Alpha
                  \Fx(ShapeFxId)\Alpha = alpha
                  color = \Fx(ShapeFxId)\color
                  \Fx(ShapeFxId)\color=RGBA(Red(color),Green(color),Blue(color),alpha)
                  
                Case #ShapePropertie_Style 
                  \Fx(ShapeFxId)\Style = GetGadgetState(#G_shapeFxLineTyp)
              EndSelect
            EndIf
          EndWith
        Next 
      EndIf
      
      Drawcanvas()
      ;}
      
    ElseIf mode =1
      If i=-1
        i = ShapeId
      EndIf
      
      Select propertie
          
        Case #ShapePropertie_Color
          color = Obj(ObjId)\Shape(i)\Fx(ShapeFxId)\Color
          alpha = Obj(ObjId)\Shape(i)\Fx(ShapeFxId)\Alpha
          Obj(ObjId)\Shape(i)\Fx(ShapeFxId)\color=RGBA(Red(color),Green(color),Blue(color),alpha)
      EndSelect
    EndIf
  EndIf
  
EndProcedure



; other : selection
Procedure MouseOnShape(m,i,x,y)
  Protected w, h
  
  vx = Vd\viewX
  vy = Vd\viewY
  
  With obj(m)\shape(i)
    w = \SizeW
    h = \SizeH
    If \ShapTyp = #VD_ShapeText
      h =VectorParagraphHeight(\Text$, \d,\h) ;  VectorTextHeight(\Text$, #PB_VectorText_Visible )
      w =VectorTextWidth(\Text$, #PB_VectorText_Visible )
    EndIf
    
     ;Debug Str(\x)+"<"+Str(x)+"<"+Str(\x+\SizeW)+" / "+Str(\y)+"<"+Str(y)+"<"+Str(\y+\SizeH)
;     Debug Str(\x)+"/"+Str(x)+"/"+Str(\w)+" :: "+Str(\y)+"/"+Str(y)+"/"+Str(\h)
    If x>=\X+vx And x<=\x+w+vx And y>=\y+vy And y<=\y+h+vy
      ProcedureReturn 1
  EndIf
  EndWith
EndProcedure
Procedure Shape_GetRectangleSelection()
  
  vx = Vd\viewX
  vy = Vd\viewY
  
  With obj(ObjId)
    For i= 0 To ArraySize(\shape())
      If \Shape(i)\Hide = 0
        x = vd\Selection\x +vx
        y = vd\Selection\y +vy
        w = vd\Selection\w
        h = vd\Selection\h
        x1 = \Shape(i)\boundx 
        y1 = \Shape(i)\boundy 
        w1 = \Shape(i)\boundw 
        h1 = \Shape(i)\boundh 
        x2 = \Shape(i)\X +\x
        y2 = \shape(i)\y +\y
        w2 = \Shape(i)\SizeW
        h2 = \Shape(i)\SizeH
        
        If  (x<=x1 And x+w>= x1+w1 And y<=y1  And y+h>=h1+y1) Or (x<=x2 And x+w>= x2+w2 And y<=y2  And y+h>=h2+y2)
          \Shape(i)\Selected = 1
          If shapeid = -1
            shapeId = i
          EndIf
          ok = 1
        EndIf
        
      EndIf
    Next
  EndWith
 
 ProcedureReturn ok
  
EndProcedure


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 139
; FirstLine = 10
; Folding = AAweYw0P-8Qk5PAAAAAAAAA+DAA7fKneQIAgQ-GCAAAAA5PAAAAAAAA50
; EnableXP