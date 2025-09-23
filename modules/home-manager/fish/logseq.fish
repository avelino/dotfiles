# Determine action from first argument and validate
set -l action $argv[1]

if test -z "$action"
  echo "Usage: logseq [sync|cloud]"
  return 1
end

switch $action
  case sync
    echo "logseq: starting sync process..."

    # Ensure we're working with the latest cloud version
    logseq cloud

    # Save current directory
    set -l current_dir (pwd)

    # Sync with git repository
    if not cd @NOTES_DIR@
      echo "Error: Could not access notes directory"
      return 1
    end

    # Fetch and pull changes, showing any errors
    if not git pull --ff-only
      echo "Warning: Git pull failed, manual intervention may be needed"
      return 1
    end

    # Perform rsync with error checking
    if not rsync -aP -q \
      --exclude=".git/" \
      --exclude="logseq/*/" \
      --exclude="logseq/.recycle/" \
      --exclude=".trash/" \
      --delete \
      @CLOUD_DIR@/* @NOTES_DIR@/

      echo "Error: rsync failed"
      return 1
    end

    # Check if there are any changes to commit
    if git status --porcelain | grep -q .
      git add .
      git commit -m "sync(logseq): (date '+%Y-%m-%d %H:%M')"

      if not git push
        echo "Error: Failed to push changes"
        return 1
      end
      echo "logseq: sync completed successfully"
    else
      echo "logseq: no changes to sync"
    end

    # Return to original directory
    cd $current_dir
  case cloud
    echo "logseq: initializing journal for today..."
    set -l journal_path @CLOUD_DIR@/journals/(date +%Y-%m-%d).md

    # Check if journals directory exists
    if not test -d @CLOUD_DIR@/journals
      echo "Error: Journals directory not found"
      return 1
    end

    # Create journal file if it doesn't exist
    if not test -f $journal_path
      echo "- Creating new journal for (date '+%A, %B %d, %Y')" > $journal_path
      echo "Journal created: $journal_path"
    else
      # Verify file is readable
      if test -r $journal_path
        echo "Journal exists: $journal_path"
      else
        echo "Error: Cannot read journal file"
        return 1
      end
    end
  case '*'
    echo "logseq: method not found"
    echo "Usage: logseq [sync|cloud]"
end


