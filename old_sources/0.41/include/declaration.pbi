
; Declaration

; init
Declare InitVectorDrawing()
Declare InitImages()
Declare Vd_OptionsReset()
Declare VD_SaveOptions()
Declare VD_LoadOptions()
Declare InitVD()

; images
Declare UnPreMultiplyAlpha(image)

; gadgets & menu
Declare AddGadget(id,typ,x,y,w,h,txt$="",min.d=0,max.d=0,tip$="",val.d=-65257,name$=#Empty$)
Declare AddButonImage(gadg,x,y,w,h,img,flag,tip.s)
Declare Vd_CreateToolbar()
Declare SetPanelGadget(disable=0)
Declare VD_CreateLayerUi()
Declare Vd_SetGadgetOption()
Declare BG_LoadImage(name$, loadimage=0,reset=1)
Declare UpdateGadgetParent()

; bank objets
Declare UpdateListBank(updatefolder=0, ShapeFolder$=#Empty$)
Declare VD_CreateGadgetsBankShape(y1=0)
Declare VD_UpdateShapeBankCanvas(createImage=0, updatefolder=1)
Declare VD_EventBangkGadget()

; shape edit
Declare ShapeGetProperties(state=1)
Declare Shape_SelectAll(Selection=1)
Declare VD_Shape_ChangeImage()
Declare VD_ConvertShape(to_Pt=1, typ=0)
Declare Shape_Delete()
Declare Shape_SetPropertie(propertie=#ShapePropertie_Color, value=-1)
Declare Shape_SetFXpropertie(propertie=#ShapePropertie_Color,mode=0,value=-1,i=-1)
Declare Shape_SetOrigin(Mode=0,x=0,y=0,update=1)
Declare MouseOnShape(m,i,x,y)

; Shape point edit
Declare Shape_CheckBrokenPoint()
Declare Vd_SetPoint(param=0,draw=1)

; draw
Declare ShapeDrawFx(Obj,Shape,fx)
Declare VDDrawFx(vo,j,dessus=0)
Declare VdDrawShape1(vo,j)
Declare VDDrawShapeColor(vo,j)
Declare Grid3D()
Declare VDDrawUtil()
Declare DrawCanvas(x=0,y=0,Selected=0,gad=#G_canvasVector)
Declare VD_ShapeCoord(i,camw.d=1,camh.d=1)
Declare DrawObjClipping(m)

; ui, update
Declare UpdateListShape()
Declare UpdateListShapeFX()
Declare UpdateListPresetFx()
Declare Vd_ResizeAll()
Declare Vd_UpdateTimeLine()
; LAyers
Declare VD_Layer_UpdateUI(update=0)


; Shape
Declare ShapeExportFx()
Declare ShapeLoadFx()
Declare ShapeExportFxLayer()
Declare ShapeLoadFxLayer(nom$)
Declare ShapeAddFx(i=0)
Declare Shape_Add(x,y)
Declare AddPathRoundBox(x, y, w, h, r)
Declare Shape_Save(file$ = "",autosave=0, selection=0)
Declare Shape_Load(merge=0, file$ ="",draw=1)

; Manu (files)
Declare VD_OpenTheHelp(html=0)
Declare Scene_Export(scene=0,forbankimg=0,file$=#Empty$,selected=0)
Declare Doc_New(eraseall=1,copy=0,draw=1,x=0,y=0)
Declare WindowInfos_Create(maininfo$,info$)
Declare WindowInfos_Update(info$)
Declare WindowInfos_Close()
Declare.s VD_GetCameratext(i)

; window
Declare OpenWinVectorDrawing()



; IDE Options = PureBasic 5.61 (Windows - x86)
; CursorPosition = 84
; FirstLine = 64
; EnableXP