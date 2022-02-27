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



Based on https://www.colby.so/posts/turbo-rails-101-todo-list
