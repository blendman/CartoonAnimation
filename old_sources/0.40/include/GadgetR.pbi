; EnableExplicit

;############################################################################################################################
;                  Redimensionnement automatique des gadgets - pf shadoko - 2016
;                   Mise sous forme de module et améliorations - Naheulf - 2020
;  
;  Code original :
;      https://www.purebasic.fr/french/viewtopic.php?f=6&t=16201
;  
;  Fonctionnement:
;      Les instructions OpenWindow, ButtonGadget, TextGadget, ..., CloseGadgetList
;      doivent etre utilisées avec le suffixe 'R'
;
;      Les 4 paramètres suplémentaires indiquent le ratio d'adaptation aux variation de taille du parent: 
;        - rdx : 0 -> Pas de déplacement horizontal ; 1 -> Reste collé au bord droit
;        - rdw : 0 -> Largeur fixe                  ; 1 -> S'étire à volonté
;        - rdy : 0 -> Pas de déplacement vertical   ; 1 -> Reste collé au bord bas
;        - rdh : 0 -> Hauteur fixe                  ; 1 -> S'étire à volonté
;      Note : 
;  
;  Équivalence avec les paramètres de la version originale :
;      rx,ry = 0 -> rdx,rdy = 0 ; rdw,rdh = 0
;      rx,ry = 1 -> rdx,rdy = 1 ; rdw,rdh = 0
;      rx,ry = 2 -> rdx,rdy = 0 ; rdw,rdh = 1
;      rx,ry = 3 -> rdx,rdy = position/tailleDuParent ; rdw,rdh = taille/tailleDuParent
;      rx,ry = 4 -> rdx,rdy = 0 ; rdw,rdh = (position+taille)/tailleDuParent
;      rx,ry = 5 -> rdx,rdy = position/tailleDuParent ; rdw,rdh = 1 - (position/tailleDuParent)
;
;  Signification des 2 paramètres suplémentaires utilisés dans la version originale.
;      rx et ry correspondent au type de redimensionnement:
;      rx/ry = 0 : pas de modification
;      rx/ry = 1 : modification de la position x/y
;      rx/ry = 2 : modification de la largeur/hauteur
;      rx/ry = 3 : positionnement proportionnel
;      rx/ry = 4 : positionnement proportionnel coté droit
;      rx/ry = 5 : positionnement proportionnel coté gauche
;
;############################################################################################################################


DeclareModule GadgetR
	
	;--------------------------------- gadgets
	Declare ButtonGadgetR     (Gadget,X,Y,Width,Height,Text$,  Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare TextGadgetR       (Gadget,X,Y,Width,Height,Text$,  Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare CheckBoxGadgetR   (Gadget,X,Y,Width,Height,Text$,  Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare StringGadgetR     (Gadget,X,Y,Width,Height,Text$,  Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare EditorGadgetR     (Gadget,X,Y,Width,Height,        Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare ButtonImageGadgetR(Gadget,X,Y,Width,Height,imageID,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	
	;--------------------------------- containers
	Declare CanvasGadgetR  (Gadget,X,Y,Width,Height,        Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare ContainerGadgetR  (Gadget,X,Y,Width,Height,        Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare PanelGadgetR      (Gadget,X,Y,Width,Height,                     rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	Declare ScrollAreaGadgetR (Gadget,X,Y,Width,Height,
	                           scrolldx,scrolldy,scrollstep,   Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
	
	;--------------------------------- window
	Declare OpenWindowR(n,x,y,dx,dy,txt.s,f=#PB_Window_SystemMenu,pid=0)
	
	;---------------------------------
	Declare CloseGadgetListR()
EndDeclareModule ; GadgetR

Module GadgetR
	EnableExplicit
	
	Structure GadgetInfo
		id.i          ; gadgetID
		Map Glist.s() ; liste des gadgets contenus (pour les containers)
		x.w : y.w	  ; position d'origine
		w.w : h.w	  ; dimensions d'origine
		rdx.f : rdy.f ; contributions des positions lors des redimmentionnements
		rdw.f : rdh.f ; contributions dimentions lors des redimmentionnements
	EndStructure
	
	Global Dim GadgetCont.s(256), GadgetConti
	Global NewMap GadgetList.GadgetInfo()
	
	Procedure Redimensioner(c, nx.w, ny.w, ndw.w, ndh.w, type$="G")
		Protected.GadgetInfo gi, o
		Protected.w dw,dh, nw, nh
		If type$="G":ResizeGadget(c,nx, ny, ndw, ndh):EndIf
		gi=GadgetList(type$+Str(c))
		dw = ndw-gi\w
		dh = ndh-gi\h
		ForEach gi\Glist() : o=GadgetList(gi\Glist())
			If (o\rdx Or o\rdw Or o\rdy Or o\rdh)
				nx = o\x + o\rdx * dw
				nw = o\w + o\rdw * dw
				ny = o\y + o\rdy * dh
				nh = o\h + o\rdh * dh
				Redimensioner (o\id, nx, ny, nw, nh)
			EndIf
		Next
		
	EndProcedure
	
	Procedure _GadgetInfo(na, id, x.w,y.w,w.w,h.w, rdx.f,rdw.f,rdy.f,rdh.f, iscontainer=0)
		Protected gadget.GadgetInfo, tg$
		
		If id=#PB_Any : gadget\id=na : Else : gadget\id=id : EndIf
		gadget\x=x     : gadget\y=y
		gadget\w=w     : gadget\h=h
		gadget\rdx=rdx : gadget\rdy=rdy
		gadget\rdw=rdw : gadget\rdh=rdh
		
		If iscontainer=-1
			tg$="W"+Str(gadget\id)
			GadgetConti=0
		Else
			tg$="G"+Str(gadget\id)
			GadgetList(GadgetCont(GadgetConti))\Glist(tg$)=tg$
		EndIf
		GadgetList(tg$)=gadget
		If iscontainer
			GadgetConti+1
			GadgetCont(GadgetConti)=tg$
		EndIf
		ProcedureReturn gadget\id
	EndProcedure
	
	
	;--------------------------------- gadgets
	Procedure ButtonGadgetR(Gadget,X,Y,Width,Height,Text$,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=ButtonGadget(Gadget,X,Y,Width,Height,Text$,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	Procedure TextGadgetR(Gadget,X,Y,Width,Height,Text$,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=TextGadget(Gadget,X,Y,Width,Height,Text$,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	Procedure CheckBoxGadgetR(Gadget,X,Y,Width,Height,Text$,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=CheckBoxGadget(Gadget,X,Y,Width,Height,Text$,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	Procedure StringGadgetR(Gadget,X,Y,Width,Height,Text$,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=StringGadget(Gadget,X,Y,Width,Height,Text$,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	Procedure EditorGadgetR(Gadget,X,Y,Width,Height,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=EditorGadget(Gadget,X,Y,Width,Height,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	Procedure ButtonImageGadgetR(Gadget,X,Y,Width,Height,imageID,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=ButtonImageGadget(Gadget,X,Y,Width,Height,imageID,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh)
	EndProcedure
	
	;--------------------------------- containers
	
	Procedure CanvasGadgetR(Gadget,X,Y,Width,Height,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=CanvasGadget(Gadget,X,Y,Width,Height,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh, 1)
	EndProcedure
	
	Procedure ContainerGadgetR(Gadget,X,Y,Width,Height,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=ContainerGadget(Gadget,X,Y,Width,Height,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh, 1)
	EndProcedure
	
	Procedure PanelGadgetR(Gadget,X,Y,Width,Height,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=PanelGadget(Gadget,X,Y,Width,Height)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh, 1)
	EndProcedure
	
	Procedure ScrollAreaGadgetR(Gadget,X,Y,Width,Height,scrolldx,scrolldy,scrollstep,Flags=#False,rdx.f=0,rdw.f=0,rdy.f=0,rdh.f=0)
		Protected na=ScrollAreaGadget(Gadget,X,Y,Width,Height,scrolldx,scrolldy,scrollstep,Flags)
		ProcedureReturn _GadgetInfo(na,Gadget,X,Y,Width,Height,rdx,rdw,rdy,rdh, 1)
	EndProcedure
	
	;--------------------------------- window
	Procedure _WindowResizeEvent()
		Protected n=EventWindow()
		Redimensioner(n,0,0,WindowWidth(n), WindowHeight(n),"W")
	EndProcedure
	
	Procedure OpenWindowR(Window,X,Y,Width,Height,Title$,Flags=#PB_Window_SystemMenu,ParentID=0)
		Protected na=OpenWindow(Window,X,Y,Width,Height,Title$,Flags,ParentID)
		Protected nw=_GadgetInfo(na,Window,X,Y,Width,Height,0,1,0,1, -1)
		BindEvent(#PB_Event_SizeWindow,@_WindowResizeEvent(), nw)
		ProcedureReturn nw
	EndProcedure
	
	;---------------------------------
	Procedure CloseGadgetListR()
		CloseGadgetList()
		GadgetConti-1
	EndProcedure
	
EndModule ; GadgetR

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 51
; FirstLine = 37
; Folding = TEgB-
; EnableXP