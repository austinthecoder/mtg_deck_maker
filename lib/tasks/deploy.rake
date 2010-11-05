desc "deploys to heroku staging"
task :deploy_to_staging do
  `git push staging dev:master`
  `heroku rake db:migrate --app mtgdeckmaker-staging`
  `heroku restart --app mtgdeckmaker-staging`
end