; Made with Cartoon ! 0.12
; Date : 08/04/2016
; Pb Version : 5.42 + 

Global Zoom.f = 1


Procedure Heart(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="")

    Protected Z.f
    Z = Zoom
    MovePathCursor((x+109)*Z, (y+105)*Z)
    AddPathCurve((x+235)*Z, (y-33)*Z, (x+219)*Z, (y+131)*Z, (x+114)*Z, (y+240)*Z)
    AddPathCurve((x-29)*Z, (y+148)*Z, (x+40)*Z, (y)*Z, (x+109)*Z, (y+105)*Z)

    VectorSourceColor(-12577347)
    FillPath()

EndProcedure 

w = 800
h= 600

OpenWindow(0, 0, 0, w,h, "", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)

CanvasGadget(0,0,0,w,h)

If StartVectorDrawing(CanvasVectorOutput(0))
    AddPathBox(0,0, GadgetWidth(0),GadgetHeight(0))
    VectorSourceColor(RGBA(120,120,120,255))
    FillPath()

    Heart(0,0)
    
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