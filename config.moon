import config from require "lapis.config"

config "development", ->
  server "nginx"
  code_cache "off"
  num_workers "1"
  theme "default"
  
  mysql ->
    backend "resty_mysql"
    host "127.0.0.1"
    user "naxxramas_user"
    password "naxxramas_passwd"
    database "naxxramas_db"
