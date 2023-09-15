# You Have Somehow Wandered Into the Area Where I Keep My Vim Configuration.

Make of that what you will.


# of particular interest

When I'm on windows I use gvim instead of vim in a terminal. I also don't use tmux since it isn't available on windows. (Other than WSL.)

The main thing I used tmux for was not multiplexing but rather the ability to easily send commands to an arbitrary tmux window.

A similar thing is possible with vim when it is compiled with +clientserver, and luckily, gvim has that feature.

So I have this function:

    if has('win32')
        fun! Termsay(msg)
            let l:filename = expand("%:p:t")
            let l:parentdirname = expand("%:p:h:t")
            let l:servername = toupper(l:parentdirname . "_" . l:filename)
            let l:startcmdfmt = "start /B gvim.exe --servername %s"
            let l:startcmd = printf(l:startcmdfmt,l:servername)
            if match(serverlist(),l:servername) == -1
                call system(l:startcmd)
                sleep 333m
                call remote_send(l:servername,":term ++curwin ++kill=kill<cr>")
            endif
            call remote_send(l:servername,a:msg."<cr>")
        endfun
    endif

Along with this command:

    if has('win32')
        com! -nargs=1 Termsay call Termsay(<q-args>)
    endif

Coupled with an autocommand:

    aug DeskPy
        au!
        au BufNew,BufReadPost ~/Desktop/*.py call DeskPySetup(expand("<afile>"))
    aug END

Which executes (in this example) when editing python files on my Desktop or in any folder therein. (Remember: the glob character ``*`` in an autocommand is recursive!)

The autocommand runs this function which sets things up for python and defines a mapping:

    fun! DeskPySetup(afile)
        if has('win32')
            let l:prog = expand("~/anaconda3/python.exe")
            exe printf("nmap <buffer><F12> :Termsay %s %s <cr>",l:prog,a:afile)
        endif
    endfun

The end result is that I can press F12 to run whatever I'm editing in a terminal.

It doesn't block my editing window waiting for me to press ENTER. It doesn't steal my focus by switching to the other terminal either.

How it works: Vim can talk to another vim instance with +clientserver, using ``remote_send()``

The main vim instance starts the secondary vim instance using

    start /B gvim.exe --servername FOO_BAR_NAME

Then you can send keystrokes to that vim instance like this:

    call remote_send(FOO_BAR_NAME,"QUOTED STRING OF KEYSTROKES")

(In order to tell it to press return and execute the keystrokes as a command, you send the string "\<cr>".)

Since vim can run a terminal inside itself, we tell the new vim instance to make one of those like this:

    call remote_send(FOO_BAR_NAME,":term ++curwin ++kill=kill<cr>")

``:term`` is the command. ``++curwin`` makes the new terminal occupy the full screen instead of being a split, and ``++kill=kill`` makes it not complain when you close vim with a running process.

So from then on we can send that vim instance commands and they will be run inside the terminal.  In this case, I want to tell python to run the file I am editing.

    let l:filename = expand("%:p:t")

The name of the file currently being edited -- you get that with ``expand("%:p:t")``

``%`` is the current buffer.  The modification ``:p`` gets the path to the file in the buffer.  The modification ``:t`` gets the tail of the path, aka the name.

The secondary vim instance needs a server name so that we can direct messages to it, so I name the server based on the directory of the file I am editing plus the name of the file.

    let l:parentdirname = expand("%:p:h:t")
    let l:servername = toupper(l:parentdirname . "_" . l:filename)


``expand("%:p:h:t")`` gives that value.  The ``:h`` modifier give the head of the path -- everything that's not the tail, that is.  So the tail of the head of the path of the buffer is the name of the directory.

They say a picture is word a thousand words. I don't know how many words an animation is worth but here is this setup in action:

<p><video controls preload="metadata">
<source type="video/webm" src="untitled.webm"></source>
Your browser does not support playing HTML5 video. You can
<a href="untitled.webm" download>download a copy of the video
file</a> instead.
Here is a description of the content: test link
</video></p>
