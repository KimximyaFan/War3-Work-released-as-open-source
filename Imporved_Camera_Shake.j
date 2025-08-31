library ND

globals
    integer array ND_Size
    integer array ND_ID
endglobals

function ND_Find takes player p, integer max returns real
    local integer i = 0
    local real degree = 0
    local real temp = 0
    
    loop
    set i = i + 1
    exitwhen i > max
        // 당신의 맵이 해시테이블에서 부모 키값으로 플레이어 핸들을 쓰고
        // 자식 키값 1000번 대를 쓴다면, 여기 아래 1000을 수정하세요
        set temp = LoadRealBJ(1000 + i, GetHandleId(p), bj_lastCreatedHashtable)

        if temp > degree then
            set degree = temp
        endif
    endloop

    return degree
endfunction

function ND_Func takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer id = GetHandleId(t)
    local player p = LoadPlayerHandleBJ(0, id, bj_lastCreatedHashtable)
    local integer current_ID = LoadIntegerBJ(1, id, bj_lastCreatedHashtable)
    local integer n = GetConvertedPlayerId(p)
    
    set ND_Size[n] = ND_Size[n] - 1
    
    if ND_Size[n] == 0 then
        call CameraClearNoiseForPlayer( p )
        set ND_ID[n] = 0
    else
        // 당신의 맵이 해시테이블에서 부모 키값으로 플레이어 핸들을 쓰고
        // 자식 키값 1000번 대를 쓴다면, 여기 아래 1000을 수정하세요
        call SaveRealBJ(0, 1000 + current_ID, GetHandleId(p), bj_lastCreatedHashtable)
        call CameraSetEQNoiseForPlayer( p, ND_Find(p, ND_ID[n]) )
    endif
    
    call FlushChildHashtableBJ(id, bj_lastCreatedHashtable)
    call DestroyTimer(t)

    set p = null
    set t = null
endfunction

function ND takes player p, real time, real degree returns nothing
    local timer t = CreateTimer()
    local integer id = GetHandleId(t)
    local integer n = GetConvertedPlayerId(p)
    
    set ND_Size[n] = ND_Size[n] + 1
    set ND_ID[n] = ND_ID[n] + 1
    
    // 당신의 맵이 해시테이블에서 부모 키값으로 플레이어 핸들을 쓰고
    // 자식 키값 1000번 대를 쓴다면, 여기 아래 1000을 수정하세요
    call SaveRealBJ(degree, 1000 + ND_ID[n], GetHandleId(p), bj_lastCreatedHashtable)

    call SavePlayerHandleBJ(p, 0, id, bj_lastCreatedHashtable)
    call SaveIntegerBJ(ND_ID[n], 1, id, bj_lastCreatedHashtable)
    
    // 0.0001은 부동소수점 이슈 보정입니다
    if degree + 0.0001 >= ND_Find(p, ND_ID[n]) then
        call CameraSetEQNoiseForPlayer( p, degree )
    endif
    
    call TimerStart(t, time, false, function ND_Func)
    
    set t = null
endfunction

endlibrary