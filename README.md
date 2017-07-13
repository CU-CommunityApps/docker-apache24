# Docker configuration for Apache 2.4 image

This repository should *remain private* since it includes CUWebAuth source code.  While Identity Management currently does not password-protect their downloads from the build environment, we really shouldn't be publicly redistributing their code without making sure they are okay with it.

# Building mod_cuwebauth

The included `build-mod_cuwebauth.sh` script can be used to compile mod_cuwebauth within a Docker container.  The script will build a temporary Docker image, copy the mod_cuwebauth.so artifact to `lib/` and clean up the temporary images/containers.

```
./bin/build-mod_cuwebauth.sh
```

You will need to commit the updated version ot `lib/mod_cuwebauth.so` to the repository.

The `build-mod_cuwebauth.sh` script can take an optional command-line argument to select a particular version to build.  The corresponding source tarball _must_ exist in the `cuwal-src/` directory.  Also consider where alterations to the compilation enviromnment or CUWA sources are required when updating versions.

# CUWA Compiliation issues

In the `cuwal-src/` tree, there exists a patch for the bundled `configure` script for cuwal-2.3.0.238.  The stock `configure` script gets stuck trying to probe for `apr_psprintf()`; this patch simply bypasses that probe.

There also exists a patch for `/usr/share/apache2/build/config_vars.mk` on Ubuntu 14.04.  The included APXS version adds CFLAGS that treat `format-security` compiler warnings as _errors_, interrupting the build of `mod_cuwebauth.la`.  While this does not impact the shared object generation, the patch removes that warning as an error and allows the build to complete.

In time, we should circle back around with Identity Management to see if they are aware of these issues.
