; Made with Cartoon ! 0.15
; Date : 15/04/2016
; Pb Version : 5.42 + 

Global Zoom.f = 1


Procedure Boolean(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="")

    Protected Z.f
    Z = Zoom
    MovePathCursor((0+x)*Z, (0+y)*Z)
    AddPathCurve((-175+x)*Z, (0+y)*Z, (-175+x)*Z, (204+y)*Z, (0+x)*Z, (204+y)*Z)
    AddPathCurve((175+x)*Z, (204+y)*Z, (175+x)*Z, (0+y)*Z, (0+x)*Z, (0+y)*Z)

    MovePathCursor((82+x)*Z, (24+y)*Z)
    AddPathCurve((-77+x)*Z, (24+y)*Z, (-77+x)*Z, (188+y)*Z, (82+x)*Z, (188+y)*Z)
    AddPathCurve((241+x)*Z, (188+y)*Z, (241+x)*Z, (24+y)*Z, (82+x)*Z, (24+y)*Z)
    VectorSourceColor(-8856356)
    FillPath()


EndProcedure 

; code test
w = 800
h= 600
OpenWindow(0, 0, 0, w,h, "", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
CanvasGadget(0,0,0,w,h)
If StartVectorDrawing(CanvasVectorOutput(0))
    AddPathBox(0,0, GadgetWidth(0),GadgetHeight(0))
    VectorSourceColor(RGBA(120,120,120,255))
    FillPath()
    Boolean(180,80)    
    StopVectorDrawing()
EndIf

Repeat
  Event = WaitWindowEvent()  
Until Event = #PB_Event_CloseWindow




; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; Folding = -
; EnableAsm
; EnableUnicode
; EnableXP
; EnablePurifier