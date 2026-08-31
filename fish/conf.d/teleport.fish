# ── Teleport Customer Care ──────────────────────────────
set -gx TELEPORT_DRIVE "$HOME/Google Drive/Drive partagés/Group - Customer Success/CUSTOMER CARE/Team/Teleport-Customer-Care"
set -gx TELEPORT_LOCAL "$HOME/Documents/Teleport-Customer-Care"

alias cdt='cd "$TELEPORT_DRIVE"'
alias cdtl='cd "$TELEPORT_LOCAL"'
alias tmanage='zsh "$TELEPORT_LOCAL/Tmanage.sh"'
alias tconnect='zsh "$TELEPORT_LOCAL/Tconnect.sh"'

function SyncTeleportScripts
    set -l excl "inventory/servers_shared.csv" "teleport.env" "Connect-Teleport.ps1" "Manage-TeleportInventory.ps1"

    if not test -d "$TELEPORT_DRIVE"
        echo "Drive inaccessible"
        return 1
    end

    mkdir -p "$TELEPORT_LOCAL"
    set -l c 0
    set -l s 0
    set -l e 0

    find "$TELEPORT_DRIVE" -type f | while read -l src
        set -l rel (string replace "$TELEPORT_DRIVE/" "" -- "$src")
        set -l dest "$TELEPORT_LOCAL/$rel"

        if contains -- "$rel" $excl
            set e (math $e + 1)
            continue
        end

        mkdir -p (dirname "$dest")
        if not test -f "$dest"; or test "$src" -nt "$dest"
            if cp "$src" "$dest"
                echo "  [OK] $rel"
                set c (math $c + 1)
            end
        else
            set s (math $s + 1)
        end
    end

    printf "\n  %d copie(s), %d identique(s), %d exclu(s)\n\n" $c $s $e
end
