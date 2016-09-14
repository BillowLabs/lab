## Using Mavens Mate

To use Mavens Mate and GitHub:

1. Add a "New Project" in Mavens Mate linked to the Salesforce instance.
2. In a terminal session, navigate to the new project folder and enter the following:

```bash
git init
git remote add origin https://github.com/BillowLabs/[name].git
git fetch --all
git reset --hard origin/[branch]
```

3. Optional: Clean the project to ensure eveything is up to date from the instance
4. Optional: Review any changes from the clean using:
```bash
git add .
git status
```


## Starting Work:
1. Branch from Main
2. . build/build.sh deploy
3. Clean Project
4. Commit (there should be no changes - but if changes)

## Do Work:
1. Make changes
2. Commit
3. Push as needed (runs integration tests against Sandbox)

## Finishing work:
1. Clean Project & Commit (if changes)
2. Run build with tests -> ‘. build/build.sh’
3. Commit changes & Push
4. Create Pull Request (Add notes, steps, and Assign to Anna)
5. Code Review

## Merging:
1. Clean against Main
2. Commit any Changes (Copy src to prod dir)
3. Merge Pull Request & Resolve any Diffs
4. Delete Branch

## Git Cheat Sheet

###Undo Changes
```bash
git reset --hard
git clean -fd
git checkout [branch]
git pull
```

###Delete local branch
```bash
git branch -d [branch]
```

###Prune branches
```bash
git fetch -p 
```

### Clone into existing directory
git clone https://github.com/BillowLabs/[name].git ./temp
mv temp/.git ./.git
rm -rf ./temp
