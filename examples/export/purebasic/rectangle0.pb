; Made with Cartoon ! 0.12
; Date : 08/04/2016
; Pb Version : 5.42 + 

Global Zoom.f = 1


Procedure Object0(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="")

    Protected Z.f
    Z = Zoom
    MovePathCursor(0*Z, 0*Z)
    AddPathBox((0+x)*Z, (0+y)*Z, (315*ScaleX)*Z, (148*ScaleY)*Z)

    VectorSourceColor(-16744193)
    FillPath()


    MovePathCursor(89*Z, 65*Z)
    AddPathEllipse((89+x)*Z, (65+y)*Z, (68*ScaleX)*Z, (47*ScaleY)*Z)

    VectorSourceColor(-8856356)
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

    Object0(0,0)
    
    StopVectorDrawing()
EndIf



Repeat
  Event = WaitWindowEvent()
  
  
Until Event = #PB_Event_CloseWindow



; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 40
; Folding = -
; EnableAsm
; EnableUnicode
; EnableXP
; EnablePurifier