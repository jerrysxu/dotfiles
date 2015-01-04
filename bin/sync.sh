for dir in *
do
  echo "<<<<<<<< Syncing $dir ..."
  return_value=0

  if [ -d "$dir/.git" ]
  then
    (cd "$dir" && git pull --rebase)
    return_value=$?
  fi
  if [ -d "$dir/.svn" ]
  then
    (cd "$dir" && svn up)
    return_value=$?
  fi
  
  if test $return_value -eq 0
  then
    echo Syncing passed for $dir | highlight green ".*"
  else
    echo Syncing failed for $dir | highlight red ".*"
  fi
done
