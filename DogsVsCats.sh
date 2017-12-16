#!/bin/bash

case "$1" in
  "start")
    # Start the server
    optirun gunicorn wsgi:app --bind 0.0.0.0:8000 --reload
    ;;
  "serve")
    # Open http://127.0.0.1:8000/ in default browser
    python -m webbrowser http://127.0.0.1:8000/

    # Start the server
    optirun gunicorn wsgi:app --bind 0.0.0.0:8000 --reload
    ;;
  *)
    printf "invalid / insufficient argument. \n \
          1. ./DogsVsCats.sh start - start the server \n \
          2. ./DogsVsCats.sh serve - start server & open browser \n"
    ;;
esac
