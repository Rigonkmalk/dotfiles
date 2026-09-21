# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/pazema/.docker/bin"
# End of Docker Desktop section.

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

# >>> cawst managed block >>>
# Géré automatiquement par cawst ('cawst reload') — les modifications
# manuelles de ce bloc seront écrasées à la prochaine synchronisation.
set -gx CAWST_HOME "/Users/pazema/.local/bin"
if not contains $CAWST_HOME $PATH
    set -gx PATH $CAWST_HOME $PATH
end
if type -q cawst
    cawst completions fish | source
end
function cawst-reload
    type -q cawst; and cawst _sync_shell --quiet
    source "/Users/pazema/.config/fish/config.fish"
    type -q cawst; and echo "✅ cawst-reload : commande 'cawst' active."; or echo "⚠️  cawst-reload : 'cawst' introuvable après rechargement."
end
# <<< cawst managed block <<<
