# rootbuilder

This is a Docker container base image for producing tiny BusyBox/buildroot filesystem tar files. You can use these tar files for building BusyBox containers from scratch. See the example directory for a BusyBox container that includes curl that was built using rootbuilder.

## Using rootbuilder

Make a directory in your project called `rootbuilder` that has a Dockerfile with just the contents `FROM progrium/rootbuilder`. Building this Dockerfile will produce a filesystem tar that you can access from the stdout of running the built contianer. You often use it like this:

	$ docker build -t rootfs-build .
	$ docker run --rm rootfs-build > ../rootfs.tar
	$ docker rmi rootfs-build

Now that you have a `rootfs.tar` in your project root, your actual project Dockerfile can look like this:

	FROM scratch
	ADD rootfs.tar /

## Customizing rootbuilder

You can change buildroot settings and modify the filesystem tar produced during the build process by including either a `pre-make` and/or a `post-make` script (with proper exec bits) in a `hooks` directory of your `rootbuilder` directory. These are added during the build process via ONBUILD ADD instructions in the base `progrium/rootbuilder` Dockerfile. It will also add any directories under `package` to the `package` directory of the buildroot, so you can configure packages.

A common use for `pre-make` is to add configuration to the buildroot config. A common use for `post-make` is to modify the resulting `rootfs.tar` file in the build environment.

## Credit

This project is mostly just a generalization of the [tarmakers](https://github.com/radial/core-busyboxplus) by [Brian Clements](https://github.com/brianclements), itself inspired by the original tarmaker work of the venerable [Jérôme Petazzoni](https://github.com/jpetazzo).

## Sponsor

This project was made possible thanks to [DigitalOcean](http://digitalocean.com).

## License

BSD