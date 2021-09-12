**General information**

Name : Cartoon  ! (animation)
Dev : Blendman

Current Public version (beta) : 0.38
Date : 5 september 2021 (update the todolist with more features)

Current Dev version (beta) : 0.39



**I) Todolist**

AR = to be changed or improved

■  creation  / shape tools
ok 0.01 - complexe shape
ok 0.03 - add pt (add point at the end of the curve of line)
ok 0.03 - delete point
ok 0.07 - circle/ellipse
ok 0.07 - rectangle/ square
ok 0.08 - line (clic+ctrl to add more point)
ok 0.08 - curve (clic+ctrl to add more point)
ok 0.09 - text
ok 0.09 - image
ok - round rectangle / square
ok - free drawing tool line
ok - free drawing tool curve
 - other shape : triangle, start, polygon predefined

■ Transformations
ok 0.03 - move shape 
ok 0.03 - add or delete shape
ok 0.04 - scale shape 
ok 0.05 - Rotate shape 
ok 0.07 need improvement - add center for rotation & scale
ok 0.07 - rotation by center
ok - scale by center
ok 0.08 - merge objet file : to add new object
ok 0.15 - move pts selected (several)
ok - scale selection points
ok - rotate selection of points
ok but need improvement (only shape and point for now) - mode edition : all/objet/shape/points
ok - insert a pt between two points selected
ok - tool miror for single shape or selection in center (horizontal and vertical)
- tool miror : with selection and boundingbox

■ UI (toolbar)
ok 0.06 - pan
ok 0.06 - zoom
ok 0.10 AR - offset : origin (=center), selection (boundingbox)
- offset : mouse cursor, selected shape
ok 0.10 - snap, snapX, snapY

■ File 
ok 0.05 - merge shape file 
ok 0.03 - save
ok 0.03 - saveAs
ok 0.04 AR - export image (object selected only)
ok 0.10 - export scene (camera x,y,w,h)
ok 0.12 - Export pb command processus
- Import pb command processus (?)
- Import SVG
ok 0.37 - Export SVG
- save images sequence of animation (from start to end frame) in png, jpg
- export animation in AVI (?)
ok - export option : size in %
- export option : all
ok 0.39.1 - export option : selected object only
ok - export option : by Layer
- export option : start - end frame for export (use the animation start /end or custom)


■ Edit
ok 0.07 - Copy / paste shape
ok 0.08 - select all shapes, deselect all shapes
ok 0.14 - set shape to bottom
ok 0.14 - set shape to top
ok 0.14 - set shape to origin
ok 0.14 - set shape to cursor
ok - set Origin to shape
ok - set origin to cursor

■ options
ok 0.09 - load options
ok 0.09 - save options
ok 0.13 - background color
ok 0.13 - background checker
ok - background image (+load, scale, alpha, crop)
ok - window background image ( to set x,y,w,h, crop...)

■ window (interface)
ok 0.01 - drawing (& shapekey)
- animation (dope sheet, lna)
- scene
- sequences
- compositing

■ layers (object)
ok 0.10 - ui layer
ok 0.10 - layer hide
ok 0.10 - layer LOCK
ok 0.10 - layer ADD
ok 0.10 - layer del
ok 0.10 - layer move up, down
ok 0.13 - layer position (X,Y)
ok 0.13 - layer size (w,h)
ok 0.13.5 AR - layer alpha
- layer typ ???  (vector, camera, light, fx, image parameters, particles, sounds)  ???
- merge with bottom object-layer
- merge all objects
- merge all visible
- duplicate layer
ok with saving - send object to library (bank)
- layer parenting (to another object)
- fix object to camera

■ text shape
ok 0.09 - change text
ok 0.09 - change font

■ Image 
ok 0.07 - image tool 
ok 0.07 - image alpha
ok 0.13.5 - image repeat
ok 0.13.5 - image w,h
ok 0.13.5 - image x,y
ok 0.14 - change image

■ Shape parameters
ok 0.04 - add path style  : filled, line, dash, dot
ok 0.11 - Hide
ok 0.11 - lock
ok 0.11 - linked shape (to use the drawing mode "intersect")
ok 0.12 - closepath
ok 0.16 - convert box to complexe shape
ok 0.16 - convert circle to complexe shape
wip - gradient color
- create gradient
- save gradient
- load gradient
- global Style/color  for shape
ok 0.39 - joint several shapes in 1
- separate the shape in several shapes
ok - parenting : set parent from shape
ok but need improvement - unparenting
ok but need improvement - parenting : move parent -> move children
- parenting : scale parent -> scale children
- parenting : rotate parent-> rotate children

■ point parameter (for line, curve, complex shape)
ok 0.15 - set point hard
ok 0.15 - set point smooth 

■ Style/ FX
ok 0.06 - btn add  fx
ok 0.06 - style : filled, line, dash, dot
ok 0.06 - color, alpha, x,y
ok 0.06 AR - depth 
ok 0.06 - depth back/front
ok 0.06 - export selected Fx chanel 
ok 0.07 - file : save/load avec Fx
ok 0.07 - scale
ok 0.07 - preset save
ok 0.13 - preset load
- preset add
- size w,h
- global color for fx
- Gradient color fx
Premade fx : (?)
- stroke, size, back/front
- shadowExt, size, color, back/front
- reflet (rond ?), size, color, position, forme
- copy, paste Fx parameters
- save Fx (all parameters)
- clip : fx only draw in first shape

■ Timeline
ok 0.13.5 - buttons play, next, prev, currentframe, start/end frame, fps
ok 0.15 - set end frame
ok 0.15 - set FPS
ok 0.16 - canvas time & key
ok 0.16 - keyframe visible
ok 0.16 - select keyframe
ok 0.16 - move keyframe
ok 0.17 - hide layer
ok 0.17 - lock layer
ok 0.17 - move currentframe
ok 0.17 - set loop
- delete keyframe
- add keyframe automatic / manual
- copy/paste keyframe
- Add Animation layer
- move layer
- delete layer
- set end frame

■ Animation
ok 0.13.5 - play system & preview animation (no interpolation)
- preview animation with interpolation
- we can add keyframe
- we can move keyframes
- we can change shape parameters and animate it
- key interpolation
- animation move object / shape
- animation rotate (object / shape)
- animation scale (object / shape)
- animation transformation option (cursor / bouding box / origin)


■ Network
?? - add a netwrok feature, for render farm or other cool possibility 
?? - work together on the same file ? Share file for team ??


**II) BUGS**

- layer : w & h : not at the good position with view\x - y
- rotation doesn't work well with text
