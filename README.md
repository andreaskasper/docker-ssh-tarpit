# SSH TARPIT
A simple python script to make your server a little bit safer. It created a fake SSH Server which answers very very very sloooooowwww. It keeps SSH clients locked up for hours or even days at a time. The purpose is to put your real SSH server on another port and then let the script kiddies get stuck in this tarpit instead of bothering a real server.

### Features
- [x] Creates a simple tarpit for your SSH Port

### Build status:
[![Build Status](https://img.shields.io/docker/cloud/automated/andreaskasper/ssh-tarpit.svg)](https://hub.docker.com/r/andreaskasper/ssh-tarpit)
[![Build Status](https://img.shields.io/docker/cloud/build/andreaskasper/ssh-tarpit.svg)](https://hub.docker.com/r/andreaskasper/ssh-tarpit)
![Build Status](https://img.shields.io/docker/image-size/andreaskasper/ssh-tarpit/latest)

### Bugs & Issues:
![Github Issues](https://img.shields.io/github/issues/andreaskasper/docker-ssh-tarpit.svg)
![Code Languages](https://img.shields.io/github/languages/top/andreaskasper/docker-ssh-tarpit.svg)

### Stats:
![Docker Pulls](https://img.shields.io/docker/pulls/andreaskasper/ssh-tarpit.svg)

### Demo:
[![Play with docker](https://raw.githubusercontent.com/play-with-docker/stacks/cff22438cb4195ace27f9b15784bbb497047afa7/assets/images/button.png)](http://play-with-docker.com/?stack=https://raw.githubusercontent.com/andreaskasper/docker-ssh-tarpit/main/stack.yml)

### Running the container :
#### Simple Run

```sh
$ docker run -p 22:2222 andreaskasper/ssh-tarpit
```

#### Getting help

```sh
$ docker run andreaskasper/ssh-tarpit --help
```

### Environment Parameters
| Parameter     | Default       | Description   |
| ------------- |:-------------:|:------------- |
| BIND_ADDRESS  | 0.0.0.0       | The IP address the script binds to - normally you don't need to change this                   |
| BIND_PORT     | 2222          | The port the scripts connects to - normally you don't need to change this                     |
| VERBOSE       | info          | Values: debug,info,warn,error,fatal - prints it to STDOUT so you can read it with docker logs |

### Steps
- [x] Build a base test image to test this build process (Travis/Docker)
- [ ] Build tests
- [ ] Gnomes
- [ ] Profit

### support the projects :hammer_and_wrench:
* [![donate via Patreon](https://img.shields.io/badge/Donate-Patreon-green.svg)](https://www.patreon.com/AndreasKasper)
* [![donate via PayPal](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/AndreasKasper)
