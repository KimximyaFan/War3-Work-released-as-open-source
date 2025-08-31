struct HeroWearing

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

private Equip None

// Behavior
public static method create takes nothing returns thistype
    return thistype.allocate()
endmethod

method destroy takes nothing returns nothing
    call thistype.deallocate( this )
endmethod

public method Get_Wearing_Equip takes integer i returns Equip
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
    endif
    
    return None
endmethod

public method Set_Wearing_Equip takes integer i, Equip E returns nothing
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
    endif
endmethod

endstruct