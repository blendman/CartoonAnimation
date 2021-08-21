
;{ infos, bugs, todolist, etc..
;{ Infos
; name : cartoon animation
; software : 2D image vector (and later animation)
; main developper : blendman
; last update : 9 July 2021
; version : 0.19
;}

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
; ??? - other shape : triangle, star, polygon

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
; ok 0.10 - export scene (camera x,y,w,h) as image
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
; ok 0.17 AR- animation (Dope Sheet, LNA)
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
; ■ Network ?????
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
;}

;{ changes

; BUG OK : 
; - quand on change le depth, il faut actualiser le shapeId (avec l'idunik), car le shape qui a le shapeid change (car on fait un tri en fonction de la nouvelle pos\depth)
; pouvoir agrandir tous les shapes ou l'objet par rapport à un centre ou une boundingbox
; - ajouter le unpremultiply en sortie d'image.
; - fix the autosave bug
; 0.28 - quand on clique (sans shift), ça devrait tout déselectionner (shape et pt), 
; 0.25 - set origin to shape ou shape to origin devrait s'effectuer sur tous les shapes selected
; 0.27 - modifier/option miror quand on modifie les points
; 0.25 - si on sélectionne avec shift et qu'on bouge ou zoom on perd la sélection
; 0.25 - ajouter ctrl+P : pour parenter des shapes avec un parent.
; 0.28 - ajouter shift+P pour supprimer le parenting
; 0.25 - pouvoir modifier tous les shapes selectionnés (couleur, alpha, style, line width, height, distance)
; ok ? - fixe bugs! (when select object or other things like that).
; 0.29.1 - bug si clic sur layer, le shapeid n'apparait plus
; 0.33.1 - bug export purebasic : si couleur noir c'est invisible
; - problème avec la selection (outil move, pas l'outil select des points)


; ok priority :
; 0.23 - ajouter une fenêtre d'export, où on peut définir la résolution de l'image en sortie
; 0.27 - ajouter les mode d'edition (libre, objet, shape, point)
; 0.25 - export image : ajouter un % de sortie (par exemple, on est en 2048*2048 (ça c'est la vue caméra), et en sortie, on définit le % et le X,Y
; 0.24 - copier/coller plusieurs shape en même temps
; 0.27 - when copy/paste : we should sort the new depth
; 0.28 - ajouter un outil ligne en cliquant et à main levée qui créer une ligne ou un shape.
; 0.28 (WIP) - avec outil ligne polygonal, créer des points  et les points de tangeantes en x+10/Y+10 et x1-10/Y-10
; pour pouvoir les selectionner (ou je devrais les mettre en tangeante, donc que les point ABC forment une droite
; (B etant le point que je crée en cliquant et A et C les points de tangeante qu'on peut bouger)
; 0.27 - menu : deparenting (bug to fixe)
; 0.30 - select shape : line si stroke/dash etc..., path si filled
; 0.31.7 - si shape\locked : bloquer tout changement de properties (alpha, x,y, color...)
; 0.31.7- changer les spingadget en texte (car parfois on peut avoir width, height, etc entre 0 et 1.
; 0.33 - ajouter des nuanciers de couleur
; 0.33 - pouvoir modifier les paramètres des FX sur tous les shapes selectionnés en même temps 
; 0.33 - rectangle selection
; 0.33.2 - ajouter une fenêtre d'attente quand on créé les images pour la banque ! 
; 0.33.3 - bug rotation : parfois, le gettransformation n'est pas pris en compte et les points sont complètement décalés.
; ok - add a point in the middle of 2 selected point (curve, line)
; 0.32 - voir les bounding box des shapes selected
; 0.33.7 - save/load selection (ok with group)
; 0.34.1 - BG img : add scale (%)
; 0.34.1 - BG img : resize image
; 0.34.1 - BG img : show image just une partie (clipout)
; 0.35 - when create a line, we should set origin to shape.
; 0.36 - pouvoir supprimer les fx
; 0.36 - si on utilise pas de fx, simplifier dans drawcanvas()

; ok - ajouter un système de storyboard (voir le fichier cartoon_dev) : see BDcreator
; ok - ajouter un système de création de page de BD : see BDcreator


; ok ?? : 
; - problème quand on sélectionne un shape, parfois un autre est sélectionné aussi et bouge en même temps.


;---------------------------------
;---------------------------------
;---------------------------------


; En réflexion : 
; bof : - ajouter un gadgets pour passer d'un point à un autre


; Not urgent : 
; - modifier/option miror quand on crée des points
; - ajouter les options de strokepath(roundend...)
; - pouvoir updater les folder de shapes (si on fait des modifs ou qu'on ajoute un folder)
; - add a gadget zoom (trackbar with 100 % )

; moyen urgent:
; - ajouter le système parent enfant pour scale
; - ajouter le système parent enfant pour rotation
; - ajouter le système parent enfant pour modifier les points, le centre, etc..; 
; - G/Ctrl+G : to group/ungroup shape.
; - add to tool rotation the parameter : rotation + combobox (rot in mirorH,V, 90, 180, 270...)
; - add to scale tool the parameter scaleW/H


; BUGS :
; - bug quand on supprime un point : il faudrait avoir un choix : seulement le point ou le point et les 2 points d'encrage (si courbe)
; - pouvoir agrandir ou rotationner tous les shapes sélectionnés, mais par rapport à une bounding box
; - bug avec le deparanting : les shapes ne restent pas à leur place si on l'applique.
; - bug when lockselection and move (the startX /Y should be recalcultaed each time we clicdown)
; - revoir le système de savepreviewimage si on sauve un fichier (car si les shapes ne sont pas dans la vue camera, c'est coupé)
; wip - fixe the bug setorigin with parenting
; - bug export purebasic : ne prend pas les fx en compte
; - bug scale : n'est pas en fonction du centre mais en 0,0
; - parfois, on ne peut pas supprimer un shape avec "del", mais ça fonctionne avec le bouton "-" du panneau "bank"

;******** priority
; ok a integrer - simplifier des points d'un path (supprimer les points trop prêt et si angle<20 de différence)
; WIP - add shape\finalX,Y for selection and or other thing which use shape\X,Y
; WIP 0.30 - pouvoir save des preset d'outils (comme la line : avec les options (couleur, style, fx, couleur fx...) 
; FX : 
; - pouvoir change le depth (position) des fx
; - ajouter le depth, et actif dans les options de création.
; - pouvoir copier/coller le fx du shapeId à tous les shapes selected
; Shape : 
; - pouvoir séparer un shape en plusieurs morceaux (en plusieurs shapes ?)
; - pouvoir joindre des shapes séparés
; misc : 
; WIP - ajouter un editeur de personnage (créer à partir d'une banque facilement : tete, oreille, yeux, bouche, nez, cou, cheveux..)
; - add bg img to save_Doc(), and load only it if doc_open()
; - bug exportimage : si la camera est décalée en y et le scale <> 100%
; - verifier si les idunik des shapes sont bien unik, sinon-> changer l'idunik et changer l'idunik sur les objet enfants
; - pouvoir créer des objets à partir de groupe (? ou autre) de shape, qui seraient des images. Si je modifie un shape du groupe, ça update l'image.



; 10/08/2021 0.36 (49)
; // New
; - clic on btn fx "-" : delete the current fx (except the fx0, need to be changed)
; - panel Fx : add btn fx "-"
; // Changes
; - fx : when set fx\actif, -> set\usefx = 1
; - fx : simplication of drawshapefx() (check if \usefx=1 before to check each fx is \actif=1)
; - gadget : several changes with some gadgets (position, size..)
; // Fixes
; - when change depth, sometimes, the selected shapeID change.
; - Shape_Load() : with old file, Obj()\Shape()\idunik$ could be = ""
; - we can't select text or image if view is <> 0,0
; - parented shapes parenté aren't stuck to their parents
; - when create a new shape, it should be selected by default



; 9/08/2021 0.35.3 (48)
; // Changes
; - Scene_Export() : on the image exported, I draw shape if \hide= 0
; // Fixes
; - If create a polygonal line (ctrl+clic), when create the other point than first, the points created are not at the mouse position
; - If create a bezier line (ctrl+clic), when create the other point than first, the points created are not at the mouse position


; 6/08/2021 0.35 (47)
; // Changes
; - several changes in eventcanvas.pbi and procedure_draw.pbi : delete all *z or * z1 ..; -> replace by scalecoordinate()
; - change with pen tool (addpathline) if we don't use distance or angle (=0)
; - if #vd_actionAddline or addcurve -> add Shape_SetOrigin(1) when lefbuttonUp


; 5/08/2021 0.34.8 (46)
; // New
; - rotation : in editmode "point", rotate only the points selected (for line, curve, shapecomplexe)
; // Changes
; - Addgadget() : with checkbox, add 2 pixels of space between name and checkbox.
; - rotation : line/curve : rotate the point, not the shape (was like before)
; // external tool : work on BDcreator (storyboard and comics creationà
; - see the log of this tool


; 4/08/2021 0.34.7 (45)
; // external tool : BDcreator (storyboard and comics creationà
; - see the log of this tool
; // New
; - windowimageprop() : add canvas to crop easily the image
; // Changes
; - change windowBGimagepropertie() to WindowBackgroundPropertie()
; - remove some gadgets from panel option (BG gadgets : w, h)
; - add VDDrawBG(depth=0) in drawing procedure.
; - change width/height of displayed image for background to fit the change in WindowBackgroundPropertie()
; - move the group menu to selection menu
; // Fixes
; - if BG is over the shapes, the scale isn't used.
; - when open the program, the vdoptions\bgimg parameters don't have to be reset .
; - menufile has a menubar() in top


; 3/08/2021 0.34.3 (44)
; // New
; - add BG_ResizeImage() to resize, and clip the BG image
; - add windowimageprop() (for bg image) : + gadgets resize, scale, clipoutW/H/X/Y
; - clic on btn BGproperties : open windowimageprop()
; // Changes
; - drawcanvas() use VDoptions\BGImg\Scale for BGimage.
; - BG_LoadImage() : now, it check if BG image need to be resize or clip with BG_ResizeImage() 


; 2/08/2021 0.34 (43)
; // New
; - options BG image : add btn properties (empty for the moment)
; - WindowCharacterEditor() : add maximize/minimizegagdet
; - Scene_Export() : add an options to save image in png, in big size, to use it with windowcharactercreator (.
; - structure : shape\group$ : shape can have group (to use it for export image for exemple)
; - menu : #menuVD_ShapeSetGroup + lang() -> open windowgroup()
; - add windowgroup() : list, boutton namegroupe, add, set to group, unset
; - Set group  to selected shapes
; - group : Select shape of the group
; - bank : when on the canvas, we see now the name of the image


; 31/07/2021 0.33.6 (42)
; // Changes
; - add mirored point when create with pencil (bezier free line)
; - add rotatecoordonnate for all shapetyp (it's no more the points that are rotate, but it's the shape.
; - VD_ResetCoord() : change scalecoordonnate if exportImage or not.
; // Fixes
; - bug rotation : sometimes, the points of the shape are completely moved



; 30/07/2021 0.33.5 (41)
; // New
; - Change color for fx with swatch, for selected shapes
; - add window intro and logo (logo is wip)
; - add cross to cursor mouse (tool select)
; - add shortcut : Ctrl+E(Mode edition point/object), Ctrl+M (point : miror/free)
; - add options\pathsave$ and \pathopen$ to keep the folder in which we have save or open a file.
; // Changes
; - change the color of the selected shape to see it if shapeline are black.
; - change the alpha of the grid color (was 255-> 100) to see the shapes over.
; // Fixes
; - Bg imag : change height doesn't work.
; - rectangle select : the last selected should be shapeId if shapeID = -1
; - bug export purebasic : change export color to "rgba()"
; - in mode <> point, with tool move, if we are over a point, it move point instead of move shape.
; - fixe a crash if ctrl+clic with toolcurve with no shape selected
; - fixe a crash if ctrl+clic+move with toolcurve with no shape selected
; - bug with grid drawing
; - if select all, if shapeid=-1, it should be assigned to a shaped selected (last or first)
; - bug to select a shape with several layers, it check all alyers-> should check only the current layer
; - bug with Shape_Delete(), redim didn't erase the index0, do I use dim.
; - quand on supprime des objets puis qu'on load un shape depuis la banque, il ajoute le dernier objet supprimé
; - bug with Shape_Delete() with several layers, the layerid-1 is hiden



; 29/07/2021 0.33 (40)
; // New
; - add selection rectangle with tool select (wip)
; - add menu show origin
; - add an cross origin in drawscene (to see the 0,0 origin) (en option)
; - we can change FX (Style, color, alpha, active, widthtroke (lineW)) for all selected shapes (if not hide and not locked)
; - when clic on swatch canvas, it change the color of shape (style not fx)
; - add data\presets\swatch : add swatch presets
; - add tab "swatch"
; - add swatch.pbi (from animatoon), and modifiy it for cartoon
; - add vdoptions : swatch parameters
; - enumeration : add constant for swatch
; - new window character editor (wip)
; - 3 new images (new, open, save)
; // Changes
; - window scene propertie : window can be resized, add a max and min (W , H)
; - change Shape_SetPropertie() to set color with swatch
; - when change #G_shapeListAdd : if it's a subfolder, the canvasbank is updated
; - when select #G_shapeListAdd : i use now GetFilePart(BankImage$(bankImageID))
; - The canvasbank show the images from the subfolder or from the mainfolder if no subfolder.
; - The bank show now the subfolders if exists of the main folder selected (and not the name of each element in the main folder)
; - Now, the program verify on each subfolder for the folders in data\shapes\ if the image of the shape exists
; - add lang() to texts for gadgets (bank)
; - add lang() to texts for menu (Selection, Layer, window, help)
; - other minor changes (tooltips..)
; // fixes
; - shape_load() : I check if the extension file is corect before to try to open the file. I have added a procedureReturn if not good extension or other error
; - Doc_new() : add a procedurereturn if not ok.
; - Scene_Export : if camera\x or Y <>0 the export image is cut
; - shape_save() : have to use createfile and not openfile !!
; - with texte and "," -> remplace by "{-virg-}"
; - fixe error in Vd_DeletePoint(i)
; - select all only if not hiden



; 28/07/2021 0.32 (40)
; // New
; - addgadget for simplication (distance, angle)
; - tab FX : clic on gadget "open" -> open the path of the fx.
; - tab FX : add gadget "open", to open the path of the fx.
; - add boundingbox when select a shape
; - add point in the middle of 2 points.
; // Changes
; - show points only if editmode = point or if action = line/curve creation.
; - change spingadget in string (for width, height, ...)
; - some parameters for shape should be get in float (lineW,H, D...)
; - changes in structure sShape & sFXShape (w,h,d are .d now)
; - minimum size for : style and fx :  line (width), height, distance is now 0.001 (was 1)
; // Fixes
; - when change color fx and cancel, the color is white.
; - when change color fx, the color in the requester isn't correct.
; - fx : when clic on "active", the fx of the shape should be activated
; - drawutil : draw only the anchors and node if in editmode.
; - when select a shape, the open gagdget isn't updated
; - when use del key in edtmode "point", it should delete the selected point not the shape.
; - when ctrl+N (doc_new), the tile of window should change.
; - when change editmode, the canvas should be updated
; - when deletepoint, the next anchor has \center=1, and the editing of curve bug also.
; - if shape\locked : lock all change of properties (alpha, x,y, color...)
; - check if gadget are disable if we change of shapeid, and disabled/enabled gadget if needed
; - tool line (pen) din't use vdOptions\ToolOptions\distance to create the points.



; 27/07/2021 0.31 (40)
; // New
; - the FX can be scaled with curve 
; - the fx can be now closed or open (by defaut it is closed) even if the line (shape) is open or close
; - gadget point : hide or show the selected curve (by point)
; - we can define if a point (and the curve associated) is hiden or visible 
; // Changes
; - improve the point selection
; - work on Curve line tool
; - some changes in ShapeSelectAll()
; // Fixes
; - we cant select a text easily
; - we cant change the color of a text
; - selection box of the text isn't correct
; - panel color : alpha spin was too small
; - The shapeID selection was drawn 2 times.
; - fixe a bug when move a shape
; - the scale with 1 shape isn't good.
; - the scale with proportionnal (+ctrl) didn't work
; - when create an ellipse/box/roundedbox, the scale with proportionnal (+ctrl) didn't work
; - when copy/paste, old selection should be selected after paste
; - when vd\EditMode =#VD_Editmode_Point and ctrl+A : all points should be selected
; - when vd\EditMode =#VD_Editmode_Point and ctrl+D : the shapeId shouldn't be unselected


; 26/07/2021 0.30.5 (39)
; // Changes
; - work on Curve line tool (simplify line, set transformation)


; 25/07/2021 0.30.4 (38)
; // New
; - curve line tool : we can draw a free curve line (for the moment, the anchor point aren't correctly placed).
; - Curve line tool : add option : Bezier, pencil (Free).


; 25/07/2021 0.30 (38)
; // New
; - panel tool : add gadgets for shapeFX options by default (open, color, alpha, shapetyp, width (if stroke))
; - panel tool : add gadgets for shape options by default (open, color, alpha, shapety,p width (of stroke))
; - panel tool : clic on gagdet color change the defaut color of created shape.
; - line tool : we can draw a free line.
; - line tool : add option : polygon, Free
; - line tool : add "type" options for line (polygon, 
; // changes
; - When editmode = objet, we can't move the points, only move the object.
; - now, to select a shape, I use insidepath and insideStroke.
; - Add framegadget for tool options
; - now line or curve are created with the tool options (open, style, alpha, color, width of stroke)
; - list view shape : no more multiselection (multiselection with shift+clic)
; - add lang() to texts for options tool
; // Fixes
; - we can't unselect the shapeid
; - delete point should delete only 1 point if shapetyp = line
; - draw shape shouldn't draw all points in red until the point\selected
; - when doc_new(), the window title should be ""


; 24/07/2021 0.29.4 (37)
; // New
; - when clic on canvas bank, it select the image (shape) to add, and update the gadget #G_shapeListAdd.
; - canvasbank, Add red box (to see the selected bankimageId)
; // Change
; - text : use drawvectorparagraph now
; - text : is centered now
; // Fixes
; - when clic on layer, the shapeID is no more drawn
; - when move layer, the shapeID is not drawn each time
; - check if a file is not empty before to try to open it



; 23/07/2021 0.29 (36)
; // New
; - add two containers for gadgets text & image (shape), to hide them if not text or image.
; // Changes
; - MouseOnshape(x,y), to know if a mouse in on a shape image or text
; - add MouseOnshape(x,y) in VD_DrawScene() to know if we clic on an image or text shape.
; - add lang() to some texts in gadgets (FX shape, layer panel, tooltip for toolbar)
; - add lang() to texts in menu (Files, edit, view)
; - add mouse x/y in statusbar
; - scale tool : now the size are fixed to the mouse cursor
; - scale tool : use ctrl to get proportionnal scale (box, circle,roundbox, image)
; - Rotate tool : use ctrl to get rotation *10
; - scale tool : we can scale the shape selected now (wip)
; // Fixes
; - scale tool, the sizeH is inversed with the y mouse position
; - bug with point selection, #VD_Editmode_All wasn't = 0


; 22/07/2021 0.28.5 (35)
; // New
; - Add window Gradient (wip)


; 21/07/2021 0.28.3 (34)
; // New
; - add alpha from layer with all shape of the layer (not alpha calculated by shapes * obj\alpha)
; // Changes
; - selection border is now black for all shapes (not only shapeID)
; // Fixes
; - with shift down, we can't select a shape if a big shape is under it
; - when lockselection, we can't move the selected shape
; - when clic without shift, all shapes are deselected



; 20/07/2021 0.28 (33)
; // New
; - shift+P : deparanting selected shapes (WIP : some bug to fixe with it)
; - point : add a kind of smooth move mode (curve only)
; - point : when move a point, update the gadget point X/Y
; - add tab "tool" (panel left), for tool options, we can keep the bank tab.
; // Changes
; - insert a point in the curve at the mouse cursor
; - some changes in the UI when select points (curve, complexes shapes)
; // Fixes
; - when move point with mirored mode, we should use x1-\X and Y1-\y
; - bug avec le dernier point d'une courbe et le mode usemirored mode.
; - usemirored mode should work only if shift =0.
; - when shift+select a point, should check if it's a center point before to select the other points (tangent points)



; 19/07/2021 0.27 (32)
; // New
; WIP - add tab "tool" (panel left), for tool options, we can keep the bank tab.
; - Edit mode (All, object, shape, point) (need to be improved)
; - Tool Edit mode
; - new gadget On point GUI : set point mirored, use point mirored
; - set point mirored, use point mirored
; - point can be moved with mirored mode (tangent like)
; - add vdoptions\debugOn to get some extra functions (gadget idunik for example)
; // Changes
; - add lang() to some texts in gadgets (shape, point)
; // Fixes
; - fixe 2 bugs in The export in purebasic (line)
; - when copy/paste : we should sort the new depth
; - when copy/paste : we should have a different id_unik for the new shape
; - when ShapePastToshape : we should sort the new depth
; - when ShapePastToshape : we should keep the id_unik for the shape selected


; 18/07/2021 0.26.1 (31)
; // Fixe
; - fixe a bug with bank
; - fixe The export in purebasic which doesn't export the line and curve


; 17/07/2021 0.26 (30)
; // New
; - add vdoptions\panelLayerW for width of panel layer
; - add vdoptions\BankCaseW for the width of the case of bankimage
; - sortarray for bankimage and file on shapefolder
; - now, it check the folder in data\shapes\ and create all the image preview, if they don't exists !
; - Tab "create" (bank of shapes) : add images of the elements of the current folder on the canvas
; - Doc_save() : add date() to file, add shape : close, idunik$, parentid, depth, pos.
; - now, the fx can be opened too ! (we can have a color and black line for character :))
; - when playanimation, it display the scene (was empty before)
; // changes
; - change in the GUI (size of panel layer)
; - add lang() to some texts in some functions and menus
; - shape\idUnik$ and shape\parent\idunik$ are now a word$ to get a very different idunik (see Shape_CreateIdUnik())
; - some changes in the drawing utilities (dash stroke of selection, centre point...)
; - we can now deselected the shapeID
; - select or move a pt, gui is now updated
; // fixes
; - fixe bug with dispay scene, when playanimation


; 16/07/2021 0.25 (29)
; // New
; - add a point in the middle of 2 selected point (curve, line) (wip)
; - menu : deparenting (wip)
; - Tab "create" (bank of shapes) : add scrollarea & canvas to show image of the bank (wip)
; - with shift+clic, we can now select or deselect a shape.
; - when calcul center point, set pt()\center =1 (calcul is in the drawutil)
; - add close/open to curve
; - submenu #menuVD_AddPtAtMiddle
; - Add Shape_SetPropertie() to change propertie for selection (color, alpha...)
; - menu : parent (Ctrl+P)
; - menu : lock selected, unlock all, lock all except selected
; - SetOrigin to Mouse
; - add Mouse Cible cursor
; - add window preference (only autosave for the moment)
; - menu file : preference
; - add Layer_CheckifOk(ObjId) to verify if we can do anything on a layer
; // changes
; - DrawCanvas(x=0,y=0,Selected=0) : by default, now selected =0, to not be able to select by default and keep selection
; - SetLineDistance (dash, point) to selection
; - SetLineHeight (dash, point) to selection
; - SetStrokeWidth to selection
; - SetStyle to selection
; - SetAlpha to selection
; - Setcolor to selection
; - setorigin works with selection
; - Shape_delete() : works with selection
; - some change in doc_new(), shape_load()
; - add lang() to some texts in some functions and menus
; - ShapeGetProperties(state=1) has now 1 option, to set a simple solution if needed (set state instead of settext)
; - ShapeGetProperties() is only updated if we have selected a shape
; // Fixes
; - autosave didn't work, autosave only if vdoptions\dochaschanged
; - lock Layer didn't work
; - Shape_delete() only if Layer_CheckifOk(ObjId) = 1
; - Shape_delete() only if \hide =0 and \locked =0
; - Vd_DeletePoint() only if Layer_CheckifOk(ObjId) = 1
; - operation (leftbuton down) on layer only if Layer_CheckIfOk(ObjId) =1 
; - When movecanvas (space) the shape under mouse is selected
; - When movecanvas (space) the multi-selection is lost
; - Vd\LockSelection didn't work
; - sometimes, the gadgets for shape aren't updated
; - if mousemove, it shouldn't select the shape under the mouse
; - some bugfixes with scene properties and camera


; 15/07/2021 0.24 (28)
; // New
; - export image : now, it use the x,y,w,h& % defined in window scene output properties (so by the active camera)
; - scene properties : add %, framegadget, output Width/height
; - scene properties : When change gadgets, it change the camera properties
; - scene properties : when change W,H, X, Y, %, it calcule the finale size of image and open a message if size > 8096x8096
; - copy/paste several shapes
; - add gadget "#G_shapeIdUnik" to see the idunik of the shape
; - add unpremultiply for export image (to fixe the PB bug with vectorlib export) (function by wilbert ! )
; - add shape : \finalX,Y to know the finalX,Y (= \x + tranformation +  parenting).
;  (need to be changed in all functions using \x, \Y)
; // Changes
; - add #PB_String_ReadOnly to AddGadget() for stringgadget
; - add lang() to some texts in some functions
; - add a macro ShapeSetParentingPosition(vo,j) to use on every functions which need to know parenting operations
; - now, the position of shape is updated in GUI if we move the shape
; - it's more easy to select a point from a curve/line
; - // fixes
; - when we change the shape depth, it change the shapeID (for object or shape loaded)
; - when loadshape\object, add the idunik for all shapes created
; - bug with depth when change it with buton (up, down) and list of shape
; - tool move and clicdown on a shape : the propertie aren't update (only if clicup)
; - if select a shape which isn't text or image, hide and disable the gadget text & image
; - when change the layer order, that change the ObjID
; - when open a file, we can't use the layer GUI (to see or select the layer)
; - scene properties : we don't see the scene properties
; - when create a curve, the "anchor" point aren't correctly placed


; 14/07/2021 0.23 (27)
; // New
; parent limitation : we can't select the points if the shape is parenting, because it ckeck the position without parenting
; - ajouter le système parent enfant avec l'outil move
; - add shape\parent : when move only
; - LoadScene shape\parent
; - add parent\x, y to shape position (if shape has parents)
; - add structure VD_camera dim VD_camera()
; - add window scene propertie + gadget : camera id,x,y,w,h,% (for output), zoom
; - add Lang.pbi, for futur localisation/traduction
; // Changes
; - lots of changes with panel & gadgets (color, size, position, name, tooltips...)
; - Set the color to "normal" (gadget, window), darkmode later ^^
; - set the tools in the toolbar at top
; - now, the tool options are displayed on the tab "tool" 
; - when load scene, the depth & pos are *10 now (to separate easily the depth between shape)
; // fixe
; - we shouldn't be able to create a shape if shift=1.
; - bug with shortcut (H, back, Shift+H...) and stringgadget (name of shape)



; 13/07/2021 0.22 (26)
; // New
; - save selected
; - hide all except selected
; - Unhide all (by layer) ctrl+H
; - hideselected (by layer) key H
; - Add tool mirorH, mirroV
; - Add gadgets mirorH, mirroV
; - Add icone mirorH, mirroV
; - menu selection with : selectAll, deselectALL, lock selection
; // Changes
; - FX of shape are clipped now
; - change shortcut deleteshape to #PB_Shortcut_Back
; - code cleaning and reagencement (add menu.pbi, shape.pbi, paste code of shape in shape.pbi...)
; - VD_ExportPbCommand() : add hour of creation
; - VD_ExportPbCommand() : now, it export all the objects and shapes in the pb file
; - VD_ExportPbCommand() : add a code example in the export (openwindwo, and display canvasgadget and objects)
; // Fixes
; - fx gadget aren't updated when change of shapeID
; - export image didn't use the clip of shape
; - the show gadget isn't updated when hide or show the shape
; - the shape\depth was a few buggued. Now, when create a shape, it add a depth=(nb_shape+1)*20, to get more difference between all depth shape
; - when open colorequester, the color is black
; - we don't see the points/dash lline... with shape curve & line.
; - when create the first point of line, it create 2 points instead of 1
; - when create the first point of curve, it create 4 points instead of 3
; - fixe bug with grid, sometime the width is <0
; - bug sur certains shapes si on le charge en tant que shape et non en tant qu'objet (file\open) (le dernier point était bugué)
; - gadget name : set name of shape only if name <> #empty$
; - with new file, it create a empty shape if we use tool addshape or shape-bank and if we dont have a shape


; 12/07/2021 0.21 (25)
; // New
; - we can create curves by clicking+ctrl (Ctrl+clic add point to curve)
; - we can create curves by clicking+ctrl lines (polygon) 
; - add tab "create" (is "tool" now), and add gadget to create a shape (combobox with folders, ccbox with files from folder selected, buton + and -)
; WIP - add to tool rotation the parameter : rotation (we can directly set the rotation of object in the option of tool
; - Obj\shape : add idunik, to know each shape event if they have the same name
; - we can load an image on the background
; - we can change the depth (position on the rendering function) of the image on the background
; - add X/Y position for BG-image (to move it if needed)
; - panel Shape : add parameters show/depth
; - panel option : add gagdet to set an image as background reference (img,x,y,alpha,w,h,depth)
; - change some colors of GUI (ToolBar top, tool container, container for scene path, window color)
; - when zoom/dezoom : the circle point should keep their default size, to select it easily 
; // Changes
; - changes in enumeration
; - clean up code (move global in structures.pbi, move enumeration in enumeration.pbi...)
; // fixes
; - the background isn't zoomed
; - some gadget (tab options) didn't show the correct value (alpha, use checker..)
; - at start, we have  points for an empty shape (because the shape array start to 0.


; 11/07/2021 0.20 (24)
; // New
; - we can draw an image on the background (as reference for example or later, color select)
; // Changes
; - change Options\bgimg to bgchecker if you use the checker.
; // Fixes
; - when create a new shape, it isn't created at mouse position
; - when deselect, all shape/point are still selected (in fact, shift was down)


; 09/07/2021 0.19 (23)
; // New
; - add zoom with wheel mouse
; - add menu "edit" (copy, paste, selectAll, deselect ALL)
; // Changes
; - the code is now separated into several little files (infos, enumeration, init, procedures, macros, loop...)
; - change zoom parameters with keyboard (Ctrl+/-)
; // fixes
; - when change of a shape, if cancel, the shape color is black
; - ctrl+V didn't paste at mouse position.


; 08/07/2021 (0.18.5) (22)
; // New
; - menu scene propertie (width/height), à revoir

; [11/02/2021] (0.18.13) (21)
; // Changes
; - "control animation" panel is in "layer" panel now
; - panel name "object" -> "layer"
; // Fixes
; - fixe a crash when select a tool with two options
; - fixe a bug of height of the toolbar
; - fixe a bug of height of the panel (right, left) and canvas


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
; - Shape : set shape to bottom (depth)
; - Shape : set shape to top (depth)
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




; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 424
; FirstLine = 108
; Folding = A5
; EnableXP
; DisableDebugger