desc "deploys to heroku staging"
task :deploy_to_staging do
  `git push staging dev:master`
  `heroku rake db:migrate --app mtgdeckmaker-staging`
  `heroku restart --app mtgdeckmaker-staging`
end

desc "deploys to heroku production"
task :deploy_to_prod do
  `git push production master:master`
  `heroku rake db:migrate --app mtgdeckmaker`
  `heroku restart --app mtgdeckmaker`
end