//! import "DzAPIHardware.j"
//! import "DzAPISync.j"

library PlayerMousePosition initializer Init requires DzAPISync

globals
    real array mouse_x
    real array mouse_y
endglobals

function Set_Mouse_Y_Func takes nothing returns nothing
    local string sync_string = DzGetTriggerSyncData()
    local integer player_num = S2I( SubString(sync_string, 0, 2) )
    local real y = S2R( SubString( sync_string, 2, StringLength(sync_string) ) )
    
    set mouse_y[player_num] = y
endfunction

function Set_Mouse_Y takes player p returns nothing
    local integer player_num = GetConvertedPlayerId(p)
    
    if GetLocalPlayer() == p then
        if GetPlayerId(p) < 10 then
            call DzSyncData("GMY", "0" + I2S(player_num) + R2S(DzGetMouseTerrainY()))
        else
            call DzSyncData("GMY", I2S(player_num) + R2S(DzGetMouseTerrainY()))
        endif
    endif
endfunction

function Set_Mouse_X_Func takes nothing returns nothing
    local string sync_string = DzGetTriggerSyncData()
    local integer player_num = S2I( SubString(sync_string, 0, 2) )
    local real x = S2R( SubString( sync_string, 2, StringLength(sync_string) ) )
    
    set mouse_x[player_num] = x
endfunction

function Set_Mouse_X takes player p returns nothing
    local integer player_num = GetConvertedPlayerId(p)
    
    if GetLocalPlayer() == p then
        if GetPlayerId(p) < 10 then
            call DzSyncData("GMX", "0" + I2S(player_num) + R2S(DzGetMouseTerrainX()))
        else
            call DzSyncData("GMX", I2S(player_num) + R2S(DzGetMouseTerrainX()))
        endif
    endif
endfunction

function Init takes nothing returns nothing
    local trigger trg

    set trg = CreateTrigger()
    call DzTriggerRegisterSyncData( trg, "GMX", false )
    call TriggerAddAction( trg, function Set_Mouse_X_Func )
    
    set trg = CreateTrigger()
    call DzTriggerRegisterSyncData( trg, "GMY", false )
    call TriggerAddAction( trg, function Set_Mouse_Y_Func )
    
    set trg = null
endfunction

endlibrary