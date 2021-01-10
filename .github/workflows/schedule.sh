#!/bin/bash -eux

file=.github/cache/file

[[ -f $file ]] || install -m 644 -D /dev/null $file

eval "$(cat $file)"
new=$(wget -qO- https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest | sed 's/^ *"tag_name": "\(.*\)",$/\1/p' -n)

if ! [[ "${cache:-}" == "$new" ]]; then
  curl -fSso /dev/null -X POST $trigger
  echo "cache=$new" > $file
fi
