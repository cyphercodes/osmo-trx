# ===========================================================================
#          http://www.gnu.org/software/autoconf-archive/ax_ext.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_SSE
#
# DESCRIPTION
#
#   Find SIMD extensions supported by compiler. The -m"simdextensionname" is
#   added to SIMD_FLAGS if compiler supports it. For example, if "sse2" is
#   available, then "-msse2" is added to SIMD_FLAGS.
#
#   This macro calls:
#
#     AC_SUBST(SIMD_FLAGS)
#
#   And defines:
#
#     HAVE_SSE3 / HAVE_SSE4.1
#
# LICENSE
#
#   Copyright (c) 2007 Christophe Tournayre <turn3r@users.sourceforge.net>
#   Copyright (c) 2013 Michael Petch <mpetch@capp-sysware.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.
#
# NOTE: The functionality that requests the cpuid has been stripped because
#       this project detects the CPU capabilities during runtime. However, we
#       still need to check if the compiler supports the requested SIMD flag

#serial 12

AC_DEFUN([AX_SSE],
[
  AC_REQUIRE([AC_CANONICAL_HOST])

  AM_CONDITIONAL(HAVE_SSE3, false)
  AM_CONDITIONAL(HAVE_SSE4_1, false)

  case $host_cpu in
    i[[3456]]86*|x86_64*|amd64*)
      AX_CHECK_COMPILE_FLAG(-msse3, ax_cv_support_sse3_ext=yes, [])
      if test x"$ax_cv_support_sse3_ext" = x"yes"; then
        SIMD_FLAGS="$SIMD_FLAGS -msse3"
        AC_DEFINE(HAVE_SSE3,,
          [Support SSE3 (Streaming SIMD Extensions 3) instructions])
        AM_CONDITIONAL(HAVE_SSE3, true)
      else
        AC_MSG_WARN([Your compiler does not support SSE3 instructions])
      fi

      AX_CHECK_COMPILE_FLAG(-msse4.1, ax_cv_support_sse41_ext=yes, [])
      if test x"$ax_cv_support_sse41_ext" = x"yes"; then
        SIMD_FLAGS="$SIMD_FLAGS -msse4.1"
        AC_DEFINE(HAVE_SSE4_1,,
          [Support SSE4.1 (Streaming SIMD Extensions 4.1) instructions])
        AM_CONDITIONAL(HAVE_SSE4_1, true)
      else
        AC_MSG_WARN([Your compiler does not support SSE4.1])
      fi
  ;;
  esac

  AC_SUBST(SIMD_FLAGS)
])
