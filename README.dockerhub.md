# Corrade 11 Docker Container

This docker image provides [Corrade](https://grimore.org/secondlife/scripted_agents/corrade), a scripted agent (bot) for SL. Note that [Corrade](https://grimore.org/secondlife/scripted_agents/corrade) is free to use but closed-source and proprietary with its [own license](https://grimore.org/licenses/was-pc-od). 


## Quick start

To launch the container, simply run:
```
docker run -d -p54377:54377 --name corrade sysconfig/corrade-11-docker:latest
```

Then call http://127.0.0.1:54377 in the browser (or the respective IP of the server you are running it on). Password is "nucleus". Configure as required.

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
    --name corrade sysconfig/corrade-11-docker:latest
```

If you plan to rebuild the container often, you might instead use this:
```
docker run -d -p54377:54377 \
    --env-file Corrade.properties \
    --name corrade sysconfig/corrade-11-docker:latest
```
You'd have to populate the file `Corrade.properties` accordingly then. [An example can be found here.](https://github.com/sysconfig/corrade-11-docker/blob/master/Corrade.properties)

In either case, the container will then generate a Configuration.xml with sensible defaults for the one account and group specified and load this as Corrade starts up. If Configuration.xml already exists, environment variables have no effect, thereby preserving whatever changes have been made manually (through copying in or via Nucleus) later.


## Build your own?

Sure, why not :)  You can find build instructions and Dockerfiles for Debian 10 (this image) as well as Centos 8 Stream versions [in my GitHub repository](https://github.com/sysconfig/corrade-11-docker).

## License

The following license applies to my docker build and (GitHub repository](https://github.com/sysconfig/corrade-11-docker), **NOT** to Corrade itself.

Copyright (C) 2021 by https://github.com/sysconfig

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. 
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, 
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
