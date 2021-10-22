## dependencies
- docker

You can get docker [here](https://docs.docker.com/get-docker/).Make sure you can run `docker` and `docker-compose` in your terminal.

## Step to run the project
Go to the project direcotory, run the follow commands:
```
# build
docker-compose build

# start service
docker-compose up

# create db and tables
docker-compose run web rails db:create
docker-compose run web rails db:migrate

# run test
docker-compose run web bundle exec rspec
```
Visit localhost:300


## Errors you may encounter
- when you run `docker-compose build`, it throws a error like:
```
ERROR: Version in "./docker-compose.yml" is unsupported. You might be seeing this error because you're using the wrong Compose file version. 
Either specify a supported version(e.g "2.2" or "3.3") and place your service definitions under the `services` key...
```
just edit the docker-compose.yml and change the version to 3.3.

- when you run `docker-compose up`, it throws error like missing some gem(e.g. nokogiri), then you might need to run `docker-compose run web bundle install`. Actually the Dockerfile has contained this command, i think it may be OS issue, i encountered this in Ubuntu.

## Schema
```
ActiveRecord::Schema.define(version: 2021_10_20_131906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id"
    t.string "description"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_important", default: false
    t.boolean "is_urgent", default: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
```

## TODO list
- Use `factory_bot` and `faker` to generate data in rspec.
- I18n, need to extract the wordings like alert message to `config/locales` file.
- use `dotenv` to store env variables.
- use `simplecov` to track rspec coverage.
- configuration for `git push` to make sure `standardrb` was run.

## Screenshot
![image](https://github.com/icecoll/simple_task_project/blob/main/screenshot.png)

