;  ***  space
space::Send {space}

^space::Send ^{space}
#space::Send #{space}
^#space::Send ^#{space}
!space::Send !{space}
^!space::Send ^!{space}

;  *** space + Num
space & 0::Send {)}
space & 1::Send +1
space & 2::Send +2
space & 3::Send +3
space & 4::Send +4
space & 5::Send +5
space & 6::Send +6
space & 7::Send +7
space & 8::Send +8
space & 9::Send +9


space & r:: Send {F2} ;功能键F2
space & b:: Send {F5} ;功能键F5
space & s:: Send {F6} ;功能键F6



;  *** space + XX
#if GetKeyState("space", "P")

i:: Send {up}
j:: Send {left}
k:: Send {down}
l:: Send {right}

n:: Send {home}
m:: Send {end}

t:: Send +{home}	;Shift+home
y:: Send +{end}	;Shift+end

f & i:: Send ^{up}	;Ctrl+up
f & k:: Send ^{down}	;Ctrl+domn	

w:: Send ^w	;浏览器关闭标签页
h:: Send {Backspace} ;退格


=:: Send {+}
-:: Send {_}
':: Send {"}
,:: Send {<}
.:: Send {>} 
;:: Send {:}
[:: Send {{}
]:: Send {}}

; 复制粘贴
c:: Send ^c
d:: Send ^v

return




