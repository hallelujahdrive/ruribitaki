#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([ruribitaki], [0.1], [hallelujahdrive@gmail.com])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])

# Checks for programs.
LT_PREREQ([2.4.2])
LT_INIT
AC_PROG_CC
AC_PROG_CC_STDC
AM_PROG_LIBTOOL
AM_PROG_VALAC([0.26])
AC_PROG_INSTALL

# Checks for libraries.
pkg_modules="
	glib-2.0
	json-glib-1.0
	rest-0.7
	"
PKG_CHECK_MODULES(RURI,[$pkg_modules])
# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
RURI_VALA_FLAGS=" \
	--pkg glib-2.0 \
	--pkg json-glib-1.0 \
	--pkg rest-0.7
	"

#includedir=${prefix}/include
libdir=${prefix}/lib
pcdir=${prefix}/lib/pkgconfig
vapidir=${prefix}/share/vala/vapi

AC_SUBST(RURI_CFLAGS)
AC_SUBST(RURI_LIBS)
AC_SUBST(RURI_VALA_FLAGS)
AC_SUBST(includedir)
AC_SUBST(libdir)
AC_SUBST(pcdir)
AC_SUBST(vapidir)

AC_CHECK_FUNCS([atexit memchr memset setlocale strstr])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/ruribitaki.pc])
AC_OUTPUT
echo "$RURI_LIBS"
