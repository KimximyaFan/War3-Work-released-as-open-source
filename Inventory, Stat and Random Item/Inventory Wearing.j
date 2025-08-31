library InvenWearing requires InvenGeneric, InvenToolTip, Stat

globals
    private trigger sync_trg

    integer array wearing_back_drops
    integer array wearing_texts
    integer array wearing_img
    integer array wearing_buttons
    
    integer wearing_clicked_index = -1
endglobals

private function Wearing_Synchronize takes nothing returns nothing
    local string sync_data = DzGetTriggerSyncData()
    local integer pid = S2I( SubString(sync_data, 0, 1) )
    local integer wearing_index = S2I( SubString(sync_data, StringLength(sync_data) - 2, StringLength(sync_data)) )
    local integer inven_index
    local Equip E = Hero(pid).Get_Wearing_Item(wearing_index)

    set inven_index = Hero(pid).Check_Inven_Possible()
        
    if inven_index == -1 then
        // 템창 꽉참
    else
        call Hero(pid).Remove_Wearing_Item( wearing_index )
        call Hero(pid).Set_Inven_Item( inven_index, E )
        
        // 프레임 이미지 처리는 각플로 합시다
        if GetLocalPlayer() == Player(pid) then
            call Wearing_Remove_Img( wearing_index )
            call Inven_Set_Img( inven_index, E )
        endif
        
        call Stat_Refresh(pid)
    endif
endfunction

private function Wearing_Clicked takes nothing returns nothing
    local integer pid = GetPlayerId( DzGetTriggerUIEventPlayer() )
    local integer wearing_index = S2I( SubString(DzFrameGetName(DzGetTriggerUIEventFrame()), 0, 2) )
    
    if wearing_clicked_index == wearing_index then
        set wearing_clicked_index = -1
        call Inven_Tool_Tip_Leave()
        
        // 장비창 아이템 처리 관련 동기화를 해줍시다
        // 문자열 앞부분은 플레이어번호 뒷부분은 템칸 인덱스
        call DzSyncData("wearing", I2S(pid) + " 0" + I2S(wearing_index))
    else
        set wearing_clicked_index = wearing_index
        set inven_clicked_index = -1
    endif
endfunction

// 장착 칸 9개, 백드롭과 버튼으로 구성됨
private function Inven_Wearing_Frames takes nothing returns nothing
    local integer i
    local real x = -0.12
    local real y = 0.095
    local real padding = 0.065
    local real array X
    local real array Y
    local string array wearing_type
    
    set X[0] = 0
    set Y[0] = 0.00
    
    set X[1] = padding
    set Y[1] = 0
    
    set X[2] = -padding
    set Y[2] = -padding
    
    set X[3] = 0
    set Y[3] = -padding
    
    set X[4] = padding
    set Y[4] = -padding
    
    set X[5] = -padding
    set Y[5] = -2*padding
    
    set X[6] = 0
    set Y[6] = -2*padding
    
    set X[7] = padding
    set Y[7] = -2*padding
    
    set X[8] = -padding
    set Y[8] = -3*padding
    
    set X[9] = padding
    set Y[9] = -3*padding
    
    set wearing_type[0] = "투구"
    set wearing_type[1] = "목걸이"
    set wearing_type[2] = "무기"
    set wearing_type[3] = "갑옷"
    set wearing_type[4] = "방패"
    set wearing_type[5] = "반지1"
    set wearing_type[6] = "벨트"
    set wearing_type[7] = "반지2"
    set wearing_type[8] = "장갑"
    set wearing_type[9] = "부츠"
    
    set i = -1
    loop
    set i = i + 1
    exitwhen i > 9
        set wearing_back_drops[i] = DzCreateFrameByTagName("BACKDROP", "", inven_box, "QuestButtonPushedBackdropTemplate", 0)
        call DzFrameSetPoint(wearing_back_drops[i], JN_FRAMEPOINT_CENTER, inven_box, JN_FRAMEPOINT_CENTER, x + X[i], y + Y[i] )
        call DzFrameSetSize(wearing_back_drops[i], inven_square_size, inven_square_size)
        
        set wearing_texts[i] = DzCreateFrameByTagName("TEXT", "", wearing_back_drops[i], "", 0)
        call DzFrameSetPoint(wearing_texts[i], JN_FRAMEPOINT_CENTER, wearing_back_drops[i], JN_FRAMEPOINT_CENTER, 0.0, 0.0)
        call DzFrameSetText(wearing_texts[i], "|cffffcc00" + wearing_type[i] + "|r")
        
        set wearing_img[i] = DzCreateFrameByTagName("BACKDROP", "", wearing_back_drops[i], "QuestButtonPushedBackdropTemplate", 0)
        call DzFrameSetPoint(wearing_img[i], JN_FRAMEPOINT_CENTER, wearing_back_drops[i], JN_FRAMEPOINT_CENTER, 0, 0 )
        call DzFrameSetSize(wearing_img[i], inven_item_size, inven_item_size)
        call DzFrameShow(wearing_img[i], false)
        
        set wearing_buttons[i] = DzCreateFrameByTagName("BUTTON", I2S(i) + " wearing", wearing_back_drops[i], "ScoreScreenTabButtonTemplate", 0)
        call DzFrameSetPoint(wearing_buttons[i], JN_FRAMEPOINT_CENTER, wearing_back_drops[i], JN_FRAMEPOINT_CENTER, 0, 0)
        call DzFrameSetSize(wearing_buttons[i], inven_square_size, inven_square_size)
        call DzFrameSetScriptByCode(wearing_buttons[i], JN_FRAMEEVENT_CONTROL_CLICK, function Wearing_Clicked, false)
        // 마우스 진입, 빠져나올 때 툴팁 함수 실행됨
        call DzFrameSetScriptByCode(wearing_buttons[i], JN_FRAMEEVENT_MOUSE_ENTER, function Inven_Tool_Tip_Enter, false)
        call DzFrameSetScriptByCode(wearing_buttons[i], JN_FRAMEEVENT_MOUSE_LEAVE, function Inven_Tool_Tip_Leave, false)
        
        call DzFrameShow(wearing_buttons[i], false)
    endloop
endfunction

function Inven_Wearing_Init takes nothing returns nothing
    call Inven_Wearing_Frames()
    
    // 장착칸 동기화
    set sync_trg = CreateTrigger()
    call DzTriggerRegisterSyncData(sync_trg, "wearing", false)
    call TriggerAddAction( sync_trg, function Wearing_Synchronize )
endfunction

endlibrary