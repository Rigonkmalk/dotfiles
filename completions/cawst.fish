# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_cawst_global_optspecs
    string join \n h/help V/version
end

function __fish_cawst_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_cawst_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_cawst_using_subcommand
    set -l cmd (__fish_cawst_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c cawst -n "__fish_cawst_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c cawst -n "__fish_cawst_needs_command" -s V -l version -d 'Print version'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "menu" -d 'Ouvre la TUI interactive (comportement par défaut)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "all-aws" -d 'Toutes les instances AWS visibles (sans filtre de tag)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "all" -d 'Toutes les instances taggées équipe (+ motif optionnel)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "my" -d 'Mes instances'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "my-ondemand" -d 'Mes instances on-demand'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "my-all" -d 'Mes instances (perso + on-demand)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "user" -d 'Instances d\'un autre utilisateur'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "user-ondemand" -d 'Instances on-demand d\'un autre utilisateur'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "user-all" -d 'Instances (perso + on-demand) d\'un autre utilisateur'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "to-save" -d 'Instances à sauvegarder (plus vieilles que le seuil configuré)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "start" -d 'Démarrer des instances (ID exact ou nom/motif)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "stop" -d 'Arrêter des instances (ID exact ou nom/motif)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "ssh" -d 'Connexion (Teleport en priorité, SSH direct en repli)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "rename" -d 'Renommer une instance côté AWS (tag Name)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "start-ondemand" -d 'Démarrer mes instances on-demand (tout, ou un workspace précis)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "stop-ondemand" -d 'Arrêter mes instances on-demand (tout, ou un workspace précis)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "ssh-login" -d 'Gérer les logins SSH mémorisés par instance'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "config" -d 'Assistant de configuration'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "alias" -d 'Gérer la table d\'alias GitHub on-demand'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "cache-clear" -d 'Vider le cache local'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "reload" -d 'Installer / mettre à jour l\'intégration shell'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "sso" -d 'Lancer « aws configure sso » pour le profil configuré'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "doctor" -d 'État des dépendances externes et du gestionnaire de paquets'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "completions" -d 'Script de complétion pour un shell'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "_sync_shell" -d 'Synchronisation silencieuse du bloc shell (usage interne)'
complete -c cawst -n "__fish_cawst_needs_command" -f -a "list-commands" -d 'Liste des sous-commandes (usage interne, complétion)'
complete -c cawst -n "__fish_cawst_using_subcommand menu" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand all-aws" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand all" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand my" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand my-ondemand" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand my-all" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand user" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand user-ondemand" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand user-all" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand to-save" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand start" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand stop" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand rename" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand start-ondemand" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand stop-ondemand" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and not __fish_seen_subcommand_from list clean remove set" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and not __fish_seen_subcommand_from list clean remove set" -f -a "list" -d 'Lister les logins en cache (avec le nom d\'instance résolu)'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and not __fish_seen_subcommand_from list clean remove set" -f -a "clean" -d 'Retirer les entrées dont l\'instance n\'existe plus côté AWS'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and not __fish_seen_subcommand_from list clean remove set" -f -a "remove" -d 'Oublier le login mémorisé pour une instance'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and not __fish_seen_subcommand_from list clean remove set" -f -a "set" -d 'Forcer le login mémorisé pour une instance'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and __fish_seen_subcommand_from clean" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand ssh-login; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand config" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and not __fish_seen_subcommand_from list add remove" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and not __fish_seen_subcommand_from list add remove" -f -a "list" -d 'Afficher la table'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and not __fish_seen_subcommand_from list add remove" -f -a "add" -d 'Ajouter ou modifier un alias'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and not __fish_seen_subcommand_from list add remove" -f -a "remove" -d 'Supprimer un alias'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand alias; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand cache-clear" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand reload" -l shell -d 'Shell ciblé (défaut : détecté automatiquement)' -r
complete -c cawst -n "__fish_cawst_using_subcommand reload" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand sso" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand doctor" -l install -d 'Installer ce qui manque (AWS CLI v2 depuis l\'installateur officiel sur Linux et macOS)'
complete -c cawst -n "__fish_cawst_using_subcommand doctor" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand completions" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand _sync_shell" -l shell -r
complete -c cawst -n "__fish_cawst_using_subcommand _sync_shell" -l quiet
complete -c cawst -n "__fish_cawst_using_subcommand _sync_shell" -s h -l help -d 'Print help'
complete -c cawst -n "__fish_cawst_using_subcommand list-commands" -s h -l help -d 'Print help'
