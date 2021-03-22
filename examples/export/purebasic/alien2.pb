; Made with Cartoon ! 0.14
; Date : 12/04/2016
; Pb Version : 5.42 + 

Global Zoom.f = 0.5


Procedure Alien2(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="")

    Protected Z.f
    Z = Zoom
    MovePathCursor((141+x)*Z, (107+y)*Z)
    AddPathCurve((168+x)*Z, (98+y)*Z, (188+x)*Z, (154+y)*Z, (151+x)*Z, (161+y)*Z)
    AddPathCurve((123+x)*Z, (163+y)*Z, (112+x)*Z, (118+y)*Z, (141+x)*Z, (107+y)*Z)
    VectorSourceColor(-2491416)
    FillPath()

    MovePathCursor((144+x)*Z, (117+y)*Z)
    AddPathCurve((159+x)*Z, (112+y)*Z, (183+x)*Z, (142+y)*Z, (153+x)*Z, (148+y)*Z)
    AddPathCurve((137+x)*Z, (152+y)*Z, (126+x)*Z, (123+y)*Z, (144+x)*Z, (117+y)*Z)
    VectorSourceColor(-16760254)
    FillPath()

    MovePathCursor((225+x)*Z, (290+y)*Z)
    AddPathCurve((397+x)*Z, (263+y)*Z, (181+x)*Z, (342+y)*Z, (82+x)*Z, (347+y)*Z)
    AddPathCurve((40+x)*Z, (352+y)*Z, (170+x)*Z, (222+y)*Z, (78+x)*Z, (190+y)*Z)
    AddPathCurve((-11+x)*Z, (166+y)*Z, (0+x)*Z, (0+y)*Z, (143+x)*Z, (103+y)*Z)
    AddPathCurve((146+x)*Z, (196+y)*Z, (449+x)*Z, (235+y)*Z, (219+x)*Z, (263+y)*Z)
    AddPathCurve((173+x)*Z, (265+y)*Z, (193+x)*Z, (297+y)*Z, (225+x)*Z, (290+y)*Z)
    VectorSourceColor(-16079976)
    FillPath()

    MovePathCursor((109+x)*Z, (115+y)*Z)
    AddPathCurve((136+x)*Z, (106+y)*Z, (156+x)*Z, (162+y)*Z, (119+x)*Z, (169+y)*Z)
    AddPathCurve((91+x)*Z, (171+y)*Z, (80+x)*Z, (126+y)*Z, (109+x)*Z, (115+y)*Z)
    VectorSourceColor(-2491416)
    FillPath()

    MovePathCursor((115+x)*Z, (130+y)*Z)
    AddPathCurve((130+x)*Z, (125+y)*Z, (154+x)*Z, (155+y)*Z, (124+x)*Z, (161+y)*Z)
    AddPathCurve((108+x)*Z, (165+y)*Z, (97+x)*Z, (136+y)*Z, (115+x)*Z, (130+y)*Z)
    VectorSourceColor(-16760254)
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
    Alien2(0,0)    
    StopVectorDrawing()
EndIf

Repeat
  Event = WaitWindowEvent()  
Until Event = #PB_Event_CloseWindow



; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 4
; Folding = -
; EnableAsm
; EnableUnicode
; EnableXP
; EnablePurifier