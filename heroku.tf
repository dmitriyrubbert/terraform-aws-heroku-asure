####################
# Dmitriy Lazarev 2019
# dmitriy.rubbert@gmail.com
####################
# https://devcenter.heroku.com/articles/using-terraform-with-heroku#provisioning-an-empty-app

provider "heroku" {
  version = "~> 2.0"
}

resource "heroku_app" "setrackertf" {
  name   = "setrackertf"
  region = "eu" # https://devcenter.heroku.com/articles/regions
}

# Build code & release to the app
resource "heroku_build" "setrackertf" {
  app        = heroku_app.setrackertf.name
  buildpacks = ["https://github.com/heroku/heroku-buildpack-python.git"]

  source = {
    # A local directory, changing its contents will
    # force a new build during `terraform apply`
    path = "../setracker.herokuapp.com/src/"
  }
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "setrackertf" {
  app        = heroku_app.setrackertf.name
  type       = "web"
  quantity   = 1
  size       = "Free"
  depends_on = [heroku_build.setrackertf]
}

output "app_url" {
  value = "https://${heroku_app.setrackertf.name}.herokuapp.com"
}

resource "heroku_addon" "papertrail" {
  app  = heroku_app.setrackertf.name
  plan = "papertrail:choklad"
}
