library Inventory requires InvenGeneric, InvenButtonAndBox, InvenItem, InvenWearing, InvenDiscard, DiscardAll, DiscardAllCheck, InvenToolTip

function Inventory_Frame_Init takes nothing returns nothing
    call Inven_Generic_Init()
    call Inven_Button_And_Box_Init()
    call Inven_Item_Init()
    call Inven_Wearing_Init()
    call Inven_Discard_Init()
    call Inven_Discard_All_Init()
    call Inven_Discard_All_Check_Init()
    call Inven_Sort_Init()
    call Inven_Tool_Tip_Init()
endfunction

endlibrary