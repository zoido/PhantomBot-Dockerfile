# PhantomBot-Dockerfile

Dockerfile for [PhantomBot](https://github.com/phantombot/phantombot).

## clone
```console
git clone git@github.com:zoido/PhantomBot-Dockerfile.git
```

## build
```console
docker build -t zoido/phantombot .
```

## run
```console
docker run -d --name phantombot -p 25004:25004 -p 25005:25005 \
 -v <botlogin.txt path>:/opt/phantombot/botlogin.txt:ro \
 -v <db path>:/opt/phantombot/phantombot.db \
 -v <logs path>:/opt/phantombot/logs \
 -v <lang path>:/opt/phantombot/scripts/lang/custom \
 zoido/phantombot
```
