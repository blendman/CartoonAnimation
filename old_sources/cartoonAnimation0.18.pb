

;{ Infos

;{ todolist by version

; v 0.1
; ok - Ui général
; ok - ouvrir image
; ok - bank d'image
; ok - ajouter / delete sprite
; ok - screen central
; ok - draw
; 
; v 0.2
; ok - zoom, pan
; ok - panel properties sprite
; ok - Select sprite, move
; ok ar - rotate sprite, scale sprite
; 
; v 0.3
; - Ajouter / delete Bones
; - scale, move, rotate bones
; - file : load, save
; 
; V 0.4 
; - ajouter key sur sprite
; - ajouter key bones
; - delete key (sprite, bones)
; 
; V 0.5
; - timeline
; - play, stop, frame current, frame start, End
; - keyframe et key
; - copy, paste key
; - copy / paste keyframe
; 
; V 0.6
; - interpolation (sprite, bones)
; - sprite & bones animation : move, scale, rotation, alpha,
; 
; V 0.7
; - bone parenting
; - rotate, move, scale du bone → agit sur sprites enfants
; 
; V 0.8
; - export images
; - camera x,y,w,h

;}

;{ Todolist


;****** important
; il faudra revoir le système de position des points en position relative par rapport à la position du shape (elle-même relative à l'objet qui le contient)
; donc :
#ok = 0
CompilerIf #ok = 1
    
    For i=0 To ArraySize(Obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(i)            
            For j=0 To ArraySize(\pt())
                \pt(j)\x - \pt(0)\x 
                \pt(j)\y - \pt(0)\y 
            Next  
            \pt(0)\x = 0
            \pt(0)\y = 0
        EndWith        
    Next
    
CompilerEndIf
; 
;*******

; ■ creation / shape tools
; ok 0.01 - complexe shape
; ok 0.03 - ADD/delete pt
; ok 0.07 - circle/ellipse
; ok 0.07 - rectangle/ square
; ok 0.08 - line
; ok 0.08 - curve
; ok 0.09 - text
; ok 0.09 - image
; ok 0.18 - round rectangle / square
; - free drawing line
; ??? - other shape : triangle, start, polygon

; ■ creation / shape tools options : for shapecomplexe
; ok 0.01 - normal mode
; - sub mode
; - intersect mode


; ■ Transformations
; ok 0.03 - move shape
; ok 0.03 - ADD Or delete shape
; ok 0.04 - scale shape
; ok 0.05 - Rotate shape
; ok 0.07 AR - ADD offset For rotation & scale
; ok 0.07 AR - rotation by center/offset
; ok 0.08 - merge objet file : To ADD new object
; ok 0.15 - move pts selected (several)
; - scale by centre/offset
; - insert a pt between two points
; 
; ■ UI (toolbar)
; ok 0.06 - pan
; ok 0.06 - zoom
; ok 0.10 AR - offset : origin, cursor, center, selection
; ok 0.10 - snap, snapX, snapY
; 
; ■ File
; ok 0.05 - merge shape file
; ok 0.03 - save
; ok 0.03 - saveAs
; ok 0.04 AR - export image (object selected only)
; ok 0.10 - export scene (camera x,y,w,h)
; ok 0.12 - Export pb command processus
; - Import pb command processus (?)
; - Import SVG
; - Export SVG
; - save images sequence of animation (from start To End frame) in png, jpg
; - export animation in AVI (?) 
; - export option : size in %
; - export option : all
; - export option : selected object only
; - export option : by shape
; - export option : start - End frame For export (use the animation start /End Or custom)
; 
; ■ Edit
; ok 0.07 - Copy / paste shape
; ok 0.08 - Select all shapes, deselect all shapes
; ok 0.14 - set shape To bottom
; ok 0.14 - set shape To top
; ok 0.14 - set shape To origin
; ok 0.14 - set shape To cursor
; - Undo
; - redo

; ■ options
; ok 0.09 - load options
; ok 0.09 - save options
; ok 0.13 - background color
; ok 0.13 - background checker
; 
; ■ window (Interface)
; ok 0.01 - drawing (Object editing)
; - animation (Dope Sheet, LNA)
; - scene
; - Sequencer
; - Compositing
; 
; ■ layers (object)
; ok 0.10 - ui layer
; ok 0.10 - layer hide
; ok 0.10 - layer LOCK
; ok 0.10 - layer ADD
; ok 0.10 - layer del
; ok 0.10 - layer move up, down
; ok 0.13.5 AR - layer alpha
; ok 0.13 - layer position (X,Y)
; ok 0.13 - layer size (w,h)
; - layer typ ??? (vector, camera, light, fx, image parameters, particles, sounds) ???
; - merge With bottom object-layer
; - merge all objects
; - merge all visible
; - duplicate layer
; - send object To library (bank)
; - layer parenting (To another object)
; - fix object To camera
; 
; ■ text shape
; ok - change text
; ok - change font
; 
; ■ Image
; ok 0.07 - image alpha
; ok 0.07 - image tool
; ok 0.14 - change image
; ok 0.13.5 - image Repeat
; ok 0.13.5 - image w,h
; ok 0.13.5 AR - image x,y
; 
; ■ Shape parameters
; ok 0.04 - style : filled, line, dash, dot
; ok 0.11 - Hide
; ok 0.11 - Lock
; ok 0.11 - linked shape
; ok 0.12 - closepath
; ok 0.15.5 - convert To Shape (box, ellipse)
; - texture
; - gradient color
; - Global Style/color For shape
; - joint 2 shapes in 1 complexe shape
; - separate the shape in several shapes
; - parenting : set parent from shape
; - convert To line (line, curve, shape)
; - convert To Curve (line, curve, shape)
; - shape Smooth
; - shape Hard
; 
; ■ point parameter (For line, curve, complex shape)
; ok 0.15 - set point hard
; ok 0.15 - set point smooth
; 
; ■ Style/ FX
; ok 0.06 - btn ADD fx
; ok 0.06 - style : filled, line, dash, dot
; ok 0.06 - color, alpha, x,y
; ok 0.06 AR - depth
; ok 0.06 - depth back/front
; ok 0.06 - export selected Fx chanel
; ok 0.07 - file : save/load avec Fx
; ok 0.07 - scale
; ok 0.07 - preset save
; ok 0.13 - preset load
; - preset ADD
; - size w,h
; - Global color For fx
; - Gradient color fx
; - copy, paste Fx parameters
; - save Fx (all parameters)
; - clip : fx only draw in the shape
; Premade fx : (?)
; - stroke, size, back/front
; - shadowExt, size, color, back/front
; - reflet (rond ?), size, color, position, forme
; 
; ■ Timeline
; ok 0.13.5 - buttons play, Next, prev, currentframe, start/End frame, fps
; ok 0.17 - On timeline : buttons play, Next, prev, currentframe, start/End frame, fps
; ok 0.17 - canvas time & key
; ok 0.17 - keyframe visible
; ok 0.17 - Select keyframe
; ok 0.17 - move keyframe
; - delete keyframe
; - Add keyframe automatic / manual
; - copy/paste keyframe
; 
; ■ Animation
; ok 0.13.5 - play system & preview animation (no interpolation)
; - preview elements for animation 
; - preview animation With interpolation
; - we can Add keyframe
; - we can move keyframes
; - we can change shape parameters And animate it
; - key interpolation
; - animation move object / shape
; - animation rotate (object / shape)
; - animation scale (object / shape)
; - animation transformation option (cursor / bouding box / origin)
; 
; ■ Network
; ?? - Add a netwrok feature, For render farm Or other cool possibility
; ?? - work together on the same file ? Share file For team ??



;}

;{ bugs 

; - qd on clique sur rien, mais qu'en déplaçant la souris on rencontre un shape, ça le sélectionne et le bouge.
; - layer : w & h : not at the good position with view\x - y

; ok 
; 0.15
; - bug avec addpt : les nouveaux points sont mis n'importe comment !
; - tool line, curve bug with view

; 0.14
; - bug with Addfx : fx isn't add to the shape
; - bug With color if load file (because object\alpha = 0 with file <0.14)

;0.13
; - pas de save/load  des shape image !
; - when add a complex shape, it erase the old shape
; - when open a file, the layer isn't used as active
; - sometimes, add a new shape erase the name of the layer
; - when multiselect, selection for complexe shape hasn't the good position
; - changement de depth bug encore un peu

; 0.12
; - les images ne bougent pas avec move, sauf si on clique sur le point en haut à gauche
; - on ne peut plus bouger les points des shapes complexe/curve, line 
; - qd curve ou line, on ne doit pas bouger les autres points que le pot selected
; ok ? - qd on loade, ça ne place plus les nouveaux elements aux bons endroits

; 0.11
; - qd on ajoute un shape complexe et qu'on a un autre shape qui était sélectionné, on augmente la taille de l'ancien shape

; 0.10
; - bug Fx avec le zoom
; - qd on crée un nouveau objet-calque, ça crée un shape vide
; - qd on crée un shape complexe, ça bug

; 0.08
; - fx ne marchent pas correctement avec shape box, ellipse, line, curve...

; 0.07
; - avec ctrl+A ou shift, on ne peut pas déplacer et bouger plusieurs shapes
; - on ne peut plus bouger de point avec le zoom

; 0.06
; - on ne peut plus bouger de point avec le zoom ou view

; 0.04
; - changement de depth bug
; - corriger le scale qui bug un peu

; 0.03
; - qd on copie/coller un shape, color et alpha ne sont pas ok
; - qd on veut cliquer sur un shape, mais qu'aucun n'est sélectionné, ça ne marche pas
;}

;{ changes

; [16/05/2016] (0.18.1) (7h50-9h) (20)
; // New
; - View : show/hide timeline


; [24/04/2016] (0.18) (7h50-9h) (20)
; // New
; - Rndbox by Diskay


; [19/04/2016] (0.17) (7h50-9h) (20)
; // New
; - Timeline : buttons play,stop,start,end,loop
; - Timeline : Layer (+name) + button view, hide, selected layer
; - Timeline : frame rules/markers, keyframe, startframe,endframe,currentframe
; - Timeline : event (move keyframe, ascencor, currenframe...)
; - Version : X86 & X64


; [16/04/2016] (0.16) (7h50-9h) (19)
; // New
; - Hex option for : export in purebasic code
; - tool preset : add a new system for tool preset (with saving option)
; - Option tool : change with tool selected
; - Option canvas : now, some options are in the container for main canvas (snap..)
; - Canvas Path : to know if we modify the scene, object or shape (& pt)
; - Toolbar is now vertical
; - view : show anchor of selected shapes



; [15/04/2016] (0.15.5) (7h50-9h) (18)
; // New
; - Submenu : convertToShape (rectangle to shape complexe)
; - Submenu : convertToShape (ellipse to shape complexe)
; - View : Zoom 1000% & 1500%



; [13/04/2016] (0.15) (7h50-9h) (17)
; // New
; - View : Zoom 500%
; - View : view center
; - Zoom is no more limited to 250%
; - Option : menu Zoom 500%
; - Option : Show camera Cache
; - Option : camera Cache alpha
; - Now, at start, Cartoon Check For update.
; - point : multi-select & move (line, curve, complexe shape)
; - Point : set soft
; - Point : set hard
; - Help : wiki
; - Help : update
; // Changes
; - when pt selected: we can see a red circle on this point
; - when pt selected: SpinGadget pt X /Y is now updated
; // Fixes
; - when create a new shape, it was a bug with the view (line, curve, circle, box...)
; - when add points, it was a bug with view (line, curve, complexe shape)
; - numerous bugs with add pt fixed
; - Fixe a bug with delete key : work only if the active gadget = main canvas (to not erase our shape by mystake)
; - Fixe a bug for Spingadget point X & Y (doesn't work witht the last point)
; - Fixe a bug with position X & Y object-layer and ShapeFx
; - Fixe a bug when create new doc, object-layer alpha, & size was 0
; - various little bugs fixed


; [11/04/2016] (0.14) (7h50-9h) (16)
; // new
; - Image : change image
; - Shape : set shape to origin
; - Shape : set origin to shape
; - Shape : set shape to bottom
; - Shape : set shape to top
; // Fixes
; - fixe some bug in the export for purebasic
; - fixe a bug with Addfx : fx isn't add to the shape
; - fixe a bug With color if load file (because object\alpha = 0 with file <0.14)
; - fixe a bug if load old file (object width & height was 0)


; [10/04/2016] (0.13.5) (7h50-9h) (15)
; // new
; - Object-layer : alpha 
; AR - Image shape : X,Y,W,H,Repeat
; - add animation system (not finished) : draw fps and currentframe only
; - animation : play, fps, startframe, endframe, currentframe
; - StatusBar
; // Fixes
; - a few bugs


; [09/04/2016] (0.13) (7h50-9h) (14)
; 1ère version postée sur sourceforge ! 
; // New
; - Load preset is ok
; - Object-Layer : now, shape position use the position of the Object-Layer (x,y in "object" panel)
; - Object-Layer : size of the layer (w,h) can be changed
; - File> save, load : ok With shape image
; - Options > Change bg color
; - Options > BG checker
; // Fixes
; - the depth of the shape is ok now
; - when add a complex shape, it erase the old shape
; - when open a file, the layer isn't used as active
; - sometimes, add a new shape erase the name of the layer
; - when multiselect, selection for complexe shape hasn't the good position
; - deselect all > didn't deselect the current shapeId 


; [08/04/2016] (0.12) (7h50-9h) (13)
; // New
; - Add ExportPbCommand() : export circle, box, complex shape
; - we can close or open the path (checkbox "close")
; // Changes
; - save / load : add the x & y for the shape
; // Fixes
; - scale didn't work with box, ellipse, image,text
; - move : use the x & y  of the shape, et doesn't change the position of the point
; - creation of shape : now use the mouseX/mousey for x/y, for shape box,ellipse,text,image,roundbox
; - move : the image didn't move with the move tool
; - fixe a bug with the down buton for shape depth
; - the selected shape wasn't drawn with dashpath
; - when line, we don't have to move the 3 points when selecting a point
; - when creation shape complexe : it erase the shape0 of the current object
; - when load file, new object replaced the other
; - when load, the width/height/distance for style was always default if <10


; [06/04/2016] (0.12) (6h50-9h) (12)
; // New
; - Point (in panel shape) : button menu
; - popup menu (pt) : deletepoint



; [05/04/2016] (0.11) (6h50-9h) (11)
; // New
; - Shape : link -> to know if the path is "closed" after the previous shape
; - Shape : hide, lock
; // Fixes
; - when we add a new complexe shape, and another one was selected, the other is scaled if we increase the size of the new .



; [04/04/2016] (0.101) 
; - fixe a crash when select an object without shape
; - when delete a shape if the layer was empty, it deleted the shape of the previous layer
; - when mouse over a shape, it select the shape even if the shape wasn't on the selected object


; [04/04/2016] (0.10) (7h50-9h) (10)
; // New
; - ui objet (layer) : scrollarea, canvas, layer, hide, lock, alpha
; - objet-layer : add, del, up, down
; - TB : cbbox offset
; - TB : snap, snapX, snapY
; - show camera border, camera x,y,w,h
; - show Grid, grid w,y
; - Spin pt x et Y sont actifs
; - menu : export scene (image)
; // fixes
; - bug Fx avec le zoom
; - qd on crée un nouveau objet-calque, ça crée un shape vide


; [03/04/2016] (0.09) (7h50-9h) (9)
; // New
; - fichier options : load / save
; - btn font : Ajout du changement de font pour un text.
; - désormais, lorsqu'on n'a pas de shape, les bouton d'interface sont inactifs.
; - pour certains shapes, je cache certains boutons
; - file save/load : text ok
; // Fixes
; - qd on crée un text ou un shape au dessus d'un autre shape, ça peut le sélectionner au lieu de rester sur le shape qu'on crée



; [02/04/2016] (0.08) (7h50-9h) (8)
; // New
; - Properties : btn text pour changer le texte
; - shape X, Y : maintenant, j'utilise aussi un x et y pour la position du shape
; - tool line
; - tool curve
; - tool Text
; - Objet : Name,x,y createNewObj (checkbox),w,h
; - menu : deleteshape
; - menu : help : avec fichier help.rtf
; // changes
; - désormais, on peut supprimer le dernier shape (ou le premier)
; - file save/Load : sauvegarde désormais les objets
; - file save/Load : prend en compte les nouveaux types de forme (box,circle, line...)
; // Fixes
; - maintenant, on peut créer box et ellipse en changeant la taille à la création
; - les objets crées n'ont plus qu'un seul point dans vectoObj()\Shape()\pt() (box,circle...) sauf les line et curves
; - la selection (point tillé) est corrigée et suit l'objet désormais
; - qd on crée un objet, ça met certains paramètres par defaut (pour le fx et autres)


; [01/04/2016] (0.075) (7h50-9h) (7)
; // Fixe
; - qd export : fx sont exportés maintenant
; - les fx n'étaient pas bien dessinés pour les shapes de plus de 2 points
; - on ne peut plus bouger de point avec le zoom


; [31/03/2016] (0.07) (7h50-9h) (7)
; // New
; - Ajout btn tool : shape,box,ellipse,line, curve, image
; - ok tool AR : box, circle, image
; - AR : offset pour rotation , scale...
; - ajout position X et Y du shape pour l'offset
; - multi selection (en maintenant Shift appuyé)
; - désormais, on peut bouger, tourner ou redimensionner plusieurs shapes en même temps
; - Fx : enregistré et chargé dans le fichier du shape
; - shorcut zoom et reset ok
; - ajout dashpath() pour selection
; // Fixes
; - Fx scale : désormais, le path est relatif et donc fonctionne beaucoup mieux, qu'on le réduise, qu'on bouge les points ou qu'on transforme le path.



; [30/03/2016] (0.06) (7h50-9h) (6)
; // New
; Fx (=layer style)
; - select fx
; - Add new fx
; - fx parameter : x,y, style (filled, line, dash, dot & w,h,dist), alpha, color, depth (front, back)
; - fx : scale
; - export fx layer
; UI/menu
; - ui btn select
; - menu view : zoom+,-,50,100,200,reset view, show only sel, hide ancre
; - menu help : about
; - menu edit : ShapeLockSelect
; - Pan ok
; - zoom ok (with menu view)
; // fixes
; - le copier/coller de shape ne marchait plus
; - qd on sauve une image, il n'y avait pas d'extension
; - on ne peut plus bouger de point avec la view


; [29/03/2016] (0.05) (8h-9h30) (5)
; // new
; - Rotate shape seul
; - merge shape file : pour ajouter de nouveau shape à l'objet en cours
; // changes
; - j'ai changé pour les lignes et les points, pour enlever le "flick"
; // tests
; - j'ai testé l'ajout de Point (insert point), mais ça ne marche pas encore super bien
; // fixes


; [28/03/2016] (0.04) (9h-11h) (4)
; // new
; - on peut changer le type de path : filled, line, dash, dot
; - on peut changer la width, height et distance
; - désormais, qd on ajoute un shape, on peut choisir le shape à ajouter (depuis une combobox)
; - on peut agrandir un shape
; // Fixes
; - changement de depth bug
; - corriger le scale qui bug un peu


; [27/03/2016] (0.03) (9h-11h) (3)
; // New
; - on peut selectionner un shape en cliquant dessus
; - on peut supprimer un shape
; - save le meme fichier si on a déjà le nom
; - move shape seul 
; Ui
; - bouton toolbar
; - panel properties


; [26/03/2016] (0.02) (10h-11h30/17h-18h) (2)
; // New
; - change color
; - change alpha
; - shape nom
; - depth : up/down
; - pt get prop : x,y, alpha
; - ajout autosave
; Files
; - export image
; Edit
; - Copy current shape
; - past
; - past to current shape
; // Fixes
;-  system de point revu


; [25/03/2016] (0.01) (17h-18h) (1)
; // New
; - add shape
; - shape sélectionne point, bouge point
; Files
; - save, load shape



;}

;}


;{ structures 

Structure sTool
    
    LockX.a
    LockY.a
;     SizeTyp.a
;     SizeW.w
;     SizeH.w
    SizeProp.a

EndStructure


Structure sPoint
    
    x.i
    y.i
    LockX.a
    LockY.a
    startX.i    
    startY.i
    Selected.a
    
    Center.a ; le point "center", celui qu'on bouge (au milieu des anchor)
    Hard.a ; pour connaître la dureté du point : hard / soft
    
EndStructure

Structure sKey
    
    x.w
    y.w
    W.w
    H.w
    keyframe.w
    Array point.sPoint(0)
    
EndStructure

Structure sFXShape
    
    ; pour les effets (= style sur toshop)
    Nom$
    X.w
    Y.w
    Style.a
    Color.i
    Alpha.a
    Depth.a
    W.i
    H.i
    SizeW.w
    SizeH.w
    Scale.W
    Typ.a ; le typ 0=normal, 1 = shadow ext, 2 = stroke, 3 = glow int, 4 =glow ext, 5 = reflet (rond ?), 6 = light int, 7 = rimlight
    Dist.i
    Actif.a
    
    Clip.a
    
EndStructure

Structure sShape
    
    Nom$

    Array pt.sPoint(5)
    
    Array Fx.sFXShape(0)
    
    ShapTyp.a ; le type de shape : box, circle, shape, line, image...
    
    ; si c'est un text
    Text$
    Font.i
    FontName$
    FontStyle.i
    FontFx.i
    
    ;si on utilise une image
    Img.i
    ImgRepeat.w
    ImgW.w
    ImgH.w
    ImgRot.w
    ImgX.w
    ImgY.w
    
    Filename$ ; pour l'image par exemple
    
    ; rndbox
    Rnd.w
    
    ; transformations
    Size.d
    Rot.w
    X.w
    Y.w
    Scale.w
    SizeW.w   
    SizeH.w
    ; nécessaire pour les trnasformations par groupe (selected = 1)
    StartX.w
    StartY.w
    
    
    ; Offset 
    CurX.w ; necessaire pour connaitre le centre 
    CurY.w ; necessaire pour connaitre le centre 
    Cx.w
    Cy.w
    
    ; color, alpha
    Color.i
    ColorGrad.a ; couleur uni ou un dégradé ?
    Array ColGrad.i(0)
    Alpha.a
    
    ; paramètre du path
    Close.a ; il est clos ?
    Clip.a ; doit-on cliquer le shape dans le précédent ?
    Linked.a ; le shape est-il "lié " avec les autres ?, autrement dit ferme-t-on le chemin après le précédent ou le laisse-t-on ouvert ?

    ; le shape parent
    Parent.i
    
    
    ; depth
    Pos.i
    Depth.a
    
    ; Editor
    Selected.a
    Hide.a
    Locked.a
    
   
    ; pour le style
    Typ.a
    w.w
    h.w
    d.w ; distance for dot
    
EndStructure

; Structure sMesh
;    
;     ; informations internes
;     Array Shape.sShape(0) 
;     
; EndStructure

Structure sObj
    
    
    ; pour l'diteur
    BBoxW.w
    BBoxH.w
    Nom$ 
    
    
     ; editor
    Hide.a
    ShowBBox.a
    Locked.a
    Actif.a
    
    
    MeshId.i
    ParentId.i
    
    
   
    ; informations internes
    Array Shape.sShape(0) 
    
    
    ; Animations
    Depth.a
    Alpha.a
    Bm.a
    
    ; position du layer
    x.i
    y.i
    
    ; taille du layer
    w.w
    h.w
    
    ; rotation du layer
    RotX.w
    RotY.w
    Rot.w
    
   
    
EndStructure

Structure sVd
   
    ViewX.w
    ViewY.w
    Space.a
    SpaceX.i
    SpaceY.i
    
    PathId.a
    SceneID.w

    
    ; fichiers
    ShapeFileName$
    File$
    
    ; update
    NewVersion.d
    NewVersionTxt$
    UpdateOk.a
    
    ; animation
    CurrentFrame.i
    Play.a
    PlayTimer.f
    Loopiz.a
    FrameEnd.w
    FrameStart.w
    FrameFps.w
    
    
    ; action éditeur
    AddObjet.a    
    Move.a
    TestShapeOk.b
    ClicLb.b
    KeyPressed.a
    Shift.a ; pour savoir si shift est appuyé
    LockSelection.a; pour locker la sélection
    CreateObj.a
    NbShape.b ; just besoin pour supprimer le dernier shape car tableau ne peut pas etre négatif helas
    
EndStructure

Structure sVdOptions
    
    
    Array Tool.sTool(20)
    
    
    Action.a
    
    ShowTip.a
    ConfirmExit.a
    
    ; window
    WinW.w
    WinH.w
    WinState.i
    Zoom.i ; le zoom
    
    ; show/hide
    HideAncre.a
    ShowAncreSelected.a
    ShowOnlySel.a
    ShowSelection.a
    ShowCameraBorder.a
    ShowCameraCache.a
    ShowCameraSafe.a
    CameraCacheAlpha.a
    
    ShowTimeLine.a
    
    
    ; Ui
    PanelW.w
    ToolBarH.w
    ToolBarW.w
    ToolBarVertical.w
    ToolBarNbCol.w
    ToolBarOptionH.w
    
    TimeLineH.w
    ColorGadget.i
    
    
    ; camera
    CameraX.w
    CameraY.w
    CameraW.w
    CameraH.w
    CameraSizeH.w
    CameraSizeW.w
    
    
    ; color
    BgColor.i
    BgImg.i
    GridColor.i
    TimeLineColor.i
    CameraCacheColor.i
    
    
    ;options
    Autosave.a
    AutosaveTime.i
    
    UseHexForPBCode.a
    
    Snap.a
    SnapX.w
    SnapY.w
    
    Offset.a ; type d'offset
    
    GridW.w
    GridH.w
    ShowGrid.a
    
EndStructure


;{ la scène
Structure sKeySc
    
    x.w
    y.w
    keyframe.w
    ShapeKey.w
    
EndStructure

Structure sLayer 
    
    ObjId.w ; l'objet auquel il fait référence
    Name$
    
    Hide.a
    Locked.a
    ShowKey.a
    
    Array key.sKeySc(0)
    
    ; pour l'animation
    CurX.d
    CurY.d
    RatioX.d
    RatioY.d
    NextKey.w
    CurKey.w
    CurShapeKey.w
    
EndStructure

Structure sScene
        
    Array Layer.sLayer(0)
    
    FrameStart.w
    FrameEnd.w
    FrameTotal.w
    
    Name$
        
EndStructure
Global Dim Scene.sScene(0)
;}

;}


;{ variables, constantes 

CompilerIf Not Defined(White, #PB_Constant)
  #White = $EEEEEE
CompilerEndIf

#ProgramVersionVD = "0.18"
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86     
    #ProgramBitVD = " (x86)"
CompilerElse
    #ProgramBitVD = " (x64)"
CompilerEndIf
#ProgramNameVD = "Cartoon Animation "

Enumeration 
    
    
    ;{ Window
    #Win_VectorDrawing = 2
    #Win_VD_update
    ;}
    
    ;{ gadgets
    #G_canvasVector = 0
    
    #G_CanvasPathVD
    #G_CanvasPathVDScene
    #G_CanvasPathVDObjet
    #G_CanvasPathVDShape
    
    #G_CanvasOptionVD
    #G_ToolVDOffset
    #G_ToolVDSnap
    #G_ToolVDSnapX
    #G_ToolVDSnapY
    
    
    ; Timeline
    #G_VDTimeline
    
    
    
    
    ;{ toolbar
    
    ;{ options des outils
    #G_ToolBarOptionVD
    #G_TBOptionToolSet
    
    #G_TBOptionToolInfo
    
    ; tjs le premier de la liste des options des outils
    #G_TBOptLockX 
    #G_TBOptLockY
    #G_TBOptLockW
    #G_TBOptLockH
    #G_TBOptSizeTyp
    
    
    
    ; toujours dernier des options des outils
    #G_TBOptSizeLast 
    ;}
    
    
    #G_ToolBarVD
    
    #G_ToolVDMove    
    #G_ToolVDSelect
    #G_ToolVDScale
    #G_ToolVDRot
    #G_ToolVDTransform
    #G_ToolVDAddPt
    #G_ToolVDInsertPt
    #G_ToolVDDelPt
    
    #G_ToolVDShape 
    #G_ToolVDBox
    #G_ToolVDBoxRnd
    #G_ToolVDCircle
    #G_ToolVDLine
    #G_ToolVDCurve
    #G_ToolVDImage
    #G_ToolVDText
    
    #G_ToolVDLast
    
   
    
    
    
    
    #G_ToolVDLast2
    ;}
    
    
    #G_PanelFirst ;first panel gadget, needed for some menu
    
    ;{ Panel left  (properties, color, fx)  
    #G_panelVD
    
    ;{ objet
    
    #G_ObjSA
    #G_ObjList
    #G_ObjDepth
    #G_ObjName
    #G_ObjX
    #G_ObjY
    #G_ObjCreate
    #G_ObjHide
    #G_ObjLock
    #G_ObjLockAlpha
    #G_ObjW
    #G_ObjH
    #G_ObjRot
    #G_ObjAdd
    #G_ObjDel
    #G_ObjUp
    #G_ObjDown
    #G_ObjBm
    #G_ObjAlpha
    
    #G_ObjFirst ; non utilisé, mais nécessaire
                ;}
    
    ;{ Properties
    #G_shapeList
    #G_shapeNom 
    
    #G_shapeHide     
    #G_shapeLock     
    #G_shapeLink    
    #G_shapeClose   
    #G_shapeClip  
    
    #G_shapeAdd    
    #G_shapeListAdd   
    #G_shapeDel    
    #G_shapeColor
    #G_shapeColorTyp
    #G_shapeGradient    
    #G_shapeTexture 
    #G_shapeTextureOk 
    #G_shapeAlpha
    #G_shapePosUp
    #G_shapePosDown    
    #G_shapeCX
    #G_shapeCY
    #G_shapeX
    #G_shapeY
    #G_shapeSizeW
    #G_shapeSizeH
    #G_shapeTyp
    #G_shapeLineW ; width of the line (for line, dash, dot)
    #G_shapeLineH ; height for dash
    #G_shapeLineD ; distance for dot
    
    #G_shapeRnd
    
    #G_shapeText
    #G_shapeTextFont
    
    #G_shapeImgChange
    #G_shapeImgRepeat
    #G_shapeImgX
    #G_shapeImgY
    ;#G_shapeImgRot
    #G_shapeImgW
    #G_shapeImgH
    ;}
    
    ;{ point
    #G_shapeAddPt
    #G_shapeDelPt
    
    #G_shapePtX
    #G_shapePtY
    #G_shapePtMenu
    #G_shapePtHard
    #G_shapePtSoft
    #G_shapePtXlock
    #G_shapePtYLock
    #G_shapePtLine
    #G_shapePtCurve
    ;}
    
    ;{ FX
    #G_shapeFxPresetList
    #G_shapeFxPresetAdd
    #G_shapeFxPresetSave
    #G_shapeFxList
    #G_shapeFxAdd
    #G_shapeFxActif
    #G_shapeFxX
    #G_shapeFxY
    #G_shapeFxDepth
    #G_shapeFxAlpha
    #G_shapeFxColor
    #G_shapeFxColorTyp ; filled, gradient linear, circle gradient
    #G_shapeFxLineTyp
    #G_shapeFxLineW
    #G_shapeFxLineH
    #G_shapeFxLineD
    #G_shapeFxScale
    #G_shapeFxSizeH
    #G_shapeFxSizeW
    #G_shapeFxClip
    
    
    #G_shapeLast
    
    
    ;}
    ;}
    
    ;{ Panel control anim
    #G_PanelVDControl
    
    #G_VDAnimPlay
    #G_VDAnimFps
    #G_VDAnimStart
    #G_VDAnimEnd
    #G_VDAnimCurFrame
    #G_VDAnimMaxFrame
    ;}
    
    ;{ panel right
    
    #G_panelVD_R
    
    ; options
    #G_Vd_OptBGCheck
    #G_Vd_OptBGColor
    #G_Vd_OptCamCachAlpha
    
    
    #G_PanelLast ; last panel gadget, needed for some menu
    ;}
    
    ;autre gadgets
    #G_VD_UpdateEdit
    #G_VD_UpdateBtnOk
    #G_VD_UpdateBtnCancel
    
    
    ;}
    
    ;{ menu
    
    #MenuWinVD = 2
    
    #MenuVDPopUpPt
    ; #MenuVDPopUp
    
    ; files
    #menuVD_ShapeNew =0
    #menuVD_ProjNew
    #menuVD_ProjOpen
    #menuVD_ProjSave
    #menuVD_ProjSaveCopy
    #menuVD_ShapeOpen 
    #menuVD_ShapeMergeObj 
    #menuVD_ShapeMergeShape 
    #menuVD_ShapeSave 
    #menuVD_ShapeSaveAs
    #menuVD_ShapeExport
    #menuVD_ExportScene
    #menuVD_ExportPb
    #menuVD_ShapeQuit
    
    ; edit    
    #menuVD_ShapeSelectAll    
    #menuVD_ShapeDeselectAll    
    #menuVD_ShapeCopy 
    #menuVD_ShapePast
    #menuVD_ShapePastToshape 
    #menuVD_ShapeLockSelect
    #menuVD_ShapeDelete    
    #menuVD_SetShapeToBottom
    #menuVD_SetShapeToTop
    #menuVD_SetShapeToOrigin
    #menuVD_SetShapeToCursor
    #menuVD_SetOriginToShape
    
    
    #menuVD_DeleteObjet
    #menuVD_AddObjet
    #menuVD_SetObjetToBottom
    #menuVD_SetObjetToTop
    #menuVD_MergeObjetWithBottom
    
    
    ;view
    #menuVD_Zoomplus
    #menuVD_ZoomMoins
    
    #menuVD_Zoom50
    #menuVD_ZoomReset
    #menuVD_Zoom200
    #menuVD_Zoom500    
    #menuVD_Zoom1000
    #menuVD_Zoom1500
   
    
    #menuVD_HideAncre
    #menuVD_ShowAncreSelected
    #menuVD_ShowOnlySelected
    
    #menuVD_ShowSelection
    #menuVD_ViewReset
    #menuVD_ViewCenter
    #menuVD_ShowGrid
    #menuVD_ShowCamBorder
    #menuVD_ShowCamCache
    
    
    ; Window
    #menuVD_WS_Draw
    #menuVD_WS_Animation
    #menuVD_WS_Compo
    #menuVD_WS_Scene
    #menuVD_WS_Sequence
    #menuVD_ShowTimeLine
    
    ;help
    #menuVD_About
    #menuVD_Update
    #menuVD_Help
    #menuVD_HelpHtml
    #menuVD_Wiki
    
    
    ; pop up
    
    ; pt
    #menuVD_PathClose
    #menuVD_PathOpen
    #menuVD_AddPtBefore
    #menuVD_AddPtAfter
    #menuVD_CopyPt
    #menuVD_DeletePt
    #menuVD_ConvertToline
    #menuVD_ConvertToCurve
    #menuVD_ConvertToShape
    #menuVD_SeparateShape
    #menuVD_JointShape
    #menuVD_PtSelectAll
    
    
    
    
    #menuVD_Last
    
    ;}
    
    ;{ action VD
    #VD_actionMove =0
    #VD_actionSelect
    #VD_actionScale
    #VD_actionRot
    #VD_actionTransform
    #VD_actionAddPt
    #VD_actionInsertPt
    
    
    
    
    
    
    #VD_actionDelPt ; toujours avant #VD_actionAddShape
    
    ; attention, même position que les gadgets
    #VD_actionAddShape
    #VD_actionAddBox
    #VD_actionAddBoxRnd
    #VD_actionAddCircle
    #VD_actionAddLine
    #VD_actionAddCurve
    #VD_actionAddImage
    #VD_actionAddText
    ;}
    
    ;{ shape type
     ; attention, meme sens que gadget et action !! 
    #VD_ShapeShape = 0
    #VD_ShapeBox    
    #VD_ShapeBoxRnd
    #VD_ShapeCircle
    #VD_ShapeLine
    #VD_ShapeCurve
    #VD_ShapeImage
    #VD_ShapeText
   
    ;}
    
    ;{ Style FX
    #VD_StyleFilled = 0
    #VD_StyleLine
    #VD_StyleDash
    #VD_StyleDot
    ;}
    
    ;{ Type de gadgets
    #Gad_Spin = 0    
    #Gad_String
    #Gad_Btn
    #Gad_BtnImg
    #Gad_Chkbox
    #Gad_Cbbox
    #Gad_ListV
    
    ;}
    
    ;{ messagerequester 
    #MR_error=16
    #MR_Question=32
    #MR_QuestionYEsNo=33
    #MR_Info=64
    #MR_InfoYesCancel=65
    ;}
    
    ;{ files
    #JSONFile = 0
    ;}
    
    ;{ Images
    
    ; Images
    #Img_bg = 1 
    
    ; là, je dois remettre à 0
    #Img_Move = 0
    #Img_Rot
    #Img_Scale
    #Img_Addpt
    #Img_Delpt
    #Img_Select
    #Img_Zoom
    #Img_Pan
    #Img_Shape
    #Img_Box
    #Img_BoxRnd
    #Img_Circle
    #Img_Line
    #Img_Curve
    #Img_Image
    #Img_Text
    #Img_FreeForm
    #Img_Polygon
    #Img_Star
    
    #Img_Properties
    #Img_Hard
    #Img_Soft
    
    
    ; play timeline
    #Img_Play     
    #Img_Stop 
    #Img_Loop 
    #Img_Start 
    #Img_End
    
    
    
    #Img_VdLast ; tjs dernier
    
    
    ;}
    
    ;{ Workspace
    #VD_WorkSpaceScene =0
    #VD_WorkSpaceObject
    #VD_WorkSpaceLNA
    #VD_WorkSpaceSequence
    #VD_WorkSpaceCompo
    
    #VD_PathScene = 0
    #VD_PathObj 
    #VD_PathShape 
    ;}
    
    
    
EndEnumeration

;}


If UsePNGImageDecoder() = 0 Or UsePNGImageEncoder()= 0 Or UseJPEGImageDecoder() = 0 Or UseJPEGImageEncoder() = 0
    MessageRequester("Error","Unable to open the image encode/decoder",16)
    End
EndIf


;{ utile
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

;}


;{ procedures 


;{ Declaration

; init
Declare InitVectorDrawing()
Declare InitShapeImages()
Declare Vd_OptionsReset()
Declare VD_SaveOptions()
Declare VD_LoadOptions()
Declare InitVD()

; gadgets & menu
Declare AddGadget(id,typ,x,y,w,h,txt$="",min=0,max=0,tip$="",val=-65257)
Declare Vd_CreateToolbar()
Declare SetPanelGadget(disable=0)
Declare VD_CreateObjectUi()
Declare Vd_SetGadgetOption()

; shape edit
Declare ShapeGetProperties()
Declare ShapeSelectAll(Selection=1)
Declare VD_ShapeChangeImage()
Declare VD_ConvertShape(to_Pt=1)
Declare ShapeDelete()
Declare Vd_SetPoint(param=0,draw=1)

; draw
Declare ShapeDrawFx(Obj,Shape,fx)
Declare VDDrawFx(vo,j,dessus=0)
Declare VdDrawShape1(vo,j)
Declare VDDrawShapeColor(vo,j)
Declare Grid3D()
Declare VDDrawUtil()
Declare DrawCanvas(x=0,y=0,Selected=1)

; ui, update
Declare UpdateListShape()
Declare UpdateListAddShape()
Declare UpdateListShapeFX()
Declare UpdateListPresetFx()
Declare UpdateUiObjetVD(update=0)
Declare Vd_ResizeAll()


; file
Declare ShapeExportFx()
Declare ShapeLoadFx()
Declare ShapeExportFxLayer()
Declare ShapeLoadFxLayer(nom$)
Declare ShapeAddFx(i=0)
Declare ShapeAddObjet(x,y)
Declare VDOpenTheHelp(html=0)
Declare ShapeSave(file$ = "",autosave=0)
Declare ShapeNew(eraseall=1, copy=0,draw=1)
Declare ShapeLoad(merge=0, file$ ="",draw=1)
Declare ShapeExport(scene=0)


Declare OpenWinVectorDrawing()



;}


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
    
    ; pour initialiser le programme (utile pour sprite animation)
    Global Dim Obj.sObj(0)
    Obj(0)\Shape(0)\color = -12577347
    
    
    ; Global Dim Animation.sAnim(0)
    
    
    Global CopyObj.sObj
    
    Global ObjId.i, ShapeId.i, ShapeFxId.i, PtId.i, KeyId.i
    
    Global Vd.sVd
    Global VdOptions.sVdOptions
    
    Global Dim ShapeFx.sFXShape(0)
    
    ; LoadFont(0, "Times New Roman", 20, #PB_Font_Bold)
    
    ; puis, on cahrge les préférences
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

Procedure InitShapeImages()
    
    ; chargement des images 
    
    Global Dim ImgVD.i(#Img_VdLast)
   
    ImgVd(#Img_Move)    = LoadImage2(#PB_Any,"data\editor\move.png")
    ImgVd(#Img_Rot)     = LoadImage2(#PB_Any,"data\editor\rotate.png")
    ImgVd(#Img_Scale)   = LoadImage2(#PB_Any,"data\editor\scale.png")
    ImgVd(#Img_Addpt)   = LoadImage2(#PB_Any,"data\editor\addpt.png")
    ImgVd(#Img_Delpt)   = LoadImage2(#PB_Any,"data\editor\delpt.png")
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
    
    
    ; ImgVd(20) = LoadImage2(#PB_Any,"data\paper\paper1.png")
    
    
    
   
    
    Enumeration 
        #ivd_layer    
        #ivd_layersel    
        #ivd_layeradd    
        #ivd_layerdel    
        #ivd_layerhide    
        #ivd_layerlock    
        #ivd_layerup   
        #ivd_layerdown  
    EndEnumeration
    
    Global Dim ImgLayer.i(10)
    
    ImgLayer(#ivd_layer)        = LoadImage(#PB_Any,"data\editor\layer.jpg")
    ImgLayer(#ivd_layersel)     = LoadImage(#PB_Any,"data\editor\layerSel.jpg")
    ImgLayer(#ivd_layeradd)     = LoadImage(#PB_Any,"data\editor\layerbtn1.jpg")
    ImgLayer(#ivd_layerdel)     = LoadImage(#PB_Any,"data\editor\layerbtn2.jpg")
    ImgLayer(#ivd_layerhide)    = LoadImage(#PB_Any,"data\editor\layerEye.jpg")
    ImgLayer(#ivd_layerlock)    = LoadImage(#PB_Any,"data\editor\locked.png")
    ImgLayer(#ivd_layerup)      = LoadImage(#PB_Any,"data\editor\up.png")
    ImgLayer(#ivd_layerdown)    = LoadImage(#PB_Any,"data\editor\down.png")
    
    
    If LoadFont(0,"arial",30) : EndIf
   
EndProcedure



; options
Procedure Vd_OptionsReset()
    
    With VDOptions
        
        \winw = 1024
        \winh = 768
        \WinState   = #PB_Window_Maximize
        
        \HideAncre      = 0
        \ShowOnlySel    = 0
        \ShowSelection  = 1
        \ShowCameraBorder   = 1
        \ShowCameraCache    = 1
        \CameraCacheAlpha   = 255
        
        \Action   = 0
        
        ; camera
        \CameraX=0
        \CameraY=0
        \CameraW=1024
        \CameraH=768

        
        \ShowGrid = 0
        \GridColor = RGBA(200,200,200,255)
        \GridW = 32
        \GridH = 32
        
        \BgColor = RGBA(120,120,120,255)
        \ColorGadget = RGB(150,150,150)
        
        \PanelW     = 150
        \ToolBarH   = 25
        \TimeLineH  = 80
        
        \ConfirmExit = 1
        \ShowTip    = 1
        \Zoom       = 100
        \Autosave   = 1
        \AutosaveTime = 180
        
        \Snap   = 0
        \SnapX  = 32
        \SnapY  = 32
        \Offset = 0
        
    EndWith
    
EndProcedure

Procedure VD_SaveOptions()
    
    FileName.s = GetCurrentDirectory() + "Preferences.ini"

    ; Sauvegarde des options
    CreateJSON(#JSONFile)
    InsertJSONStructure(JSONValue(#JSONFile), @VdOptions, sVdOptions)
    SaveJSON(#JSONFile, FileName, #PB_JSON_PrettyPrint)

EndProcedure

Procedure VD_LoadOptions()
    
    Vd_OptionsReset()
    
    FileName.s = GetCurrentDirectory() + "Preferences.ini"
    
    If FileSize(FileName) < 0        
        VD_SaveOptions()
    EndIf
        
    ; Lecture des options
    LoadJSON(#JSONFile, FileName, #PB_JSON_NoCase)
    ExtractJSONStructure(JSONValue(#JSONFile), @VdOptions, sVdOptions)
    
 
    min(VdOptions\TimeLineH, 20)
    
    
    
EndProcedure

Procedure InitVD()
    
    InitShapeImages()
    
    With Vd
        \ShapeFileName$="1-defaut.txt"        
        \FrameEnd = 300
        \FrameFps  = 24
    EndWith
        
EndProcedure

;}



;{ gadgets & menu

Procedure AddGadget(id,typ,x,y,w,h,txt$="",min=0,max=0,tip$="",val=-65257)
    
    
    ; pour ajouter plus facilement un gadget
    
    If txt$ <> "" And typ <= #Gad_String 
        w1 = 35
        If TextGadget(#PB_Any,x,y+2,w1,h,txt$) : EndIf    
        ;w1
    EndIf
    
    
    Select typ
        Case #Gad_spin
            If SpinGadget(id, x+w1,y,w,h,min,max,#PB_Spin_Numeric) : EndIf
            
        Case #Gad_String
            If min = 1
                If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_Numeric) : EndIf
            Else
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
            If CheckBoxGadget(id,x+w1,y,w,h,txt$) : EndIf    
            
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
        SetGadgetState(id,val)
    EndIf
    
EndProcedure

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
    min(winh,600)
    
    min(VdOptions\ToolBarNbCol,1)
    ww = VdOptions\ToolBarNbCol * (h2+5)
    min(hh,20)
    min(ww,30)
    VdOptions\ToolBarW = ww
    
    ; puis, on le recrée
    If VdOptions\ToolBarVertical = 0
        
        If ContainerGadget(#G_ToolBarVD,0,0,winw,hh)
            
            ; create tools
            AddGadget(#G_ToolVDShape, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Shape),"Add a complex shape.")         : x1+h2+a
            AddGadget(#G_ToolVDBox, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Box),"Add a box.")         : x1+h2+a
            AddGadget(#G_ToolVDBoxRnd, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_BoxRnd),"Add a rounded box.")         : x1+h2+a
            AddGadget(#G_ToolVDCircle, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Circle),"Add a circle.")         : x1+h2+a
            AddGadget(#G_ToolVDLine, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Line),"Add a line.")         : x1+h2+a
            AddGadget(#G_ToolVDCurve, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Curve),"Add a curve.")         : x1+h2+a
            AddGadget(#G_ToolVDImage, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Image),"Add a image.")         : x1+h2+a
            AddGadget(#G_ToolVDText, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Text),"Add a text.")         : x1+h2+a
            
            x1 + 5
            ; transformations
            AddGadget(#G_ToolVDSelect, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Select),"Select the Shape.")         : x1+h2+a
            AddGadget(#G_ToolVDMove, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Move),"Move the Shape or the points.")         : x1+h2+a
            ; ButtonImageGadget(#G_ToolVDTransform, x1,y1,h2,h2,ImageID(ImgVd(2)))  : x1+h2+2
            AddGadget(#G_ToolVDScale, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Scale),"Scale the shape.")       : x1+h2+a
            AddGadget(#G_ToolVDRot, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Rot),"Rotate the shape.")           : x1+h2+5
            
            AddGadget(#G_ToolVDAddPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Addpt),"Add a point.")           : x1+h2+a
            AddGadget(#G_ToolVDDelPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Delpt),"Delete a point.")           : x1+h2+a
            
            x1 + 5 : y1 + 2
            ; Offset, snap
            AddGadget(#G_ToolVDOffset, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,"Choose the offset for transformation.") : x1+w1+a+5
            t$ ="Origin,Cursor,Bounding box,Selected shape"
            For i = 0 To CountString(t$,",")
                AddGadgetItem(#G_ToolVDOffset,i,StringField(t$,i+1,","))
            Next
            SetGadgetState(#G_ToolVDOffset,0)
            
            AddGadget(#G_ToolVDSnap, #Gad_Chkbox, x1,y1,w2,h1,"Snap",0,0,"Set the Snap.",VdOptions\Snap) : x1+w2+a
            AddGadget(#G_ToolVDSnapX, #Gad_Spin, x1,y1,w2,h1,"",1,100000,"Set the Snap X.",VdOptions\SnapX) : x1+w2+a
            AddGadget(#G_ToolVDSnapY, #Gad_Spin, x1,y1,w2,h1,"",1,100000,"Set the Snap Y.",VdOptions\SnapY) : x1+w2+a
            
            y1-2
            
            CloseGadgetList()
        EndIf
        
        If ContainerGadget(#G_ToolBarOptionVD,0,0,winw,hh)
            CloseGadgetList()
        EndIf
        
    Else
        
        y1 = hh
        x1 = 0
        If ContainerGadget(#G_ToolBarVD,0,y1,ww,winH, #PB_Container_Raised)
            
            y1 = 0
            ; create tools
            AddGadget(#G_ToolVDShape, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Shape),"Add a complex shape.") : x1+h2 ; y1+h2+a
            AddGadget(#G_ToolVDBox, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Box),"Add a box.")        : x1 = 0  : y1+h2+a
            AddGadget(#G_ToolVDBoxRnd, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_BoxRnd),"Add a rounded box.")   : x1+h2;       : y1+h2+a
            AddGadget(#G_ToolVDCircle, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Circle),"Add a circle.")     : x1 = 0 : y1+h2+a
            AddGadget(#G_ToolVDLine, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Line),"Add a line.")         : x1+h2;  : y1+h2+a
            AddGadget(#G_ToolVDCurve, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Curve),"Add a curve.")         : x1 = 0 : y1+h2+a
            AddGadget(#G_ToolVDImage, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Image),"Add a image.")        : x1+h2;   : y1+h2+a
            AddGadget(#G_ToolVDText, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Text),"Add a text.")         : x1 = 0 : y1+h2+a
            
            y1 + 5
            ; transformations
            AddGadget(#G_ToolVDSelect, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Select),"Select the Shape.")         : x1+h2
            AddGadget(#G_ToolVDMove, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Move),"Move the Shape or the points.")     : x1=0 : y1+h2+a
            ; ButtonImageGadget(#G_ToolVDTransform, x1,y1,h2,h2,ImageID(ImgVd(2)))  : x1+h2+2
            AddGadget(#G_ToolVDScale, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Scale),"Scale the shape.")     : x1+h2;
            AddGadget(#G_ToolVDRot, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Rot),"Rotate the shape.")        : x1=0 : y1+h2+a
            
            y1 +5
            AddGadget(#G_ToolVDAddPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Addpt),"Add a point.")          : x1+h2;
            AddGadget(#G_ToolVDDelPt, #Gad_BtnImg, x1,y1,h2,h2,"",1,ImgVd(#Img_Delpt),"Delete a point.")       : x1=0 : y1+h2+a
            
          
            CloseGadgetList()
        Else
            Debug "erreur toolbar !" +ww+"/"+winH 
        EndIf
        
        If ContainerGadget(#G_ToolBarOptionVD,0,0,winw,hh) 
            CloseGadgetList()
            Vd_SetGadgetOption()
        EndIf
        
        
        
    EndIf
    
    
EndProcedure

Macro VD_ShowMenu(Id,menu)
    
    menu = 1- menu
    SetMenuItemState(#MenuWinVD,Id, menu)
    Drawcanvas()
    
EndMacro

Macro Vd_SetGadgetstate(param)
    
     If shapeId> -1
         Obj(ObjId)\Shape(ShapeId)\param = GetGadgetState(EventGadget())
         DrawCanvas()
     EndIf
    
EndMacro


Procedure VD_CreateObjectUi()
    
        ; pour créer l'interface des objets (= layers)

    x1 = 5 : y1 = 10 : a= 5 : b = 3
    w1 = 50
    h1 = 25 : h2 = 20
    hh =200
   
   
    AddGadget(#G_ObjAlpha, #Gad_Spin,x1,y1,w1,h2,"",0, 255, "Change the alpha of the object (layer).") : x1+w1+a
    
    y1+h2+b : x1 = 5
    AddGadget(#G_ObjLock, #Gad_BtnImg,x1,y1,h2,h2,"",1, ImgLayer(#ivd_layerlock), "Lock the object (layer).") : x1+h2+a

    y1 + h1+b : x1 = 5
    
    If ScrollAreaGadget(#G_ObjSA,x1,y1,VdOptions\PanelW - 20,hh,VdOptions\PanelW-42,300,#PB_ScrollArea_BorderLess)
       
        If CanvasGadget(#G_ObjList,0,0,VdOptions\PanelW, 500)
            UpdateUiObjetVD()
        EndIf
        CloseGadgetList()
    EndIf
    
    y1+hh+b
    
    AddGadget(#G_objAdd, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layeradd), "Add a new Object (layer).") :x1 +h2+b
    AddGadget(#G_ObjDel, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerdel), "Delete the current Object (Layer).") :x1 +h2+b
    AddGadget(#G_ObjUp, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerup), "Move the Object (Layer) up.") :x1 +h2+b
    AddGadget(#G_ObjDown, #Gad_BtnImg,x1,y1,h2,h2,"",0, ImgLayer(#ivd_layerdown), "Move the Object (Layer) down.") :x1 +h2+b

    y1 + h1 +b
    
    ProcedureReturn y1
EndProcedure

Procedure VD_CreatePopUpMenu()
    
    ; pour créer les menu popup :
    ; - menu popup pour les points (clic droit sur point)
    
    If CreatePopupMenu(#MenuVDPopUpPt) ; ,WindowID(#Win_VectorDrawing)) 
        
        ; MenuItem(#menuVD_PathOpen,"Open path")
        ; MenuItem(#menuVD_PathClose,"Close path")
        ; MenuBar()
        ; MenuItem(#menuVD_AddPtBefore,"Add point before this point")        
        ; MenuItem(#menuVD_AddPtAfter,"Add point after this point")
        MenuItem(#menuVD_PtSelectAll,"Select all the points of the shape")
        MenuBar()
        MenuItem(#menuVD_DeletePt,"Delete this point")
        MenuBar()
        MenuItem(#menuVD_ConvertToline,"Convert to line")
        MenuItem(#menuVD_ConvertToCurve,"Convert to curve")
        MenuItem(#menuVD_ConvertToShape,"Convert to complexe shape")
        MenuBar()
        MenuItem(#menuVD_SeparateShape,"Separate all sub-shape to shape")
        MenuItem(#menuVD_JointShape,"Joint selected shape")
        
    EndIf
  
  
  
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


; procedure pour gadgets
Procedure Vd_SetGadgetOption()
    
    ; pour changer les options des gadgets
    
    
    x1=0 : h1=25 : a=3 : w1=150 : w2=75
    
    If OpenGadgetList(#G_ToolBarOptionVD)
        
        If IsGadget(#G_TBOptionToolSet) = 0
            AddGadget(#G_TBOptionToolSet,#Gad_BtnImg,x1,0,h1,h1,"",0,ImgVd(#Img_Properties),"Tools preset")
        EndIf
        
        x1+h1+a
        x1 + a*3
        e.d = 7.2
        ; on supprime les gadgets
        For i = #G_TBOptionToolInfo To #G_TBOptSizeLast-1
            If IsGadget(i)
                FreeGadget(i)
            EndIf
        Next
        
        ; puis, on crée les gadget en fonction de l'action (autrement de l'outil sélectionné)
        Select VdOptions\Action
                
            Case #VD_actionAddBox
                w = Len("Proportionnal")*e
                AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,0,w,h1,"Proportionnal ",0,0,"Use the proportionnal for size",VdOptions\Tool(vdOptions\Action)\LockX) : x1+w+a

            Case #VD_actionAddCircle
                w = Len("Proportionnal")*e
                AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,0,w,h1,"Proportionnal ",0,0,"Use the proportionnal for size",VdOptions\Tool(vdOptions\Action)\LockX) : x1+w+a
                
            Case #VD_actionMove
                w = Len("Lock X ")*e
                AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,0,w,h1,"Lock X",0,0,"Lock X direction",VdOptions\Tool(vdOptions\Action)\LockX) : x1+w+a            
                AddGadget(#G_TBOptLockY,#Gad_Chkbox, x1,0,w,h1,"Lock Y",0,0,"Lock Y direction",VdOptions\Tool(vdOptions\Action)\LockY)
                
            Case #VD_actionScale
                w = Len("Lock Width")*e
                AddGadget(#G_TBOptLockX,#Gad_Chkbox, x1,0,w,h1,"Lock Width",0,0,"Lock Width direction",VdOptions\Tool(vdOptions\Action)\LockX) : x1+w+a
                AddGadget(#G_TBOptLockY,#Gad_Chkbox, x1,0,w,h1,"Lock Height",0,0,"Lock Height direction",VdOptions\Tool(vdOptions\Action)\LockY)
                
                            
            Default
                ;TextGadget(#G_TBOptionToolInfo,x1,4,w1,h1,"No options for this tool")
                
        EndSelect
        
        CloseGadgetList()
    EndIf
    
EndProcedure


; timeline
Procedure Vd_TimeLineUpdate()
    
    
    ; Base par Micoute, modifié par Blendman
    gadget = #G_VDTimeline
    Protected HauteurPolice.i, X.i, Y.i, Hauteur.i
    Shared PositionAscenseurY.w,PosX.w,AutoriserAscenseur.i
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
        For i=0 To WindowWidth(#Win_VectorDrawing)
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
                                    selectedY = ArraySize(Scene(vd\SceneID)\layer())    ; ListSize(Layer())-1
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
                                    selectedY = ArraySize(Scene(vd\SceneID)\layer())    ; ListSize(Layer())-1
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



; les procédures pour le shapes
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
            For i=#G_shapeText To #G_shapeTextFont
                DisableGadget(i,0)
            Next  
            For i=#G_shapeImgChange To #G_shapeImgH
                DisableGadget(i,1)
            Next 
        ElseIf Obj(ObjId)\Shape(ShapeId)\ShapTyp = #VD_ShapeImage
            Debug "image gadget"
            For i=#G_shapeText To #G_shapeTextFont
                DisableGadget(i,1)
            Next  
            For i=#G_shapeImgChange To #G_shapeImgH
                DisableGadget(i,0)
            Next 
        Else            
            For i=#G_shapeText To #G_shapeTextFont
                DisableGadget(i,1)
            Next  
            For i=#G_shapeImgChange To #G_shapeImgH
                DisableGadget(i,1)
            Next 
            
        EndIf
    EndIf
    
EndProcedure

Procedure ShapeGetProperties()
    
    SetPanelGadget()
    
    If ObjId <=ArraySize(Obj()) 
        
        If shapeId > -1 And ShapeID <= ArraySize(Obj(ObjId)\shape())
            
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
            
            
            ; info du shape
            SetGadgetText(#G_shapeNom,Obj(ObjId)\Shape(ShapeId)\Nom$ )
            SetGadgetState(#G_shapeAlpha,Obj(ObjId)\Shape(ShapeId)\Alpha)
            SetGadgetState(#G_shapeTyp,Obj(ObjId)\Shape(ShapeId)\Typ)
            SetGadgetState(#G_shapeSizeW,Obj(ObjId)\Shape(ShapeId)\SizeW)
            SetGadgetState(#G_shapeSizeH,Obj(ObjId)\Shape(ShapeId)\SizeH)
            
            SetGadgetState(#G_shapeLineW,Obj(ObjId)\Shape(ShapeId)\w)
            SetGadgetState(#G_shapeLineH,Obj(ObjId)\Shape(ShapeId)\h)
            SetGadgetState(#G_shapeLineD,Obj(ObjId)\Shape(ShapeId)\d)
            SetGadgetState(#G_shapeCX,Obj(ObjId)\Shape(ShapeId)\Cx)
            SetGadgetState(#G_shapeCY,Obj(ObjId)\Shape(ShapeId)\Cy)
            SetGadgetState(#G_shapeX,Obj(ObjId)\Shape(ShapeId)\X)
            SetGadgetState(#G_shapeY,Obj(ObjId)\Shape(ShapeId)\Y)
            
            SetGadgetState(#G_shapeLink,Obj(ObjId)\Shape(ShapeId)\Linked)
            SetGadgetState(#G_shapeLock,Obj(ObjId)\Shape(ShapeId)\Locked)
            SetGadgetState(#G_shapeHide,Obj(ObjId)\Shape(ShapeId)\Hide)
            
            
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
            
            SetGadgetState(#G_shapeFxList,ShapeFxId)
            SetGadgetState(#G_shapeFxActif,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Actif)
            SetGadgetState(#G_shapeFxAlpha,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Alpha)
            SetGadgetState(#G_shapeFxDepth,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Depth)
            SetGadgetState(#G_shapeFxLineTyp,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Style)
            SetGadgetState(#G_shapeFxLineW,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\W)
            SetGadgetState(#G_shapeFxLineH,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\H)
            SetGadgetState(#G_shapeFxLineD,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Dist)
            SetGadgetState(#G_shapeFxX,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\X)
            SetGadgetState(#G_shapeFxY,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Y)
            SetGadgetState(#G_shapeFxScale,Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Scale)
        EndIf
        
    EndIf

EndProcedure
;}



;{ shape


; create
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


; Edit 
Procedure ShapeSelectAll(Selection=1) 
    
    For j =0 To  ArraySize(Obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(j)
            \selected = Selection
        EndWith
    Next
    
EndProcedure        

Procedure ShapeDelete()
    
    ; pour supprimer un shape
    If ShapeId <> -1
        
        If Obj(ObjId)\Actif > 0
            
            If ArraySize(Obj(ObjId)\Shape()) >0                            
                DeleteArrayElement(Obj(ObjId)\Shape,shapeId)
                ShapeId = 0                           
                ShapeGetProperties()                           
            Else 
                DeleteArrayElement(Obj(ObjId)\Shape,shapeId)
                ShapeId = -1
                vd\NbShape = -1
                ReDim Obj(ObjId)\Shape(0)
                Obj(ObjId)\Actif = 0
            EndIf
            UpdateListShape()
            Drawcanvas()
            
        EndIf
    EndIf
    
EndProcedure

Procedure VD_ShapeChangeImage()
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


; Convert
Procedure VD_ConvertShape(to_Pt=1)
    
    ; pour convertir un shape vers des points ou vers une forme prédéfinies (elipse, rectangle...)
    
    If shapeId > -1
        With obj(ObjId)\Shape(ShapeId)
            If To_Pt =1 ; on convertit en curve/pt
                
                Select \ShapTyp
                        
                      Case #VD_ShapeCircle 
                         \ShapTyp = #VD_ShapeShape 
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
                          
                          
                      Case #VD_ShapeBox
                         \ShapTyp = #VD_ShapeShape
                         ReDim \pt.sPoint(11)
                         \pt(0)\x = 0
                         \pt(0)\y = 0
                         \pt(3)\x = \SizeW
                         \pt(3)\y = 0
                         \pt(6)\x = \SizeW
                         \pt(6)\y = \SizeH
                         \pt(9)\x = 0
                         \pt(9)\y = \SizeH
                         
                         ; puis, je mets tous les points en hard
                          PtId = 0 : Vd_SetPoint(0,0)
                          PtId = 3 : Vd_SetPoint(0,0) 
                          PtId = 6 : Vd_SetPoint(0,0)
                          PtId = 9 : Vd_SetPoint(0,0)
                          
                EndSelect
                                
            Else
                
            EndIf
        EndWith
    EndIf
    
    Drawcanvas()
    
EndProcedure





;Edit point 
Procedure Vd_DeletePoint(i)
    
    ; pour supprimer le point sélectionné
    If ShapeId> -1 And shapeId <= ArraySize(Obj(ObjId)\Shape())
        With Obj(ObjId)\Shape(ShapeId)
            u=i-1
            If u<0
                u=ArraySize(\pt())
            EndIf
            v=i+1
            If v > ArraySize(\pt())
                v=0
            EndIf
            
            DeleteArrayElement(\pt,u)
            DeleteArrayElement(\pt,i)
            DeleteArrayElement(\pt,v)
        EndWith
    EndIf

EndProcedure

Procedure Vd_SetPoint(param=0,draw=1)
    
    ; param = 0 : hard
    ; param = 1 : soft
    
    ; pour changer la dureté d'un point :hard (line) ou smooth (curve)
    If shapeId > -1 And shapeid <= ArraySize(Obj(ObjId)\Shape())
        
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
    
    If draw=1
        Drawcanvas()
    EndIf
    
EndProcedure  
;}



;{ draw

Procedure VD_ResetCoord()
        
    z.d = VdOptions\Zoom * 0.01
    ResetCoordinates()
    ScaleCoordinates(z,z)
    
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
        
       
        
        sc.f = \Fx(k)\Scale*0.01
        vx = vd\ViewX + \Fx(k)\X + \X ;+ Obj(a)\x ;+ \pt(0)\x*(1-0.5*sc)
        vy = vd\ViewY + \Fx(k)\Y + \Y ;+ Obj(a)\y ;+ \pt(0)\y*(1-0.5*sc)
        
        ; scu.f = sc
        ; scv.f = sc
        ; scw.f = sc
        ; ScaleCoordinates(sc,sc)
        ; TranslateCoordinates(\pt(0)\x*sc,\pt(0)\y*sc)
        
        x0 = \pt(0)\x
        y0 = \pt(0)\y
        
        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
        
        Select \ShapTyp
            Case #VD_ShapeShape
                ;         x0 = \pt(0)\x
                ;         y0 = \pt(0)\y
                xo0 = x0
                yo0 = y0
                MovePathCursor(x0+vx,y0+vy)
                
                For i =0 To ArraySize(\pt()) Step 3
                    
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
                    Else
                        x3 = (\pt(w)\x-x0)
                        y3 = (\pt(w)\y-y0)
                        xfin3 + x3
                        yfin3 + y3
                        xo0 = x0
                        yo0 = y0  
                    EndIf
                    
                    AddPathCurve(x1*sc,y1*sc,x2*sc,y2*sc,x3*sc,y3*sc,#PB_Path_Relative)
                    
                    x0 = x3 + xo0
                    y0 = y3 + yo0
                    
                    
                Next
                
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
                    EndIf                    
                    AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                Next
                If \Close
                    ClosePath()
                EndIf
                
            Case #VD_ShapeLine              
                For i =0 To ArraySize(\pt()) 
                    AddPathLine(\pt(i)\x+vx,\pt(i)\y+vy)
                Next
                If \Close
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
        
        For k =0 To ArraySize(\Fx())
            
            If \Fx(k)\Depth = dessus
                
                If \Fx(k)\Actif = 1 
                    
                    ShapeDrawFx(vo,j,k)
                    
                EndIf                        
                
            EndIf
            
        Next
        
    EndWith
    
EndProcedure

Procedure VdDrawShape1(vo,j)
    
    ; pour dessiner le chemin , avant les opérations de remplissage 
    ; (donc pour la couche normal et éventuellement d'autres couche (fx...)
    
    z.d
    z = VdOptions\Zoom*0.01
    
    
    With Obj(vo)\Shape(j)
        
        vx = Vd\viewX + \x ; + Obj(ObjId)\x 
        vy = Vd\viewY + \y ; + Obj(ObjId)\y
        
        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
        
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
                    
                    AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                Next
                
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
                MovePathCursor(vx,vy)
                VectorFont(FontID(\Font), \SizeW)
                AddPathText(\text$)
                
            Case #VD_ShapeCurve
                For i =1 To ArraySize(\pt())-1 Step 3
                    u = i
                    v = i+1
                    w = i+2
                    If w > ArraySize(\pt())
                        w =0
                    EndIf                    
                    AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                Next
                If \Close
                    ClosePath()
                EndIf
                
            Case #VD_ShapeLine
                For i =0 To ArraySize(\pt()) 
                    AddPathLine(\pt(i)\x+vx,\pt(i)\y+vy)
                Next
                If \Close
                    ClosePath()
                EndIf
                
        EndSelect
        
    EndWith
    
    
EndProcedure

Procedure VDDrawShapeColor(vo,j)
    
    ; pour remplir le chemin, avec le style souhaité : filled, line, dash, dot
    Protected  d.d  
        
    With Obj(vo)\Shape(j)
        
        If \ShapTyp <> #VD_ShapeImage
            ; puis, on remplit avec la couleur du shape
            
            ; <----------------- !!!!!!!!!! temporaire, je dois ajouter des paramètres : position des dégradé, position x,y du dégradé circulaire, couleur dégradé, etc...
            
            Select \ColorGrad
                    
                Case 0
                    VectorSourceColor(RGBA(Red(\color),Green(\color),Blue(\color),(\Alpha * Obj(vo)\Alpha)*0.0039215)) ; 0.0039215 = 1/255
                    
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
    
        w = GadgetWidth(#G_canvasVector)/VdOptions\GridW
        h = GadgetHeight(#G_canvasVector)/VdOptions\GridH
        m = VdOptions\GridW
        n = VdOptions\GridH
        For j = 0 To h 
            ; MovePathCursor(vx,j*n + vy)
            MovePathCursor(vx,j*n)
            AddPathLine(GadgetWidth(#G_canvasVector),j*n + vy)
        Next        
        For i = 0 To w
            ; MovePathCursor(i*m + vx,vy)
            MovePathCursor(i*m,vy)
            AddPathLine(i*m + vx, GadgetHeight(#G_canvasVector))
        Next 
        VectorSourceColor(VdOptions\GridColor)
        StrokePath(1)        
    
EndProcedure

Procedure VDDrawUtil()
    
    ; draw UTILES : 
    ; - lignes points tillés (sélection) 
    ; - puis j'affiche les elements utiles : dashpath de selection, centre, droites & points d'ancrage...
    ; - grille
    ; - taille de la "camera" ou export (x,y,w,h)
    
    z.d = VdOptions\Zoom * 0.01
    
    
    If Obj(ObjId)\Hide = 0
        
       ; VD_ShapeCoord(ObjId)
    
        ; pour voir les anchors
        If VdOptions\HideAncre = 0 
            
            If ShapeId >- 1
                
                With Obj(ObjId)\Shape(ShapeId)
                    
                    
                    vx = Vd\viewX + \X ; + Obj(ObjId)\x
                    vy = Vd\viewY + \y ; + Obj(ObjId)\y
                    
                    
                    ; on dessine les points du shape
                    Select \ShapTyp
                            
                        Case #VD_ShapeShape
                            MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
                            For i =0 To ArraySize(\pt())
                                
                                ;AddPathLine(pt(i)\x, pt(i)\y) 
                                
                                If Mod(i,3)=0                   
                                    AddPathBox(\pt(i)\x-5+vx,\pt(i)\y-5+vy,10,10)
                                    VectorSourceColor(RGBA(0,255,255,100))
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
                                        StrokePath(1)
                                    Else
                                        u = i+1
                                        If u>ArraySize(\pt())
                                            u = 0
                                        EndIf
                                        MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                                        AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                                        AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy)
                                        VectorSourceColor(RGBA(0,0,0,100))
                                        StrokePath(1)
                                    EndIf
                                    
                                    AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,5)
                                    VectorSourceColor(RGBA(255,255,0,100))
                                    FillPath()
                                EndIf
                                
                                If i=PtId Or \pt(i)\Selected = 1
                                    
                                    AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,6)
                                    VectorSourceColor(RGBA(255,0,0,120))
                                    FillPath()
                                    
                                EndIf
                                
                                
                            Next
                            
                            
                        Default
                            For i =0 To ArraySize(\pt())
                                AddPathBox(\pt(i)\x-5+vx,\pt(i)\y-5+vy,10,10)
                                
                                If i=PtId Or \pt(i)\Selected = 1
                                    
                                    AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,6)
                                    VectorSourceColor(RGBA(255,0,0,120))
                                    FillPath()
                                    
                                EndIf
                                
                            Next                            
                            VectorSourceColor(RGBA(0,255,255,100))
                            FillPath()
                            
                    EndSelect
                    
                    
                    
                    ; le centre du shape en bleu
                    MovePathCursor(\CurX+vx,\CurY+vy)
                    AddPathCircle(\Cx,\cy,10,0,360,#PB_Path_Relative)
                    VectorSourceColor(RGBA(0,255,255,100))
                    FillPath()
                    
                EndWith
                
            EndIf
            
            If VdOptions\ShowAncreSelected
                
                For j=0 To ArraySize(obj(ObjId)\Shape())
                    
                    With Obj(ObjId)\Shape(j)
                        vx = Vd\viewX + \X ; + Obj(ObjId)\x
                        vy = Vd\viewY + \y ; + Obj(ObjId)\y
                        
                        If \Hide = 0
                            
                            If \Selected = 1
                                ; on dessine les points du shape
                                Select \ShapTyp
                                        
                                    Case #VD_ShapeShape
                                        
                                        MovePathCursor(\pt(0)\x+vx,\pt(0)\y+vy)
                                        
                                        For i =0 To ArraySize(\pt())
                                            
                                            ;AddPathLine(pt(i)\x, pt(i)\y) 
                                            
                                            If Mod(i,3)=0                   
                                                AddPathBox(\pt(i)\x-5+vx,\pt(i)\y-5+vy,10,10)
                                                VectorSourceColor(RGBA(0,255,255,100))
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
                                                    StrokePath(1)
                                                Else
                                                    u = i+1
                                                    If u>ArraySize(\pt())
                                                        u = 0
                                                    EndIf
                                                    MovePathCursor(\pt(i)\x+vx,\pt(i)\y+vy)
                                                    AddPathLine(\pt(i)\x+vx, \pt(i)\y+vy) 
                                                    AddPathLine(\pt(u)\x+vx, \pt(u)\y+vy)
                                                    VectorSourceColor(RGBA(0,0,0,100))
                                                    StrokePath(1)
                                                EndIf
                                                
                                                AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,5)
                                                VectorSourceColor(RGBA(255,255,0,100))
                                                FillPath()
                                            EndIf
                                            
                                            If i=PtId Or \pt(i)\Selected = 1
                                                
                                                AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,6)
                                                VectorSourceColor(RGBA(255,0,0,120))
                                                FillPath()
                                                
                                            EndIf
                                            
                                            
                                        Next
                                        
                                        
                                    Default
                                        For i =0 To ArraySize(\pt())
                                            AddPathBox(\pt(i)\x-5+vx,\pt(i)\y-5+vy,10,10)
                                            
                                            If i=PtId Or \pt(i)\Selected = 1
                                                
                                                AddPathCircle(\pt(i)\x+vx,\pt(i)\y+vy,6)
                                                VectorSourceColor(RGBA(255,0,0,120))
                                                FillPath()
                                                
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
        
        
        ; puis, j'affiche des points tillés autour du shape selectionné
        If VdOptions\ShowSelection
            
            For kk = 0 To ArraySize(Obj(ObjId)\Shape())
                
                With Obj(ObjId)\Shape(kk)
                    vx = vd\ViewX + \X ;+ Obj(ObjId)\x 
                    vy = vd\ViewY + \Y ;+ Obj(ObjId)\y
                        
                    If \Selected = 1 
                        
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
                                sizeW = VectorTextWidth(\text$)
                                sizeH = VectorTextHeight(\text$)
                                AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,SizeW,SizeH)
                                
                            Case #VD_ShapeImage 
                                AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\SizeH)
                                
                            Default
                                VdDrawShape1(ObjId, kk)
                                
                        EndSelect
                        
                    EndIf
                    
                   
                EndWith                
                
            Next
            
            VectorSourceColor(RGBA(20,20,20,255)) 
            DashPath(1,5)
            
            If shapeId > -1
                With Obj(ObjId)\Shape(shapeId) 
                    vx = vd\ViewX + \X ;+ Obj(ObjId)\x 
                    vy = vd\ViewY + \Y ;+ Obj(ObjId)\y
                    
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
                            sizeW = VectorTextWidth(\text$)
                            sizeH = VectorTextHeight(\text$)
                            AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,SizeW,SizeH)
                            
                        Case #VD_ShapeImage 
                            AddPathBox(\pt(0)\x+vx,\pt(0)\y+vy,\SizeW,\SizeH)
                            
                        Default
                            VdDrawShape1(ObjId, ShapeId)
                            
                    EndSelect
                    
                    VectorSourceColor(RGBA(200,20,20,255)) 
                    DashPath(2,5)
                EndWith
            EndIf     
            
            
        EndIf
        
    EndIf
    
    vx = vd\ViewX
    vy = vd\ViewY
    
    VD_ResetCoord()

    ; puis, on affiche la grille
    If VdOptions\ShowGrid = 1
        ; w = GadgetWidth(#G_canvasVector)/VdOptions\GridW
        w = VdOptions\CameraW/VdOptions\GridW
        ; h = GadgetHeight(#G_canvasVector)/VdOptions\GridH
        h = VdOptions\CameraH/VdOptions\GridH
        m = VdOptions\GridW
        n = VdOptions\GridH
        For j = 0 To h 
            ; MovePathCursor(vx,j*n+vy)
            ; AddPathLine(GadgetWidth(#G_canvasVector),j*n+vy)
            
            MovePathCursor(vx,j*m+vy)            
            AddPathLine(vx+VdOptions\CameraW,j*m+vy)
        Next        
        For i = 0 To w
            ; MovePathCursor(i*m+vx,vy)
            ; AddPathLine(i*m+vx, GadgetHeight(#G_canvasVector))
            MovePathCursor(i*n+vx,vy)
            AddPathLine(i*n+vx, vy+VdOptions\CameraH)
        Next 
        VectorSourceColor(VdOptions\GridColor)
        If z <1
            u = 1
        Else
            u = 100/VdOptions\Zoom
        EndIf
        
            
        StrokePath(u)        
    EndIf
    
     ; on affiche la bordure camera
    If VdOptions\showCameraBorder
        MovePathCursor(vx,vy)
        AddPathBox(vx+VdOptions\CameraX,vy+VdOptions\CameraY, VdOptions\CameraW,VdOptions\CameraH)
        VectorSourceColor(RGBA(255,120,120,255))
        StrokePath(2)
    EndIf
    
    If VdOptions\ShowCameraCache
        AddPathBox(0,-1,GadgetWidth(#G_canvasVector)/z,2+GadgetHeight(#G_canvasVector)/z)
        AddPathBox(vx+VdOptions\CameraX,vy+VdOptions\CameraY, VdOptions\CameraW,VdOptions\CameraH)
        VectorSourceColor(RGBA(0,0,0,VdOptions\CameraCacheAlpha))
        FillPath()
    EndIf
    
EndProcedure

Procedure DrawCanvas(x=0,y=0,Selected=1)
    
    ; pour dessiner le canvas
    z.d
    z = VdOptions\Zoom*0.01
    vx = Vd\viewX
    vy = Vd\viewY
   
    
    If StartVectorDrawing(CanvasVectorOutput(#G_canvasVector))
        
        ResetCoordinates()
        
        
        ;{ Background
        AddPathBox(0,0, GadgetWidth(#G_canvasVector),GadgetHeight(#G_canvasVector))
        VectorSourceColor(VdOptions\BgColor)
        FillPath()
        If VdOptions\BgImg
            
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
             ;VectorSourceImage(ImageID(ImgVd(20)), 255, ImageWidth(ImgVd(20)), ImageHeight(ImgVd(20)), #PB_VectorImage_Repeat)
        EndIf        
        ;}
        
           
        ;zoom
        VD_ResetCoord()
        
        
        If vd\NbShape >=1 ; il faut avoir au moins un shape actif !!
            
            
            
            ;{ si on crée les Fx tous en dessous
            
            ;}
            
            ; puis, on crée les objets (et les shapes qui les composent)
            For m = 0 To ArraySize(Obj())
                
                If Obj(m)\Hide = 0
                    
                    VD_ShapeCoord(m)
                    
                    For j =0 To ArraySize(Obj(m)\Shape())
                        
                        If VdOptions\ShowOnlySel = 0 Or j = ShapeId
                            
                            If Obj(m)\Shape(j)\Hide = 0
                                ; si clippath
                                ; SaveVectorState()
                                ; ClipPath()    
                                
                                ; on dessine les fx en dessous
                                VdDrawFx(m,j,0)
                                
                                
                                ;{ le shape
                                VdDrawShape1(m,j)
                                
                                ; pour tester si on clic sur un shape
                                If vd\AddObjet = 0 And Selected=1
                                    
                                    If m = ObjId 
                                        
                                        With Obj(m)\Shape(j)
                                            
                                            If Vd\TestShapeOk <= 0 
                                               
                                                If IsInsidePath(x, y) And Vd\move = 0                           
                                                    If vd\shift = 0 
                                                        ShapeSelectAll(0)
                                                        Vd\TestShapeOk = -1                                
                                                        ShapeID = j
                                                        ShapeGetProperties()
;                                                         
                                                        Select vdOptions\Action 
                                                            Case #VD_actionMove
                                                                \startY = y - \Y                                                               
                                                                \startX = x - \X
                                                            Case #VD_actionScale
                                                                \startX = x -\SizeW
                                                                \startY = y +\SizeH
                                                        EndSelect
                                                        
                                                    Else                                                       
                                                        vd\move = 2
                                                    EndIf
                                                    \selected = 1
                                                Else   
                                                    ;If vdOptions\Action = #VD_actionSelect
                                                    If vd\Shift=0 
                                                        \Selected = 0                                
                                                    EndIf                            
                                                    ;EndIf                            
                                                EndIf
                                                
                                            EndIf
                                            
                                        EndWith
                                        
                                    EndIf
                                    
                                EndIf
                                
                                If Obj(m)\Shape(j)\Linked = 0 Or j = ArraySize(Obj(m)\Shape())
                                    VDDrawShapeColor(m,j) ; color et fillpath()/strokepath()                                    
                                EndIf
                                
                                ;}
                                
                                ; si fx au dessus
                                VdDrawFx(m,j,1)                    
                                ; RestoreVectorState()
                              
                               
                            
                            EndIf
                        
                        EndIf
                        
                    Next
                    
                EndIf
            
            Next 
            
            
            ; pour vérifier si on clique sur un shape, pour le sélectionner par exemple (
            ; si on cliqué sur un shape, on garde en mémoire certaines choses
            If vd\AddObjet = 0
                If (Vd\TestShapeOk = -1 Or vd\move = 2)
                    Vd\TestShapeOk = 1
                    Vd\move = 2            
                    ShapeGetProperties()
                    If vdOptions\Action <> #VD_actionScale And vdOptions\Action <> #VD_actionRot ; And vdOptions\Action <> #VD_actionMove
                        For j =0 To  ArraySize(Obj(ObjId)\Shape())
                            With Obj(ObjId)\Shape(j)                                
                                If \selected = 1
                                    
                                    Select vdOptions\Action 
                                        Case #VD_actionMove
                                            \startY = y - \Y                                                               
                                            \startX = x - \X
                                        Case #VD_actionScale
                                            \startX = x -\SizeW
                                            \startY = y +\SizeH
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
                        ShapeSelectAll(0)
                    EndIf
                EndIf
            EndIf
            
        EndIf
        
        ; Utilitaire (grille, selection, etc.. 
        VdDrawUtil()
        
        StopVectorDrawing()
    EndIf
    
   

EndProcedure

;}



;{ update

Procedure UpdateListShape()
    
    ClearGadgetItems(#G_shapelist)
    If vd\NbShape >0
        For i = 0 To  ArraySize(Obj(ObjId)\Shape())
            AddGadgetItem(#G_shapelist,i,Obj(ObjId)\Shape(i)\Nom$) 
        Next
    EndIf

EndProcedure

Procedure UpdateListAddShape()
    
    ; pour mettre à jour la liste des shape qu'on peut ajouter (elle se trouve dans le dossier "data\shape")
    ClearGadgetItems(#G_shapeListAdd)
    
    If ExamineDirectory(0, "data\shapes\", "*.txt")  
        While NextDirectoryEntry(0)
            If DirectoryEntryType(0) = #PB_DirectoryEntry_File
                nom$=DirectoryEntryName(0)
                AddGadgetItem(#G_shapeListAdd,i,nom$)
                i+1
            EndIf
        Wend
        FinishDirectory(0)
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

Procedure UpdateUiObjetVD(update = 0)
    
    ; pour mettre à jour la liste de sobjets actuellement disponibles
    
;     ClearGadgetItems(#G_ObjList)
;     For i=0 To ArraySize(Obj())
;         AddGadgetItem(#G_ObjList,i,Obj(i)\Nom$)
;     Next
;     SetGadgetState(#G_ObjList,ObjId)
    
    
    n = ArraySize(Obj())
    
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
    
    w = WindowWidth(#Win_VectorDrawing)
    h = WindowHeight(#Win_VectorDrawing)-MenuHeight()-VdOptions\ToolBarH-50 - VdOptions\TimeLineH*(VdOptions\showTimeLine)
    h1= 25
    
    ; on resize le panel gauche
    ResizeGadget(#G_panelVD,#PB_Ignore,#PB_Ignore,#PB_Ignore,h-120)
    
    
    ResizeGadget(#G_PanelVDControl,#PB_Ignore,h-90,#PB_Ignore,120)
    
    ResizeGadget(#G_VDTimeline,#PB_Ignore,h+5+MenuHeight()+10 + 10000*(1-VdOptions\showTimeLine),w-10-tbw,VdOptions\TimeLineH)
    Vd_UpdateTimeLine()
    
    ; on resize le canvas
    ;ResizeGadget(#G_CanvasOptionVD,tbw+VdOptions\PanelW+a,#PB_Ignore,w-VdOptions\PanelW*2-a*2-tbw,#PB_Ignore)
    
    ResizeGadget(#G_CanvasPathVD,tbw+VdOptions\PanelW+a,#PB_Ignore,w-VdOptions\PanelW*2-a*2-tbw,#PB_Ignore)
    
    ResizeGadget(#G_canvasVector,tbw+VdOptions\PanelW+a,#PB_Ignore,w-VdOptions\PanelW*2-a*2-tbw,h-h1)
    Drawcanvas()
    
    ; on resize le panel droit
    ResizeGadget(#G_panelVD_R,GadgetX(#G_canvasVector)+a*2+GadgetWidth(#G_canvasVector),#PB_Ignore,#PB_Ignore,h)
    
   
    VdOptions\WinW = WindowWidth(#Win_VectorDrawing)
    VdOptions\WinH = WindowHeight(#Win_VectorDrawing)
    VdOptions\WinState = GetWindowState(#Win_VectorDrawing)
    VD_SaveOptions()
    
    Vd_CreateToolbar()
    
EndProcedure

;}



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
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Alpha = 255
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Color = RGBA(255,120,0,255)
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\W = 10
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\H = 5
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Dist = 5
    Obj(ObjId)\Shape(ShapeId)\Fx(i)\Scale = 100
    
    
    ; puis, on update
    UpdateListShapeFX()
    ShapeGetProperties()
    
EndProcedure

;}



;{ objet
Procedure Vd_LayerAdd(new= 1)
    
    ; pour ajouter un objet (layer)
    n = ArraySize(Obj())+new
    ReDim Obj(n)
    With Obj(n)
        \Alpha = 255
        \Depth = n
        \w = 100
        \h = 100
        \Nom$ = "Object"+Str(n)
    EndWith
    
    ObjId = n
    SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
    UpdateUiObjetVD(1)

EndProcedure


; Add
Procedure ShapeAddObjet(x,y)
    
    ; pour ajouter un objet de dessin
    
    ok = 1
    
    ; Debug ""+vdOptions\Action +"/"+#VD_actionAddBox
    
    PtId = 0
    
    If vdOptions\Action = #VD_actionAddShape
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
        
        ShapeNew(2,0,0) ;<-- !!!! pas de draw, sinon, ça plante, car il faudrait fermer le startdrawing du canvas ;) 
        Vd\NbShape = 1
        
        ShapeId = ArraySize(Obj(ObjId)\Shape())
        Obj(ObjId)\Actif = 1
        
        
;         For i = n To ArraySize(Obj(ObjId)\Shape())            
;             Obj(ObjId)\Shape(i)\X = x
;             Obj(ObjId)\Shape(i)\y = y
;         Next 
        
        
    Else
        
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
        
        If ok = 1
            
            
            If VD\CreateObj = 1 And old = 1 ; on crée un nouvel objet, on doit donc ajouter un objet au tableau des objets
                
                If vd\NbShape >0
                    n = ArraySize(Obj())+1  
                    ReDim Obj.sObj(n)
                    m = 0
                Else
                    n = ArraySize(Obj())  
                    ReDim Obj.sObj(n)
                    m = 0
                EndIf
                
            Else ; on crée un nouveau shape dans l'objet courrant, on aajoute un sahep dans le tableau des shape de cet objet
                
               If Obj(ObjId)\Actif = 0
                    Obj(ObjId)\Actif = 1
                    n = ObjId        
                    m = ArraySize(Obj(n)\Shape())
                    ReDim Obj(n)\Shape.sShape(m) 
                    Obj(n)\Shape(m)\Nom$ = ""
                Else
                    ; If Obj(ObjId)\Actif = 1; vd\NbShape >0
                    n = ObjId        
                    m = ArraySize(Obj(n)\Shape())+1
                    ReDim Obj(n)\Shape.sShape(m) 
                    Obj(n)\Shape(m)\Nom$ = ""
                EndIf        
            EndIf
        
        
            vd\NbShape =1
            
            ObjId = n    
            ShapeId = m
            
            ReDim Obj(n)\Shape(m)\pt.sPoint(0)
            Obj(n)\Shape(m)\w = 10
            Obj(n)\Shape(m)\h = 5
            Obj(n)\Shape(m)\d = 5
            
            If vdOptions\Action = #VD_actionAddLine 
                ReDim Obj(n)\Shape(m)\pt.sPoint(1)
                Obj(n)\Shape(m)\pt(1)\x = x
                Obj(n)\Shape(m)\pt(1)\y = y
                Obj(n)\Shape(m)\Typ = 1
            ElseIf vdOptions\Action = #VD_actionAddCurve
                ReDim Obj(n)\Shape(m)\pt.sPoint(3)
                For i = 0 To 3                
                    Obj(n)\Shape(m)\pt(i)\x = x+i*5-10
                    Obj(n)\Shape(m)\pt(i)\y = y+i*5-10
                Next
                Obj(n)\Shape(m)\Typ = 1
            EndIf
            
           
            
            With Obj(n) 
                \Actif = 1
                \Shape(m)\StartX = x
                \Shape(m)\StartY = y
                
                \Shape(m)\Rnd   = 20
                \Shape(m)\depth = m
                \Shape(m)\pos = m
                \Shape(m)\SizeW = 5
                \Shape(m)\SizeH = 5              
                \Shape(m)\Nom$ = nom$+Str(m)
                \Shape(m)\Alpha = 255
                \Shape(m)\Color = RGBA(220,220,120,255)
                \Shape(m)\pt(0)\x = x
                \Shape(m)\pt(0)\y = y
                \Shape(m)\ShapTyp = vdOptions\Action - #VD_actionAddShape
                
                
                Select vdOptions\Action 
                        
                    Case #VD_actionAddText
                        \Shape(m)\SizeW = 10
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
                
                
                UpdateUiObjetVD()
                If VD\CreateObj = 0
                    UpdateListShape()
                EndIf
                
            EndWith
            
            
        EndIf
        
    EndIf
    
    ProcedureReturn  ok 
    
EndProcedure
;}



;{ Files

Procedure VDOpenTheHelp(html=0)
    
    If html = 0
        If RunProgram(GetCurrentDirectory()+"data\help\help.rtf") :EndIf
    Else
        If RunProgram(GetCurrentDirectory()+"data\help\html\index.html") :EndIf
    EndIf

EndProcedure

Procedure ShapeSave(file$ = "",autosave=0)
    
    ; pour sauvegarder le document
    
    d$ = ","
    e$ = ";"
    
    If file$ = ""
        file$ = SaveFileRequester("Save",File$,"txt|*.txt|all|*.*",0)
    EndIf
    
    If file$ <> ""
        
        If autosave = 0
            Vd\File$ = file$
        EndIf
        
        file$ = RemoveString(file$,".txt")+".txt"
        
        If OpenFile(0,file$)
            
            txt$= "gen,"+" "+d$+StrD(ValD(#ProgramVersionVD),2)+d$
            WriteStringN(0,txt$)
            
            
            For m=0 To ArraySize(Obj())
                
                With Obj(m)
                    
                    txt$= "obj,"+\Nom$+d$+\x+d$+\y+d$+\w+d$+\h+d$+\Depth+d$+\Hide+d$+\Locked+d$+\Alpha+d$+\Bm+d$                 
                    WriteStringN(0,txt$)
                    
                    For j =0 To ArraySize(\Shape())
                        
                        ; on sauve le shape (paramètres généraux
                        txt$= "shape,"+Str(j)+d$+\Shape(j)\Color+d$+\Shape(j)\Nom$+d$+Str(\Shape(j)\Alpha)+d$
                        txt$ +Str(\Shape(j)\Typ)+d$+Str(\Shape(j)\w)+d$+Str(\Shape(j)\h)+d$+Str(\Shape(j)\d)+d$ 
                        txt$ +Str(\shape(j)\ShapTyp)+d$+Str(\shape(j)\SizeW)+d$+Str(\shape(j)\SizeH)+d$
                        
                        Select \shape(j)\ShapTyp 
                            Case #VD_ShapeText
                                txt$ +\shape(j)\Text$+e$+\shape(j)\FontName$+e$+\shape(j)\FontStyle+e$
                                
                            Case #VD_ShapeImage
                                txt$ +\Shape(j)\Filename$+e$+\shape(j)\ImgRepeat+e$+\shape(j)\ImgX+e$+
                                      \shape(j)\ImgY+e$+\shape(j)\ImgW+e$+\shape(j)\ImgH+e$+\shape(j)\ImgRot+e$
                                
                        EndSelect
                        txt$ + d$
                        txt$ +\Shape(j)\X+d$+\Shape(j)\Y+d$
                        
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
                            txt$ = "pt,"+Str(i)+","+Str(\Shape(j)\pt(i)\x)+","+Str(\Shape(j)\pt(i)\y)+","
                            WriteStringN(0,txt$)
                        Next
                        
                    Next 
                    
                EndWith
                
            Next
            
            CloseFile(0)
            
        EndIf
        
        If autosave=0
            SetWindowTitle(#Win_VectorDrawing,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD+" - "+GetFilePart(file$))
        EndIf
        
    EndIf
    
EndProcedure

Procedure ShapeNew(eraseall=1, copy=0,draw=1)
    
    If eraseall = 1
        ; ReDim Obj(ObjId)\Shape.sShape(0)
        Dim Obj.sObj(0)
        Vd\NbShape  = -1
        ShapeFxId   = 0
        ShapeId     = 0
        ObjId   = 0 
        Obj(ObjId)\Nom$ = "Object0"
        Obj(ObjId)\alpha = 255
        Obj(ObjId)\w = 100
        Obj(ObjId)\h = 100
        ; Global Dim Animation.sAnim(0)
    EndIf
    
    PtId = 0
    
    
    If copy = 0
        
        If eraseall = 2 ; pour ajouter le shape 
            
            If vd\ShapeFileName$ = ""
                vd\ShapeFileName$ = "1-defaut.txt"
            EndIf
            
            ;Debug "on va loader un shape "+ArraySize(Obj(ObjId)\shape())
            
            
            ShapeLoad(2, "data\shapes\"+vd\ShapeFileName$,draw)
            
            ;Debug "Taille_1 : "+ArraySize(Obj(ObjId)\shape())
            
            Debug "on loade "
            For i=0 To ArraySize(Obj(ObjId)\Shape())
                If Obj(ObjId)\Shape(i)\Nom$ = ""
                    DeleteArrayElement(Obj(ObjId)\Shape,i)
                EndIf        
            Next
            
            ;Debug "Taille_2 : "+ArraySize(Obj(ObjId)\shape())
            
            ;Obj(ObjId)\Shape(0)\CurX = Obj(ObjId)\Shape(0)\pt(0)\x
            ;Obj(ObjId)\Shape(0)\CurY = Obj(ObjId)\Shape(0)\pt(0)\y
            
            SetWindowTitle(#Win_VectorDrawing,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD)
            Vd\File$ = ""
            
            
            UpdateListShape()
            ;Debug "Taille_3 : "+ArraySize(Obj(ObjId)\shape())
            
            ShapeAddFx()
            ;Debug "Taille_4 : "+ArraySize(Obj(ObjId)\shape())
            
            Debug "fin de création"
            
            If draw=1
                Drawcanvas()
            EndIf
            
        EndIf
    
    Else        
        
;         t$="177,34,395,109,354,234,318,387,117,320,151,181,"
;         ReDim Obj(ObjId)\Shape(ShapeId)\pt.sPoint(5)
;         Obj(ObjId)\Shape(ShapeId)\Nom$ = "Shape_"+Str(ShapeId)
;         Obj(ObjId)\Shape(ShapeId)\Color = RGBA(Random(255),Random(255),Random(255),255)
;         Obj(ObjId)\Shape(ShapeId)\Alpha = 255
;         Obj(ObjId)\Shape(ShapeId)\Pos = ShapeId
;         Obj(ObjId)\Shape(ShapeId)\w = 10
;         Obj(ObjId)\Shape(ShapeId)\h = 5
;         Obj(ObjId)\Shape(ShapeId)\d = 5
;                 
;         u = 1
;         With Obj(ObjId)\Shape(ShapeId)
;             For i = 0 To ArraySize(\pt())
;                 \pt(i)\x = Val(StringField(t$,u,",")) : u+1
;                 \pt(i)\y = Val(StringField(t$,u,",")) : u+1
;             Next
;             ;\CurX = \pt(0)\x
;             ;\CurY = \pt(0)\y
;         EndWith
;         
;         
;         ShapeAddFx()
        
        
        
        
    EndIf
    
    UpdateUiObjetVD()
    UpdateListShape()
   
EndProcedure

Procedure ShapeLoad(merge=0, file$ ="",draw=1)
    
    
    ; pour ouvrir un shape
    If file$ = ""
        file1$ = GetCurrentDirectory()+"examples\"
        Debug file1$
        file$ = OpenFileRequester("Save",file1$,"txt|*.txt",0)
    EndIf

    If file$ <> ""
        
        If OpenFile(10,file$)
            
            Vd\File$ = file$
            
            If merge = 0 ; on ne merge, on efface donc tout
                ReDim Obj(0)
                k = 0
                ShapeNew(1,1)                
            Else ; on merge, on garde nos objets
                k = ArraySize(Obj())                
                ReDim Obj(k)
            EndIf
            
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
                            If Obj(k)\nom$ ="" 
                                If nom$ <> ""
                                    Obj(k)\nom$ =nom$
                                Else
                                    Obj(k)\nom$ ="Object"+Str(k)
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
                        
                    Case "obj"
                        If Vd\NbShape >=1 And merge <> 2 ; Obj(ObjId)\Actif = 0
                            k = ArraySize(Obj())+1                            
                        Else
                            k = ArraySize(Obj())
                            Vd\NbShape = 1
                        EndIf
                        If merge <> 2 ; on load un shape dans l'objet courant
                            ReDim Obj(k)
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
                        Else
                            k=ObjId
                            nbShape = ArraySize(Obj(ObjId)\Shape())+1
                        EndIf                   
                       
                        
                        
                    Case "shape" 
                        j = Val(StringField(line$,2,",")) + nbShape
                        If j > ArraySize(Obj(ObjId)\Shape())
                            ReDim Obj(ObjId)\Shape.sShape(j)
                        EndIf
                        Obj(ObjId)\Shape(j)\pos = j
                        Obj(ObjId)\Shape(j)\Depth = j
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
                                \Text$      = StringField(txtinfo$,1,";") 
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
                         Obj(ObjId)\Shape(j)\x   = Val(StringField(line$,u,",")) : u+1
                         Obj(ObjId)\Shape(j)\y   = Val(StringField(line$,u,",")) : u+1
                         Obj(ObjId)\Actif = 1
                        i=0
                        
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
                        EndWith
                        UpdateListShapeFX()
                        
                    Case "pt" 
                        i = Val(StringField(line$,2,","))
                        If i > ArraySize(Obj(ObjId)\Shape(j)\pt())
                            ReDim Obj(ObjId)\Shape(j)\pt.sPoint(i)
                        EndIf
                        Obj(ObjId)\Shape(j)\pt(i)\x = Val(StringField(line$,3,","))
                        Obj(ObjId)\Shape(j)\pt(i)\y = Val(StringField(line$,4,","))
                        
                EndSelect           
                
            Wend
            
            SetWindowTitle(#Win_VectorDrawing,#ProgramNameVD+#ProgramVersionVD+#ProgramBitVD+" - "+GetFilePart(file$))
            
            
            Vd\NbShape = 1
            ShapeGetProperties()
            UpdateUiObjetVD()
            
            
            CloseFile(10)
            If draw= 1
                Drawcanvas()
            EndIf
            
        EndIf
        
    EndIf
    
    UpdateListShape()
    ShapeId = 0
    
EndProcedure

Procedure ShapeExport(scene=0)
    
    ; pour exporter une image ou une série d'image

    vx = vd\ViewX
    vy = vd\ViewY
    
    ; on ouvre le fichier à sauvegarder
    File$ = SaveFileRequester("Save Image...", File$, "png Images|*.png|All Files|*.*", 0)
    
    If File$ <> ""
        
        If GetExtensionPart(File$) <> "png"
            File$+".png"
        EndIf
        
        
        vd\ViewX = 0
        vd\ViewY = 0
        
        w1 = GadgetWidth(#G_canvasVector)
        h1 = GadgetHeight(#G_canvasVector)
        If w1 < VdOptions\CameraW
            w1 = VdOptions\CameraW
        EndIf
        If h1 < VdOptions\CameraH
            h1 = VdOptions\CameraH
        EndIf
        
        If CreateImage(0, w1, h1, 32,#PB_Image_Transparent) 
            
            ;             ; on efface l'image temporaire
            ;             If StartDrawing(ImageOutput(0))
            ;                 DrawingMode(#PB_2DDrawing_AllChannels)
            ;                 Box(0,0,GadgetWidth(0),GadgetHeight(0),RGBA(0,0,0,0))
            ;                 StopDrawing()
            ;             EndIf
            
            ; on dessine sur l'image temporaire notre image
            
            If StartVectorDrawing(ImageVectorOutput(0))
                
                If old = 0
                    
                    ResetCoordinates()
                    
                    For m = 0 To ArraySize(Obj())  
                        
                        If Obj(m)\Hide = 0
                            
                            For j =0 To ArraySize(Obj(m)\Shape())                            
                                ; si clippath
                                ; SaveVectorState()
                                ; ClipPath()   
                                ; on dessine les fx en dessous
                                VdDrawFx(m,j,0)                            
                                ; dessin du shape
                                VdDrawShape1(m,j)
                                VDDrawShapeColor(m,j)                            
                                ; si fx au dessus
                                VdDrawFx(m,j,1) 
                                ; RestoreVectorState()                           
                            Next
                            
                        EndIf
                        
                    Next                     
                    
                Else
                    For j =0 To  ArraySize(Obj(ObjId)\Shape())
                        With Obj(ObjId)\Shape(j)
                            
                            MovePathCursor(\pt(0)\x,\pt(0)\y)
                            
                            
                            ; pour les Fx en dessous
                            
                            
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
                                
                                AddPathCurve(\pt(u)\x, \pt(u)\y,\pt(v)\x,\pt(v)\y,\pt(w)\x,\pt(w)\y)
                            Next
                            
                            
                            ; pour les Fx au dessus
                            
                            
                            
                            
                            ; remplir le chemin
                            color = RGBA(Red(\color),Green(\color),Blue(\color),\Alpha)
                            VectorSourceColor(Color)
                            FillPath()
                        EndWith
                    Next
                EndIf
                ; Debug"sortie :"+ GadgetWidth(#G_canvasVector)+"/"+GadgetHeight(#G_canvasVector)
                
               
                StopVectorDrawing()
            EndIf
            
            ;{  ; on définit les min x/y et max x/y
            minx = ImageWidth(0)
            miny = ImageHeight(0)
            maxX = 0
            maxY = 0
            
            ; puis, on vérifie si l'alpha est >0 , si oui, on une couleur et donc on garde le pixel
            If StartDrawing(ImageOutput(0))
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                For x=0 To ImageWidth(0)-1
                    For y =0 To ImageHeight(0)-1
                        Couleur = Point(x,y)
                        a = Alpha(couleur)
                        If a >0
                            If minx>x
                                minx=x
                            EndIf
                            If miny > y
                                miny=y
                            EndIf
                            If maxX < x
                                maxX=x
                            EndIf
                            If maxY<y
                                maxY = y
                            EndIf
                        EndIf                    
                    Next
                Next
                StopDrawing()
            EndIf
            ; Debug "x : "+Str(minx)+"/y : "+Str(miny)+" | w "+maxX+"/h "+maxY
            ; Debug "w : "+Str(maxX-minx)+"/h : "+Str(maxY-miny)
            
            x = minx
            y = miny
            w = Abs(maxX-minX)+1
            h = Abs(maxY-miny)+1
            ;}
            
            
            If scene = 1
                x = VdOptions\CameraX
                y = VdOptions\CameraY
                w = VdOptions\CameraW
                h = VdOptions\CameraH
            EndIf
            
            If GrabImage(0,1,x,y,w,h)
                
                If SaveImage(1, File$, #PB_ImagePlugin_PNG) = 0
                    MessageRequester("Save image", "Cannot save image: " + File$)
                    ; Else
                    ; MessageRequester("Save image","Image saved ! ")
                EndIf
                
            EndIf
            If IsImage(0)
                FreeImage(0)
            EndIf
            
        EndIf            
        
    EndIf
    
    vd\ViewX = vx
    vd\ViewY = vy
    
EndProcedure

Procedure VD_ExportPbCommand()
    
    ; pour exporter au format pb :)
   
    
    ; on ouvre le fichier à sauvegarder
    File$ = SaveFileRequester("Save Purebasic Command...", GetCurrentDirectory(), "Pb files (.pb)|*.pb|All Files|*.*", 0)
    
    If file$ <> ""
        
        file$ = RemoveString(file$,".pb")
        If GetExtensionPart(File$) <> "pb"
            File$+".pb"
        EndIf
        
        If CreateFile(2,file$)
            
            WriteStringN(2,"; Made with Cartoon ! "+StrD(ValD(#ProgramVersionVD),2))             
            WriteStringN(2,"; Date : "+FormatDate("%dd/%mm/%yyyy", Date()) )        
            WriteStringN(2,"; Pb Version : 5.42 + " )            
            WriteStringN(2,"")            
            WriteStringN(2,"Global Zoom.f = 1" )
            WriteStringN(2,"")
            WriteStringN(2,"")
            
            
            WriteStringN(2,"Procedure "+Obj(ObjId)\Nom$+"(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="+Chr(34)+Chr(34)+")")
            WriteStringN(2,"")
            WriteStringN(2,"    Protected Z.f")
            WriteStringN(2,"    Z = Zoom")
            
            ; d'abord, je dois vérifier quel est le x et le y le plus petit, car ce sera l'origine
            x0 = Obj(ObjId)\Shape(0)\x- Obj(ObjId)\Shape(0)\SizeW
            y0 = Obj(ObjId)\Shape(0)\y- Obj(ObjId)\Shape(0)\SizeH
            
            For i=0 To ArraySize(Obj(ObjId)\Shape()) 
                
                With Obj(ObjId)\Shape(i)
                    
                    Select \ShapTyp 
                            
                        Case #VD_ShapeCircle    
                            xx0 = \x-\SizeW
                            yy0 = \y-\SizeH
                            If xx0 >=\SizeW And yy0 >=\SizeH
                                If x0 >xx0  And y0>yy0
                                    x0 = \x -\SizeW                     
                                    y0 = \y -\SizeH
                                    final = i
                                EndIf
                            EndIf
                            
                        Case #VD_ShapeBox,#VD_ShapeBoxRnd 
                            xx0 = \x
                            yy0 = \y
                            If xx0 >=0 And yy0>0
                                If x0 >xx0  And y0>yy0
                                    x0 = \x                    
                                    y0 = \y 
                                    final = i
                                EndIf
                            EndIf
                            
                        Case #VD_ShapeShape, #VD_ShapeLine, #VD_ShapeCurve
                            For j=0 To ArraySize(\pt())
                                If x0>\pt(j)\x+\x And y0>\pt(j)\y+\y
                                    x0 = \pt(j)\x+\x
                                    y0 = \pt(j)\y+\y
                                    final = i
                                EndIf
                            Next                        
                    EndSelect            
                    
                EndWith
                
            Next
            
            ; puis, on verifie les x0 et y0
            Select Obj(ObjId)\Shape(final)\ShapTyp
                    
                Case #VD_ShapeBox,#VD_ShapeBoxRnd,#VD_ShapeCircle
                    min(x0,0)
                    min(y0,0)
                    
            EndSelect
            
            
            
            
            ; puis, je sauve le contenu des objet-layer
            For j=0 To ArraySize(Obj(ObjId)\Shape())
                
                With Obj(ObjId)\Shape(j)
                    
                    If \Hide = 0
                        
                       vx = \x - x0 
                       vy = \y - y0
                       
                       ; je sauvegarde en fonction du type de shape
                       x1 = \pt(0)\x + vx 
                       y1 = \pt(0)\y + vy 
                       
                       WriteStringN(2,"    MovePathCursor(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z)")
                       
                       Select \ShapTyp
                                
                            Case #VD_ShapeShape              
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
                                        x2 = x1
                                        y2 = y1
                                    Else
                                        x2 = \pt(w)\x+vx
                                        y2 = \pt(w)\y+vy
                                    EndIf                                    
                                    WriteStringN(2,"    AddPathCurve(("+Str(\pt(u)\x+vx)+"+x)*Z, ("+Str(\pt(u)\y+vy)+"+y)*Z, ("+
                                                   Str(\pt(v)\x+vx)+"+x)*Z, ("+Str(\pt(v)\y+vy)+"+y)*Z, ("+
                                                   Str(x2)+"+x)*Z, ("+Str(y2)+"+y)*Z)")
                                Next
                                
                            Case #VD_ShapeBox
                                WriteStringN(2,"    AddPathBox(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                                
                                
                            Case #VD_ShapeCircle
                                ; WriteStringN(2,"    AddPathEllipse(("+Str(\pt(0)\x+vx)+"+x)*Z, ("+Str(\pt(0)\y+vy)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                                WriteStringN(2,"    AddPathEllipse(("+Str(x1)+"+x)*Z, ("+Str(y1)+"+y)*Z, ("+Str(\SizeW)+"*ScaleX)*Z, ("+Str(\sizeH)+"*ScaleY)*Z)")
                                
                            Case #VD_ShapeImage
                                ;WriteStringN(2,"MovePathCursor(("+Str(vx)+"+x)*Z, "+Str(vy)+"+y)*Z)")
                                If IsImage(\img)                                   
                                    ;WriteStringN(2,"DrawVectorImage(ImageID(\img),\Alpha,\SizeW,\SizeH)                                                               
                                EndIf
                                
                            Case #VD_ShapeText                                 
                                WriteStringN(2,"    MovePathCursor(("+Str(vx)+"+x)*Z, ("+Str(vy)+"+y)*Z)")
                                WriteStringN(2,"    VectorFont(FontID(Font), ("+Str(\SizeW)+"*ScaleX)*Z)")
                                WriteStringN(2,"    txt$ = "+\Text$+ " ; you can comment this line if needed and use the txt parameter in the procedure")
                                WriteStringN(2,"    AddPathText(txt$)")
                                
                            Case #VD_ShapeCurve
                                For i =1 To ArraySize(\pt())-1 Step 3
                                    u = i
                                    v = i+1
                                    w = i+2
                                    If w > ArraySize(\pt())
                                        w =0
                                    EndIf                    
                                    ;AddPathCurve(\pt(u)\x+vx, \pt(u)\y+vy,\pt(v)\x+vx,\pt(v)\y+vy,\pt(w)\x+vx,\pt(w)\y+vy)
                                Next
                                
                            Case #VD_ShapeLine
                                For i =0 To ArraySize(\pt()) 
                                    ;AddPathLine(\pt(i)\x+vx,\pt(i)\y+vy)
                                Next
                                
                        EndSelect
                        
                        ; puis, je sauvegarde la couleur
                        If \Linked = 0
                            
                            ;WriteStringN(2,"") 
                            If VdOptions\UseHexForPBCode = 0
                                color$ = Str(\color)
                            Else
                                color$ = "$"+Hex(\color)
                            EndIf
                            
                            WriteStringN(2,"    VectorSourceColor("+Color$+")")   
                            
                            ;{
                            ;                         Select \ColorGrad
                            ;                                 
                            ;                             Case 0
                            ;                                 VectorSourceColor(\color)   
                            ;                                 
                            ;                             Case 1 ; gradient lineaire
                            ;                                 n = ArraySize(\ColGrad())
                            ;                                 p = ArraySize(\pt())
                            ;                                 VectorSourceLinearGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,\pt(p)\x,\pt(p)\y)         
                            ;                                 For i=0 To n
                            ;                                     d = i/n
                            ;                                     VectorSourceGradientColor(\ColGrad(i),d) 
                            ;                                 Next
                            ;                                 
                            ;                             Case 2 ; gradient circulaire
                            ;                                 n = ArraySize(\ColGrad())
                            ;                                 VectorSourceCircularGradient(\pt(0)\x+w/2,\pt(0)\y+h/2,w/2) 
                            ;                                 For i=0 To n
                            ;                                     d = i/n
                            ;                                     VectorSourceGradientColor(\ColGrad(i),d)                    
                            ;                                 Next
                            ;                                 
                            ;                             Case 3 ; degradé 
                            ;                                 n = ArraySize(\ColGrad())
                            ;                                 VectorSourceImage(ImageID(\Img))    
                            ;                                 For i=0 To n
                            ;                                     d = i/n
                            ;                                     VectorSourceGradientColor(\ColGrad(i),d) 
                            ;                                 Next
                            ;                                 
                            ;                                 
                            ;                                 
                            ;                         EndSelect
                            ;}
                            
                            ; on choisit le type (line, dash, dot, filled..)
                            Select \Typ
                                Case 0
                                    WriteStringN(2,"    FillPath()")
                                    
                                Case 1
                                    WriteStringN(2,"    StrokePath("+Str(\w)+",#PB_Path_RoundEnd)")
                                    
                                Case 2
                                    WriteStringN(2,"    DashPath("+Str(\w)+", "+Str(\h)+")")
                                    
                                Case 3
                                    WriteStringN(2,"    DotPath("+Str(\w)+", "+Str(\h)+",#PB_Path_RoundEnd)")
                                    
                            EndSelect
                            
                            ;WriteStringN(2,"")  
                            WriteStringN(2,"")  
                            
                        EndIf
                        
                    EndIf
                    
                EndWith
               
            Next
            
            
            WriteStringN(2,"")
            WriteStringN(2,"EndProcedure ")
            WriteStringN(2,"")
            WriteStringN(2,"")
                
            
            
            CloseFile(2)
        EndIf
        
        
    EndIf
    
    
    
EndProcedure
;}



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
        
        ; J'efface avec un simple Background, pour gagner du temps
        AddPathBox(0,0, VdOptions\CameraW,VdOptions\CameraH)
        VectorSourceColor(VdOptions\BgColor)
        FillPath()
        
        
        ; je devrais afficher un cache pour voir uniquement ce que contient la camera
        AddPathBox(0,0, GadgetWidth(#G_canvasVector),GadgetHeight(#G_canvasVector))
        AddPathBox(0,0, VdOptions\CameraW,VdOptions\CameraH)
        VectorSourceColor(RGBA(50,50,50,255))
        FillPath()
        
        
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
        VectorSourceColor(RGBA(0, 0, 0, 255))
        FillPath()
        
         
        StopVectorDrawing()
    EndIf

EndProcedure

Procedure PlayAnimation()
    
    
        VdDrawAnimation()
       
    
EndProcedure

;}


;}



Procedure OpenWinVectorDrawing()
    
    
    InitVectorDrawing()   
    
    winw = VDOptions\WinW
    winh = VDOptions\WinH
    
    flag = #PB_Window_SystemMenu|#PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget

    If OpenWindow(#Win_VectorDrawing, 0, 0, winw, winh, #ProgramNameVD+#ProgramVersionVD+#ProgramBitVD, flag)
        
        
    ;{ menu, gadgets...
    
    If CreateMenu(#MenuWinVD,WindowID(#Win_VectorDrawing))
        
        ;{ files
        MenuTitle("Files")
;         MenuItem(#menuVD_ProjNew,"New Project")
;         MenuItem(#menuVD_ProjOpen,"Open Project")
;         MenuItem(#menuVD_ProjSave,"Save Project")
;         MenuItem(#menuVD_ProjSaveCopy,"Save Project copy")
;         For i = #menuVD_ProjNew To #menuVD_ProjSaveCopy
;             DisableMenuItem(#MenuWinVD,i,1)
;         Next
        
        MenuBar()
        MenuItem(#menuVD_ShapeNew,"New "+Chr(9)+"Ctrl+N")
        MenuItem(#menuVD_ShapeOpen,"Load Object"+Chr(9)+"Ctrl+O")
        MenuItem(#menuVD_ShapeMergeShape,"Merge")
        MenuBar()
        MenuItem(#menuVD_ShapeSave,"Save"+Chr(9)+"Ctrl+S")
        MenuItem(#menuVD_ShapeSaveAs,"Save a copy")
        MenuBar()
        MenuItem(#menuVD_ShapeExport,"Export the object as image"+Chr(9)+"Ctrl+E")
        MenuItem(#menuVD_ExportScene,"Export Scene (image)")
        MenuBar()
        MenuItem(#menuVD_ExportPb,"Export in purebasic")
        MenuBar()
        MenuItem(#menuVD_ShapeQuit,"Quit")
        ;}
        
        ; MenuTitle("Edit")
        
        ;{ view
        MenuTitle("View") 
        OpenSubMenu("Zoom")
        MenuItem(#menuVD_Zoomplus,"Zoom +"+Chr(9)+"Ctrl + ")
        MenuItem(#menuVD_ZoomMoins,"Zoom -"+Chr(9)+"Ctrl - ")
        MenuItem(#menuVD_Zoom50,"Zoom 50%"+Chr(9)+"Ctrl+Pad5")
        MenuItem(#menuVD_ZoomReset,"Zoom 100%"+Chr(9)+"Ctrl+Pad1")
        MenuItem(#menuVD_Zoom200,"Zoom 200%"+Chr(9)+"Ctrl+Pad2")
        MenuItem(#menuVD_Zoom500,"Zoom 500%"+Chr(9)+"Ctrl+Pad8")
        MenuItem(#menuVD_Zoom1000,"Zoom 1000%"+Chr(9)+"Ctrl+Pad6")
        MenuItem(#menuVD_Zoom1500,"Zoom 1500%"+Chr(9)+"Ctrl+Pad7")
        CloseSubMenu()
        MenuBar()
        MenuItem(#menuVD_ViewCenter,"View Center"+Chr(9)+"Ctrl+Pad4")
        MenuItem(#menuVD_ViewReset,"View Reset"+Chr(9)+"Ctrl+Pad0")
        MenuBar()
        MenuItem(#menuVD_ShowGrid,"Show grid"+Chr(9)+"Ctrl+G")
        SetMenuItemState(#MenuWinVD,#menuVD_ShowGrid,VdOptions\ShowGrid)
        MenuItem(#menuVD_ShowCamBorder,"Show camera border")
        MenuItem(#menuVD_ShowCamCache,"Show camera cache")
        MenuBar()
        MenuItem(#menuVD_HideAncre,"Hide anchor")
        MenuItem(#menuVD_ShowAncreSelected,"Show anchor of selected shapes")
        MenuItem(#menuVD_ShowSelection,"Show selection (dash stroke)")
        MenuItem(#menuVD_ShowOnlySelected,"Show only selected")
        SetMenuItemState(#MenuWinVD,#menuVD_ShowSelection,VdOptions\ShowSelection)
        SetMenuItemState(#MenuWinVD,#menuVD_HideAncre,VdOptions\HideAncre)
        ;}
        
        MenuTitle("Object")
        MenuItem(#menuVD_AddObjet,"Add a new object")
        MenuItem(#menuVD_DeleteObjet,"Delete the current object")

        ;{ shapes 
        MenuTitle("Shape")
        MenuItem(#menuVD_ShapeSelectAll,"Select All"+Chr(9)+"Ctrl+A")
        MenuItem(#menuVD_ShapeDeselectAll,"Deselect All"+Chr(9)+"Ctrl+D")
        MenuItem(#menuVD_ShapeLockSelect,"Lock selection")
        MenuBar()
        MenuItem(#menuVD_ShapeCopy,"Copy current shape"+Chr(9)+"Ctrl+C")
        MenuItem(#menuVD_ShapePast,"Paste"+Chr(9)+"Ctrl+V")
        MenuItem(#menuVD_ShapePastToshape,"Paste to shape ")
        MenuBar()
        MenuItem(#menuVD_ShapeDelete,"Delete the current shape"+Chr(9)+"Suppr")
        MenuBar()
        MenuItem(#menuVD_SetShapeToOrigin,"Set shape to origin (position x,y)")
        MenuItem(#menuVD_SetOriginToShape,"Set origin to shape (position x,y)")
        MenuBar()
        MenuItem(#menuVD_SetShapeToBottom,"Set Shape to bottom (depth)")
        MenuItem(#menuVD_SetShapeToTop,"Set Shape to top (depth)")
        ;}
        
        MenuTitle("Window") 
        ; OpenSubMenu("WorkSpace")
        ;MenuItem(#menuVD_WS_Draw,"Drawing (& ShapeKey)")
        ;MenuItem(#menuVD_WS_Animation,"Animation (Dope sheet, LNA)")
        MenuItem(#menuVD_ShowTimeLine,"Show Timeline")
        MenuBar()
        MenuItem(#menuVD_WS_Scene,"Scene")
        SetMenuItemState(#MenuWinVD,#menuVD_WS_Scene,1)
        ;MenuItem(#menuVD_WS_Sequence,"Sequence")
        ;MenuItem(#menuVD_WS_Compositor,"Compositor")
        
        MenuTitle("Help")        
        MenuItem(#menuVD_About,"About")
        MenuItem(#menuVD_Update,"Update")
        MenuBar()
        MenuItem(#menuVD_Help,"Help (rtf)")
        MenuItem(#menuVD_Wiki,"Help (Wiki)")
        
        ; MenuItem(#menuVD_HelpHtml,"Help (html)"+Chr(9)+"F1")
        
        ;{ Shortcuts
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_O,#menuVD_ShapeOpen)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_N,#menuVD_ShapeNew)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_S,#menuVD_ShapeSave)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_E,#menuVD_ShapeExport)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_C,#menuVD_ShapeCopy)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_V,#menuVD_ShapePast)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_D,#menuVD_ShapeDeselectAll)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_A,#menuVD_ShapeSelectAll)
        
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Add,#menuVD_Zoomplus)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Subtract,#menuVD_ZoomMoins)
        
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad5,#menuVD_Zoom50)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad2,#menuVD_Zoom200)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad8,#menuVD_Zoom500)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad6,#menuVD_Zoom1000)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad7,#menuVD_Zoom1500)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad1,#menuVD_ZoomReset)
        
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad0,#menuVD_ViewReset)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_Pad4,#menuVD_ViewCenter)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Control|#PB_Shortcut_G,#menuVD_ShowGrid)
        
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_Delete,#menuVD_ShapeDelete)
        AddKeyboardShortcut(#Win_VectorDrawing,#PB_Shortcut_F1,#menuVD_HelpHtml)
        ;}
        
    EndIf
    
    VD_CreatePopUpMenu()
    
    InitVD()
   
    ;{ gadgets
    
    ;VdOptions\PanelW = 150
    ;VdOptions\ToolBarH = 25
    PanelVDW = VdOptions\PanelW
    BarVDH = VdOptions\ToolBarH
    TimeLineH = VdOptions\TimeLineH
    If TimeLineH <20
        TimeLineH = 20
    EndIf
    
    x1 = 5 : a=1
    y1 = 0
    w1 = 100 : w2 = 30 : w7=45 : w8=40 : w3 = 50 : w4 = 60 : w5 = 20 : w6 = 80
    h1 = 20 : h2 = 25
    
    Hg = Winh-10-TimeLineH-BarVDH
       
    VD_CreateToolBar()
    
    tbw = 0
    If VdOptions\ToolBarVertical = 1
        tbw = VdOptions\ToolBarW+a
    EndIf
    
    
    x1 = 10 : y1 = 10
    
    a = 3 : b = 5 : c = 2
    If PanelGadget(#G_panelVD,tbw,BarVDH,PanelVDW,Hg-50)
        
        ;{ Shapes
        
        y1 = 10
        AddGadgetItem(#G_panelVD,-1,"Shapes")
        
        
        TextGadget(#PB_Any, x1,y1+3,w2,h1,"Name") : x1+w2+2
        StringGadget(#G_shapeNom, x1,y1,w1,h1,"") : y1 +h1+a : x1 =10
        
        AddGadget(#G_shapeListAdd, #Gad_Cbbox, x1,y1,w6,h1,"",0,0,"Select the shape to add.") : x1+w6+2
        UpdateListAddShape()        
        AddGadget(#G_shapeAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,"Add a new complexe Shape.") : x1+w5+2
        AddGadget(#G_shapeDel, #Gad_Btn, x1,y1,w5,h1,"-",0,0,"Delete the selected shape.") :x1 =10 : y1+h1+a
        
        If ListViewGadget(#G_shapelist,x1,y1,130,100,#PB_ListView_ClickSelect) : y1+100+a  
        Else
            End
        EndIf
        AddGadget(#G_shapePosUp, #Gad_BtnImg, x1,y1,h1,h1,"",0,ImgLayer(#ivd_layerup),"Move the shape up.") : x1+h1+a
        AddGadget(#G_shapePosDown, #Gad_BtnImg, x1,y1,h1,h1,"",0,ImgLayer(#ivd_layerdown),"Move the shape down.") : x1+h1+a
        AddGadget(#G_shapeHide, #Gad_BtnImg, x1,y1,h1,h1,"",1, ImgLayer(#ivd_layerhide),"Hide the selected shape.") : x1+h1+a
        AddGadget(#G_shapeLock, #Gad_BtnImg, x1,y1,h1,h1,"",1, ImgLayer(#ivd_layerlock),"Lock the selected shape.") : x1+h1+a
        
        y1 + h1+a : x1 = 10
        AddGadget(#G_shapeLink, #Gad_Chkbox, x1,y1,w3,h1,"Link ",0,0,"To link the shape with the next shape and get 'hole' in shape if intersection instead of filled color.") : x1 + w3+a
        AddGadget(#G_shapeClose, #Gad_Chkbox, x1,y1,w3,h1,"Close ",0,0,"Close the path (line, curve, complexe shape)") : x1=10 : y1+h1+a
                 
      
        AddGadget(#G_shapeX, #Gad_Spin, x1,y1,w3,h1,"X ",-100000,100000,"Set the X position of the shape.") : y1+h1+a
        AddGadget(#G_shapeY, #Gad_Spin, x1,y1,w3,h1,"Y ",-100000,100000,"Set the Y position of the shape.")  : y1+h1+a
        AddGadget(#G_shapeSizeW, #Gad_Spin, x1,y1,w3,h1,"W ",0,10000,"Set the width of the shape.")  : y1+h1+a
        AddGadget(#G_shapeSizeH, #Gad_Spin, x1,y1,w3,h1,"H ",0,10000,"Set the height of the shape.")  : y1+h1+a
        
        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3+b,"Center") : y1 +15
        AddGadget(#G_shapeCX, #Gad_Spin,x1,y1,w3,h1,"CX",-10000,10000,"Change the center X (offset)") : y1+h1+a 
        AddGadget(#G_shapeCY, #Gad_Spin,x1,y1,w3,h1,"Cy",-10000,10000,"Change the center Y (offset)") : y1+h1+b*3
        
        ; Point
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*4+b,"Points") : y1 +15
        AddGadget(#G_shapePtMenu,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Properties),"Open the properties menu for the points") : x1+h1+a
        AddGadget(#G_shapePtHard,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Hard),"Set the point hard") : x1+h1+a
        AddGadget(#G_shapePtSoft,#Gad_BtnImg,x1,y1,h1,h1,"",0,ImgVd(#Img_Soft),"Set the point soft") : y1+h1+a
        
        x1 =10
        AddGadget(#G_shapePtX,#Gad_Spin,x1,y1,w7,h1,"X: ",-100000,100000,"Position X of the point (or the shape for box, ellipse, image, text).") : x1+w7+w2+a*2
        AddGadget(#G_shapePtXlock,#Gad_Chkbox,x1,y1,w8,h1,"Lock",0,0,"Lock X.") : y1+h1+a
        x1=10
        AddGadget(#G_shapePtY,#Gad_Spin,x1,y1,w7,h1,"Y: ",-100000,100000,"Position Y of the point (or the shape for box, ellipse, image, text).") : x1+w7+w2+a*2
        AddGadget(#G_shapePtYLock,#Gad_Chkbox,x1,y1,w8,h1,"Lock",0,0,"Lock Y.") : y1+h1+a
        
        ;}
                
        ;{ Color
        AddGadgetItem(#G_panelVD,-1,"Color")
        x1 = 10 : y1 = 10        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*2,"Color") : y1 +15 
        AddGadget(#G_shapeAlpha, #Gad_Spin, x1,y1,w2+15,h1,"Alpha",0,255,"Change alpha of the shape.") : x1+w2+15+35
        ButtonGadget(#G_shapeColor, x1,y1,w3,h1,"Color"): y1+h1+b*3 : x1=10
        ; ButtonGadget(#G_shapeTexture, x1,y1,w3,h1,"Texture"): y1+h1+b*3 : x1=10
        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*6,"Style") : y1+15
        AddGadget(#G_shapeTyp, #Gad_Cbbox, x1,y1,w1,h1,"",0,255,"Change the type of the shape (line, filled..).") : y1+h1+a
        line$ = "filled,line,dash,dot,custom"
        For i=0 To 3
            AddGadgetItem(#G_shapeTyp,i,StringField(line$,i+1,","))
        Next
        AddGadget(#G_shapeLineW, #Gad_Spin, x1,y1,w3,h1,"Width",0,1000,"Change the width of the line shape.") : y1+h1+a
        AddGadget(#G_shapeLineH, #Gad_Spin, x1,y1,w3,h1,"Height",0,1000,"Change the Height of the line shape.") : y1+h1+a
        AddGadget(#G_shapeLineD, #Gad_Spin, x1,y1,w3,h1,"Dist",0,1000,"Change the distance for the line shape (dot line).") : y1+h1+a
        
        y1+h1        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3,"Extra") : y1+15  
        AddGadget(#G_shapeRnd, #Gad_Spin, x1,y1,w3,h1,"Rnd ",-100000,100000,"Change the corner (for round box)"): y1+h1+a        
        y1+h1        
        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3,"Text") : y1+15   
        AddGadget(#G_shapeText, #Gad_Btn, x1,y1,w3,h1,"Text",0,0,"Change the text"): y1+h1+a 
        AddGadget(#G_shapeTextFont, #Gad_Btn, x1,y1,w3,h1,"Font",0,0,"Change the text font"): y1+h1+a
        
        y1+h1        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*8,"Image") : y1+15
        AddGadget(#G_shapeImgChange, #Gad_Btn, x1,y1,w3,h1,"Image",0,0,"Change the Shape Image"): y1+h1+a
        AddGadget(#G_shapeImgRepeat, #Gad_Chkbox, x1,y1,w3,h1,"Repeat",0,0,"Repeat the image on the shape"): y1+h1+a
        AddGadget(#G_shapeImgX, #Gad_Spin, x1,y1,w3,h1,"X ",-100000,100000,"Change the Image position X on the shape"): y1+h1+a
        AddGadget(#G_shapeImgY, #Gad_Spin, x1,y1,w3,h1,"Y ",-100000,100000,"Change the Image position Y on the shape"): y1+h1+a
        AddGadget(#G_shapeImgW, #Gad_Spin, x1,y1,w3,h1,"W ",1,10000,"Change the Image width."): y1+h1+a
        AddGadget(#G_shapeImgH, #Gad_Spin, x1,y1,w3,h1,"H ",1,10000,"Change the Image height."): y1+h1+a
        ;AddGadget(#G_shapeImgRot, #Gad_Spin, x1,y1,w3,h1,"Angle ",-10000,10000,"Change the Image angle."): y1+h1+a
        

        
        ;}
        
        ;{ FX 
        
        AddGadgetItem(#G_panelVD,-1,"FX")
        x1 = 10 : y1 = 10

        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*2,"Presets")
        y1 + 15
        AddGadget(#G_shapeFxPresetList, #Gad_Cbbox, x1,y1,w4,h1,"",0,0,"Select a preset for the Fx, if you prefer ;).")  : x1+w4+2
        AddGadget(#G_shapeFxPresetAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,"Add a new preset.")  : x1+w5+2
        AddGadget(#G_shapeFxPresetSave, #Gad_Btn, x1,y1,w2,h1,"Save",0,0,"Save the current parameter of the preset.")  : x1=10 : y1 +h1+a
        UpdateListPresetFx()
        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*3,"Parameters")
        y1+20
        AddGadget(#G_shapeFxList, #Gad_Cbbox, x1,y1,w1,h1,"",0,0,"Select the Fx to change.")  : x1+w1+2
        AddGadget(#G_shapeFxAdd, #Gad_Btn, x1,y1,w5,h1,"+",0,0,"Add a new Fx for the shape.") : x1=10 : y1+h1+a
        AddGadget(#G_shapeFxActif, #Gad_Chkbox, x1,y1,w3,h1,"Actif",0,0,"Set the Fx actif.") : y1+h1+a
        x1=10
        
        
        FrameGadget(#PB_Any,5,y1,PanelVDW-15,h1*6,"Style")
        Y1 +20
        AddGadget(#G_shapeFxLineTyp, #Gad_Cbbox, x1,y1,w1,h1,"Type",0,0,"Set the type of the Fx.") : y1+h1+a
        For i=0 To 3
            AddGadgetItem(#G_shapeFxLineTyp,i,StringField(line$,i+1,","))
        Next
        
        AddGadget(#G_shapeFxLineW, #Gad_Spin, x1,y1,w3,h1,"Width",0,1000,"Change the width of the line Fx.") : y1+h1+a
        AddGadget(#G_shapeFxLineH, #Gad_Spin, x1,y1,w3,h1,"Height",0,1000,"Change the height of the line Fx.") : y1+h1+a
        AddGadget(#G_shapeFxLineD, #Gad_Spin, x1,y1,w3,h1,"Dist",0,1000,"Change the distance for the line Fx (dot line).") : y1+h1+a
        
        y1 +10
        AddGadget(#G_shapeFxX, #Gad_Spin, x1,y1,w3,h1,"X : ",-10000,10000,"Set the X of the Fx.") : y1+h1+a 
        AddGadget(#G_shapeFxY, #Gad_Spin, x1,y1,w3,h1,"Y : ",-10000,10000,"Set the Y of the Fx.") : y1+h1+a 
        AddGadget(#G_shapeFxAlpha, #Gad_Spin, x1,y1,w3,h1,"Alpha",0,255,"Set the alpha of the Fx.") : x1+w3+w2+10
        AddGadget(#G_shapeFxColor, #Gad_Btn, x1,y1,w2,h1,"Color",0,0,"Set the color of the Fx.") : y1+h1+a : x1 = 10
        AddGadget(#G_shapeFxScale, #Gad_Spin, x1,y1,w3,h1,"Scale",-10000,10000,"Set the scale of the Fx.") : y1+h1+a :

        AddGadget(#G_shapeFxDepth, #Gad_Cbbox, x1,y1,w1,h1,"Depth",0,0,"Set the depth of the Fx.") : y1+h1+a 
        depth$ = "Back,Front,All back,All front"
        For i=0 To 3
            AddGadgetItem(#G_shapeFxDepth,i,StringField(Depth$,i+1,","))
        Next
        ;}
        
        CloseGadgetList()
    EndIf
    
    
    If PanelGadget(#G_PanelVDControl,tbw,Hg-50,PanelVDW,50)
        x1 =10 : y1 = 10
        AddGadgetItem(#G_PanelVDControl,-1,"Control")        
        
      ; Control butons 
        ;FrameGadget(#PB_Any,5,y1,PanelW-15,70,"Control") : y1 +20
        
        AddGadget(#G_VDAnimStart,#Gad_Btn,x1,y1,w2,h1,"<",0,0,"Start of the animation") : x1 + w2 +2
        AddGadget(#G_VDAnimPlay,#Gad_Btn,x1,y1,w2,h1,"Play",0,0,"Play the animation") : x1+w2+2
        
        ;ButtonGadget(#G_AnimNext,x1,y1,w2,h2,">>") : x1 + w2 +2 
        ;GadgetToolTip(#G_AnimNext,"Next keyframe for the sprite")
        
        AddGadget(#G_VDAnimEnd,#Gad_Btn,x1,y1,w2,h1,">",0,0,"End of the animation") : x1=10 : y1 +(h1+2)
        
        StringGadget(#G_VDAnimCurFrame, x1,y1,40,h1,"0",#PB_String_Numeric) : x1+42
        SetGadgetText(#G_VDAnimCurFrame,Str(CurrentFrame))
        GadgetToolTip(#G_VDAnimCurFrame,"Current Frame") 
        
        StringGadget(#G_VDAnimMaxFrame, x1,y1,40,h1,"300",#PB_String_Numeric) : x1+42
        SetGadgetText(#G_VDAnimMaxFrame,Str(Vd\FrameEnd))
        GadgetToolTip(#G_VDAnimMaxFrame,"Set the Max Frame for animation")
        
        SpinGadget(#G_VDAnimFps,x1,y1,40,h1,1,1000,#PB_Spin_Numeric ) 
        SetGadgetState(#G_VDAnimFps,vd\FrameFps) :  GadgetToolTip(#G_VDAnimFps,"Set The FPS for animation")
        
        
        CloseGadgetList()
    EndIf
    
    
    If CanvasGadget(#G_VDTimeline,tbw,Hg+10,winw-10-tbw,TimeLineH)
        Vd_UpdateTimeLine()
    EndIf
    
    
    If ContainerGadget(#G_CanvasPathVD,tbw+PanelVDW+5,BarVDH,winw,h2)
        
        x1 = 0 : y1 = 0  
        
        If CanvasGadget(#G_CanvasPathVDScene,x1,0,250,h1) :X1+260 : EndIf 
        VD_UpdateCanvasPaTh()
        
            
        
        y1 = 0                     
        ; Offset
        AddGadget(#G_ToolVDOffset, #Gad_Cbbox, x1,y1,w6,h1,"",0,0,"Choose the offset for transformation.") : x1+w6+a+5
        t$ ="Origin,Cursor,Bounding box,Selected shape"
        For i = 0 To CountString(t$,",")
            AddGadgetItem(#G_ToolVDOffset,i,StringField(t$,i+1,","))
        Next
        SetGadgetState(#G_ToolVDOffset,0)
        
        ; snap
        AddGadget(#G_ToolVDSnap, #Gad_Chkbox, x1,y1,w7,h1,"Snap",0,0,"Set the Snap.",VdOptions\Snap) : x1+w7+a
        AddGadget(#G_ToolVDSnapX, #Gad_Spin, x1,y1,w7,h1,"",1,100000,"Set the Snap X.",VdOptions\SnapX) : x1+w7+a
        AddGadget(#G_ToolVDSnapY, #Gad_Spin, x1,y1,w7,h1,"",1,100000,"Set the Snap Y.",VdOptions\SnapY) : x1+w7+a
        
        CloseGadgetList()
    EndIf
    
    If CanvasGadget(#G_canvasVector, tbw+PanelVDW+5, BarVDH+h2, winw-PanelVDW*2-10-tbw, Hg-h2,#PB_Canvas_Keyboard|#PB_Canvas_Border) :EndIf
    
;     If ContainerGadget(#G_CanvasOptionVD,tbw+PanelVDW+5,Hg-h2,winw,h2)
;         
;        
;         CloseGadgetList()
;     EndIf
    
    
    ; RIGHT panel
    If PanelGadget(#G_panelVD_R,tbw+PanelVDW+10+GadgetWidth(#G_canvasVector),BarVDH,PanelVDW,Hg)
               
        ;{ Objet
        x1 = 10 : y1 = 10
        AddGadgetItem(#G_panelVD_R,-1,"Object")
        
        ; AddGadget(#G_ObjCreate, #Gad_Chkbox, x1,y1,w6+35,h1,"Create new object.",0,0,"Create a new object when you add a new shape, box, circle, line...") : y1+h1+a
        
        ; AddGadget(#G_ObjList, #Gad_ListV, x1,y1,w6+35,200,"",0,0,"Select the objet to modify.") : y1+200+a
        
        y1 +VD_CreateObjectUi()
       
        ; AddGadget(#G_ObjDepth, #Gad_Spin, x1,y1,w6,h1,"Depth",-10000,10000,"Change the depth of the objet.") : y1+h1+a
        ; AddGadget(#G_ObjName, #Gad_String, x1,y1,w6,h1,"Name ",0,0,"Change the name of the objet.") : y1+h1+a
        x1 =5 
        If FrameGadget(#PB_Any, x1,y1,PanelVDW-x1*2,h1*6,"Properties") : EndIf
        y1 +15 : x1 +10
        AddGadget(#G_ObjX, #Gad_Spin, x1,y1,w6,h1,"X ",-10000,10000,"Change the X of the objet.") : y1+h1+a
        AddGadget(#G_ObjY, #Gad_Spin, x1,y1,w6,h1,"Y ",-10000,10000,"Change the Y of the objet.") : y1+h1+a
        AddGadget(#G_ObjW, #Gad_Spin, x1,y1,w6,h1,"W ",0,100000,"Change the width of the objet.") : y1+h1+a
        AddGadget(#G_ObjH, #Gad_Spin, x1,y1,w6,h1,"H ",0,100000,"Change the height of the objet.") : y1+h1+a
       
        
        ;}
        
        ;{ options
        
         x1 = 5 : y1 = 10
         AddGadgetItem(#G_panelVD_R,-1,"Options")
          If FrameGadget(#PB_Any, x1,y1,PanelVDW-x1*2,h1*3,"Background") :  y1 +15 : x1 +10 : EndIf
         AddGadget(#G_Vd_OptBGCheck, #Gad_Chkbox, x1,y1,w6,h1,"Checker BG ",0,0,"Add a checker to the Background.",VdOptions\BgImg) : y1+h1+a
         AddGadget(#G_Vd_OptBGColor, #Gad_Btn, x1,y1,w6,h1,"Color BG ",0,0,"Change the background color.",VdOptions\BgImg) : y1+h1+a
         AddGadget(#G_Vd_OptCamCachAlpha, #Gad_Spin, x1,y1,w7,h1,"Alpha",0,255,"Change the transparency of the camera cache.",VdOptions\CameraCacheAlpha) : y1+h1+a

         ;}
         
        CloseGadgetList()
    EndIf
    
    ;}
    
    ;{ Status bar
    If CreateStatusBar(0,WindowID(#Win_VectorDrawing))
      AddStatusBarField(110)
      AddStatusBarField(150)
      AddStatusBarField(150)
      StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
    EndIf
    

    ;}
        
    ;{ puis, on lance l'initialisation
    
    ; ShapeNew() 
    
    
    Drawcanvas()
    SetPanelGadget(1)
    SetWindowState(#Win_VectorDrawing,VdOptions\WinState)
    Vd_ResizeAll()
    Vd_LayerAdd(0)
   
    
    ; pour l'autosave
    rand = Random(1000000)
    TimerAutosave = ElapsedMilliseconds() + VdOptions\AutosaveTime * 1000
    
    BindEvent(#PB_Event_SizeWindow,@Vd_ResizeAll(),#Win_VectorDrawing)
    
    
    ;{ Tips
    Tp$ = "To create a line or a curve,select the line or curve tool, then clic and move the mouse./To move,rotate,scale a shape, first : select the object which contain this Shape, then move the mouse./"
    Tp$ + "To add point to the shape, curve or line, use 'addpoint' tool./To create a new object, when creating a new shape, set the checkbox 'Create new objet', in object panel./'"
    n = CountString(tp$,"/")-1
    Dim tip$(n)
    For i =0 To ArraySize(tip$())        
        tip$(i) = StringField(tp$,i+1,"/")
    Next   
    If VdOptions\ShowTip = 1
        MessageRequester("Tips ! ",tip$(Random(n)),32)
    EndIf
    ;}
    
     VD_CreateToolBar()
    ;}
     
     CreateThread(@VD_CheckForUpdate(),23 ); on vérifie si une nouvelle version existe
     
    ;}
     
    
     
    Repeat
        
        z.d = VdOptions\Zoom * 0.01
        
        Repeat 
            
            Event = WaitWindowEvent(1)
            
            If event = #PB_Event_Menu
            
                Select EventMenu()
                    
                    ;{ files
                Case #menuVD_ShapeSaveAs 
                    ShapeSave()
                    
                Case #menuVD_ShapeSave 
                    ShapeSave(VD\File$)
                    
                Case #menuVD_ShapeNew 
                    ShapeNew()
                    DrawCanvas()
                    
                Case #menuVD_ShapeMergeShape
                    ShapeLoad(1)
                    
                Case #menuVD_ShapeOpen
                    ShapeLoad()
                                        
                Case #menuVD_ExportScene
                    ShapeExport(1)
                    
                Case #menuVD_ExportPb
                    VD_ExportPbCommand()
                    
                Case #menuVD_ShapeExport
                    ShapeExport()
                    
                Case #menuVD_ShapeQuit
                    End
                    ;}
                    
                    ;{ Edit
                    ;}
                    
                    ;{ View
                Case #menuVD_ShowCamCache
                    Vd_ShowMenu(#menuVD_ShowCamCache,VdOptions\ShowCameraCache)
                    
                Case #menuVD_ShowCamBorder
                    Vd_ShowMenu(#menuVD_ShowCamBorder,VdOptions\ShowCameraBorder)
                    
                Case #menuVD_ShowGrid
                    Vd_ShowMenu(#menuVD_ShowGrid,VdOptions\ShowGrid)
                    
                Case #menuVD_ShowSelection
                    Vd_ShowMenu(#menuVD_ShowSelection,VdOptions\ShowSelection)
                    
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
                    VdOptions\Zoom + 1
                    Drawcanvas()
                    StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
                    
                Case #menuVD_ZoomMoins
                    If VdOptions\Zoom > 1
                        VdOptions\Zoom -1
                        Drawcanvas()
                    EndIf
                    StatusBarText(0, 0, "Zoom "+Str(VdOptions\Zoom))
                    
                    ;}
                    
                    ;{ Object
                Case #menuVD_AddObjet
                    n = ArraySize(Obj())+1
                    ReDim Obj.sObj(n)
                    ObjId = n
                    UpdateUiObjetVD()
                    
                Case #menuVD_DeleteObjet
                    DeleteArrayElement(Obj,ObjId)
                    ObjId = 0                    
                    UpdateUiObjetVD(1)
                    ;}
                    
                    ;{ Shapes 
                Case #menuVD_ShapeDelete
                    If GetActiveGadget() = #G_canvasVector
                        ShapeDelete()
                    EndIf
                    
                    
                Case #menuVD_ShapeLockSelect
                    Vd\LockSelection = 1-Vd\LockSelection
                    SetMenuItemState(0,#menuVD_ShapeLockSelect, Vd\LockSelection)
                    
                Case #menuVD_ShapeSelectAll
                    For i=0 To ArraySize(Obj(ObjId)\Shape())                        
                        With Obj(ObjId)\Shape(i)
                            \Selected = 1
                            Select vdOptions\Action 
                                Case #VD_actionMove
                                    \startY = y - \Y                                                               
                                    \startX = x - \X
                                Case #VD_actionScale
                                    \startX = x -\SizeW
                                    \startY = y +\SizeH
                            EndSelect
                        EndWith
                    Next
                    VD\Shift = 1
                    DrawCanvas(0,0,0)
                    
                Case #menuVD_ShapeDeselectAll
                    For i=0 To ArraySize(Obj(ObjId)\Shape())
                        Obj(ObjId)\Shape(i)\Selected = 0
                    Next
                    ShapeId = -1
                    DrawCanvas()
                    
                Case #menuVD_ShapeCopy                    
                    If ShapeId>-1
                        CopyObj\Shape(0)=Obj(ObjId)\Shape(ShapeId)
                        CopyObj\Shape(0)\Nom$ = "Shape_"+Str(ArraySize(Obj(ObjId)\Shape())+1)
                    EndIf 
                    
                Case #menuVD_ShapePast 
                    ;{
                    x = WindowMouseX(#Win_VectorDrawing) - VdOptions\PanelW
                    y = WindowMouseY(#Win_VectorDrawing) - vdoptions\ToolBarH
                    
                    n = ArraySize(Obj(ObjId)\Shape())+1
                    ReDim Obj(ObjId)\Shape(n)
                    ShapeId = n
                    ShapeNew(0,1)
                    Obj(ObjId)\Shape(ShapeId) = CopyObj\Shape(0)                   
                    Obj(ObjId)\Shape(ShapeId)\X =x
                    Obj(ObjId)\Shape(ShapeId)\y =y
                    Debug "X " + Obj(ObjId)\Shape(ShapeId)\X+ "/"+ x
                    Drawcanvas()
                    ShapeGetProperties()
                    UpdateListShape()
                    ;Debug "alpha "+Obj(ObjId)\Shape(ShapeId)\Alpha
                    ;Debug Obj(ObjId)\Shape(ShapeId)\Nom$ 
                    ;}
                    
                Case #menuVD_ShapePastToshape
                    If ShapeId>-1  
                        Obj(ObjId)\Shape(ShapeId)= CopyObj\Shape(0)
                         Drawcanvas()
                    EndIf
                                       
                Case #menuVD_SetShapeToTop
                    If ShapeId < ArraySize(Obj(ObjId)\Shape()) And ShapeId > -1
                        
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
                    If shapeId>-1                        
                        With Obj(ObjId)\Shape(ShapeId)
                            For j= 1 To ArraySize(\pt())
                                \pt(j)\x - \pt(0)\x
                                \pt(j)\y - \pt(0)\y
                            Next 
                            \pt(0)\x = 0
                            \pt(0)\y = 0
                        EndWith                           
                        Drawcanvas()
                    EndIf
                                        
                Case #menuVD_SetOriginToShape
                    If shapeId>-1                        
                        With Obj(ObjId)\Shape(ShapeId)
                            x6 = \pt(0)\x
                            y6 = \pt(0)\y
                            For j= 0 To ArraySize(\pt())
                                \pt(j)\x - x6
                                \pt(j)\y - y6
                            Next                                
                            \x + x6
                            \y + y6                           
                        EndWith                          
                        Drawcanvas()
                    EndIf
                    ;}
                    
                    ;{ Windows
                Case #menuVD_ShowTimeLine
                    Vd_ShowMenu(#menuVD_ShowTimeLine,VdOptions\showTimeLine)                    
                    Vd_ResizeAll()
                    ;}
                    
                    ;{ Help
                Case #menuVD_HelpHtml
                    VDOpenTheHelp(1)
                    
                Case #menuVD_Update
                    RunProgram("https://github.com/blendman/CartoonAnimation")
                    
                Case #menuVD_Wiki
                    RunProgram("https://github.com/blendman/CartoonAnimation/wiki/Home/")
                    
                Case #menuVD_Help
                    VDOpenTheHelp()
                    
                Case #menuVD_About
                    MessageRequester("Info",#ProgramNameVD+" is a software made by Blendman, to create vectoriel Shapes and animation."+Chr(10)+
                                            "The software is made in purebasic."+Chr(10)+                                            
                                            "Version : "+#ProgramVersionVD+#ProgramBitVD+Chr(10)+
                                            "Date : "+FormatDate("%dd/%mm/%yyyy",#PB_Compiler_Date))
                    ;}
                    
                    ;{ popup point
                Case #menuVD_PtSelectAll
                    If shapeId >-1
                        For i=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                            Obj(ObjId)\Shape(ShapeId)\pt(i)\Selected =1
                        Next
                        Vd\Shift = 1
                        Drawcanvas()
                    EndIf
                                        
                Case #menuVD_ConvertToShape
                    VD_ConvertShape()
                    
                Case #menuVD_DeletePt
                    Vd_DeletePoint(PtId)
                    DrawCanvas()
                    ;}
                    
            EndSelect
                        
            ElseIf event = #PB_Event_Gadget
                
                If vd\Play = 0
                    
                    Select EventGadget()
                            
                            ;{ * canvas 
                        Case #G_canvasVector 
                            
                            ; vd\Shift = 0                   
                            If EventType() = #PB_EventType_KeyDown ; Or EventType() = #PB_EventType_Focus          
                                If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Modifiers) & #PB_Canvas_Shift                            
                                    vd\Shift = 1                          
                                EndIf                        
                                If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) & #PB_Shortcut_Space                         
                                    Vd\Space = 1                            
                                EndIf
                            EndIf
                            
                            If EventType() = #PB_EventType_LeftButtonDown Or 
                               (EventType() = #PB_EventType_MouseMove And                         
                                GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
                                
                                If StartVectorDrawing(CanvasVectorOutput(#G_canvasVector))
                                    
                                    VD_ShapeCoord(ObjId)
                                    
                                    x5 = GetGadgetAttribute(#G_canvasVector, #PB_Canvas_MouseX)                           
                                    y5 = GetGadgetAttribute(#G_canvasVector, #PB_Canvas_MouseY)
                                    
                                    x = (ConvertCoordinateX(x5,y5,#PB_Coordinate_Device, #PB_Coordinate_User)/z) 
                                    y = (ConvertCoordinateY(x5,y5,#PB_Coordinate_Device, #PB_Coordinate_User)/z) 
                                    
                                    x1 = (x -VD\ViewX) 
                                    y1 = (y -VD\ViewY)
                                    
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
                                        
                                        
                                        If EventType() = #PB_EventType_LeftButtonDown     
                                            
                                            ; on clique sur le canvas 
                                            
                                            If Vd\ClicLb = 0
                                                
                                                Vd\spaceX = X - VD\ViewX
                                                Vd\spaceY = Y - VD\ViewY
                                                
                                                Vd\cliclb = 1
                                                Vd\move = 0
                                                
                                                If vdOptions\Action <= #VD_actionDelPt
                                                    
                                                    If shapeId >-1 ; on a 1 shape sélectionné
                                                        
                                                        If vdOptions\Action = #VD_actionAddPt
                                                            
                                                            If vd\move =0
                                                                
                                                                Select Obj(ObjId)\Shape(ShapeId)\ShapTyp 
                                                                        
                                                                    Case #VD_ShapeShape, #VD_ShapeCurve
                                                                        
                                                                        ; d'abord, je conserve la place du dernier point, 
                                                                        ;car je vais ajouter mes nouveaux points (3), après cette place.
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
                                                                            x4 = x1-\x
                                                                            y4 = y1-\y
                                                                            
                                                                            \pt(u)\x = x4+20
                                                                            \pt(u)\y = y4 
                                                                            \pt(v)\x = x4-20                                                                                    
                                                                            \pt(v)\y = y4 
                                                                            ; je définis la position du point n étant à x & y
                                                                            \pt(n)\x = x4
                                                                            \pt(n)\y = y4 
                                                                            ; puis, je dois replacer notre ancien dernier point à sa place initiale
                                                                            \pt(w)\x = x6
                                                                            \pt(w)\y = y6
                                                                            
                                                                            Vd\move = 3
                                                                        EndWith
                                                                        
                                                                    Case #VD_ShapeLine
                                                                        
                                                                        With Obj(ObjId)\Shape(ShapeId)
                                                                            n = ArraySize(\pt())+1
                                                                            ReDim \pt.sPoint(n)                                               
                                                                            \pt(n)\x = x1
                                                                            \pt(n)\y = y1                                         
                                                                            Vd\move = 3
                                                                        EndWith
                                                                        
                                                                EndSelect
                                                                
                                                            EndIf
                                                            
                                                        ElseIf vdOptions\Action = #VD_actioninsertPt
                                                            
                                                            ;For i =0 To ArraySize(\pt()
                                                            ;If \pt(
                                                            ;Next
                                                            ;InsertArrayElement(pt, element) 
                                                            
                                                        ElseIf  vdOptions\Action = #VD_actionRot
                                                            
                                                            For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                                                                
                                                                With Obj(ObjId)\Shape(ki)
                                                                    
                                                                    If ki = ShapeId Or \Selected = 1
                                                                        
                                                                        \startX = x+\Rot
                                                                        For k = 0 To ArraySize(\pt())
                                                                            \pt(k)\startX = \pt(k)\x
                                                                            \pt(k)\startY = \pt(k)\y                                               
                                                                        Next  
                                                                        
                                                                    EndIf 
                                                                    
                                                                EndWith
                                                                
                                                            Next
                                                    
                                                        ElseIf  vdOptions\Action = #VD_actionScale  
                                                                
                                                            For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                                                                
                                                                With Obj(ObjId)\Shape(ki)
                                                                    
                                                                    If ki = ShapeId Or \Selected = 1
                                                                        ; Debug "ok scale on garde start"
                                                                        For k = 0 To ArraySize(\pt())
                                                                            \pt(k)\startX = \pt(k)\x
                                                                            \pt(k)\startY = \pt(k)\y                                               
                                                                        Next 
                                                                        
                                                                        Select \ShapTyp
                                                                                
                                                                            Case #VD_ShapeBox,#VD_ShapeCircle,#VD_ShapeBoxRnd,#VD_ShapeImage,#VD_ShapeText  
                                                                                
                                                                                \startX = x+\SizeW
                                                                                \startY = y+\SizeH
                                                                                
                                                                            Default 
                                                                                \startX = x+\size
                                                                                
                                                                        EndSelect
                                                                        
                                                                    EndIf
                                                                    
                                                                EndWith
                                                                
                                                            Next
                                                        
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
                                                                
                                                                ; puis, je vérifie si on clique sur un point (pour le sélectionner)
                                                                c=3
                                                                With Obj(ObjId)\Shape(ShapeId)
                                                                                                                                        
                                                                    For ip=0 To ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())  
                                                                        
                                                                        xa = Obj(ObjId)\Shape(ShapeId)\pt(ip)\x - c + \X ;+ Obj(ObjId)\x
                                                                        ya = \pt(ip)\y - c + \y                                  ;+ Obj(ObjId)\y 
                                                                        wa = \pt(ip)\x + c + \x                                  ;+ Obj(ObjId)\x
                                                                        ha = \pt(ip)\y + c + \y                                  ;+ Obj(ObjId)\y
                                                                        
                                                                        If (x1>=xa And x1<=wa And y1>=ya And y1<=ha) Or 
                                                                           Sqr(Pow(\pt(ip)\x-x1,2)+Pow(\pt(ip)\y-y1,2))<=6    
                                                                            
                                                                            PtId = ip
                                                                            \pt(ip)\Selected = 1
                                                                            ok = 1 
                                                                            ShapeGetProperties()
                                                                            \startY = y1                                                      
                                                                            \startX = x1
                                                                            
                                                                            Select vdOptions\Action
                                                                                    
                                                                                Case #VD_actionMove 
                                                                                    
                                                                                    Vd\move = 1
                                                                                    sx0 = \pt(ip)\x + \x ;+ Obj(ObjId)\x
                                                                                    sy0 = \pt(ip)\y + \y ;+ Obj(ObjId)\y
                                                                                    
                                                                                    \pt(ip)\startX = \pt(ip)\x ;- x1 
                                                                                    \pt(ip)\startY = \pt(ip)\y ;- y1
                                                                                    j=ip
                                                                                    
                                                                                    If \ShapTyp = #VD_ShapeShape Or \ShapTyp = #VD_ShapeCurve
                                                                                        u = j+1
                                                                                        If u > ArraySize(\pt())
                                                                                            u=0
                                                                                        EndIf
                                                                                        v =j-1
                                                                                        If v <0
                                                                                            v =ArraySize(\pt())
                                                                                        EndIf                                                
                                                                                        sx1 = \pt(u)\x + \x ;+ Obj(ObjId)\x
                                                                                        sy1 = \pt(u)\y + \y ;+ Obj(ObjId)\y
                                                                                        sx2 = \pt(v)\x + \x ;+ Obj(ObjId)\x
                                                                                        sy2 = \pt(v)\y + \y ;+ Obj(ObjId)\y
                                                                                        If vd\shift
                                                                                            \pt(u)\Selected = 1
                                                                                            \pt(v)\Selected = 1
                                                                                        EndIf
                                                                                        \pt(u)\startX = \pt(u)\x ;- x1  ;+ Obj(ObjId)\x
                                                                                        \pt(u)\startY = \pt(u)\y ;- y1  ;+ Obj(ObjId)\y
                                                                                        \pt(v)\startX = \pt(v)\x ;- x1  ;+ Obj(ObjId)\x
                                                                                        \pt(v)\startY = \pt(v)\y ;- y1  ;+ Obj(ObjId)\y
                                                                                        
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
                                                                            
                                                                            Debug "start move "+\x+"/"+\y
                                                                            If \ShapTyp = #VD_ShapeImage Or \ShapTyp = #VD_ShapeText
                                                                                Vd\move = 2 
                                                                                \startY = y - \Y ;+ Obj(ObjId)\x                                                              
                                                                                \startX = x - \X ;+ Obj(ObjId)\y
                                                                            EndIf
                                                                                                                                                        
                                                                        EndIf
                                                                        
                                                                    EndIf
                                                                
                                                                EndWith  
                                                                
                                                                
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
                                                    ; on ajoute un nouvel objet                                                    
                                                    ;If vdOptions\Action <> #VD_actionAddBoxRnd
                                                        update = ShapeAddObjet(x1,y1)
                                                        PointId = ArraySize(Obj(ObjId)\Shape(shapeId)\pt())
                                                        If vdOptions\Action = #VD_actionAddCurve
                                                            pointId -2
                                                        EndIf   
                                                        
                                                        vd\AddObjet=2
                                                    ;EndIf
                                                    
                                                EndIf
                                                
                                            EndIf                                
                                           
                                            
                                        ElseIf EventType() = #PB_EventType_MouseMove ; on bouge la souris
                                            
                                            If ShapeId >-1 And vdOptions\Action < #VD_actionAddShape
                                                
                                                x1 * (1-VdOptions\Tool(vdOptions\Action)\LockX)
                                                y1 * (1-VdOptions\Tool(vdOptions\Action)\LockY)
                                                
                                                If VdOptions\Snap = 1
                                                    Snap(x1,VdOptions\SnapX)  
                                                    Snap(y1,VdOptions\SnapY) 
                                                EndIf
                                                
                                                If Vd\move = 1   ; on bouge le/les pts sélectionné(s) 
                                                    
                                                    Select vdOptions\Action
                                                            
                                                        Case #VD_actionMove
                                                            
                                                            i = PtId
                                                            With Obj(ObjId)\Shape(ShapeId)
                                                                
                                                                If \Locked = 0
                                                                    
                                                                    Select \ShapTyp
                                                                            
                                                                        Case #VD_ShapeShape, #VD_ShapeCurve, #VD_shapeLine
                                                                            If im <= ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                                                                                
                                                                                If vd\Shift =0
                                                                                    ;{ on ne bouge qu'un point
                                                                                    \pt(i)\x = x1 -\x ; - Obj(ObjId)\x
                                                                                    \pt(i)\y = y1 -\y ; - Obj(ObjId)\y
                                                                                    
                                                                                    SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
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
                                                                                            \pt(u)\x = sx1+(\pt(i)\x-sx0)
                                                                                            \pt(u)\y = sy1+(\pt(i)\y-sy0)
                                                                                            \pt(v)\x = sx2+(\pt(i)\x-sx0)
                                                                                            \pt(v)\y = sy2+(\pt(i)\y-sy0)
                                                                                        EndIf 
                                                                                    EndIf 
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
                                                                            
                                                                        Default
                                                                            i = PtId
                                                                            ;For i=0 To ArraySize(\pt())
                                                                                ;If i =PtId Or \pt(i)\Selected = 1
                                                                                If i <= ArraySize(Obj(ObjId)\Shape(ShapeId)\pt())
                                                                                    \pt(i)\x = x1 -\x - Obj(ObjId)\x
                                                                                    \pt(i)\y = y1 -\y - Obj(ObjId)\x
                                                                                    SetGadgetText(#G_shapePtX,Str(\pt(i)\x))
                                                                                    SetGadgetText(#G_shapePtY,Str(\pt(i)\y))
                                                                                EndIf
                                                                            ;Next 
                                                                    EndSelect
                                                                    
                                                                EndIf
                                                                
                                                            EndWith
                                                            
                                                    EndSelect
                                                    
                                                ElseIf Vd\move= 2   ; on bouge tout
                                                    
                                                   
                                                    If VdOptions\Snap
                                                        Snap(x,VdOptions\SnapX)  
                                                        Snap(y,VdOptions\SnapY) 
                                                    EndIf
                                                    
                                                    For ki = 0 To ArraySize(Obj(ObjId)\Shape())
                                                        
                                                        With Obj(ObjId)\Shape(ki) 
                                                            
                                                            If \Locked = 0
                                                                
                                                                If ki = shapeId Or \Selected = 1
                                                                    
                                                                    Select vdOptions\Action
                                                                            
                                                                        Case #VD_actionMove
                                                                            
                                                                            ;Select \ShapTyp                                                                           
                                                                            
                                                                            ;Case #VD_ShapeCurve,#VD_ShapeCurve,#VD_ShapeBox,#VD_ShapeBoxRnd,#VD_ShapeCircle,#VD_ShapeImage,#VD_ShapeText
                                                                            \X = (x - \startX) * (1-VdOptions\Tool(vdOptions\Action)\LockX) + \X * VdOptions\Tool(vdOptions\Action)\LockX 
                                                                            \Y = (y - \startY) * (1-VdOptions\Tool(vdOptions\Action)\LockY) + \Y * VdOptions\Tool(vdOptions\Action)\LockY 
                                                                            
                                                                            
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
                                                                            
                                                                            
                                                                        Case #VD_actionScale
                                                                            n =0
                                                                            ;\Size = (x-\pt(n)\startX)*0.01 
                                                                            \Size = (x-\startX)*0.01                                                                   
                                                                            
                                                                            ;Debug ""+\size+"/"+size
                                                                            For k = 0 To ArraySize(\pt())                                                   
                                                                                \pt(k)\x = \pt(k)\startX * (1+\size) -\pt(n)\startX * (\size)
                                                                                \pt(k)\y = \pt(k)\startY * (1+\size) -\pt(n)\startY * (\size)
                                                                            Next
                                                                            
                                                                            Select \ShapTyp
                                                                                    
                                                                                    
                                                                                Case #VD_ShapeBox, #VD_ShapeBoxRnd, #VD_ShapeCircle,#VD_ShapeImage,#VD_ShapeText
                                                                                    ; \w = \pt(0)\startX * (1+\size) -\pt(0)\startX * (\size)
                                                                                    ; \Size = Abs((x-startXX)*0.5)
                                                                                    
                                                                                    ;                                                                            \Size = (x-startXX)*0.0001
                                                                                    ;                                                                            \SizeY = (y-startYY)*0.0001
                                                                                    ;                                                                            
                                                                                    ;                                                                            u1.d=1+\size
                                                                                    ;                                                                            min(u1,0.1)
                                                                                    ;                                                                            \SizeW = Abs(\SizeW * u1) ; -\w * (\size)
                                                                                    ;                                                                            
                                                                                    ;                                                                            u1=1+\sizeY
                                                                                    ;                                                                            min(u1,0.1)
                                                                                    ;                                                                            \SizeH = Abs(\SizeH * u1) ; -\w * (\size)
                                                                                    ;                                                                            
                                                                                    Obj(ObjId)\Shape(shapeId)\SizeW = Abs(X - \StartX)                                                  
                                                                                    Obj(ObjId)\Shape(shapeId)\SizeH = Abs(y - \StartY)
                                                                                    min(Obj(ObjId)\Shape(shapeId)\SizeW,1)
                                                                                    min(Obj(ObjId)\Shape(shapeId)\SizeH,1)
                                                                                    
                                                                                    
                                                                                    
                                                                                    
                                                                                Default
                                                                                    
                                                                            EndSelect
                                                                            
                                                                            
                                                                        Case #VD_actionRot
                                                                            n =0
                                                                            
                                                                            \Rot = (x-\startX)*0.1
                                                                                                                                                        
                                                                            Cos.f = Cos(Radian(\rot))
                                                                            Sin.f = Sin(Radian(\rot))
                                                                                                                                                        
                                                                            ; on garde les coordonnées du premier point
                                                                            x1 = \CurX + \Cx
                                                                            y1 = \CurY + \Cy
                                                                            ; Debug "depart rot : "+x1+"/"+y1
                                                                            
                                                                            For k = 0 To ArraySize(\pt()) 
                                                                                ;X*Cos-Y*Sin, X*Sin+Y*Cos,
                                                                                Xx = \pt(k)\startX -x1                                         
                                                                                Yy = \pt(k)\startY -y1
                                                                                
                                                                                \pt(k)\x = Xx*Cos - Yy*Sin + x1 
                                                                                \pt(k)\y = Xx*Sin + Yy*Cos + y1
                                                                            Next 
                                                                                                                                                        
                                                                    EndSelect
                                                                    
                                                                EndIf
                                                                
                                                            EndIf
                                                            
                                                        EndWith
                                                        
                                                    Next
                                                    
                                                EndIf
                                                
                                            Else ; on a ajouté un shape, on augmente sa taille
                                                
                                                If vd\AddObjet=2 ;on a ajouté l'objet, on change sa taille
                                                    
                                                    ;x1 * (1-VdOptions\LockX)
                                                    ;y1 * (1-VdOptions\LockY)
                                                    
                                                    If VdOptions\Snap = 1
                                                        Snap(x1,VdOptions\SnapX)  
                                                        Snap(y1,VdOptions\SnapY) 
                                                    EndIf
                                                    
                                                    With Obj(ObjId)\Shape(shapeId)
                                                        
                                                        startX = \StartX
                                                        startY = \StartY
                                                        
                                                        Select \ShapTyp ;vdOptions\Action
                                                                
                                                            Case #VD_ShapeLine ;#VD_actionAddLine
                                                                \pt(PointId)\x = X1
                                                                \pt(PointId)\y = Y1
                                                                
                                                            Case #VD_ShapeCurve; #VD_actionAddCurve 
                                                                For i=0 To 2
                                                                    \pt(PointId+i)\x = X1-5+i*5
                                                                    \pt(PointId+i)\y = Y1-5+i*5
                                                                Next
                                                                
                                                            Case #VD_ShapeBox, #VD_ShapeBoxRnd  ;#VD_actionAddBox, #VD_actionAddBoxRnd 
                                                                \SizeW = X1 - StartX
                                                                \SizeH = y1 - StartY
                                                                
                                                            Case #VD_ShapeText
                                                                \SizeW = Abs(X1 - Startx)                                                   
                                                                \SizeH = Abs(y1 - StartY)
                                                                Min(\SizeW,1)
                                                                
                                                            Case #VD_ShapeCircle
                                                                \SizeW = Abs(X1 - StartX)                                                  
                                                                \SizeH = Abs(y1 - StartY)
                                                                min(\SizeW,1)
                                                                min(\SizeH,1)
                                                                
                                                        EndSelect
                                                        
                                                        update =1
                                                        
                                                    EndWith
                                                    
                                                EndIf
                                                
                                            EndIf                                
                                            
                                        EndIf
                                        
                                    EndIf
                                    
                                    StopVectorDrawing() 
                                EndIf
                                
                                If Vd\move >= 1 Or Vd\cliclb = 1 Or update = 1
                                    update = 0
                                    Drawcanvas(x,y)                             
                                EndIf
                                
                            ElseIf EventType() = #PB_EventType_KeyUp                         
                                If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key) = #PB_Shortcut_Space 
                                    Vd\space= 0                           
                                    vd\keypressed = 0                           
                                EndIf                        
                                ; Debug "key "+GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)
                                If GetGadgetAttribute(#G_canvasVector, #PB_Canvas_Key)= 16 ; shift 
                                    Vd\shift= 0                           
                                    vd\keypressed = 0                          
                                EndIf 
                                
                            ElseIf EventType() = #PB_EventType_LeftButtonUp
                                Vd\move = 0
                                Vd\TestShapeOk = 0 
                                Vd\cliclb = 0
                                If Vd\AddObjet >=1
                                    VD\AddObjet = 0
                                    vdOptions\Action = #VD_actionMove
                                    For i =#G_ToolVDMove To #G_ToolVDLast
                                        If IsGadget(i)
                                            SetGadgetState(i,0)
                                        EndIf                        
                                    Next
                                    SetGadgetState(#G_ToolVDMove,1)
                                    Vd_SetGadgetOption()
                                EndIf
                            EndIf
                            
                            ;}
                            
                            ;{ * toolbar
                        Case #G_ToolVDMove To #G_ToolVDLast
                            vdOptions\Action = EventGadget() - #G_ToolVDMove
                            For i =#G_ToolVDMove To #G_ToolVDLast
                                If IsGadget(i)
                                    SetGadgetState(i,0)
                                EndIf                        
                            Next
                            SetGadgetState(EventGadget(),1)
                            ;Select vdOptions\Action
                               ; Case #VD_actionAddBoxRnd
                                    ;MessageRequester("Info","These tool doesn't work for the moment")
                            ;EndSelect
                            Vd_SetGadgetOption()
                            SetActiveGadget(#G_canvasVector)
                            
                        Case #G_ToolVDSnapY, #G_ToolVDSnapX, #G_ToolVDSnap   
                            VdOptions\Snap = GetGadgetState(#G_ToolVDSnap)
                            VdOptions\SnapX = GetGadgetState(#G_ToolVDSnapX)
                            VdOptions\SnapY = GetGadgetState(#G_ToolVDSnapY)
                            min(VdOptions\SnapX,1)
                            min(VdOptions\SnapY,1)
                            
                        Case #G_ToolVDOffset
                            VdOptions\Offset = GetGadgetState(#G_ToolVDOffset)
                            ;}
                            
                            ;{ * option tool
                        Case #G_TBOptLockX,#G_TBOptLockY
                            VdOptions\Tool(vdOptions\Action)\LockX = GetGadgetState(#G_TBOptLockX)
                            VdOptions\Tool(vdOptions\Action)\LockY = GetGadgetState(#G_TBOptLockY)
                            ;}
                            
                            ;{ * objet
                        Case #G_ObjAlpha
                            Obj(ObjId)\Alpha = GetGadgetState(#G_ObjAlpha)
                            DrawCanvas()
                            
                        Case #G_Objdown
                            ; c'est inversé, car les calques sont affichés de bas en haut
                            If ObjId>0
                                newpos = ObjId-1
                                pos = ObjId  
                                CopyObj\depth = Obj(ObjId)\Depth
                                Obj(ObjId)\Depth = Obj(newpos)\depth   
                                Obj(newpos)\depth = CopyObj\depth                        
                                SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
                                UpdateUiObjetVD(1)
                            EndIf
                            
                        Case #G_Objup
                            ; c'est inversé, car les calques sont affichés de bas en haut
                            If ObjId<ArraySize(Obj())
                                newpos = ObjId+1
                                pos = ObjId  
                                CopyObj\depth = Obj(ObjId)\Depth
                                Obj(ObjId)\Depth = Obj(newpos)\depth   
                                Obj(newpos)\depth = CopyObj\depth                        
                                SortStructuredArray(Obj(),#PB_Sort_Ascending,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
                                UpdateUiObjetVD(1)
                            EndIf
                            
                        Case #G_ObjList
                            ; attention, c'est inversé car les calques vont de bas en haut et non de haut en bas
                            
                            If StartDrawing(CanvasOutput(#G_ObjList))
                                x = GetGadgetAttribute(#G_ObjList, #PB_Canvas_MouseX)
                                y = GetGadgetAttribute(#G_ObjList, #PB_Canvas_MouseY)
                                If EventType() = #PB_EventType_LeftButtonDown
                                    Vd\PathId = 1                                    
                                    ShapeId = 0
                                    oldObjId = ObjId
                                    v_id = y/25
                                    If x > 25
                                        n = ArraySize(Obj())
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
                                ElseIf EventType() = #PB_EventType_LeftDoubleClick                            
                                    If x > 25
                                        nom${20} = InputRequester("New Name","Set the name for this object",Obj(ObjId)\Nom$)
                                        If nom$ <> ""
                                            Obj(ObjId)\Nom$ = nom$
                                        EndIf
                                    EndIf
                                EndIf
                                
                                StopDrawing()
                            EndIf
                            If VD\pathId=1
                                VD_UpdateCanvasPath()
                            EndIf
                            
                            UpdateUiObjetVD(1)
                            
                            
                        Case #G_ObjDel 
                            DeleteArrayElement(Obj,ObjId)
                            ObjId = 0                    
                            UpdateUiObjetVD(1)
                            
                        Case #G_ObjAdd    
                            Vd_LayerAdd()
                            
                        Case #G_ObjLock
                            Obj(ObjId)\Locked = GetGadgetState(#G_ObjLock)
                            UpdateUiObjetVD(1)
                            
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
                            UpdateUiObjetVD()
                            
                            
                        Case #G_ObjX, #G_ObjY 
                            Obj(ObjId)\x = GetGadgetState(#G_ObjX)
                            Obj(ObjId)\y = GetGadgetState(#G_ObjY)
                            Drawcanvas()
                            
                        Case #G_ObjDepth
                            Obj(ObjId)\Depth = GetGadgetState(#G_ObjDepth)
                            SortStructuredArray(Obj(),#PB_Sort_Ascending ,OffsetOf(sObj\Depth),TypeOf(sObj\Depth))
                            UpdateUiObjetVD()
                            
                            
                            ;}
                            
                            ;{ * Shape properties 
                            
                            ;{ parameters : nom, link, hide, close, lock, x,y,w,h
                        Case #G_shapeNom
                            If ShapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Nom$ = GetGadgetText(#G_shapeNom)
                                UpdateListShape()
                            EndIf
                       
                        Case #G_shapeClose
                            If shapeid >-1
                                Obj(ObjId)\Shape(ShapeId)\Close = GetGadgetState(#G_shapeClose)
                                DrawCanvas()
                            EndIf
                            
                        Case #G_shapeLink
                            If ShapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Linked = GetGadgetState(#G_shapeLink)
                                DrawCanvas()
                            EndIf
                            
                        Case #G_shapeLock 
                            If ShapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Locked = GetGadgetState(#G_shapeLock)
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
                            
                            ;{ add, list                            
                        Case #G_shapeAdd 
                            If Obj(ObjId)\Actif = 0
                                ShapeID= 0                       
                                ReDim Obj(ObjId)\Shape.sShape(0)
                                Obj(ObjId)\Shape(0)\Nom$ = ""
                            Else
                                n = ArraySize(Obj(ObjId)\Shape())+1
                                ReDim Obj(ObjId)\Shape.sShape(n)
                                ShapeId = n 
                                Obj(ObjId)\Shape(n)\Nom$ = ""
                            EndIf  
                            ShapeNew(2)
                            Obj(ObjId)\actif = 1
                            Vd\NbShape = 1
                            SetActiveGadget(#G_canvasVector)
                            
                        Case #G_shapeDel
                            ShapeDelete()
                            SetActiveGadget(#G_canvasVector)   
                            
                            
                        Case #G_shapeListAdd
                            Vd\ShapeFileName$ = GetGadgetItemText(#G_shapeListAdd,GetGadgetState(#G_shapeListAdd))
                            
                        Case #G_shapelist
                            If vd\NbShape >=0
                                ShapeId = GetGadgetState(#G_shapelist)
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
                                    ShapeGetProperties()                       
                                EndIf
                            EndIf
                            ;}
                        
                            ;{ style 
                        Case #G_shapeTyp
                            If ShapeId >- 1
                                Obj(ObjId)\Shape(ShapeId)\Typ = GetGadgetState(#G_shapeTyp) : Drawcanvas()
                            EndIf
                            
                        Case #G_shapeLineW
                            If ShapeId >- 1
                                Obj(ObjId)\Shape(ShapeId)\w = GetGadgetState(#G_shapeLineW)
                                min(Obj(ObjId)\Shape(ShapeId)\w,1)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeLineH
                            If ShapeId >- 1
                                Obj(ObjId)\Shape(ShapeId)\h = GetGadgetState(#G_shapeLineH)
                                min(Obj(ObjId)\Shape(ShapeId)\h,1)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeLineD
                            If ShapeId >- 1
                                Obj(ObjId)\Shape(ShapeId)\d = GetGadgetState(#G_shapeLineD)
                                min(Obj(ObjId)\Shape(ShapeId)\d,1)
                                Drawcanvas()
                            EndIf
                            ;}
                            
                            ;{ offset
                        Case #G_shapeCX, #G_shapeCY
                            If ShapeId >-1
                                Obj(ObjId)\Shape(ShapeId)\Cx = GetGadgetState(#G_shapeCX)
                                Obj(ObjId)\Shape(ShapeId)\Cy = GetGadgetState(#G_shapeCY)
                                Drawcanvas()
                            EndIf
                            ;}
                                                        
                            ;{ pts
                         
                            
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
                            
                        Case #G_shapePtSoft
                            Vd_SetPoint(1)
                            
                        Case #G_shapePtMenu
                            If ShapeId > -1                        
                                DisplayPopupMenu(#MenuVDPopUpPt,WindowID(#Win_VectorDrawing),GadgetX(#G_shapePtMenu)+5,WindowMouseY(#Win_VectorDrawing))  
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
                             
                        Case #G_shapeColor
                            If shapeid > -1
                                col = ColorRequester(Obj(ObjId)\Shape(ShapeId)\Color)
                                Obj(ObjId)\Shape(ShapeId)\Color=RGBA(Red(col),Green(col),Blue(col),Obj(ObjId)\Shape(ShapeId)\alpha)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeAlpha
                            If shapeid > -1
                                Obj(ObjId)\Shape(ShapeId)\alpha = GetGadgetState(#G_shapeAlpha)
                                col = Obj(ObjId)\Shape(ShapeId)\Color
                                Obj(ObjId)\Shape(ShapeId)\Color = RGBA(Red(col),Green(col),Blue(col),Obj(ObjId)\Shape(ShapeId)\alpha)
                                Drawcanvas()
                            EndIf
    
                            
                            ;}
                            
                            ;{ depth
                        Case #G_shapePosDown
                            If ShapeId < ArraySize(Obj(ObjId)\Shape()) And ShapeId > -1
                                
                                ; on échange uniquement les positions
                                NewShapeId = shapeId+1
                                Obj(ObjId)\Shape(ShapeId)\pos+1 
                                
                                ; puis, on échange                        
                                Obj(ObjId)\Shape(ShapeId+1)\pos-1 
                                ShapeId = NewShapeId
                                SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending,OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
                                UpdateListShape()
                                SetGadgetItemState(#G_shapelist,ShapeId,1)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapePosUp
                            If shapeId > 0                        
                                ; on échange uniquement les positions
                                NewPos  = shapeId-1
                                Pos     = ShapeId
                                
                                ; CopyObj\depth = Obj(ObjId)\Depth
                                Depth = Obj(ObjId)\Shape(ShapeId)\pos
                                
                                ;Obj(ObjId)\Depth = Obj(newpos)\depth   
                                Obj(ObjId)\Shape(ShapeId)\pos =  Obj(ObjId)\Shape(newpos)\pos
                                
                                
                                ;Obj(newpos)\depth = CopyObj\depth        
                                Obj(ObjId)\Shape(NewPos)\pos =  depth
                                
                                
                                
                                ShapeId = NewPos
                                SortStructuredArray(Obj(ObjId)\Shape(),#PB_Sort_Ascending,OffsetOf(sShape\Pos) ,TypeOf(sShape\Pos))
                                UpdateListShape()
                                SetGadgetItemState(#G_shapelist,ShapeId,1)
                                Drawcanvas()
                            EndIf
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
                            VD_ShapeChangeImage()
                            
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
                            
                        Case #G_shapeFxActif 
                            If shapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Actif = GetGadgetState(#G_shapeFxActif)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeFxLineTyp
                            If shapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Style = GetGadgetState(#G_shapeFxLineTyp)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeFxLineW,#G_shapeFxLineH,#G_shapeFxLineD
                            If shapeId > -1
                                W = GetGadgetState(#G_shapeFxLineW) : min(w,1)
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\w =w                    
                                H = GetGadgetState(#G_shapeFxLineH) : min(h,1)
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\h=h
                                Dist = GetGadgetState(#G_shapeFxLineD) : min(dist,1)
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\dist=dist
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeFxDepth
                            If shapeId > -1
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Depth = GetGadgetState(#G_shapeFxDepth)
                                Drawcanvas()
                            EndIf
                            
                        Case #G_shapeFxAlpha
                            If shapeId > -1
                                Alpha = GetGadgetState(#G_shapeFxAlpha)
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Alpha = Alpha                    
                                color = Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\color
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\color=RGBA(Red(color),Green(color),Blue(color),Alpha)
                                Drawcanvas()
                            EndIf
                            
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
                            If shapeId > -1
                                If ShapeFxId > ArraySize(Obj(ObjId)\Shape(ShapeId)\Fx())
                                    ShapeFxId = 0
                                EndIf                        
                                Color = ColorRequester(Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Color)
                                alpha = Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\Alpha
                                Obj(ObjId)\Shape(ShapeId)\Fx(ShapeFxId)\color=RGBA(Red(color),Green(color),Blue(color),alpha)
                                Drawcanvas()
                            EndIf
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
                            
                            ;{ * options
                        Case #G_Vd_OptBGColor
                            Col = ColorRequester(VdOptions\BgColor)
                            VdOptions\BgColor=RGBA(Red(col),Green(col),Blue(col),255)
                            drawcanvas()
                            
                        Case #G_Vd_OptCamCachAlpha                            
                            VdOptions\CameraCacheAlpha=GetGadgetState(#G_Vd_OptCamCachAlpha)
                            drawcanvas()
                            
                        Case #G_Vd_OptBGCheck
                            VdOptions\BgImg = GetGadgetState(#G_Vd_OptBGCheck)
                            DrawCanvas()
                            ;}
                            
                    EndSelect
                    
                Else ;si on joue l'animation, on ne doit plus pouvoir bouger le reste, sauf certains gadgets (lié à l'animation par exemple)
                    
                    Select EventGadget()
                            
                        Case #G_VDTimeline
                           VD_TimeLineEvent(1)
                            
                        Case #G_VDAnimPlay
                            Vd\Play = 1 - Vd\Play
                            play$ ="play,stop"
                            SetGadgetText(#G_VDAnimPlay,StringField(play$,1+Vd\Play,","))
                            DrawCanvas()
                           
                            
                    EndSelect
                    
                EndIf
                
            ElseIf event =#PB_Event_CloseWindow
                
                If EventWindow() = #Win_VectorDrawing
                    quit = 1
                EndIf
                
            EndIf
        
        Until event = 0 Or quit = 1
        
       
        
        If Vd\Play = 0
            
            If Vd\UpdateOk = 1
                Vd\UpdateOk = 0
                VD_OpenWinUpdate()
            EndIf
               
            If VdOptions\Autosave = 1
                If ElapsedMilliseconds() > TimerAutosave + VdOptions\AutosaveTime * 1000
                    TimerAutosave = ElapsedMilliseconds()
                    t$="data\shapes\_autosave\autosave"+Str(rand)+".txt"
                    ShapeSave(t$,1)            
                EndIf            
            EndIf            
        
        Else
            
            PlayAnimation()
            
        EndIf
        
        
    Until quit = 1
    
    
    VD_SaveOptions()
    UnbindEvent(#PB_Event_SizeWindow,@Vd_ResizeAll(),#Win_VectorDrawing)
    
    EndIf


    ; RestartScreen()


EndProcedure


OpenWinVectorDrawing()



; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 1003
; Folding = BAAQAFAAAFAsDgBy--TCAAAAAAAAAAAAAAAAAAAAAAAwAAvBAAABAAA5DAAAAAAAAAAAQAAAYAazAAAAAAAAAAAAAAAAAAA50ASKl70AAAECBHHAAAAAAoAAAAoBYAgAAAAAXAAAAw
; EnableAsm
; EnableThread
; EnableXP
; EnableOnError
; UseIcon = spriteanimation.ico
; Executable = _release\x64\cartoon0.18\cartoon0.18.exe
; EnablePurifier
; EnableUnicode