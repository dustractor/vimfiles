GotoMonitor(win_selector:="A",monitor_index:=0,x_percent:=0,y_percent:=0){
    mon_a_w := 3840
    mon_b_w := 2560
    WinGetPos,winx,winy,winh,winw,%win_selector%
    if (winx<mon_a_w){
        tx := mon_a_w+(mon_b_w*(winx*(1/mon_a_w)))
    }else{
        tx := mon_a_w*((winx-mon_a_w)*(1/mon_b_w))
    }
    WinMove,%win_selector%,,%tx%
}
SetTitleMatchMode,RegEx
;GotoMonitor("ahk_exe gvim.exe")
GotoMonitor(".*FOO$ ahk_exe gvim.exe ahk_class Vim")

