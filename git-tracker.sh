
#!/bin/bash

# Nama file: git-tracker.sh

# Lokasi file log
LOG_FILE="$HOME/.git_activity_log"

# Fungsi untuk mendapatkan nama repo
get_repo_name() {
    basename -s .git `git config --get remote.origin.url`
}

# Fungsi untuk mendapatkan folder saat ini
get_current_folder() {
    basename "$PWD"
}

# Fungsi untuk mencatat aktivitas
log_activity() {
    repo=$(get_repo_name)
    folder=$(get_current_folder)
    echo "$(date '+%Y-%m-%d %H:%M:%S') - [$repo/$folder] $1" >> "$LOG_FILE"
}

# Fungsi untuk membuat branch baru
new_branch() {
    if [ -z "$1" ]; then
        echo "Usage: git-tracker new-branch <branch-name>"
        return 1
    fi
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git checkout -b "$1"
    log_activity "New branch '$1' created from '$current_branch'"
}

# Fungsi untuk stash
stash_changes() {
    message="$1"
    if [ -z "$message" ]; then
        message="Stash at $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    git stash push -m "$message"
    log_activity "Stashed changes: $message"
}

# Main script
case "$1" in
    new-branch)
        new_branch "$2"
        ;;
    stash)
        shift
        stash_changes "$*"
        ;;
    log)
      # change here
      if [ -f "$LOG_FILE" ]; then
        echo '{"logs":['
        first=true
        while IFS= read -r line; do
          if [ "$first" = true ] ; then
            first=false
          else
            echo ','
          fi
          echo "{\"entry\":\"$line\"}"
        done < "$LOG_FILE"
        echo ']}'
      else
        echo '{"error":"No log file found."}'
      fi
      ;;
    *)
        echo "Usage: git-tracker {new-branch|stash|log}"
        echo "  new-branch <branch-name>: Create a new branch"
        echo "  stash [message]: Stash changes with optional message"
        echo "  log: Show activity log"
        ;;
esac
