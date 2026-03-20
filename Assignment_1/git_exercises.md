# ashura git exercises solutions

## 1. master
Required cloning a repo and running
    ```
    git verify
    ```

## 2. commit-one-file
Added only 1 file to the commit using `git add A.txt` and commited it using `git commit` and then verified using `git verify`.

## 3. commit-one-file-staged
Unstaged B.txt by using `git restore --staged B.txt` and commited the staged files(A.txt) using `git commit` and then verified using `git verify`.

## 4. ignore-them
Made a file `.gitignore`
```
*.exe
*.o
*.jar
libraries/
```
and ran
```bash
git add -A
git commit
git verify
```
to verify the commit the files and verify the solution.

## 5. chase-branch
Merged the escaped branch to our current-branch and verified
```bash
git merge escaped
git verify
```

## 6. merge-conflict
Merged the another-piece-of-work to the merge-conflict branch and encountered merge conflicts. Resolved the conflicts by editing the file which was creating issues(equation.txt).
```bash
git merge another-piece-of-work
vim equation.txt
git add equation.txt
git commit
git verify
```

## 7. save-your-work
Temporarily save the code by pushing it to git stash and then editing the contents of the bug, committing the bug-fixes and recover previous work by popping it from the stash and then making changes and committing them and verifying the answer.
```bash
git stash
vim bug.txt
git add bug.txt
git commit 
git stash pop
vim bug.txt
git add bug.txt
git commit
git verify
```

## 8. change-branch-history
Since we need to get the changes made in the hot-bugfix branch to our change-branch-history, we rebase from A to hot-bugfix which would incorporate the changes made in hot-bugfix in our current branch.
```bash
git rebase hot-bugfix
git verify
```

## 9. remove-ignored
We delete the fie from the staging area and commit the changes which makes it so that the file is not deleted fro the storage but is deleted form the staging area and hence is ignored by git.
```bash
git rm --cached ignored.txt
git verify
```

## 10. case-sensitive-filename
rename the file by moving it to a new one with the correct name, commit changes and verify.
```bash
git mv File.txt file.txt
git commit
git verify
```

## 11. fix-typo
Make the changes to the file and save them, then amend the previous commit and also alter the commit message.
```bash
vim file.txt
git commit -a --amend
git verify
```

## 12. forge-date
Amend the date of the commit by running the command-
```bash
git commit --amend --no-edit --date="1987-06-15"
git verify
```

## 13. fix-old-typo
Use interactive rebase to edit the 2nd last commit. Ammend the commit. Continue the rebase. Deal with merge-conflicts. Commit.
```bash
git rebase -i HEAD~2
vim file.txt
git commit -a --amend
git rebase --continue
vim file.txt
git add file.txt
git commit
git verify
```