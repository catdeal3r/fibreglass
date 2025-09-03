function fish_prompt
    set_color $fish_color_cwd
    if test $PWD = "/home/$(whoami)"
        echo -n '~'
    else
        echo -n (path basename $PWD)
    end
    set_color normal
    echo -n ' - '
end
