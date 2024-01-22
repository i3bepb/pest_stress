
Build local image with local user (1000:1000)
```shell
docker build -f Dockerfile.dev -t pest_stress:1.1.0 --build-arg MYAPP_IMAGE=i3bepb/php-for-test:1.1.5-php-8.3.2-cli-alpine3.19 --build-arg LOCAL_USER_ID_ARG=1000 --build-arg LOCAL_GROUP_ID_ARG=1000 .
```

Run container
```shell
docker run -it --rm -v $(pwd)/application:/home/www-data/application pest_stress:1.1.0 sh
```

Show ip container
```shell
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 1937118d41f7
```

Run stress test
```shell
./vendor/bin/pest stress http://172.17.0.1 --concurrency=5 --get
```
```shell
docker run -it --rm -v $(pwd)/application:/home/www-data/application pest_stress:1.1.0 /home/www-data/application/vendor/bin/pest stress http://172.17.0.1 --get
```

