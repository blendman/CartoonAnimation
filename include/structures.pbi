﻿
; structures & variables global
Structure sToolOptions
  Open.a
  Color.i
  Alpha.a
  Style.a
  Width.d
  distance.d
  angle.d
EndStructure

Structure sTool
  LockX.a
  LockY.a
  ;     SizeTyp.a
  SizeW.w
  SizeH.w
  Rotation.w
  RotationType.a ; 90,180,207, mirror
  MirorH.a
  MirorV.a
  SizeProp.a
  type.a ; type of tool (option of tool, if exists)
  
  Options.sToolOptions
EndStructure

Structure SPointBase
  x.i
  y.i
EndStructure
Global Dim CopyPathLength.spointBase(0)

Structure sPoint Extends sPointBase
  
  LockX.a
  LockY.a
  startRotX.i  
  startRotY.i   
  startX.i    
  startY.i
  Selected.a
  
  Center.a ; le point "center", celui qu'on bouge (au milieu des anchor)
  Hard.a   ; pour connaître la dureté du point : hard / soft
  hide.a ; to know if the curve is rendered
  hideFX.a ; to know if FX curve is rendered
  broken.a ; to know if a shape is made with several parts, if yes, so the points is broken and i had movepathcursor()
  MaxPt.w ; to know the max of point has the part of the shape (if shape is composed to several broken curves)
EndStructure

Structure sRectangle
  x.f
  y.f
  w.w
  h.w
EndStructure
Structure sRectangle2
  x.w
  y.w
  w.w
  h.w
EndStructure

Structure sImg Extends sRectangle 
  Filename$
  Depth.a
  Alpha.a
 
EndStructure
Global Dim BankImage$(0), NbBankImage=-1

Structure sBGImg Extends sImg
  Resize.f
  Scale.f
  ClipOut.sRectangle2
EndStructure


Structure sCharPart
  img.i
  x.d
  y.d
  w.w
  h.w
EndStructure
; character, for the window character creator
Structure sCharacter
  eyeR.sCharPart
  eyeL.sCharPart
  CilR.sCharPart
  CilL.sCharPart
  Hair.sCharPart
  mouth.sCharPart
  nose.sCharPart
  head.sCharPart
  hearR.sCharPart
  hearL.sCharPart
  neck.sCharPart
  
EndStructure


; utilities for shapes
Structure sGroup
  Name$
EndStructure
Global Dim ShapeGroup.Sgroup(0), NbGroup=-1



Structure sColorBase
  Color.i
  r.a
  g.a
  b.a
  a.a
EndStructure

; les shapes
Structure sFXShape
  
  ; pour les effets
  Nom$
  X.w
  Y.w
  Style.a
  Color.i
  Alpha.a
  Depth.a
  W.d
  H.d
  SizeW.w
  SizeH.w
  Scale.W
  Typ.a ; le typ 0=normal, 1 = shadow ext, 2 = stroke, 3 = glow int, 4 =glow ext, 5 = reflet (rond ?), 6 = light int, 7 = rimlight
  Dist.d
  Actif.a
  
  Clip.a
  open.a
  UseOwnopen.a
EndStructure
Global Dim ShapeFx.sFXShape(0)

Structure sParent Extends sRectangle
  idUnik$
  id.w
  startx.d
  startY.d
  StartRot.w
EndStructure

Structure sShape
  
  Nom$
  idUnik$ ; current id unique, for parenting or to knwo what is this shape.
  Old_idUnik$ ; old idunik, when loading, to Help to update parenting with the shape which has this old_idunik too
  Array pt.sPoint(5)
  Array Fx.sFXShape(0)
  UseFx.a
  
  ShapTyp.a ; le type de shape : box, circle, shape, line, image...
            ; si c'est un text
  Text$
  Font.i
  FontName$
  FontStyle.i
  FontFx.i
  ; si on utilise une image
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
  Rot.d
  X.d
  Y.d
  ; the final X,Y = position (\X,Y) + Transformation + Parenting
  FinalX.d
  FinalY.d
  FinalRot.w
  
  Scale.d
  SizeW.d  
  SizeH.d
  ; nécessaire pour les trnasformations par groupe (selected = 1)
  StartRot.d
  StartX.d
  StartY.d
  StartW.d
  StartH.d
  
  ; Offset 
  CurX.d ; necessaire pour connaitre le centre 
  CurY.d ; necessaire pour connaitre le centre 
  Cx.w
  Cy.w
  
  ;bound
  boundx.w
  boundy.w
  boundw.w
  boundh.w
  
  ; color, alpha
  ;  if shape is filled
  Color.i
  ColorGrad.a ; couleur uni ou un dégradé ?
  Array ColGrad.sColorBase(0)
  Alpha.a

  ; pour le style 
  Typ.a ; only for line
  w.d ; size for the line
  h.d
  d.d ; distance for dot

  
  ; paramètre du path
  open.a ; il est open ou clos ? (par defaut il est clos)
  Clip.a  ; doit-on cliquer le shape dans le précédent ?
  Linked.a ; le shape est-il "lié " avec les autres ?, autrement dit ferme-t-on le chemin après le précédent ou le laisse-t-on ouvert ?
  ClipFX.a
  ClipFX_Ok.a
  
  ; le shape parent : si on move/rotate/scale, ça move/scale/rotate l'enfant.
  Parent.sParent
  Group$
  
  ; depth
  Pos.i
  Depth.a
  
  ; Editor
  Selected.a
  Hide.a
  Locked.a
  
  
EndStructure

; The objects : an object is made with 1 or several shapes.
Structure sObj Extends sRectangle
  
  ; pour l'diteur
  BBoxW.w
  BBoxH.w
  Nom$ 
  ; editor
  Hide.a
  ShowBBox.a
  Locked.a
  Actif.a
  
;   MeshId.i
;   ParentId.i
  
  ; to use clippath with the layer
  Clip.a
  ClipW.W
  ClipH.W
  ClipBorder.a
  ClipBorderAlpha.a
  ClipBorderColor.i
  ClipBorderStroke.w
  ClipColor.i
  ClipAlpha.a
  ClipHide.a

  ; informations internes
  Array Shape.sShape(0) 
  ; Animations
  Depth.a
  Alpha.a
  Bm.a  
;   ; position du layer
;   x.i
;   y.i
;   ; taille du layer
;   w.w
;   h.w
  ; rotation du layer
  RotX.w
  RotY.w
  Rot.w
EndStructure
Global Dim Obj.sObj(0)
Obj(0)\Shape(0)\color = -12577347
; the ID used by the program
Global ObjId.i, ShapeId.i, OldShapeId.i, ShapeFxId.i, PtId.i, KeyId.i, Ze_idunik$
Global NbObj.w = -1
OldShapeId =-1
; Global NbShape=-1

; to copy an object
Global CopyObj.sObj



Structure sColor2 Extends sColorbase
  x.f
  y.f
EndStructure
Structure sGradient
  Filename$
  name$
  NbColor.w
  Array color.sColor2(0)
EndStructure
Global Dim Gradient.sGradient(0)
Global nbGradient=-1


Structure sObjLayer
  Hide.a
  IdUnik$
  selected.a
  x.w
  y.w
EndStructure
Structure sLayer
  Name$
  Array Obj.sObjLayer(0)
  NbObj.w
EndStructure
Global Dim Layer.sLayer(0)
Global NbLayer.w


; programm
Structure sVd
  
  ViewX.w
  ViewY.w
  Space.a
  SpaceX.i
  SpaceY.i
  ClicSelect.a
  
  Selection.sRectangle2
  
  BBox.sRectangle
  BBoxcenter.SPointBase
  
  PathId.a
  SceneID.w
  
  ; fichiers
  ShapeFileName$
  DocFilename$
  
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
  Ctrl.a 
  Alt.a
  
  ; Shape and point edition
  PtUsemirored.a
  EditMode.a
  
  LockSelection.a; pour locker la sélection
  CreateObj.a
  NbShape.b ; just besoin pour supprimer le dernier shape car tableau ne peut pas etre négatif helas
  
  ; bank image
  BankHasSubfolder.a
  
  ; UI
  ; for swatch and FX
  PanelLeftName$
  PanelLeftItem.a
EndStructure
Global Vd.sVd


; for gadgets
Structure sColor Extends sColorBase
  H.l ; hue
  S.l ; saturation
  L.l ; luminence 
EndStructure


; color, swatch
Structure sSwatch
  col.sColor
  Color.i
  x.w
  y.w
  name$
  img.i
  gadImg.i
EndStructure
Global Dim SwatchColor.sSwatch(0)


; options
Structure sVdOptions
  Array Tool.sTool(20)
  
  Action.a
  ToolOptions.sToolOptions
  ToolOptionsFX.sToolOptions
  
  Lang$
  DocHasChanged.a
  DebugOn.a 
  
  ShowTip.a
  ConfirmExit.a
  
  Beta.a
  ToolMoveCanSelect.a
  ; Theme color
  Theme$
  ThemeColor.i
  
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
  ShowShapeBoundingBox.a
  ShowBoxselect.a
  ShowCenter.a
  ShowCameraBorder.a
  ShowCameraCache.a
  ShowCameraSafe.a
  CameraCacheAlpha.a
  
  ShowTimeLine.a
  ShowBGImg.a
  UsethemeColor.a
  
  ; Ui
  PanelW.w
  PanelLayerW.w
  ToolBarH.w
  ToolBarW.w
  ToolBarVertical.w
  ToolBarNbCol.w
  ToolBarOptionH.w
  TimeLineH.w
  
  BankCaseW.a
  BankOutputSize.w
  BankOutputSizeFOrCreation.w
  
  ; Color UI
  ColorGadget.i
  TimeLineColor.i
  CameraCacheColor.i
  
  ; BG
  BgColor.i
  BGAlpha.a
  BGChecker.a
  BgImg.sBGImg
 
  
  GridColor.i
  
  ; swatch window
  SwatchColumns.a
  Swatch$
  SwatchName$
  
  ; camera
  CameraX.w
  CameraY.w
  CameraW.w
  CameraH.w
  CameraSizeH.w
  CameraSizeW.w
  
  ; autosave
  Autosave.a
  AutosaveTime.i
  AutosaveFileName$
  
  UseHexForPBCode.a
  
  ; options 
  Snap.a
  SnapX.w
  SnapY.w
  
  CenterTransformation.a
  RotationOnPoint.a 
  
  GridW.w
  GridH.w
  ShowGrid.a
  ShowOrigin.a
  
  ; paths
  PathOpen$
  PathSave$
  
EndStructure
Global VdOptions.sVdOptions

;{ export svg

Structure sShapeSVG
  Startx.w
  Starty.w
  x.w
  y.w
  w.w
  h.w
  text$
  ; for curve
  x1.w
  y1.w
  x2.w
  y2.w
  
EndStructure

Structure sSVG_line
  Segment$ ; infos about the shape 
  shapetyp.a ; 0 = rect,1=circle,2=line,3=curve
  shape.sShapeSVG
  Strokecolor.i
  strokesize.w
  strokeColorTyp.a ; 0=Color, 1 = gradient linear, 2= gradient circular, 3= texture
  strokeTyp.a ; 0=fill, 1=stroke, 2= dash, 3=point
  strokeflag.a
  strokeAlpha.a
  close.a
  List curve.sShapeSVG()
EndStructure


;}


Structure sVDCamera Extends sRectangle
  ID.a
  name$
  crop.srectangle
  scale.w ; in %
  zoom.d
  optionoutput.a
EndStructure
Global Dim VD_camera.sVDCamera(0)
Global CameraID, NBcamera=-1


;{ The Scene  & animation
Structure sKeySc
  
  x.w
  y.w
  keyframe.w
  ShapeKey.w
  
EndStructure

Structure sLayerAnim 
  
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
  
  Array Layer.sLayerAnim(0)
  
  FrameStart.w
  FrameEnd.w
  FrameTotal.w
  
  Name$
  
EndStructure
Global Dim Scene.sScene(0)
;}

; Global Dim Animation.sAnim(0)
Global Mouseincanvas, othergadgethasfocus, mouseX, mouseY


; IDE Options = PureBasic 5.61 (Windows - x86)
; CursorPosition = 235
; FirstLine = 125
; Folding = AAFAG+
; EnableXP