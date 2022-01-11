#SingleInstance Force
#WinActivateForce

Splish(smtxt){
    SplashTextOn,,,%smtxt%
    Sleep,1000
    SplashTextOff
}

UseSpeakers(){
    Run,%A_ScriptDir%\speakers.ahk
    Splish("speakers")
}
UseHeadphones(){
    Run,%A_ScriptDir%\headphones.ahk
    Splish("headphones")
}

gvim=c:\Program Files\vim\vim82\gvim.exe
browser=C:\Program Files\Mozilla Firefox\firefox.exe
cmder=C:\Users\dustr\Documents\cmder_mini\Cmder.exe

NewGVimInstance(){
    global gvim
    Run, %gvim%
}

TheGVimInstance(){
    global gvim
    Sleep, 123
    if WinExist("ahk_exe gvim.exe"){
        WinActivate, ahk_exe gvim.exe
    }
    else {
        Run,%gvim%,,,Vpid
        WinWait, ahk_pid %Vpid%
        WinActivate, ahk_pid %Vpid%
    }
}

BlenderTerm(){
    Run,%BLENDER%,,,Bpid
}

DoReload(){
    Splish("reloading")
    Reload
}
OtherMonitor(win_selector){
    SetTitleMatchMode,RegEx
    WinMove,%win_selector%,,3841,0,2560,1440
    SetTitleMatchMode,1
}
#+O::OtherMonitor(".*FOO$ ahk_exe gvim.exe ahk_class Vim")
opencmdhere() {
    If WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass") {
        WinHWND := WinActive()
        For win in ComObjCreate("Shell.Application").Windows
            If (win.HWND = WinHWND) {
                currdir := SubStr(win.LocationURL, 9)
                currdir := RegExReplace(currdir, "%20", " ")
                Break
            }
    }
    Run, cmd, % currdir ? currdir : "C:\"
}

#J::Run,explorer.exe %A_MyDocuments%
#b:: BlenderTerm()
#l::
    global browser
    InputBox,q,idgaf,search something blah
    q := StrReplace(q,A_Space,"+")
    arg:=Format("https://www.google.com/search?q={}",q)
    Run, %browser% %arg%
    return
#v::TheGVimInstance()
#+v::NewGVimInstance()
#,:: Run,%gvim% -c "e ."
#m:: Run,%gvim% -c "e ~/machine.ahk"
#!v:: Run,%gvim% -c "e $MYVIMRC"
+!^NumpadDiv::UseHeadphones()
+!^NumpadMult::UseSpeakers()
#+H:: Run,explorer.exe %HOMEDRIVE%%HOMEPATH%
^!+P::Run,%cmder% /task ipy
^!+R::DoReload()
^!T:: Run,%cmder%,%HOMEDRIVE%%HOMEPATH%
#c::opencmdhere()

DoAScan(){
    Send !fns
    Sleep,50
    Send !s
}
+!^z::DoAScan()

