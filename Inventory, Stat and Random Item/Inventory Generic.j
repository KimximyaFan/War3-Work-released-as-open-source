library InvenGeneric

globals
    string array item_grade
    real inven_square_size = 0.048
    real inven_item_size = 0.046
endglobals

function Wearing_Set_Img takes integer i, Equip E returns nothing
    call DzFrameSetTexture(wearing_img[i], E.Get_Img(), 0)
    call DzFrameShow(wearing_img[i], true)
    call DzFrameShow(wearing_buttons[i], true)
endfunction

function Wearing_Remove_Img takes integer i returns nothing
    call DzFrameShow(wearing_img[i], false)
    call DzFrameShow(wearing_buttons[i], false)
endfunction

function Inven_Set_Img takes integer i, Equip E returns nothing
    call DzFrameSetTexture(item_img[i], E.Get_Img(), 0)
    call DzFrameShow(item_img[i], true)
    call DzFrameShow(item_buttons[i], true)
endfunction

function Inven_Remove_Img takes integer i returns nothing
    call DzFrameShow(item_img[i], false)
    call DzFrameShow(item_buttons[i], false)
endfunction

private function Variables_Init takes nothing returns nothing
    set item_grade[0] = " 일반 "
    set item_grade[1] = "|cff489CFF 희귀 |r"
    set item_grade[2] = "|cffB95AFF 영웅 |r"
    set item_grade[3] = "|cffFF8224 전설 |r"
    set item_grade[4] = "|cffFF4848 신화 |r"
endfunction

function Inven_Generic_Init takes nothing returns nothing
    call Variables_Init()
endfunction

endlibrary