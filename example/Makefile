
build: rootfs.tar Dockerfile
	docker build -t rootbuilder-example .

rootfs.tar:
	cd rootbuilder && docker build -t example-rootbuilder .
	docker run --rm example-rootbuilder > rootfs.tar
	docker rmi example-rootbuilder