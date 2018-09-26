

test "$GLIBC_VERSION" = "" && GLIBC_VERSION="`ldd --version | head -n 1 | grep -oE '[^ ]+$'`"

if [ ""$GLIBC_VERSION>2.26" | bc" ]; then

	patch -p1 <../patches/glibc_memfd.diff || exit 1
	patch -p1 <../patches/glibc_configure.diff || exit 1

fi