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

https://user-images.githubusercontent.com/17977331/156383968-c9131afd-c041-41b0-9b96-138ddab7e641.mov

PS Based on https://www.colby.so/posts/turbo-rails-101-todo-list
            and
            https://github.com/lazaronixon/authentication-zero
