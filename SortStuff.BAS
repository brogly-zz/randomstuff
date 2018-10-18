Attribute VB_Name = "SortStuff"
Public QSortCalls As Integer
Public PartitionCalls As Integer

Sub Partition(ByRef lst As Variant, ByRef l As Variant, ByRef e As Variant, ByRef g As Variant)
    PartitionCalls = PartitionCalls + 1
    If UBound(lst) = 0 Or UBound(lst) = 1 Then Exit Sub
    
    Dim pivot As Integer
    pivot = lst(UBound(lst) - 1)
    
    For i = LBound(lst) To UBound(lst) - 1 Step 1
        If lst(i) < pivot Then
            ReDim Preserve l(UBound(l) + 1)
            l(UBound(l) - 1) = lst(i)
        ElseIf lst(i) = pivot Then
            ReDim Preserve e(UBound(e) + 1)
            e(UBound(e) - 1) = lst(i)
        Else
            ReDim Preserve g(UBound(g) + 1)
            g(UBound(g) - 1) = lst(i)
        End If
    Next i
End Sub

Function QSort(ByRef lst As Variant) As Variant
    QSortCalls = QSortCalls + 1
    If UBound(lst) = 0 Or UBound(lst) = 1 Then
        QSort = lst
        Exit Function
    End If
    
    Dim l() As Integer
    ReDim l(0)
    Dim e() As Integer
    ReDim e(0)
    Dim g() As Integer
    ReDim g(0)
    
    Partition lst, l, e, g
    
    l = QSort(l)
    e = QSort(e)
    g = QSort(g)
    
    Dim oldLUBound As Integer
    oldLUBound = UBound(l)
    ReDim Preserve l(UBound(l) + UBound(e) + UBound(g))
    
    Dim i As Integer
    For i = 0 To UBound(e) - 1 Step 1
        l(i + oldLUBound) = e(i)
    Next i
    
    For i = 0 To UBound(g) - 1 Step 1
        l(i + oldLUBound + UBound(e)) = g(i)
    Next i
    
    QSort = l
    
End Function

'Recursive Quick Sort
'Seems to crash above 42 numbers. There could be a bug or the VBA Stack Space is very limited.
Sub QuickSortMain()
    QSortCalls = 0
    PartitionCalls = 0

    Dim thingsToSort As Variant
    thingsToSort = SortSheet.range("A1:A7").Value
    
    Dim oneDArray As Variant
    ReDim oneDArray(1)
    
    Dim item As Variant
    For Each item In thingsToSort
        ReDim Preserve oneDArray(UBound(oneDArray) + 1)
        oneDArray(UBound(oneDArray) - 1) = item
    Next item
    
    
    Dim startTime As Double
    Dim finishTime As Double
    Dim amtOfTime As Double

    startTime = Timer
    oneDArray = QSort(oneDArray)
    finishTime = Timer
    
    amtOfTime = finishTime - startTime
    Debug.Print amtOfTime & " seconds."
    
    SortSheet.range("B1:B7").Value = WorksheetFunction.Transpose(oneDArray)
    
    MsgBox "QSortCalls: " & QSortCalls
    MsgBox "PartitionCalls: " & PartitionCalls
End Sub

Sub Bogosort(ByVal amtOfNumbers As Integer)
    SortSheet.Activate
    Dim position As Integer
    Dim sorted As Boolean
    sorted = False
    
    Do Until sorted = True
        
        Dim i As Integer
        For i = 1 To amtOfNumbers Step 1
            position = Int((Rnd() * amtOfNumbers) + 1)
            Dim tmp As Integer
            tmp = SortSheet.Cells(i, 1)
            SortSheet.Cells(i, 1) = SortSheet.Cells(position, 1)
            SortSheet.Cells(position, 1) = tmp
        Next i
        
        sorted = True
        For i = 2 To amtOfNumbers Step 1
            If SortSheet.Cells(i - 1, 1) > SortSheet.Cells(i, 1) Then
                sorted = False
            End If
        Next i
    Loop
End Sub

Sub BogosortArray(ByVal amtOfNumbers)
    Dim numArray As Variant
    numArray = SortSheet.range("A1:A" & amtOfNumbers).Value
    
    SortSheet.Activate
    Dim position As Integer
    Dim sorted As Boolean
    sorted = False
    
    Do Until sorted = True
        
        Dim i As Integer
        For i = 1 To amtOfNumbers Step 1
            position = Int((Rnd() * amtOfNumbers) + 1)
            Dim tmp As Integer
            tmp = numArray(i, 1)
            numArray(i, 1) = numArray(position, 1)
            numArray(position, 1) = tmp
        Next i
        
        sorted = True
        For i = 2 To amtOfNumbers Step 1
            If numArray(i - 1, 1) > numArray(i, 1) Then
                sorted = False
            End If
        Next i
    Loop
    
    SortSheet.range("B1:B" & amtOfNumbers).Value = numArray
End Sub

Sub BogosortFast()

    Dim startTime As Double
    Dim finishTime As Double
    Dim amtOfTime As Double
    
    startTime = Timer
    BogosortArray 7
    finishTime = Timer
    
    amtOfTime = finishTime - startTime
    Debug.Print amtOfTime & " seconds."
    
End Sub

Sub BogosortSlow()
    Dim startTime As Double
    Dim finishTime As Double
    Dim amtOfTime As Double

    startTime = Timer
    Bogosort 7
    finishTime = Timer
    
    amtOfTime = finishTime - startTime
    Debug.Print amtOfTime & " seconds."
End Sub

Sub RandomNumbers()
    RandomAColumn 500, 7
End Sub

Sub RandomAColumn(ByVal maxVal As Integer, ByVal amt As Integer)
    Dim i As Integer
    For i = 1 To amt
        SortSheet.range("A" & i).Value = Int((Rnd * maxVal) + 1)
    Next i
End Sub
