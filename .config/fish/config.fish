if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish --cmd cd | source
    alias c=clear
end
