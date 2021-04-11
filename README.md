# corrade-docker

This repository provides a docker build for [Corrade](https://grimore.org/secondlife/scripted_agents/corrade), a scripted agent (bot) for SL. Note that [Corrade](https://grimore.org/secondlife/scripted_agents/corrade) is free to use but closed-source and proprietary with its [own license](https://grimore.org/licenses/was-pc-od). 

This repository however is licensed under the **0-Clause BSD Licence** (see below) and merely provides a wrapper and means to run Corrade, without altering it.

The intention is to make it easy to deploy Corrade with Docker, hence making it independent from the underlying OS or environment. It will work just fine on Docker for Windows, Linux, locally or with any hosting provider.

Provided are two different docker builds, one with Centos 8 Stream, one with Debian 9 (slim). It's a matter of preference, which one you pick. They do exactly the same. 



## Dockerfile build

* execute for CentOS build: `docker build -t corrade -f Dockerfile-centos .` 
* execute for Debian 9 (Slim) build: `docker build -t corrade -f Dockerfile-debian-9-slim .` 

Note, the build will try to pull https://corrade.grimore.org/download/corrade/linux-x64/LATEST.zip, which is the latest Corrade version available


## Startup

With the build just created above, run:
```
docker run -d -p54377:54377 --name corrade corrade
```

Then call http://127.0.0.1:54377 in the browser. Password is "nucleus". Configure as required.

You can then pull down the saved configuration for future use as follows:
```
docker cp corrade:/corrade/Configuration.xml .
```


Alternatively, if you have a configuration already, just copy it in:
```
docker cp Configuration.xml corrade:/corrade
```
Corrade will pick the changes up shortly after, but in some cases it might be required to stop and start the container.

```
docker stop corrade
docker start corrade
```

## Advanced startup

Instead of starting up Corrade, then going into Nucleus and/or copying Configuration.xml in manually, the container can instead take environment variables and generate a Configuration.xml from that. The docker run command would look like this then (replace with sensible values):

```
docker run -d -p54377:54377 \
    --env FIRSTNAME=Avatarname \
    --env LASTNAME=Resident \
    --env PASSWORD=supersecret \
    --env GROUP="My Group" \
    --env GROUPPW=groupassword \
    --name corrade corrade
```

If you plan to rebuild the container often, you might instead use this:
```
docker run -d -p54377:54377 \
    --env-file Corrade.properties \
    --name corrade corrade
```
You'd have to populate the file `Corrade.properties` accordingly then.

In either case, the container will then generate a Configuration.xml with sensible defaults for the one account and group specified and load this as Corrade starts up. If Configuration.xml already exists, environment variables have no effect, thereby preserving whatever changes have been made manually (through copying in or via Nucleus) later.


## License


Copyright (C) 2021 by https://github.com/sysconfig

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. 
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, 
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
