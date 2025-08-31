library InvenSort

globals
    private trigger sync_trg

    private integer sort_button
endglobals

private function Sort_Synchronize takes nothing returns nothing
    local string sync_data = DzGetTriggerSyncData()
    local integer pid = S2I( SubString(sync_data, 0, 1) )
    local integer i
    local integer j
    local integer max_grade
    local integer max_index
    local boolean i_exist
    local Equip E
    
    /*
        간단한 Selection Sort
        모르면 구글 검색
    */
    
    set i = -1
    loop
    set i = i + 1
    exitwhen i > 24
        set max_grade = -1
        set max_index = i
        set i_exist = false
        if Hero(pid).Check_Inven_Item(i) == true then
            set i_exist = true
            set max_grade = Hero(pid).Get_Inven_Item(i).Get_Grade()
        endif
        
        set j = i
        loop 
        set j = j + 1
        exitwhen j > 24
            if Hero(pid).Check_Inven_Item(j) == true then
                set E = Hero(pid).Get_Inven_Item(j)
                
                if max_grade < E.Get_Grade() then
                    set max_grade = E.Get_Grade()
                    set max_index = j
                endif
            endif
        endloop
        
        if i != max_index then
            if i_exist == true then
                set E = Hero(pid).Get_Inven_Item(i)
            endif
            
            call Hero(pid).Set_Inven_Item( i, Hero(pid).Get_Inven_Item(max_index) )
            
            if i_exist == true then
                call Hero(pid).Set_Inven_Item( max_index, E )
            else
                call Hero(pid).Remove_Inven_Item( max_index )
            endif
            
            // 프레임 이미지 처리는 각플로 합시다
            if GetLocalPlayer() == Player(pid) then
                call Inven_Set_Img( i, Hero(pid).Get_Inven_Item(i) )
                
                if i_exist == true then
                    call Inven_Set_Img( max_index, E )
                else
                    call Inven_Remove_Img( max_index )
                endif
            endif
        endif
    endloop
endfunction

private function Sort_Clicked takes nothing returns nothing
    local integer pid = GetPlayerId( DzGetTriggerUIEventPlayer() )
    
    // 동기화를 해줍시다
    call DzSyncData("sort", I2S(pid) + " 0" )
endfunction

private function Inven_Sort_Button takes nothing returns nothing
    set sort_button = DzCreateFrameByTagName("GLUETEXTBUTTON", "", inven_box, "ScriptDialogButton", 0)
    call DzFrameSetPoint(sort_button, JN_FRAMEPOINT_CENTER, inven_box, JN_FRAMEPOINT_CENTER, 0.015, 0.12)
    call DzFrameSetSize(sort_button, 0.060, 0.04)
    call DzFrameSetText(sort_button, "정렬")
    call DzFrameSetScriptByCode(sort_button, JN_FRAMEEVENT_CONTROL_CLICK, function Sort_Clicked, false)
endfunction

function Inven_Sort_Init takes nothing returns nothing
    call Inven_Sort_Button()
    
    // 정렬 동기화
    set sync_trg = CreateTrigger()
    call DzTriggerRegisterSyncData(sync_trg, "sort", false)
    call TriggerAddAction( sync_trg, function Sort_Synchronize )
endfunction

endlibrary