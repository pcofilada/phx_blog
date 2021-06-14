# PhxBlog

### Getting Started

```
  git clone git@github.com:pcofilada/phx_blog.git
  cd phx_blog
  cp .env.sample .env
  docker-compose up --build
  // Open new terminal and go to phx_blog folder
  docker-compose run --rm app mix ecto.migrate
  Visit http://localhost:4000/
```

### System Dependecies

- [Docker](https://www.docker.com/)
