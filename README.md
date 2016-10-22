## KavaRok4

POC in progress..

### Start rok4 with one layer

```
docker run -d --name rok4-master -v /var/run/docker.sock:/var/run/docker.sock -e LAYERS="scan1000" rok4/kavarok4
```

Go to http://127.0.0.1:8008 :)

### Add layer

```
docker exec rok4-master addLayer bdortho-d075
```

You added a layer of photo Paris

### Remove layer

```
docker exec rok4-master removeLayer scan1000
```

You removed a layer of scan1000 map

### Stop

```
docker exec rok4-master stop && docker rm rok4-master
```

This command stops and removes all containers and volumes