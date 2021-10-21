#### dependencies
- docker
You can get docker [here](https://docs.docker.com/get-docker/).Make sure you can run `docker` and `docker-compose` in your terminal.

#### Step to run the project
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

#### Schema
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
