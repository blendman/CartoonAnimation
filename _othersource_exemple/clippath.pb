If OpenWindow(0, 0, 0, 400, 200, "VectorDrawing", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
    CanvasGadget(0, 0, 0, 400, 200)
    LoadFont(0, "Times New Roman", 20, #PB_Font_Bold)
    
    If StartVectorDrawing(CanvasVectorOutput(0))
        
        
        ; 
       
        MovePathCursor(0, 0)
        
        For i = 10 To 150 Step 5
            AddPathEllipse(200, 100, 2*i, i)
        Next i
        VectorSourceColor(RGBA(0, 0, 255, 255))
        FillPath()
        SaveVectorState()
        
        
        For i = 10 To 150 Step 5
            AddPathEllipse(200, 100, 2*i, i)
        Next i
        ClipPath()
       
        VectorFont(FontID(0), 150)      
        VectorSourceColor(RGBA(255, 0, 0, 255))        
        MovePathCursor(50, 25)
        DrawVectorText("Text")
        
       
        
        AddPathCircle(50,50,50)
        VectorSourceColor(RGBA(0, 120, 120, 255))
        FillPath()
        
        RestoreVectorState()
        
        StopVectorDrawing()
    EndIf
    
    Repeat
        Event = WaitWindowEvent()
    Until Event = #PB_Event_CloseWindow
EndIf

; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 18
; EnableAsm
; EnableUnicode
; EnableXP
; EnablePurifier