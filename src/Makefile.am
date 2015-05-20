AUTOMAKE_OPTIONS = subdir-objects

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
				Entities.vala \
				Enums.vala \
				MonthStrToNum.vala \
				ParseIndices.vala \
				ParseMedia.vala \
				ParseUrls.vala \
				ParseUserJsonObject.vala \
				Status.vala \
				TwitterUrls.vala \
				User.vala \
				UserStream.vala \
				rest_apis/AccountVerifyCredential.vala \
				rest_apis/FavoritesCreate.vala \
				rest_apis/FavoritesDestroy.vala \
				rest_apis/Functions.vala \
				rest_apis/Methods.vala \
				rest_apis/OAuthAccessToken.vala \
				rest_apis/Parameters.vala \
				rest_apis/RequestToken.vala \
				rest_apis/StatusesHomeTimeline.vala \
				rest_apis/StatusesMentionTimeline.vala \
				rest_apis/StatusesDestroy.vala \
				rest_apis/StatusesRetweet.vala \
				rest_apis/StatusesShow.vala \
				rest_apis/StatusesTimeline.vala \
				rest_apis/StatusesUpdate.vala \
				rest_apis/UsersShow.vala

csources = $(sources:.vala=.c)

ruribitaki.vapi ruribitaki.h libruribitaki_la_vala.stamp : $(sources)
	@$(VALAC) $^ --vapi=ruribitaki.vapi -C --header ruribitaki.h @RURI_VALA_FLAGS@
	
libruribitaki_la_LIBADD = @RURI_LIBS@
libruribitaki_la_LDFLAGS= -X -shared -X -fPIC -vsrsion-info 0:0:0
libruribitaki_la_VALASOURCES = $(sources)
libruribitaki_la_SOURCES = libruribitaki_la_vala.stamp \
															 $(csources)

CLEANFILES = *.c *.h *.o *.lo *.lib *.vapi .libs/* rest_apis/*.c rest_apis/*.h rest_apis/*.o rest_apis/*.lo
EXTRA_DIST = $(sources)
