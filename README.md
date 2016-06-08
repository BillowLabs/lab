# lab



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
