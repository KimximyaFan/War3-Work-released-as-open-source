struct Equip

    // Property
    private integer grade /* 등급 */
    private integer ad /* 0 공격력 */
    private integer ap /* 1 주문력 */
    private integer as /* 2 공격속도 */
    private integer ms /* 3 이동속도 */
    private integer crit /* 4 치확 */
    private integer crit_coef /* 5 치피 */
    private integer def_ad /* 6 물리 방어력 */
    private integer def_ap /* 7 마법 방어력 */ 
    private integer hp /* 8 체력 */
    private integer mp /* 9 마나 */
    private integer hp_regen /* 10 체력회복 */
    private integer mp_regen /* 11 마나회복 */
    private integer enhance_ad /* 12 물리 피해 강화 */
    private integer enhance_ap /* 13 마법 피해 강화 */
    private integer reduce_ad /* 14 물리 받피감 */
    private integer reduce_ap /* 15 마법 받피감 */
    
    private string item_name /* 아이템 이름 */
    private string item_type /* 아이템 타입 */
    private string item_img /* 아이템 이미지 */
    
    private integer array ran_arr[16]

    
    /*
        등급 목록
        grade 0 : 일반
        grade 1 : 희귀
        grade 2 : 영웅
        grade 3 : 전설
        grade 4 : 신화
    */
    
    
    /*
        랜덤 스탯 목록
        
        헬멧 : 0 1 2 4 5 7 8 9 10 11 
        무기 : 2 4 5 6 7 8 9 10 11
        갑옷 : 4 5 6 7 9 10 11 14 15
        방패 : 4 5 7 8 9 10 11 14 15
        목걸이 : 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
        반지 : 0 1 2 3 4 5 6 8 7 9 10 11 12 13 14 15
        벨트 : 0 1 2 3 4 5 7 8 9 10 11
        장갑 : 0 1 3 4 5 6 8 7 9 10 11
        부츠 : 0 1 2 4 5 6 8 7 9 10 11
    
    */
    
    /*
        장비 타입 목록
        
        헬멧
        무기
        갑옷
        방패
        목걸이
        반지
        벨트
        장갑
        부츠
    */

    private method Ran_Array_Shuffle takes integer size returns nothing
        local integer i
        local integer ran
        local integer temp
        
        set i = -1
        loop
        set i = i + 1
        exitwhen i >= size
            set ran = GetRandomInt(i, size-1)
            set temp = this.ran_arr[ran]
            set this.ran_arr[ran] = this.ran_arr[i]
            set this.ran_arr[i] = temp
        endloop
    endmethod
    
    private method Set_Random_Property takes integer num returns nothing
        if num == 0 then
            set this.ad = GetRandomInt(1, 10)
        elseif num == 1 then
            set this.ap = GetRandomInt(1, 10)
        elseif num == 2 then
            set this.as = GetRandomInt(1, 10)
        elseif num == 3 then
            set this.ms = GetRandomInt(1, 10)
        elseif num == 4 then
            set this.crit = GetRandomInt(1, 10)
        elseif num == 5 then
            set this.crit_coef = GetRandomInt(1, 10)
        elseif num == 6 then
            set this.def_ad = GetRandomInt(1, 10)
        elseif num == 7 then
            set this.def_ap = GetRandomInt(1, 10)
        elseif num == 8 then
            set this.hp = GetRandomInt(50, 100)
        elseif num == 9 then
            set this.mp = GetRandomInt(50, 100)
        elseif num == 10 then
            set this.hp_regen = GetRandomInt(1, 10)
        elseif num == 11 then
            set this.mp_regen = GetRandomInt(1, 10)
        elseif num == 12 then
            set this.enhance_ad = GetRandomInt(1, 5)
        elseif num == 13 then
            set this.enhance_ap = GetRandomInt(1, 5)
        elseif num == 14 then
            set this.reduce_ad = GetRandomInt(1, 5)
        elseif num == 15 then
            set this.reduce_ap = GetRandomInt(1, 5)
        endif
    endmethod
    
    // Behavior
    private method Ran_Grade takes nothing returns nothing
        local integer ran = GetRandomInt(1, 100)
        
        if ran <= 30 then
            set this.grade = 0
        elseif ran <= 50 then
            set this.grade = 1
        elseif ran <= 70 then
            set this.grade = 2
        elseif ran <= 90 then
            set this.grade = 3
        elseif ran <= 100 then
            set this.grade = 4
        endif
    endmethod

    private method Property_Setting takes nothing returns nothing
        if this.grade >= 1 then
            call this.Set_Random_Property( this.ran_arr[0] )
        endif
        if this.grade >= 2 then
            call this.Set_Random_Property( this.ran_arr[1] )
        endif
        if this.grade >= 3 then
            call this.Set_Random_Property( this.ran_arr[2] )
        endif
        if this.grade >= 4 then
            call this.Set_Random_Property( this.ran_arr[3] )
        endif
    endmethod
    
    private method Ran_Helmet takes nothing returns nothing
        local integer size = 10

        set this.item_type = "투구"
        set this.def_ad = GetRandomInt(1, 10)
        
        if this.grade == 0 then
            set this.item_name = "병신 마스크"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSobiMask.blp"
        elseif this.grade == 1 then
            set this.item_name = "부두 마스크"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNHelmOfValor.blp"
        elseif this.grade == 2 then
            set this.item_name = "히어로 헬름"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNHelmutPurple.blp"
        elseif this.grade == 3 then
            set this.item_name = "데스 마스크"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNMaskOfDeath.blp"
        elseif this.grade == 4 then
            set this.item_name = "데스로드 헬름"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNRevenant.blp"
        endif
        
        set this.ran_arr[0] = 0
        set this.ran_arr[1] = 1
        set this.ran_arr[2] = 2
        set this.ran_arr[3] = 4
        set this.ran_arr[4] = 5
        set this.ran_arr[5] = 7
        set this.ran_arr[6] = 8
        set this.ran_arr[7] = 9
        set this.ran_arr[8] = 10
        set this.ran_arr[9] = 11
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Weapon takes nothing returns nothing
        local integer size = 9
        local integer ran = GetRandomInt(1, 2)
        
        set this.item_type = "무기"
        
        if ran == 1 then
            set this.ad = GetRandomInt(1, 10)
            
            if this.grade == 0 then
                set this.item_name = "병신 검"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp" 
            elseif this.grade == 1 then
                set this.item_name = "푸른 검"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNThoriumMelee.blp" 
            elseif this.grade == 2 then
                set this.item_name = "푸른 대검"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNThoriumRanged.blp"
            elseif this.grade == 3 then
                set this.item_name = "불의 검"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNArcaniteMelee.blp"
            elseif this.grade == 4 then
                set this.item_name = "불의 대검"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNArcaniteRanged.blp"
            endif
        else
            set this.ap = GetRandomInt(1, 10)
            
            if this.grade == 0 then
                set this.item_name = "병신 완드"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNStarWand.blp" 
            elseif this.grade == 1 then
                set this.item_name = "주술 지팡이"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNWandSkull.blp" 
            elseif this.grade == 2 then
                set this.item_name = "푸른 완드"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNWandOfManaSteal.blp"
            elseif this.grade == 3 then
                set this.item_name = "현자의 지팡이"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNAdvancedStrengthOfTheMoon.blp"
            elseif this.grade == 4 then
                set this.item_name = "달의 지팡이"
                set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNStaffOfNegation.blp"
            endif
        endif

        set this.ran_arr[0] = 2
        set this.ran_arr[1] = 4
        set this.ran_arr[2] = 5
        set this.ran_arr[3] = 6
        set this.ran_arr[4] = 7
        set this.ran_arr[5] = 8
        set this.ran_arr[6] = 9
        set this.ran_arr[7] = 10
        set this.ran_arr[8] = 11
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Armor takes nothing returns nothing
        local integer size = 9

        set this.item_type = "갑옷"
        set this.hp = GetRandomInt(50, 100)
        
        if this.grade == 0 then
            set this.item_name = "병신 갑옷"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeTwo.blp"
        elseif this.grade == 1 then
            set this.item_name = "가죽 갑옷"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNLeatherUpgradeOne.blp"
        elseif this.grade == 2 then
            set this.item_name = "철 갑옷"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNMoonArmor.blp"
        elseif this.grade == 3 then
            set this.item_name = "판금 갑옷"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNImprovedMoonArmor.blp"
        elseif this.grade == 4 then
            set this.item_name = "달의 갑옷"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNAdvancedMoonArmor.blp"
        endif

        set this.ran_arr[0] = 4
        set this.ran_arr[1] = 5
        set this.ran_arr[2] = 6
        set this.ran_arr[3] = 7
        set this.ran_arr[4] = 9
        set this.ran_arr[5] = 10
        set this.ran_arr[6] = 11
        set this.ran_arr[7] = 14
        set this.ran_arr[8] = 15
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Shield takes nothing returns nothing
        local integer size = 9

        set this.item_type = "방패"
        set this.def_ad = GetRandomInt(1, 10)
        
        if this.grade == 0 then
            set this.item_name = "병신 방패"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSteelArmor.blp"
        elseif this.grade == 1 then
            set this.item_name = "철 방패"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpOne.blp"
        elseif this.grade == 2 then
            set this.item_name = "강철 방패"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpTwo.blp"
        elseif this.grade == 3 then
            set this.item_name = "불의 방패"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpThree.blp"
        elseif this.grade == 4 then
            set this.item_name = "죽음의 방패"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyArmor.blp"
        endif

        set this.ran_arr[0] = 4
        set this.ran_arr[1] = 5
        set this.ran_arr[2] = 7
        set this.ran_arr[3] = 8
        set this.ran_arr[4] = 9
        set this.ran_arr[5] = 10
        set this.ran_arr[6] = 11
        set this.ran_arr[7] = 14
        set this.ran_arr[8] = 15
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Necklace takes nothing returns nothing
        local integer size = 16
        local integer i 

        set this.item_type = "목걸이"
        
        if this.grade == 0 then
            set this.item_name = "병신 목걸이"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNNecklace.blp"
        elseif this.grade == 1 then
            set this.item_name = "용기의 메달"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNMedalionOfCourage.blp"
        elseif this.grade == 2 then
            set this.item_name = "마법의 아뮬렛"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSpellShieldAmulet.blp"
        elseif this.grade == 3 then
            set this.item_name = "금의 아뮬렛"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNAmulet.blp"
        elseif this.grade == 4 then
            set this.item_name = "달의 아뮬렛"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNTalisman.blp"
        endif
        
        set i = -1
        loop
        set i = i + 1
        exitwhen i > 15
            set this.ran_arr[i] = i
        endloop
        call Ran_Array_Shuffle(size)
        call Property_Setting()
        call Set_Random_Property( this.ran_arr[4] )
    endmethod

    private method Ran_Ring takes nothing returns nothing
        local integer size = 16
        local integer i 

        set this.item_type = "반지"
        
        if this.grade == 0 then
            set this.item_name = "병신 반지"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNRingVioletSpider.blp"
        elseif this.grade == 1 then
            set this.item_name = "초록 반지"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNCirclet.blp"
        elseif this.grade == 2 then
            set this.item_name = "동 반지"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNRingLionHead.blp"
        elseif this.grade == 3 then
            set this.item_name = "은 반지"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNRingSkull.blp"
        elseif this.grade == 4 then
            set this.item_name = "황금 반지"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNGoldRing.blp"
        endif
        
        set i = -1
        loop
        set i = i + 1
        exitwhen i > 15
            set this.ran_arr[i] = i
        endloop
        call Ran_Array_Shuffle(size)
        call Property_Setting()
        call Set_Random_Property( this.ran_arr[4] )
    endmethod

    private method Ran_Belt takes nothing returns nothing
        local integer size = 11

        set this.item_type = "벨트"
        set this.def_ad = GetRandomInt(1, 10)
        
        if this.grade == 0 then
            set this.item_name = "병신 " + this.item_type
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBelt.blp"
        elseif this.grade == 1 then
            set this.item_name = "구린 " + this.item_type
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBelt.blp"
        elseif this.grade == 2 then
            set this.item_name = "그냥 " + this.item_type
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBelt.blp"
        elseif this.grade == 3 then
            set this.item_name = "좋은 " + this.item_type
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBelt.blp"
        elseif this.grade == 4 then
            set this.item_name = "짱좋은 " + this.item_type
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBelt.blp"
        endif

        set this.ran_arr[0] = 0
        set this.ran_arr[1] = 1
        set this.ran_arr[2] = 2
        set this.ran_arr[3] = 3
        set this.ran_arr[4] = 4
        set this.ran_arr[5] = 5
        set this.ran_arr[6] = 7
        set this.ran_arr[7] = 8
        set this.ran_arr[8] = 9
        set this.ran_arr[9] = 10
        set this.ran_arr[10] = 11
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Glove takes nothing returns nothing
        local integer size = 11

        set this.item_type = "장갑"
        set this.as = GetRandomInt(1, 10)
        
        if this.grade == 0 then
            set this.item_name = "병신 장갑"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNUnholyStrength.blp"
        elseif this.grade == 1 then
            set this.item_name = "평범한 장갑"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNGlove.blp"
        elseif this.grade == 2 then
            set this.item_name = "마법의 장갑"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSpellSteal.blp"
        elseif this.grade == 3 then
            set this.item_name = "강력한 건틀릿"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower.blp"
        elseif this.grade == 4 then
            set this.item_name = "불의 건틀릿"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNAdvancedUnholyStrength.blp"
        endif

        set this.ran_arr[0] = 0
        set this.ran_arr[1] = 1
        set this.ran_arr[2] = 3
        set this.ran_arr[3] = 4
        set this.ran_arr[4] = 5
        set this.ran_arr[5] = 6
        set this.ran_arr[6] = 7
        set this.ran_arr[7] = 8
        set this.ran_arr[8] = 9
        set this.ran_arr[9] = 10
        set this.ran_arr[10] = 11
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Boots takes nothing returns nothing
        local integer size = 11

        set this.item_type = "부츠"
        set this.ms = GetRandomInt(1, 10)
        
        if this.grade == 0 then
            set this.item_name = "병신 부츠"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility.blp"
        elseif this.grade == 1 then
            set this.item_name = "속도 부츠"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"
        elseif this.grade == 2 then
            set this.item_name = "향상된 부츠"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed.blp"
        elseif this.grade == 3 then
            set this.item_name = "좋은 부츠"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBoots.blp"
        elseif this.grade == 4 then
            set this.item_name = "짱좋은 부츠"
            set this.item_img = "ReplaceableTextures\\CommandButtons\\BTNBoots.blp"
        endif

        set this.ran_arr[0] = 0
        set this.ran_arr[1] = 1
        set this.ran_arr[2] = 2
        set this.ran_arr[3] = 4
        set this.ran_arr[4] = 5
        set this.ran_arr[5] = 6
        set this.ran_arr[6] = 7
        set this.ran_arr[7] = 8
        set this.ran_arr[8] = 9
        set this.ran_arr[9] = 10
        set this.ran_arr[10] = 11
        call Ran_Array_Shuffle(size)
        call Property_Setting()
    endmethod

    private method Ran_Equip_Init takes nothing returns nothing
        local integer ran = GetRandomInt(1, 9)
        
        call this.Ran_Grade()
        
        if ran == 1 then
            call this.Ran_Helmet()
        elseif ran == 2 then
            call this.Ran_Weapon()
        elseif ran == 3 then
            call this.Ran_Armor()
        elseif ran == 4 then
            call this.Ran_Shield()
        elseif ran == 5 then
            call this.Ran_Necklace()
        elseif ran == 6 then
            call this.Ran_Ring()
        elseif ran == 7 then
            call this.Ran_Belt()
        elseif ran == 8 then
            call this.Ran_Glove()
        elseif ran == 9 then
            call this.Ran_Boots()
        endif
    endmethod
    
    public method Get_AD takes nothing returns integer
        return this.ad
    endmethod
    
    public method Get_AP takes nothing returns integer
        return this.ap
    endmethod
    
    public method Get_AS takes nothing returns integer
        return this.as
    endmethod
    
    public method Get_MS takes nothing returns integer
        return this.ms
    endmethod
    
    public method Get_CRIT takes nothing returns integer
        return this.crit
    endmethod
    
    public method Get_CRIT_COEF takes nothing returns integer
        return this.crit_coef
    endmethod
    
    public method Get_DEF_AD takes nothing returns integer
        return this.def_ad
    endmethod
    
    public method Get_DEF_AP takes nothing returns integer
        return this.def_ap
    endmethod
    
    public method Get_HP takes nothing returns integer
        return this.hp
    endmethod
    
    public method Get_MP takes nothing returns integer
        return this.mp
    endmethod
    
    public method Get_HP_REGEN takes nothing returns integer
        return this.hp_regen
    endmethod
    
    public method Get_MP_REGEN takes nothing returns integer
        return this.mp_regen
    endmethod
    
    public method Get_ENHANCE_AD takes nothing returns integer
        return this.enhance_ad
    endmethod
    
    public method Get_ENHANCE_AP takes nothing returns integer
        return this.enhance_ap
    endmethod
    
    public method Get_REDUCE_AD takes nothing returns integer
        return this.reduce_ad
    endmethod
    
    public method Get_REDUCE_AP takes nothing returns integer
        return this.reduce_ap
    endmethod
    
    // ===================================================================
    
    public method Set_AD takes integer a returns nothing
        set this.ad = a
    endmethod
    
    public method Set_AP takes integer a returns nothing
        set this.ap = a
    endmethod
    
    public method Set_AS takes integer a returns nothing
        set this.as = a
    endmethod
    
    public method Set_MS takes integer a returns nothing
        set this.ms = a
    endmethod

    public method Set_CRIT takes integer a returns nothing
        set this.crit = a
    endmethod
    
    public method Set_CRIT_COEF takes integer a returns nothing
        set this.crit_coef = a
    endmethod
    
    public method Set_DEF_AD takes integer a returns nothing
        set this.def_ad = a
    endmethod
    
    public method Set_DEF_AP takes integer a returns nothing
        set this.def_ap = a
    endmethod
    
    public method Set_HP takes integer a returns nothing
        set this.hp = a
    endmethod
    
    public method Set_MP takes integer a returns nothing
        set this.mp = a
    endmethod
    
    public method Set_HP_REGEN takes integer a returns nothing
        set this.hp_regen = a
    endmethod
    
    public method Set_MP_REGEN takes integer a returns nothing
        set this.mp_regen = a
    endmethod

    public method Set_ENHANCE_AD takes integer a returns nothing
        set this.enhance_ad = a
    endmethod
    
    public method Set_ENHANCE_AP takes integer a returns nothing
        set this.enhance_ap = a
    endmethod
    
    public method Set_REDUCE_AD takes integer a returns nothing
        set this.reduce_ad = a
    endmethod
    
    public method Set_REDUCE_AP takes integer a returns nothing
        set this.reduce_ap = a
    endmethod
    
    // ====================================================================
    
    public method Get_Grade takes nothing returns integer
        return this.grade
    endmethod
    
    public method Get_Name takes nothing returns string
        return this.item_name
    endmethod
    
    public method Get_Type takes nothing returns string
        return this.item_type
    endmethod
    
    public method Get_Img takes nothing returns string
        return this.item_img
    endmethod
    
    // ====================================================================
    
    public method Set_Grade takes integer a returns nothing
        set this.grade = a
    endmethod
    
    public method Set_Name takes string s returns nothing
        set this.item_name = s
    endmethod
    
    public method Set_Type takes string s returns nothing
        set this.item_type = s
    endmethod
    
    public method Set_Img takes string s returns nothing
        set this.item_img = s
    endmethod
    
    public static method create takes boolean isRan returns thistype
        local thistype this = thistype.allocate()
        
        if isRan == true then
            call this.Ran_Equip_Init()
        endif
        
        return this
    endmethod
        
    method destroy takes nothing returns nothing
        set this.grade = 0
        set this.ad = 0
        set this.ap = 0
        set this.as = 0
        set this.ms = 0
        set this.crit = 0
        set this.crit_coef = 0
        set this.def_ad = 0
        set this.def_ap = 0
        set this.hp = 0
        set this.mp = 0
        set this.hp_regen = 0
        set this.mp_regen = 0
        set this.enhance_ad = 0
        set this.enhance_ap = 0
        set this.reduce_ad = 0
        set this.reduce_ap = 0
        call thistype.deallocate( this )
    endmethod
    
endstruct