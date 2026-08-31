if status is-interactive
    # AWS
    set -gx AWS_PROFILE Virtu_CustomerCare-239303162585
    set -gx AWS_PAGER ""
    set -gx EDITOR "nvim"
end
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.9/bin:/Applications/Teleport Connect.app/Contents/MacOS/tsh.app/Contents/MacOS:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# pnpm
set -gx PNPM_HOME "/Users/pazema/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

# peon-ping quick controls
function peon; bash /Users/pazema/.claude/hooks/peon-ping/peon.sh $argv; end
