//enum
namespace Ruribitaki{
  //ParsedJsonObjのtype
  public enum ParsedJsonObjType{
    DELETE,
    EVENT,
    FRIENDS,
    NULL,
    RETWEET,
    TWEET;
  }
  
  //eventのtype.NULLは暫定
  public enum EventType{
    ACCESS_REVOKED,
    BLOCK,
    FAVORITE,
    FAVORITED_RETWEET,
    FOLLOW,
    LIST_CREATED,
    LIST_DESTROYED,
    LIST_MEMBER_ADDED,
    LIST_MEMBER_REMOVED,
    LIST_USER_UNSUBSCRIBED,
    LIST_UPDATED,
    LIST_USER_SUBSCRIBED,
    RETWEETED_RETWEET,
    UNBLOCK,
    UNFAVORITE,
    UNFOLLOW,
    USER_UPDATE,
    NULL;
  }
  
  //tweetのtype
  public enum TweetType{
    NORMAL,
    NULL,
    REPLY;
  }
}
