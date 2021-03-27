#!/usr/bin/env sh
lastCommit=$(git ls-remote https://github.com/melange-re/melange.git rev-parse HEAD | cut -c 1-7)
if ! (command -v jq) >> /dev/null 2>&1; then
     echo "jq must be installed. See https://stedolan.github.io/jq/download"
fi
if ! (command -v esy) >> /dev/null 2>&1; then
    echo "esy must be installed. See https://esy.sh/docs/en/getting-started.html"
fi
BS_PLATFORM="melange-re/melange#$lastCommit"
JSON_STRING=$( jq -n \
    --arg bn "$BS_PLATFORM" \
    '{
  "dependencies": {
    "bs-platform": "*"
  },
  "resolutions": {
    "bs-platform": $bn,
    "ocaml": "melange-re/ocaml#75f22c8"
  },
  "esy": {
    "buildsInSource": "unsafe",
    "build": [
      "ln -sfn #{bs-platform.install} node_modules/bs-platform"
    ]
  },
  "installConfig": {
    "pnp": false
  }
}' )
echo "$JSON_STRING" | jq '.' > esy.json
