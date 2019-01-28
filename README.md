# eslint-config-with-prettier

[![npm version](https://img.shields.io/npm/v/eslint-config-with-prettier.svg?style=flat)](https://www.npmjs.com/package/eslint-config-with-prettier) [![styled with prettier](https://img.shields.io/badge/styled_with-prettier-ff69b4.svg)](https://github.com/prettier/prettier) [![Build Status](https://travis-ci.org/marcelmokos/eslint-config-with-prettier.svg?branch=master)](https://travis-ci.org/marcelmokos/eslint-config-with-prettier) [![dependency](https://david-dm.org/marcelmokos/eslint-config-with-prettier/status.svg)](https://david-dm.org/marcelmokos/eslint-config-with-prettier) [![devDep](https://david-dm.org/marcelmokos/eslint-config-with-prettier/dev-status.svg)](https://david-dm.org/marcelmokos/eslint-config-with-prettier?type=dev)
[![Known Vulnerabilities](https://snyk.io/test/github/marcelmokos/eslint-config-with-prettier/badge.svg)](https://snyk.io/test/github/marcelmokos/eslint-config-with-prettier)

This package provides Airbnb's [.eslintrc.yml](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.eslintrc.yml) with prettier as an extensible shared config.

- If you do not want to install and setup eslint with all configs and plugins.
- Install and extend eslint-config-with-prettier it works as [create-react-app](https://github.com/facebookincubator/create-react-app) but for eslint, linting with prettier.

# Usage

## 1. install config

```bash
yarn add --dev eslint-config-with-prettier
```

or

```bash
npm install --dev eslint-config-with-prettier
```

## 2. extend config

- .eslintrc.yml

```yaml
extends:
  - eslint-config-with-prettier
```

- .eslintrc.js

```js
module.exports = {
  extends: ["eslint-config-with-prettier"],
};
```

- .eslintrc.json

```json
{
  "extends": ["eslint-config-with-prettier"]
}
```

# You can expect

- linting using eslint
- extended Airbnb config
- pretty printing using [prettier](https://www.npmjs.com/package/prettier) on `eslint --fix`
- bash script for additional setup

Tools:

- [prettier](https://www.npmjs.com/package/prettier)

Configs:

- [eslint-config-airbnb](https://www.npmjs.com/package/eslint-config-airbnb)
- [eslint-config-prettier](https://www.npmjs.com/package/eslint-config-prettier)

Plugins:

- [eslint-plugin-flowtype](https://www.npmjs.com/package/eslint-plugin-flowtype)
- [eslint-plugin-import](https://www.npmjs.com/package/eslint-plugin-import)
- [eslint-plugin-jest](https://www.npmjs.com/package/eslint-plugin-jest)
- [eslint-plugin-jsx-a11y](https://www.npmjs.com/package/eslint-plugin-jsx-a11y)
- [eslint-plugin-prettier](https://www.npmjs.com/package/eslint-plugin-prettier)
- [eslint-plugin-react](https://www.npmjs.com/package/eslint-plugin-react)

### adding support to [eslint-plugin-dollar-sign](https://www.npmjs.com/package/eslint-plugin-dollar-sign)

- helpful for ES6 code that uses jQuery

```yaml
extends:
  - eslint-config-with-prettier
plugins:
  # https://github.com/erikdesjardins/eslint-plugin-dollar-sign
  - dollar-sign
rules:
  # Require dollar sign for some variables that holds jQuery objects
  dollar-sign/dollar-sign:
    - error
    - ignoreProperties
```

- .eslintrc.js

```js
module.exports = {
  extends: ["eslint-config-with-prettier"],
  plugins: ["dollar-sign"],
  rules: {
    "dollar-sign/dollar-sign": ["error", "ignoreProperties"],
  },
};
```

- .eslintrc.json

```json
{
  "extends": ["eslint-config-with-prettier"],
  "plugins": ["dollar-sign"],
  "rules": {
    "dollar-sign/dollar-sign": ["error", "ignoreProperties"]
  }
}
```

# running setup script

###### ✋!!!on your own risk!!!✋, commit before running the script and control the output using diff in version control.

[setup.sh](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/setup.sh) that run [gist](https://gist.github.com/marcelmokos/8cb21782167f66847eb739790f2f0a06)
[example](https://github.com/marcelmokos/eslint-config-with-prettier/tree/master/example)

```bash
bash ./node_modules/eslint-config-with-prettier/setup.sh
```

If you do not want to run the bash script you can simply copy files into your project.

This script adds useful files into your project.

- [.editorconfig](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.editorconfig)
  - http://EditorConfig.org
- [.babelrc](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.babelrc)
  - babel-preset-react-app: https://www.npmjs.com/package/babel-preset-react-app
  - babel-plugin-styled-components: https://github.com/styled-components/babel-plugin-styled-components
- [.eslintignore](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.eslintignore)
- [.prettierrc](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.prettierrc)
- [.gitignore](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.gitignore)
  - using gitignore.io: https://www.gitignore.io/api/archive,macos,linux,windows,node,jetbrains,sublimetext,eclipse,netbeans,visualstudiocode
- npm lint and test scripts (scripts will merge into package.json)
  - lint and pretty print
  - test
  - precommit -> lint-staged for
    - javascript:`*.js`, `*.jsx`
    - html, styles and other files: `html,md,mdx,yaml,json,css,scss,less`
    - images: `png`,`jpeg`,`jpg`,`gif`,`svg`
  - prepush -> test:coverage and flow:errors

```json
"scripts": {
  "test": "jest",
  "test:changed": "yarn test --onlyChanged --passWithNoTests --silent --runInBand",
  "test:watch": "yarn test --watch",
  "test:update": "yarn test --update",
  "test:coverage": "yarn test --coverage --verbose --silent --runInBand --passWithNoTests",
  "lint": "eslint . --cache",
  "lint:fix": "yarn lint --fix",
  "lint:staged": "eslint --fix --max-warnings=0",
  "precommit": "lint-staged && yarn test:changed",
  "prepush": "yarn test:coverage",
  "prettier": "prettier --write *.{js,jsx,html,md,mdx,yaml,json,css,scss,less}",
},
"husky": {
  "hooks": {
    "pre-commit": "yarn precommit",
    "pre-push": "yarn prepush"
  }
},
"lint-staged": {
  "linters": {
    "*.{js,jsx}": [
      "yarn run lint:staged",
      "git add"
    ],
    "*.{json,css,scss,less}": [
      "prettier --write",
      "git add"
    ],
    "*.{png,jpeg,jpg,gif,svg}": [
      "imagemin-lint-staged",
      "git add"
    ]
  }
}
```

- [enzyme](https://www.npmjs.com/package/enzyme) component testing with settings for [jest-serializer-enzyme](https://www.npmjs.com/package/jest-serializer-enzyme)
- [.flowconfig](https://github.com/marcelmokos/eslint-config-with-prettier/blob/master/.flowconfig)
- npm flow scripts (scripts will be merged into package.json)

```json
"scripts": {
  "flow:setup": "yarn && flow-typed install",
  "flow:update": "flow-typed update",
  "flow": "flow",
  "flow:errors": "flow --show-all-errors",
  "flow:coverage": "flow coverage ./src/index.js --color && flow-coverage-report -i src/**/*.js -x src/**/*.test.js -x src/**/*.spec.js -t html",
  "prepush": "yarn test:coverage && yarn run flow:errors"
}
```
