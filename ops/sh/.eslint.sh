#!/bin/bash

files=$(git diff --cached --name-only --diff-filter=ACM | grep '.jsx\?$')
if [ "$files" = "" ]; then
    printf "No JS files committed to parse with ESLint.\n"
    printf "\033[37;42mCOMMIT SUCCEEDED\033[0m\n\n"
    exit 0
fi
pass=true
printf "\nValidating JavaScript:\n\n"
for file in ${files}; do

    result="$(node_modules/eslint/bin/eslint.js "${file}")"
    if echo "${result}" | grep -q '0 errors' || [ "$result" = "" ]; then
        printf "\t\033[37;42mESLint Passed: %s\033[0m\n\n" "${file}"
    else
        printf "\t\033[37;41mESLint Failed: %s\033[0m\n" "${file}"
        printf "\t\033[31m%s\033[0m\n\n" "${file}"

        printf "\t\033[31m===============================================\033[0m\n\n"
        printf "\t\033[31mTrying to solve automatically issue by launching cmd : eslint.js --fix %s\033[0m\n" "${file}"
        printf "\t\033[31mFor automatic fix, you should git add this file again and do a new commit\033[0m\n"
        printf "\t\033[31mIf issue persist you need to solve it manually. Refer to http://eslint.org/docs/rules/ for more info.\033[0m\n\n"
        printf "\t\033[31m===============================================\033[0m\n\n"
        node_modules/eslint/bin/eslint.js --fix "${file}"
        pass=false
    fi
done
printf "\nJavaScript validation complete\n\n"
if ! $pass; then
    printf "\033[37;41mCOMMIT FAILED:\033[0m Your commit contains files that should pass ESLint but do not. Please fix the ESLint errors and try again.\n\n"
    exit 1
else
    printf "\033[37;42mCOMMIT SUCCEEDED\033[0m\n\n"
fi
