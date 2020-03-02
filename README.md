# [Bokkun](http://bokkun.herokuapp.com/ "Bokkun")
Expenses Management Platform

## Development Guidelines

### Very-very Important!
- `master` branch will be used for releases to heroku only.
- Therefore: **DO NOT MERGE TO `master` DIRECTLY**

### Still important!
- Make a `pull request` everytime you're done with your branch(es)!
- This repo is integrated to our slack channel so the updates will be there too!

### For everytime `development` has an update!
- `git fetch --all` to get the latest updates from `origin` (GitHub)
- Then after `fetch`, please update your branch with `git merge origin/development` inside your working branch
- Please keep `your-working-branch` updated with the latest `development` branch to avoid conflicts
- Conflicts will be a total headaches to work on so please don't forget to `git merge origin/development` to `your-working-branch`

### Do-not-forget!
- Please checkout to `development` since we're going to pool everything there first
- Create a new branch for each features, please
- `develop-[action]-[feature]` as a branch name, with everything in lower case.
- Don't forget to make a `Pull Request` for each branch/development you're working on
- Change the tag both in our [Trello](https://trello.com/b/q1IAdoJX/bokkun) and your ongoing [Pull Requests](https://github.com/rnd00/bokkun/pulls)
- _Optional_ : Ask someone to review your newly-done function by adding them as the reviewer

## Running on your local

- Checkout to `development` and then run `git fetch --all` and `git pull`
- Run bundle install and yarn install to make sure any newly added gems/packages are present
- Run `rails db:create db:migrate` to get the _migration_ running up to the latest version
- run `rails db:seed` to get the db
ready with seeds
- Run `rails s` to get the server up **locally**

---

## Credits

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
