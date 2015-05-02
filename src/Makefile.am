#AUTOMAKE_OPTIONS = subdir-objects
AM_CPPFLAGS = $(RURI_CFLAGS)

lib_LTLIBRARIES = libruribitaki.la

include_HEADERS = ruribitaki.h

pc_DATA = ruribitaki.pc

vapi_DATA = \
						ruribitaki.deps \
						ruribitaki.vapi 

sources = \
				Account.vala \
				AccountVerifyCredential.vala \
				Enums.vala \
				FavoritesCreate.vala \
				FavoritesDestroy.vala \
				MonthStrToNum.vala \
				OauthAccessToken.vala \
				ParseProfileJson.vala \
				ParsedJsonObj.vala \
				RequestToken.vala \
				StatusesHomeTimeline.vala \
				StatusesMentionTimeline.vala \
				StatusesDestroy.vala \
				StatusesRetweet.vala \
				StatusesShow.vala \
				StatusesTimeline.vala \
				StatusesUpdate.vala \
				Strings.vala \
				Struct.vala \
				User.vala \
				UserStream.vala

csources = $(sources:.vala=.c)

ruribitaki.vapi ruribitaki.h $(csources) : $(sources)
	@$(VALAC) $^ --vapi=ruribitaki.vapi -C --header ruribitaki.h @RURI_VALA_FLAGS@
	touch ruribitaki.vapi ruribitaki.h

libruribitaki_la_LIBADD = @RURI_LIBS@
libruribitaki_la_LDFLAGS= -module -X -shared -X -fPIC -vsrsion-info 0:0:0
libruribitaki_la_VALASOURCES = $(sources)
libruribitaki_la_SOURCES = $(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi Makefile .deps/* .libs/*
EXTRA_DIST = $(sources)
