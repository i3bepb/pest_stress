## Try Pest plugin Stressless

Build local image with local user (1000:1000)
```shell
docker build -f Dockerfile -t pest_stress:1.0.0 --build-arg LOCAL_USER_ID_ARG=1000 --build-arg LOCAL_GROUP_ID_ARG=1000 .
```

Install
```shell
docker run -it --rm -v $(pwd)/application:/home/www-data/application pest_stress:1.0.0 composer install
```

Show ip container
```shell
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 1937118d41f7
```

Run stress test
```shell
docker run -it --rm -v $(pwd)/application:/home/www-data/application pest_stress:1.0.0 sh

./vendor/bin/pest stress http://172.17.0.1 --concurrency=5 --get
```
```shell
docker run -it --rm -v $(pwd)/application:/home/www-data/application pest_stress:1.0.0 /home/www-data/application/vendor/bin/pest stress http://172.17.0.1 --get
```

