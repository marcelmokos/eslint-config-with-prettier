#!/bin/bash

# bash script that can setup environment with common linting and testing tools

function yes_or_no {
  while true; do
    read -p "$* [y/n]: " yn
    case $yn in
      [Yy]*) return 0 ;;
      [Nn]*) echo "👍 install aborted" ; return  1 ;;
    esac
  done
}

echo "🛑🛑🛑 !!!on your own risk!!! 🛑🛑🛑,
💡 commit before running the script and control the output using diff in version control."

function editorconfig {
echo "👍 .editorconfig added"

echo "# EditorConfig: http://EditorConfig.org
# EditorConfig Properties: https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties

# top-most EditorConfig file
root = true

### defaults
[*]
charset = utf-8

# Unix-style newlines with
end_of_line = lf

# 2 space indentation
indent_size = 2
indent_style = space

# remove any whitespace characters preceding newline characters
trim_trailing_whitespace = true

# newline ending every file
insert_final_newline = true

# Denotes preferred quoting style for string literals
quote_type = double

### custom for markdown
[*.md]
# do not remove any whitespace characters preceding newline characters
trim_trailing_whitespace = false" > .editorconfig
}

editorconfig

function babelrc {
echo "👍 .babelrc added"
yarn add --dev babel-preset-react-app babel-plugin-styled-components

echo '{
  "plugins": ["babel-plugin-styled-components"],
  "presets": ["react-app"]
}' > .babelrc
}

if [ ! -f .babelrc ]; then
  babelrc
else
  yes_or_no "💡 .babelrc exist do you want override it" && babelrc
fi

function eslintignore {
echo "👍 .eslintignore added"
echo "flow-typed/npm/**
coverage/**
dist/**
.history/**
.next/**
.vscode/**
.idea/**
" > .eslintignore
}

if [ ! -f .eslintignore ]; then
  eslintignore
else
  yes_or_no "💡 .eslintignore exist do you want override it" && eslintignore
fi


function prettierrc {
echo "👍 .prettierrc added"
echo "trailingComma: all
bracketSpacing: false
" > .prettierrc
}

if [ ! -f .prettierrc ]; then
  prettierrc
else
  yes_or_no "💡 .prettierrc exist do you want override it" && prettierrc
fi

function prettierignore {
echo "👍 .prettierignore added"
echo "package.json
" > .prettierignore
}

if [ ! -f .prettierignore ]; then
  prettierignore
else
  yes_or_no "💡 .prettierignore exist do you want override it" && prettierignore
fi


function flowconfig {
echo "👍 .flowconfig added"
echo "[ignore]

[include]

[libs]
flow-typed

[options]
emoji=true
" > .flowconfig
}

function gitignore {
  echo "👍 .gitingore added"

  commonGitIgnore=$(curl -s https://www.gitignore.io/api/macos,linux,windows,node,jetbrains,sublimetext,visualstudiocode)
  currentGitIgnore=$(cat .gitignore)

echo "$commonGitIgnore

### Custom .gitignore

/flow-typed/npm
$currentGitIgnore" > .gitignore

}

grep -q www.gitignore.io .gitignore || gitignore

yarn add --dev eslint jest husky lint-staged prettier

packagejson=$(cat package.json)
addtopackagejson=$(echo '{
  "scripts": {
    "test": "jest",
    "test:watch": "yarn test --watch",
    "test:update": "yarn test --update",
    "test:coverage": "yarn test --coverage",
    "lint": "eslint \"src/**\" --cache",
    "lint:fix": "yarn lint --fix",
    "lint:staged": "yarn lint:fix --max-warnings=0",
    "precommit": "lint-staged",
    "prepush": "yarn test"
  },
  "lint-staged": {
    "*.{js,jsx}": [
      "lint:staged",
      "git add"
    ],
    "*.{json,css}": [
      "prettier --write",
      "git add"
    ]
  }
}')

echo "👍 package.json added with linting and testing"
echo "$addtopackagejson
$packagejson" | ./node_modules/.bin/json --deep-merge > package.json

function enzyme {
  yarn add --dev enzyme jest-serializer-enzyme

  packagejson=$(cat package.json)
  addtopackagejson=$(echo '{
  "jest": {
    "snapshotSerializers": [
      "jest-serializer-enzyme"
    ]
  }
}')

  echo "👍 package.json added with enzyme snapshotSerializers"
  echo "$addtopackagejson
  $packagejson" | ./node_modules/.bin/json --deep-merge > package.json
}

yes_or_no "👌 Do you want to use enzyme for Component testing?" && enzyme

function flow {
  yarn add --dev flow-bin flow-typed flow-watch

  packagejson=$(cat package.json)
  addtopackagejson=$(echo '{
    "scripts": {
      "flow:setup": "yarn && flow-typed install && flow-typed update",
      "flow": "flow --show-all-errors",
      "flow:watch": "flow-watch",
      "flow:coverage": "flow coverage ./src/ --color",
      "prepush": "yarn test && yarn run flow"
    }
  }')

  echo "👍 package.json added with flow scripts"
  echo "$addtopackagejson
  $packagejson" | ./node_modules/.bin/json --deep-merge > package.json

  yarn run flow:setup

  if [ ! -f .flowconfig ]; then
    flowconfig
  else
    yes_or_no "💡 .flowconfig exist do you want override it" && flowconfig
  fi
}

yes_or_no "👌 Do you want to use setup flow?" && flow

echo "🏁 thanks for running the script now check output using version control"
