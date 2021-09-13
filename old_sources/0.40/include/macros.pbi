
;{ macros array
Macro DeleteArrayElement(ar, el)
    
    For a=el To ArraySize(ar())-1
        ar(a) = ar(a+1)
    Next
    
    a = 0
    If ArraySize(ar())-1>=0
        a = ArraySize(ar())-1    
    EndIf
    ReDim ar(a)
    
EndMacro

Macro InsertArrayElement(ar, el)
  
  a = ArraySize(ar())+1    
  ReDim ar(a)
  
  For a=ArraySize(ar())-1 To el Step -1
    ar(a+1) = ar(a)
  Next
    
EndMacro
;}

;{ Math

Procedure SetMaximum(a,max)
  ; to set the maxi for a variable
  If a > max
    a = max
  EndIf
  ProcedureReturn a
EndProcedure
; Procedure.l max(a, b)
;   If a > b
;     ProcedureReturn a
;   EndIf
;   ProcedureReturn b
; EndProcedure

; Procedure.l min(a,b)
;   If a > b
;     ProcedureReturn b
;   EndIf
;   ProcedureReturn a
; EndProcedure
Procedure SetMin(a, min)
  
  ; to set the min value to a variable
  If a < min
    a = min
  EndIf
  
  ProcedureReturn a
EndProcedure



Macro min(vv,min)
    If vv<min
        vv = min
    EndIf
EndMacro
Macro max(vv,max)
    If vv>max
        vv = max
    EndIf
EndMacro

Macro Snap(x,val)
    
    x / val
    x * val
    
EndMacro

Macro RGB2Hex(color)
    "$"+Hex(color,#PB_Long)
    ; "$"+LSet(Hex(color & $FFFFFFFF, #PB_Quad), 16, "0")
    ; "$"+LSet(Hex(color, #PB_Quad), 16, "0")
EndMacro

Macro point_distance(x1,y1,x2,y2)   
  ;Int(Sqr((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)) )       
  Sqr((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))       
EndMacro
Macro point_direction(x1,y1,x2,y2)
  ATan2((x2- x1),(y2- y1))
EndMacro

Procedure.f GetAngle(xb,yb,Xa,Ya)
  ;   ; calcul de l'angle en radian
  ;   ar.f=ATan((Ya-yb)/(Xa-xb))
  ;   ; conversion en degres (je suis pas un crac des radians, je préfère bosser avec les degrés)
  ;   ad=ar*360/2/3.1415
  ;   ; ajout de la partie de l'angle suivant la position des points car Atang ne renvoie qu'un angle de -90 à 90
  ;   If Xa<xb And Ya<yb : ad=180+ad :EndIf ; cas haut gauche
  ;   If Xa>xb And Ya<yb : ad=360+ad :EndIf ; cas haut droite
  ;   If Xa<xb And Ya>yb : ad=180+ad :EndIf ; cas bas gauche
  ;   If Xa>xb And Ya>yb : ad=-360+ad :EndIf ; cas bas droite
  ;   ; reconversion en radian si tu en as besoin
  ; ar=ad*2*3.1415/360
  rad.f = Mod(ATan2((Xa-xb),(Ya-yb))+2*#PI,2*#PI)
  deg.f = rad * 180.0 / #PI
  ProcedureReturn deg ; ad+ar
EndProcedure
;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 91
; FirstLine = 13
; Folding = pC8
; EnableXP