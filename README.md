# README

This application is a simple todo list, built with Rails 7, import maps, and Turbo. In it, we use Turbo Streams and Turbo Frames to allow users to create, edit, and delete todos without full page turns or custom JavaScript.

To run this application locally, clone the repository and then:

```bash
bundle install
```
```bash
rails db:create db:migrate
```
```bash
bin/dev
```

## Preview

https://user-images.githubusercontent.com/17977331/155981574-551c40eb-4d1c-423a-a222-9f88c97356b4.mov


PS Based on https://www.colby.so/posts/turbo-rails-101-todo-list
            https://github.com/lazaronixon/authentication-zero
