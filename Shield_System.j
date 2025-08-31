struct Shield
    
    /*
        #구현 포인트#
        
        유닛
        지속시간
        쉴드량
        텍스트태그와 쉴드 총량
        쉴드총량 갱신 
        지속시간 끝날 시 쉴드 파괴
        쉴드 소모시 기왕이면 remaining time 제일 낮은 쉴드
        데미지 시스템 연계
        쉴드 이펙트, 부착포인트
    */
    
    // ======================================
    // 여기 변수들은 커스텀 가능
    // ======================================
    private static real shield_texttag_x = 30 /* 실드량 텍스트태그 x 위치 */
    private static real shield_texttag_y = 15 /* 실드량 텍스트태그 y 위치 */
    private static real texttag_size = 6.5    /* 실드량 텍스트태그 크기 */
    private static integer texttag_r = 200    /* 실드량 텍스트태그 색 RGB 에서 R */
    private static integer texttag_g = 200    /* 실드량 텍스트태그 색 RGB 에서 G */
    private static integer texttag_b = 255    /* 실드량 텍스트태그 색 RGB 에서 B */
    private static real timer_interval = 0.02 /* 갱신 주기 */
    // =======================================
    
    private static constant hashtable HT = InitHashtable()
    private static constant integer SHIELD_SYSTEM = 0
    
    private unit u
    private real duration
    private real remaining_time
    private real shield_value
    private texttag text_tag
    private effect e
    private string eff
    private string attach_point
    private Shield before_shield
    private Shield next_shield
    private boolean is_broken
    
    // =======================================================
    // Private
    // =======================================================
    
    private static method create takes nothing returns thistype
        local thistype this = thistype.allocate()
        return this
    endmethod
    
    private method destroy takes nothing returns nothing
        if before_shield != -1 then
            set before_shield.next_shield = next_shield
        endif
        
        if next_shield != -1 then
            set next_shield.before_shield = before_shield
        endif
        
        if Is_Shield_Root(u, this) == true then
            call End_Text_Tag()
            call End_Effect()
            
            if next_shield == -1 then
                call Remove_Root_Shield(u)
            else
                call Set_Root_Shield(u, next_shield)
                call next_shield.Start_Text_Tag()
                call next_shield.Start_Effect()
            endif
        endif
        
        set u = null
        set e = null
        set eff = null
        set attach_point = null
        set text_tag = null
        set before_shield = -1
        set next_shield = -1
        call thistype.deallocate( this )
    endmethod
    
    private static method Set_Root_Shield takes unit u, integer shield returns nothing
        call SaveInteger(HT, GetHandleId(u), SHIELD_SYSTEM, shield)
    endmethod
    
    private static method Get_Root_Shield takes unit u returns integer
        return LoadInteger(HT, GetHandleId(u), SHIELD_SYSTEM)
    endmethod
    
    private static method Remove_Root_Shield takes unit u returns nothing
        call RemoveSavedInteger(HT, GetHandleId(u), SHIELD_SYSTEM)
    endmethod
    
    private static method Is_Root_Shield_Exist takes unit u returns boolean
        return HaveSavedInteger(HT, GetHandleId(u), SHIELD_SYSTEM)
    endmethod
    
    private static method Is_Shield_Root takes unit u, integer shield returns boolean
        return shield == Get_Root_Shield(u)
    endmethod
    
    private static method Timer_Clear takes timer t returns nothing
        call FlushChildHashtable(HT, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endmethod
    
    private method Text_Tag_Refresh takes nothing returns nothing
        if text_tag == null then
            return
        endif

        call SetTextTagText(text_tag, R2S(Get_Total_Shield_Value()), TextTagSize2Height(texttag_size))
        call SetTextTagPos(text_tag, GetUnitX(u) + shield_texttag_x, GetUnitY(u), shield_texttag_y)
    endmethod

    private method Start_Text_Tag takes nothing returns nothing
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        
        set text_tag = CreateTextTag()
        call SetTextTagText(text_tag, R2S(Get_Total_Shield_Value()), TextTagSize2Height(texttag_size))
        call SetTextTagPos(text_tag, x + shield_texttag_x, y, shield_texttag_y)
        call SetTextTagColor(text_tag, texttag_r, texttag_g, texttag_b, 255)
        call SetTextTagPermanent(text_tag, true)
    endmethod
    
    private method End_Text_Tag takes nothing returns nothing
        call DestroyTextTag(text_tag)
        set text_tag = null
    endmethod
    
    private method Start_Effect takes nothing returns nothing
        set e = AddSpecialEffectTarget(eff, u, attach_point)
    endmethod
    
    private method End_Effect takes nothing returns nothing
        call DestroyEffect(e)
    endmethod
    
    private method Shield_Broken takes nothing returns nothing
        set is_broken = true
    endmethod

    private method Get_Total_Shield_Value takes nothing returns real
        local Shield root_shield = Get_Root_Shield(u)
        local Shield current_shield = root_shield
        local real total_shield_value = 0.0
        
        loop
        exitwhen current_shield == -1
            if current_shield.is_broken == false then
                set total_shield_value = total_shield_value + current_shield.shield_value
            endif
            set current_shield = current_shield.next_shield
        endloop
        
        return total_shield_value
    endmethod
    
    private method Get_Min_Remaining_Time_Shield takes nothing returns Shield
        local Shield root_shield = Get_Root_Shield(u)
        local Shield current_shield = root_shield
        local Shield min_remaining_time_shield = -1
        local real min_remaining_time = 1000000.0

        loop
        exitwhen current_shield == -1
            if current_shield.remaining_time < min_remaining_time and current_shield.is_broken == false then
                set min_remaining_time_shield = current_shield
            endif
            
            set current_shield = current_shield.next_shield
        endloop
        
        return min_remaining_time_shield
    endmethod
    
    private method Shield_Damage_Process takes real dmg returns real
        local Shield current_shield
        
        loop
        set current_shield = Get_Min_Remaining_Time_Shield()
        exitwhen dmg <= 0.0 or current_shield == -1
            if dmg >= current_shield.shield_value then
                set dmg = dmg - current_shield.shield_value
                set current_shield.shield_value = 0.0
                call current_shield.Shield_Broken()
            else
                set current_shield.shield_value = current_shield.shield_value - dmg
                set dmg = 0.0
            endif
        endloop

        return dmg
    endmethod
    
    private static method Shield_State_Check takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)
        local Shield current_shield = LoadInteger(HT, id, 0)
        
        set current_shield.remaining_time = current_shield.remaining_time - timer_interval
        
        call current_shield.Text_Tag_Refresh()
        
        if current_shield.remaining_time <= 0.0 then
            set current_shield.is_broken = true
        endif
        
        if current_shield.is_broken == true then
            call Timer_Clear(t)
            call current_shield.destroy()
        else
            call TimerStart(t, timer_interval, false, function Shield.Shield_State_Check)
        endif
        
        set t = null
    endmethod
    
    private method Apply_Shield takes nothing returns nothing
        local timer t = CreateTimer()
        local integer id = GetHandleId(t)
        local Shield current_shield = this
        
        call current_shield.Start_Text_Tag()
        call current_shield.Start_Effect()
        
        call SaveInteger(HT, id, 0, current_shield)
        call TimerStart(t, timer_interval, false, function Shield.Shield_State_Check)
        
        set t = null
    endmethod
    
    // ==================================
    // Public
    // ==================================
    
    public static method Damage_Occured takes unit u, real dmg returns real
        local Shield root_shield
        local real remaining_dmg
        
        if Is_Root_Shield_Exist(u) == false then
            return dmg
        endif
        
        set root_shield = Get_Root_Shield(u)
        set remaining_dmg = root_shield.Shield_Damage_Process(dmg)
        return remaining_dmg
    endmethod
    
    public static method Register_Shield takes unit u, real duration, real shield_value, string eff, string attach_point returns nothing
        local Shield current_shield = thistype.create()
        local Shield root_shield
        
        if shield_value <= 0.0 then
            set shield_value = 0.1
        endif
        
        set current_shield.u = u
        set current_shield.duration = duration
        set current_shield.remaining_time = duration
        set current_shield.shield_value = shield_value
        set current_shield.eff = eff
        set current_shield.attach_point = attach_point
        set current_shield.before_shield = -1
        set current_shield.next_shield = -1
        set current_shield.is_broken = false
        
        if Is_Root_Shield_Exist(u) == true then
            set root_shield = Get_Root_Shield(u)
            set current_shield.next_shield = root_shield
            set root_shield.before_shield = current_shield
            call root_shield.End_Text_Tag()
            call root_shield.End_Effect()
        endif
        
        call Set_Root_Shield(u, current_shield)
        
        call current_shield.Apply_Shield()
    endmethod
endstruct


library ShieldSystem

// ==================================
// API
// ==================================

// target에게 duration 시간동안 shield_value 만큼 쉴드 주고 attach_point에 eff를 붙힘
function Unit_Add_Shield takes unit target, real duration, real shield_value, string eff, string attach_point returns nothing
    call Shield.Register_Shield(target, duration, shield_value, eff, attach_point)
endfunction

// u의 아군에게 x, y 위치에서 size 범위의 그룹을 잡은다음 duration 시간동안 shield_value 만큼 쉴드 주고 attach_point에 eff를 붙힘
function Unit_Add_Shield_Area takes unit u, real x, real y, real size, real duration, real shield_value, string eff, string attach_point returns nothing
    local group g = CreateGroup()
    local unit c = null
    
    call GroupEnumUnitsInRange(g, x, y, size, null)
    loop
    set c = FirstOfGroup(g) 
    exitwhen c == null
        call GroupRemoveUnit(g, c)
        if IsUnitAliveBJ(c) == true and IsPlayerAlly(GetOwningPlayer(c), GetOwningPlayer(u)) == true then
            call Shield.Register_Shield(c, duration, shield_value, eff, attach_point)
        endif
    endloop

    call GroupClear(g)
    call DestroyGroup(g)
    set g = null
    set c = null
endfunction

endlibrary