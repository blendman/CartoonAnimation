; Made with Cartoon ! 0.12
; Date : 08/04/2016
; Pb Version : 5.42 + 

Global Zoom.f = 1


Procedure defaut(x,y,ScaleX.f=1,ScaleY.f=1,font=-1,txt$="")

    Protected Z.f
    Z = Zoom
    MovePathCursor(50*Z, 50*Z)
    AddPathEllipse((50+x)*Z, (50+y)*Z, (50*ScaleX)*Z, (50*ScaleY)*Z)

    VectorSourceColor(-8856356)
    FillPath()
    MovePathCursor(81*Z, 81*Z)
    AddPathCurve((-153)*Z, (-92)*Z, (-153)*Z, (-92)*Z, (-153)*Z, (-92)*Z)
