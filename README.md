"tasks"
  t.string   "name"
  t.text     "detail"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false


"users"
  t.string      "name"
  t.string      "email"
  t.string      "password_digest"
  t.datetime    "created_at", null: false
  t.datetime    "updated_at", null: false
  t.index       ["email"], name: "index_users_on_email", unique: true
