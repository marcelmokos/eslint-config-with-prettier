// generated file from .eslintrc.yml
module.exports =
{
  "root": true,
  "parser": "babel-eslint",
  "extends": [
    "plugin:react/recommended",
    "plugin:flowtype/recommended",
    "plugin:jest/recommended",
    "airbnb",
    "prettier",
    "prettier/flowtype",
    "prettier/react"
  ],
  "plugins": [
    "react",
    "import",
    "jest",
    "flowtype",
    "prettier"
  ],
  "settings": {
    "flowtype": {
      "onlyFilesWithFlowAnnotation": false
    }
  },
  "env": {
    "es6": true,
    "browser": true,
    "node": true,
    "jasmine": true,
    "jest": true,
    "jest/globals": true
  },
  "globals": {
    "fetch": true,
    "navigator": true,
    "__DEV__": true,
    "XMLHttpRequest": true,
    "React$Element": true,
    "Generator": true
  },
  "parserOptions": {
    "ecmaVersion": 2017,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "rules": {
    "prettier/prettier": [
      "error",
      {
        "trailingComma": "all",
        "bracketSpacing": false
      }
    ],
    "newline-before-return": "error",
    "no-use-before-define": [
      "error",
      {
        "functions": false,
        "classes": false,
        "variables": true
      }
    ],
    "no-unused-vars": "warn",
    "react/no-unused-prop-types": "warn",
    "yoda": [
      "error",
      "never",
      {
        "exceptRange": true
      }
    ],
    "curly": [
      "error",
      "all"
    ],
    "import/prefer-default-export": "off",
    "import/first": "off",
    "no-console": "warn",
    "no-debugger": "warn",
    "react/jsx-filename-extension": "off",
    "react/prefer-stateless-function": "warn",
    "react/require-default-props": "off",
    "jsx-a11y/href-no-hash": "off",
    "no-irregular-whitespace": [
      "off"
    ]
  }
}
