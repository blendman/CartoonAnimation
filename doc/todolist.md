#Cartoon ! 
Vector Drawing and animation
(Made in Purebasic 5.42)

#Todolist

#■  Creation  (shape tools)
ok 0.01 - complexe shape
ok 0.03 - add/delete pt
ok 0.07 - circle/ellipse
ok 0.07 - rectangle
ok 0.08 - line
ok 0.08 - curve
ok 0.09 - text
ok 0.09 - image
- round square
- free line
? - polygon, stars ?

#■  Transformations
ok 0.07 AR - add offset for rotation & scale
ok 0.07 AR - rotation by center/offset
ok 0.08 - merge objet file : to add new object
ok 0.05 - Rotate shape 
ok 0.04 - scale shape 
ok 0.03 - move shape 
ok 0.03 - add or delete shape
ok 0.15 - move pts selected (several)
- scale by centre/offset
- insert a pt between two points

#■  UI
ok 0.06 - pan
ok 0.06 - zoom
ok 0.10 AR - offset : origin, cursor, center, selection
ok 0.10 - snap, snapX, snapY

#■  File 
ok 0.05 - merge shape file : pour ajouter de nouveau shape à l'objet en cours
ok 0.03 - save le meme fichier si on a déjà le nom
ok 0.03 - saveAs
ok 0.04 - export image (object seletecd)
ok 0.10 - export scene (camera x,y,w,h)
ok 0.12 - Export pb command processus
- Import pb command processus (?)
- Import SVG
- Export SVG
- save images sequence of animation (from start To End frame) in png, jpg
- export animation in AVI (?)
- export option : size in %
- export option : all
- export option : selected object only
- export option : by shape
- export option : start - End frame For export (use the animation start /End Or custom)

#■ options
ok 0.09 - load options
ok 0.09 - save options
ok 0.13 - background color
ok 0.13 - background checker
ok 0.15 - camera cache + alpha

#■ window (Interface)
ok 0.01 - drawing (Default object editing, shape)
- scene
- compositing

#■ Edit Shape
ok 0.07 - Copy / paste shape
ok 0.08 - Select all shapes, deselect all shapes
ok 0.14 - set shape To bottom
ok 0.14 - set shape To top
ok 0.14 - set shape To origin
ok 0.14 - set shape To cursor
- Undo
- redo

#■  Object
ok 0.10 - ui layer
ok 0.10 - layer hide
ok 0.10 - layer LOCK
ok 0.10 - layer ADD
ok 0.10 - layer del
ok 0.10 - layer move up, down
ok 0.13 - layer position (X,Y)
ok 0.13 - layer size (w,h)
ok 0.13 AR - layer alpha

#■ Text shape
ok 0.09 - change text
ok 0.09 - change font

#■  Image 
ok 0.07 - image tool 
ok 0.13.5 AR - image repeat
ok 0.13.5 - image w,h
ok 0.13.5 - image x,y
ok 0.13.5 - image alpha
ok 0.14 - change image

#■  Shape parameters
ok 0.04 - add path style  : filled, line, dash, dot
ok 0.11 - Hide
ok 0.11 - lock
ok 0.11 - linked shape
ok 0.12 - closepath
ok 0.16 - convert box To complexe shape
ok 0.16 - convert ellipse To complexe shape
- texture
- gradient color
- Global Style/color For shape
- joint 2 shapes in 1
- separate the shape in several shapes
- parenting : set parent from shape
- convert To line
- convert To Curve
- Smooth
- Hard

#■ point parameter (For line, curve, complex shape)
ok 0.15 - set point hard
ok 0.15 - set point smooth

#■  Style/ FX
ok 0.06 - btn add  fx
ok 0.06 - style : filled, line, dash, dot
ok 0.06 - color, alpha, x,y
ok 0.06 - depth 
ok 0.06 - depth back/front
ok 0.06 - export selected Fx chanel 
ok 0.07 - file : save/load avec Fx
ok 0.07 - scale
ok 0.07 - preset save
ok 0.13 - preset load
- size w,h
- preset add
- global color for fx
- Gradient color fx
- copy, paste Fx parameters
- save Fx (all parameters)
- clip : fx only draw in first shape
Premade fx : (?)
- stroke, size, back/front
- shadowExt, size, color, back/front
- reflect, size, color, position, forme

#■  timeline
ok 0.14 - buttons play, next, prev, currentframe, start/end frame, fps
ok 0.15 - set FPS
ok 0.15 - Set end animation
ok 0.15 - Play animation (just playing, not update the canvas for the moment ^^)
ok 0.16 - layer hide
ok 0.16 - layer lock
ok 0.16 - move currentframe on timeline
ok 0.16 - Set Loop animation
ok 0.17 - canvas time & key
ok 0.17 - keyframe visible
ok 0.17 - select keyframe
ok 0.17 - move keyframe
- Delete keyframe
- Add keyframe automatic
- Copy/paste keyframe
- Add layer
- Move layer
- Delete layer
- Set start animation frame

#■  Animation
- we can add keyframe
- we can move keyframes
- we can change shape parameters and animate it
- key interpolation
- save image of animation (from start to end frame) in png, jpg
- export animation in AVI (?)

#■ Network
?? - Add a network feature, For render farm Or other cool possibility
?? - work together on the same file ? Share file For team ??



