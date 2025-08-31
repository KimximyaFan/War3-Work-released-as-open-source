struct Hero
    // Property
    private real ad /* 공격력 */
    private real ap /* 주문력 */
    private real as /* 공격속도 */
    private real ms /* 이동속도 */
    private real crit /* 치확 */
    private real crit_coef /* 치피 */
    private real def_ad /* 물리 방어력 */
    private real def_ap /* 마법 방어력 */ 
    private real hp /* 체력 */
    private real mp /* 마나 */
    private real hp_regen /* 체력회복 */
    private real mp_regen /* 마나회복 */
    private real enhance_ad /* 물리 피해 강화 */
    private real enhance_ap /* 마법 피해 강화 */
    private real reduce_ad /* 물리 받피감 */
    private real reduce_ap /* 마법 받피감 */
    
    private boolean array wearing_exist[10]
    private boolean array inven_exist[25]
    
    private HeroWearing wearings
    private HeroInven inventory
    
    private integer pid
    
    // Behavior
    public static method create takes integer player_id returns thistype
        local integer i = -1
        local thistype this = thistype.allocate()
        
        loop
        set i = i + 1
        exitwhen i > 24
            set this.inven_exist[i] = false
        endloop
        
        set this.wearings = HeroWearing.create()
        set this.inventory = HeroInven.create()
        set this.pid = player_id
        return this
    endmethod
        
    method destroy takes nothing returns nothing
        call thistype.deallocate( this )
    endmethod
    
    public method Get_Player takes nothing returns integer
        return this.pid
    endmethod
    
    public method Get_AD takes nothing returns real
        return this.ad
    endmethod
    
    public method Get_AP takes nothing returns real
        return this.ap
    endmethod
    
    public method Get_AS takes nothing returns real
        return this.as
    endmethod
    
    public method Get_MS takes nothing returns real
        return this.ms
    endmethod
    
    public method Get_CRIT takes nothing returns real
        return this.crit
    endmethod
    
    public method Get_CRIT_COEF takes nothing returns real
        return this.crit_coef
    endmethod
    
    public method Get_DEF_AD takes nothing returns real
        return this.def_ad
    endmethod
    
    public method Get_DEF_AP takes nothing returns real
        return this.def_ap
    endmethod
    
    public method Get_HP takes nothing returns real
        return this.hp
    endmethod
    
    public method Get_MP takes nothing returns real
        return this.mp
    endmethod
    
    public method Get_HP_REGEN takes nothing returns real
        return this.hp_regen
    endmethod
    
    public method Get_MP_REGEN takes nothing returns real
        return this.mp_regen
    endmethod
    
    public method Get_ENHANCE_AD takes nothing returns real
        return this.enhance_ad
    endmethod
    
    public method Get_ENHANCE_AP takes nothing returns real
        return this.enhance_ap
    endmethod
    
    public method Get_REDUCE_AD takes nothing returns real
        return this.reduce_ad
    endmethod
    
    public method Get_REDUCE_AP takes nothing returns real
        return this.reduce_ap
    endmethod
    
    // ===================================================================
    
    public method Set_AD takes real a returns nothing
        set this.ad = a
    endmethod
    
    public method Set_AP takes real a returns nothing
        set this.ap = a
    endmethod
    
    public method Set_AS takes real a returns nothing
        set this.as = a
    endmethod
    
    public method Set_MS takes real a returns nothing
        set this.ms = a
    endmethod

    public method Set_CRIT takes real a returns nothing
        set this.crit = a
    endmethod
    
    public method Set_CRIT_COEF takes real a returns nothing
        set this.crit_coef = a
    endmethod
    
    public method Set_DEF_AD takes real a returns nothing
        set this.def_ad = a
    endmethod
    
    public method Set_DEF_AP takes real a returns nothing
        set this.def_ap = a
    endmethod
    
    public method Set_HP takes real a returns nothing
        set this.hp = a
    endmethod
    
    public method Set_MP takes real a returns nothing
        set this.mp = a
    endmethod
    
    public method Set_HP_REGEN takes real a returns nothing
        set this.hp_regen = a
    endmethod
    
    public method Set_MP_REGEN takes real a returns nothing
        set this.mp_regen = a
    endmethod

    public method Set_ENHANCE_AD takes real a returns nothing
        set this.enhance_ad = a
    endmethod
    
    public method Set_ENHANCE_AP takes real a returns nothing
        set this.enhance_ap = a
    endmethod
    
    public method Set_REDUCE_AD takes real a returns nothing
        set this.reduce_ad = a
    endmethod
    
    public method Set_REDUCE_AP takes real a returns nothing
        set this.reduce_ap = a
    endmethod
    
    // ====================================================================
    
    private method Item_Unequiped takes Equip E returns nothing
        if E.Get_AD() != 0 then
            set this.ad = this.ad - E.Get_AD()
        endif
        if E.Get_AP() != 0 then
            set this.ap = this.ap - E.Get_AP()
        endif
        if E.Get_AS() != 0 then
            set this.as = this.as - E.Get_AS()
        endif
        if E.Get_MS() != 0 then
            set this.ms = this.ms - E.Get_MS()
        endif
        if E.Get_CRIT() != 0 then
            set this.crit = this.crit - E.Get_CRIT()
        endif
        if E.Get_CRIT_COEF() != 0 then
            set this.crit_coef = this.crit_coef - E.Get_CRIT_COEF()
        endif
        if E.Get_DEF_AD() != 0 then
            set this.def_ad = this.def_ad - E.Get_DEF_AD()
        endif
        if E.Get_DEF_AP() != 0 then
            set this.def_ap = this.def_ap - E.Get_DEF_AP()
        endif
        if E.Get_HP() != 0 then
            set this.hp = this.hp - E.Get_HP()
        endif
        if E.Get_MP() != 0 then
            set this.mp = this.mp - E.Get_MP()
        endif
        if E.Get_HP_REGEN() != 0 then
            set this.hp_regen = this.hp_regen - E.Get_HP_REGEN()
        endif
        if E.Get_MP_REGEN() != 0 then
            set this.mp_regen = this.mp_regen - E.Get_MP_REGEN()
        endif
        if E.Get_ENHANCE_AD() != 0 then
            set this.enhance_ad = this.enhance_ad - E.Get_ENHANCE_AD()
        endif
        if E.Get_ENHANCE_AP() != 0 then
            set this.enhance_ap = this.enhance_ap - E.Get_ENHANCE_AP()
        endif
        if E.Get_REDUCE_AD() != 0 then
            set this.reduce_ad = this.reduce_ad - E.Get_REDUCE_AD()
        endif
        if E.Get_REDUCE_AP() != 0 then
            set this.reduce_ap = this.reduce_ap - E.Get_REDUCE_AP()
        endif
    endmethod
    
    private method Item_Equiped takes Equip E returns nothing
        if E.Get_AD() != 0 then
            set this.ad = this.ad + E.Get_AD()
        endif
        if E.Get_AP() != 0 then
            set this.ap = this.ap + E.Get_AP()
        endif
        if E.Get_AS() != 0 then
            set this.as = this.as + E.Get_AS()
        endif
        if E.Get_MS() != 0 then
            set this.ms = this.ms + E.Get_MS()
        endif
        if E.Get_CRIT() != 0 then
            set this.crit = this.crit + E.Get_CRIT()
        endif
        if E.Get_CRIT_COEF() != 0 then
            set this.crit_coef = this.crit_coef + E.Get_CRIT_COEF()
        endif
        if E.Get_DEF_AD() != 0 then
            set this.def_ad = this.def_ad + E.Get_DEF_AD()
        endif
        if E.Get_DEF_AP() != 0 then
            set this.def_ap = this.def_ap + E.Get_DEF_AP()
        endif
        if E.Get_HP() != 0 then
            set this.hp = this.hp + E.Get_HP()
        endif
        if E.Get_MP() != 0 then
            set this.mp = this.mp + E.Get_MP()
        endif
        if E.Get_HP_REGEN() != 0 then
            set this.hp_regen = this.hp_regen + E.Get_HP_REGEN()
        endif
        if E.Get_MP_REGEN() != 0 then
            set this.mp_regen = this.mp_regen + E.Get_MP_REGEN()
        endif
        if E.Get_ENHANCE_AD() != 0 then
            set this.enhance_ad = this.enhance_ad + E.Get_ENHANCE_AD()
        endif
        if E.Get_ENHANCE_AP() != 0 then
            set this.enhance_ap = this.enhance_ap + E.Get_ENHANCE_AP()
        endif
        if E.Get_REDUCE_AD() != 0 then
            set this.reduce_ad = this.reduce_ad + E.Get_REDUCE_AD()
        endif
        if E.Get_REDUCE_AP() != 0 then
            set this.reduce_ap = this.reduce_ap + E.Get_REDUCE_AP()
        endif
    endmethod
    
    public method Type_To_Index takes string item_type returns integer
        local integer index = -1
        
        if item_type == "투구" then
            set index = 0
        elseif item_type == "목걸이" then
            set index = 1
        elseif item_type == "무기" then
            set index = 2
        elseif item_type == "갑옷" then
            set index = 3
        elseif item_type == "방패" then
            set index = 4
        elseif item_type == "반지" then
            if this.wearing_exist[5] == false then
                set index = 5
            else 
                set index = 7
            endif
        elseif item_type == "벨트" then
            set index = 6
        elseif item_type == "장갑" then
            set index = 8
        elseif item_type == "부츠" then
            set index = 9
        endif
        
        return index
    endmethod

    public method Check_Wearing takes string item_type returns integer
        local integer find_index = -1
        
        if item_type == "투구" then
            if this.wearing_exist[0] == false then
                set find_index = 0
            endif
        elseif item_type == "목걸이" then
            if this.wearing_exist[1] == false then
                set find_index = 1
            endif
        elseif item_type == "무기" then
            if this.wearing_exist[2] == false then
                set find_index = 2
            endif
        elseif item_type == "갑옷" then
            if this.wearing_exist[3] == false then
                set find_index = 3
            endif
        elseif item_type == "방패" then
            if this.wearing_exist[4] == false then
                set find_index = 4
            endif
        elseif item_type == "반지" then
            if this.wearing_exist[5] == false then
                set find_index = 5
            elseif this.wearing_exist[7] == false then
                set find_index = 7
            endif
        elseif item_type == "벨트" then
            if this.wearing_exist[6] == false then
                set find_index = 6
            endif
        elseif item_type == "장갑" then
            if this.wearing_exist[8] == false then
                set find_index = 8
            endif
        elseif item_type == "부츠" then
            if this.wearing_exist[9] == false then
                set find_index = 9
            endif
        endif
        
        return find_index
    endmethod
    
    public method Get_Inven_Item takes integer i returns Equip
        return this.inventory.Get_Inven_Equip(i)
    endmethod
    
    public method Get_Wearing_Item takes integer i returns Equip
        return this.wearings.Get_Wearing_Equip(i)
    endmethod
    
    public method Set_Inven_Item takes integer i, Equip E returns nothing
        set this.inven_exist[i] = true
        call this.inventory.Set_Inven_Equip(i, E)
    endmethod
    
    public method Set_Wearing_Item takes integer i, Equip E returns nothing
        set this.wearing_exist[i] = true
        call this.wearings.Set_Wearing_Equip(i, E)
        call this.Item_Equiped(E)
    endmethod
    
    public method Remove_Inven_Item takes integer i returns nothing
        set this.inven_exist[i] = false
    endmethod
    
    public method Remove_Wearing_Item takes integer i returns nothing
        set this.wearing_exist[i] = false
        call this.Item_Unequiped(this.Get_Wearing_Item(i))
    endmethod

    public method Delete_Inven_Item takes integer i returns nothing
        set this.inven_exist[i] = false
        call this.inventory.Get_Inven_Equip(i).destroy()
        call this.inventory.Set_Inven_Equip(i, 0)
    endmethod
    
    public method Check_Inven_Item takes integer i returns boolean
        return this.inven_exist[i]
    endmethod
    
    // 가능한 공간이 없으면 -1을 반환
    public method Check_Inven_Possible takes nothing returns integer
        local integer i
        local integer find_index
        local boolean isFind = false
        
        set i = -1
        loop
        set i = i + 1
        exitwhen i > 24 or isFind == true
            if this.inven_exist[i] == false then
                set isFind = true
                set find_index = i
            endif
        endloop
        
        if isFind == true then
            return find_index
        else
            return -1
        endif
    endmethod

endstruct