library Stat requires StatButtonAndBox

function Stat_Frame_Init takes nothing returns nothing
    call Stat_Button_And_Box_Init()
    call Stat_Text_Init()
endfunction

function Stat_Refresh takes integer pid returns nothing
    if GetLocalPlayer() == Player(pid) then
        call DzFrameSetText( stat_values[0], I2S(R2I(Hero(pid).Get_AD() + 0.0001)) )
        call DzFrameSetText( stat_values[1], I2S(R2I(Hero(pid).Get_AP() + 0.0001)) )
        call DzFrameSetText( stat_values[2], I2S(R2I(Hero(pid).Get_AS() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[3], I2S(R2I(Hero(pid).Get_MS() + 0.0001)) )
        call DzFrameSetText( stat_values[4], I2S(R2I(Hero(pid).Get_CRIT() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[5], I2S(R2I(Hero(pid).Get_CRIT_COEF() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[6], I2S(R2I(Hero(pid).Get_DEF_AD() + 0.0001)) )
        call DzFrameSetText( stat_values[7], I2S(R2I(Hero(pid).Get_DEF_AP() + 0.0001)) )
        call DzFrameSetText( stat_values[8], I2S(R2I(Hero(pid).Get_HP() + 0.0001)) )
        call DzFrameSetText( stat_values[9], I2S(R2I(Hero(pid).Get_MP() + 0.0001)) )
        call DzFrameSetText( stat_values[10], I2S(R2I(Hero(pid).Get_HP_REGEN() + 0.0001)) )
        call DzFrameSetText( stat_values[11], I2S(R2I(Hero(pid).Get_MP_REGEN() + 0.0001)) )
        call DzFrameSetText( stat_values[12], I2S(R2I(Hero(pid).Get_ENHANCE_AD() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[13], I2S(R2I(Hero(pid).Get_ENHANCE_AP() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[14], I2S(R2I(Hero(pid).Get_REDUCE_AD() + 0.0001)) + "%")
        call DzFrameSetText( stat_values[15], I2S(R2I(Hero(pid).Get_REDUCE_AP() + 0.0001)) + "%")
    endif
endfunction

endlibrary