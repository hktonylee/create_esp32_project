Create ESP32 Project
====================

This project is a minimal template for creating ESP32 project. The project comes with pre-configured Docker command so that you can easily build and flash the project without having to install the ESP-IDF on your machine.

Usage
-----

To create a new project, run the following command:

```bash
copier copy https://github.com/hktonylee/create_esp32_project .
```

To build and flash the project, run the following command:

```bash
make run

# inside the docker container
idf.py build flash monitor
```

