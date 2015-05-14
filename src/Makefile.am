#AUTOMAKE_OPTIONS = subdir-objects
AM_CPPFLAGS = $(RURI_CFLAGS)

BUILT_SOURCES = libruribitaki_la_vala.stamp

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
				Functions.vala \
				Hashtag.vala \
				Medium.vala \
				Methods.vala \
				MonthStrToNum.vala \
				OAuthAccessToken.vala \
				Parameters.vala \
				ParsedJsonObj.vala \
				ParseMedia.vala \
				ParseProfileJsonObject.vala \
				ParseUrls.vala \
				ParseUserJsonObject.vala \
				RequestToken.vala \
				Size.vala \
				StatusesHomeTimeline.vala \
				StatusesMentionTimeline.vala \
				StatusesDestroy.vala \
				StatusesRetweet.vala \
				StatusesShow.vala \
				StatusesTimeline.vala \
				StatusesUpdate.vala \
				TwitterUrls.vala \
				Url.vala \
				User.vala \
				UserStream.vala

csources = $(sources:.vala=.c)

ruribitaki.vapi ruribitaki.h libruribitaki_la_vala.stamp : $(sources)
	@$(VALAC) $^ --vapi=ruribitaki.vapi -C --header ruribitaki.h @RURI_VALA_FLAGS@
	
libruribitaki_la_LIBADD = @RURI_LIBS@
libruribitaki_la_LDFLAGS= -X -shared -X -fPIC -vsrsion-info 0:0:0
libruribitaki_la_VALASOURCES = $(sources)
libruribitaki_la_SOURCES = libruribitaki_la_vala.stamp \
															 $(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi .libs/*
EXTRA_DIST = $(sources)
