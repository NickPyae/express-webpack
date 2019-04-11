Before submitting this PR, please make sure:

Creators CheckList:
- [ ] Verify the changes in localhost.
- [ ] Changes to logic.
- [ ] Changes to docs.
- [ ] Updated the **postman.json** file.

Approvers CheckList:
- [ ] All pull requests and git commit messages follow below standard conventions.
- [ ] All newly added features are unit tested with failure cases.
- [ ] Postman covers new end-points and possibilities.


# Pull Request

Always pull the latest changes from **develop** branch first and create a **feature** branch based from **develop**.

```sh
git pull origin develop
git checkout -b feature/userstorynumber
```

### Branch naming convention:

You branch name always starts with one of the following values followed by your user story number.

```
feature/userstorynumber
```

* **feature** (new feature for the user)
* **fix** (bug fix for the user)
* **dep** (change dependency versions)
* **docs** (changes to the documentation)
* **style** (formatting, missing semi colons, etc; no production code change)
* **refactor** (refactoring code, eg. renaming a variable)
* **test** (adding missing tests, refactoring tests; no production code change)
* **release** (releasing new lib version or tag)


### Commit messages convention: 

```
"feature/userstorynumber: short description of your task"
```

Examples:

```sh
git commit -m "feature/55: sigin using sso"
git commit -m "refactor/55: refactor some services"
git commit -m "test/55: unit test for Login component"
git commit -m "fix/55: default redirect after signin"
git commit -m "release: v10"
```

### Pushing your feature branch to remote: 

```sh
git push -u origin feature/userstorynumber
```

Then, create PR to **develop** branch.