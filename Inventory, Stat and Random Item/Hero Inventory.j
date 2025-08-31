struct HeroInven

// Property
private Equip I0
private Equip I1
private Equip I2
private Equip I3
private Equip I4
private Equip I5
private Equip I6
private Equip I7
private Equip I8
private Equip I9
private Equip I10
private Equip I11
private Equip I12
private Equip I13
private Equip I14
private Equip I15
private Equip I16
private Equip I17
private Equip I18
private Equip I19
private Equip I20
private Equip I21
private Equip I22
private Equip I23
private Equip I24

private Equip None

// Behavior
public static method create takes nothing returns thistype
    return thistype.allocate()
endmethod

method destroy takes nothing returns nothing
    call thistype.deallocate( this )
endmethod

public method Get_Inven_Equip takes integer i returns Equip
    if i == 0 then
        return I0
    elseif i == 1 then
        return I1
    elseif i == 2 then
        return I2
    elseif i == 3 then
        return I3
    elseif i == 4 then
        return I4
    elseif i == 5 then
        return I5
    elseif i == 6 then
        return I6
    elseif i == 7 then
        return I7
    elseif i == 8 then
        return I8
    elseif i == 9 then
        return I9
    elseif i == 10 then
        return I10
    elseif i == 11 then
        return I11
    elseif i == 12 then
        return I12
    elseif i == 13 then
        return I13
    elseif i == 14 then
        return I14
    elseif i == 15 then
        return I15
    elseif i == 16 then
        return I16
    elseif i == 17 then
        return I17
    elseif i == 18 then
        return I18
    elseif i == 19 then
        return I19
    elseif i == 20 then
        return I20
    elseif i == 21 then
        return I21
    elseif i == 22 then
        return I22
    elseif i == 23 then
        return I23
    elseif i == 24 then
        return I24
    endif
    
    return None
endmethod

public method Set_Inven_Equip takes integer i, Equip E returns nothing
    if i == 0 then
        set I0 = E
    elseif i == 1 then
        set I1 = E
    elseif i == 2 then
        set I2 = E
    elseif i == 3 then
        set I3 = E
    elseif i == 4 then
        set I4 = E
    elseif i == 5 then
        set I5 = E
    elseif i == 6 then
        set I6 = E
    elseif i == 7 then
        set I7 = E
    elseif i == 8 then
        set I8 = E
    elseif i == 9 then
        set I9 = E
    elseif i == 10 then
        set I10 = E
    elseif i == 11 then
        set I11 = E
    elseif i == 12 then
        set I12 = E
    elseif i == 13 then
        set I13 = E
    elseif i == 14 then
        set I14 = E
    elseif i == 15 then
        set I15 = E
    elseif i == 16 then
        set I16 = E
    elseif i == 17 then
        set I17 = E
    elseif i == 18 then
        set I18 = E
    elseif i == 19 then
        set I19 = E
    elseif i == 20 then
        set I20 = E
    elseif i == 21 then
        set I21 = E
    elseif i == 22 then
        set I22 = E
    elseif i == 23 then
        set I23 = E
    elseif i == 24 then
        set I24 = E
    endif
endmethod

endstruct