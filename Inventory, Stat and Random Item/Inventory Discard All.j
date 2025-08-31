library DiscardAll requires InvenGeneric

globals
    private trigger sync_trg

    private integer discard_all_button
endglobals

private function Discard_All_Synchronize takes nothing returns nothing
    local string sync_data = DzGetTriggerSyncData()
    local integer pid = S2I( SubString(sync_data, 0, 1) )
    local integer i
    local integer grade
    local Equip E
        
    set i = -1
    loop
    set i = i + 1
    exitwhen i > 24
        if Hero(pid).Check_Inven_Item(i) == true then
            set E = Hero(pid).Get_Inven_Item(i)
            set grade = E.Get_Grade()
            
            if discard_all_check[grade] == true then
                call Hero(pid).Delete_Inven_Item(i)
                
                // 프레임 이미지 처리는 각플로 합시다
                if GetLocalPlayer() == Player(pid) then
                    call Inven_Remove_Img( i )
                endif
            endif
        endif
    endloop
endfunction

private function Discard_All_Clicked takes nothing returns nothing
    local integer pid = GetPlayerId( DzGetTriggerUIEventPlayer() )
    
    // 동기화를 해줍시다
    call DzSyncData("all", I2S(pid) )
endfunction

private function Inven_Discard_All_Button takes nothing returns nothing
    set discard_all_button = DzCreateFrameByTagName("GLUETEXTBUTTON", "", inven_box, "ScriptDialogButton", 0)
    call DzFrameSetPoint(discard_all_button, JN_FRAMEPOINT_CENTER, inven_box, JN_FRAMEPOINT_CENTER, 0.135, 0.12)
    call DzFrameSetSize(discard_all_button, 0.060, 0.04)
    call DzFrameSetText(discard_all_button, "일괄 버리기")
    call DzFrameSetScriptByCode(discard_all_button, JN_FRAMEEVENT_CONTROL_CLICK, function Discard_All_Clicked, false)
endfunction

function Inven_Discard_All_Init takes nothing returns nothing
    call Inven_Discard_All_Button()
    
    // 일괄 버리기 동기화
    set sync_trg = CreateTrigger()
    call DzTriggerRegisterSyncData(sync_trg, "all", false)
    call TriggerAddAction( sync_trg, function Discard_All_Synchronize )
endfunction

endlibrary