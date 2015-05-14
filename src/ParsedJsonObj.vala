using Json;

namespace Ruribitaki{
  public class ParsedJsonObj{
    //メンバ
    public User user;
    public User sub_user;
    
    public string text;
    public string source_label;
    public string source_url;
    public string id_str;
    
    public string? retweeted_status_id_str;
    
    public hashtag[] hashtags;
    public medium[] media;
    public url[] urls;
        
    public string? in_reply_to_status_id_str;
    
    public bool retweeted=false;
    public bool favorited=false;
    
    public int64 retweet_count=0;
    public int64 favorite_count=0;
    
    public bool is_mine=false;
        
    public ParsedJsonObjType type=ParsedJsonObjType.NULL;
    public EventType? event_type=EventType.NULL;
    public TweetType tweet_type=TweetType.NULL;
    
    public DateTime event_created_at;
    public DateTime created_at;
    
    public ParsedJsonObj(Json.Node? json_node,string? my_screen_name){
      if(json_node!=null){
        Json.Object json_obj=json_node.get_object();
        //jsonを解析
        if(json_obj.has_member("delete")){
          //deleteの解析.json_objはdelete.statusから取得
          type=ParsedJsonObjType.DELETE;
          json_obj=(json_obj.get_object_member("delete")).get_object_member("status");
        }else if(json_obj.has_member("event")){
          //eventの解析.json_objはtargetから取得
          type=ParsedJsonObjType.EVENT;
          foreach(string event_member in json_obj.get_members()){
            switch(event_member){
              case "created_at":event_created_at=parse_created_at(json_obj.get_string_member(event_member));
              break;
              case "event":
              switch(json_obj.get_string_member(event_member)){
                case "access_revoked":event_type=EventType.ACCESS_REVOKED;
                break;
                case "block":event_type=EventType.BLOCK;
                break;
                case "favorite":event_type=EventType.FAVORITE;
                break;
                case "favorited_retweet":event_type=EventType.FAVORITED_RETWEET;
                break;
                case "follow":event_type=EventType.FOLLOW;
                break;
                case "list_created":event_type=EventType.LIST_CREATED;
                break;
                case "list_destroyed":event_type=EventType.LIST_DESTROYED;
                break;
                case "list_member_added":event_type=EventType.LIST_MEMBER_ADDED;
                break;
                case "list_member_removed":event_type=EventType.LIST_MEMBER_REMOVED;
                break;
                case "listuser_subscribed":event_type=EventType.LIST_USER_SUBSCRIBED;
                break;
                case "listuser_unsubscribed":event_type=EventType.LIST_USER_UNSUBSCRIBED;
                break;
                case "list_updated":event_type=EventType.LIST_UPDATED;
                break;
                case "retweeted_retweet":event_type=EventType.RETWEETED_RETWEET;
                break;
                case "unblock":event_type=EventType.UNBLOCK;
                break;
                case "unfavorite":event_type=EventType.UNFAVORITE;
                break;
                case "unfollow":event_type=EventType.UNFOLLOW;
                break;
                case "user_update":event_type=EventType.USER_UPDATE;
                break;
                default :print("Event : %s\n",json_obj.get_string_member(event_member));
                break;
              }
              break;
              case "source":
              //sub_userの取得
              sub_user=parse_user_json_object(json_obj.get_object_member(event_member)); 
              break;
            }
          }
          json_obj=json_obj.get_object_member("target_object");
        }else if(json_obj.has_member("friends")){
          //friendsの解析(現状無視.そのうち書くかも)
          type=ParsedJsonObjType.FRIENDS;
          return;
        }else if(json_obj.has_member("retweeted_status")){
          //retweetの解析.json_objはretweet_statusから取得
          foreach(string retweeted_status_member in json_obj.get_members()){
            switch(retweeted_status_member){
              case "created_at":event_created_at=parse_created_at(json_obj.get_string_member(retweeted_status_member));
              break;
              case "id_str":retweeted_status_id_str=json_obj.get_string_member(retweeted_status_member);
              break;
              case "retweeted_status":json_obj=json_obj.get_object_member(retweeted_status_member);
              break;
              case "user":
              //userの解析
              type=ParsedJsonObjType.RETWEET;
              sub_user=parse_user_json_object(json_obj.get_object_member(retweeted_status_member));
              retweeted=(sub_user.screen_name==my_screen_name);
              break;
            }
          }
        }
        
        foreach(string member in json_obj.get_members()){
          switch(member){
            case "created_at":created_at=parse_created_at(json_obj.get_string_member(member));
            break;
            case "favorited":favorited=json_obj.get_boolean_member(member);
            break;
            case "favorite_count":favorite_count=json_obj.get_int_member(member);
            break;
            case "id_str":id_str=json_obj.get_string_member(member);
            break;
            case "in_reply_to_status_id_str":in_reply_to_status_id_str=json_obj.get_string_member(member);
            break;
            case "retweeted":
            if(!retweeted){
              retweeted=json_obj.get_boolean_member(member);
            }
            break;
            case "retweet_count":retweet_count=json_obj.get_int_member(member);
            break;
            case "source":parse_source(json_obj.get_string_member(member));
            break;
            case "entities":
            case "extended_entities":
            //entitiesの解析
            Json.Object entities_obj=json_obj.get_object_member(member);
            foreach(string entities_member in entities_obj.get_members()){
              var json_array=entities_obj.get_array_member(entities_member);
              switch(entities_member){
                case "media":media=parse_media(json_array);
                break;
                case "hashtags":parse_hashtags(json_array);
                break;
                case "urls":urls=parse_urls(json_array);
                break;
              }
            }
            break;
            case "text":
            text=json_obj.get_string_member(member);
            if(type==ParsedJsonObjType.NULL){
              type=ParsedJsonObjType.TWEET;
            }
            if(my_screen_name!=null&&text.contains(my_screen_name)){
              tweet_type=TweetType.REPLY;
            }
            break;
            //userの解析
            case "user":
            user=parse_user_json_object(json_obj.get_object_member(member));
            is_mine=(user.screen_name==my_screen_name);
            break;
            //多分だけどこれが読み出されるのはDELETEの時だけ
            case "user_id_str":
            user=new User();
            user.id_str=json_obj.get_string_member(member);
            break;
          }
        }

      }
    }
    
    public ParsedJsonObj.from_string(string json_str,string? screen_name){
      //json_obj
      Json.Parser json_parser=new Json.Parser();
      try{
        json_parser.load_from_data(json_str);
        this(json_parser.get_root(),screen_name);
      }catch(Error e){
        print("Error %s\n",e.message);
      }
    }
    //created_atのparse
    private DateTime? parse_created_at(string created_at_str){
      DateTime created_at=null;
      try{  //セイキヒョウゲンカッコバクショウで投稿日時を解析
        var created_at_regex_replace=new Regex("(:)");
        string created_at_regex=created_at_regex_replace.replace(created_at_str,-1,0," ");
        string[] created_at_split=created_at_regex.split(" ");
        int month=month_str_to_num(created_at_split[1]);
        int day=int.parse(created_at_split[2]);
        int hour=int.parse(created_at_split[3]);
        int minute=int.parse(created_at_split[4]);
        int second=int.parse(created_at_split[5]);
        int year=int.parse(created_at_split[7]);
        created_at=new DateTime.utc(year,month,day,hour,minute,second);
      }catch(Error e){
        print("%s\n",e.message);
      }
      return created_at;
    }
    
    //hashtagの解析
    private void parse_hashtags(Json.Array hashtags_json_array){
      hashtags=new hashtag[hashtags_json_array.get_length()];
      for(int i=0;i<hashtags_json_array.get_length();i++){
        Json.Object hashtags_json_obj=hashtags_json_array.get_object_element(i);
        foreach(string member in hashtags_json_obj.get_members()){
          switch(member){
            case "indices":
            Json.Array indices_json_array=hashtags_json_obj.get_array_member(member);
            hashtags[i].indices=new int[indices_json_array.get_length()];
            for(int j=0;j<indices_json_array.get_length();j++){
              hashtags[i].indices[j]=(int)indices_json_array.get_int_element(j);
            }
            break;
            case "text":hashtags[i].text=hashtags_json_obj.get_string_member(member);
            break;
          }
        }
      }
    }
    private void parse_source(string get_source){
      string[] source_split={"",""};
      //セイキヒョウゲンカッコバクショウでクライアント名とURLを解析
      try{
        var source_regex_replace=new Regex("(<a href=|rel=\"nofollow\"|\"|</a>)");
        string source_regex=source_regex_replace.replace(get_source,-1,0,"");
        source_split=source_regex.split(">");
      }catch(Error e){
        print("%s\n",e.message);
      }
      //配列からコンストラクタに格納
      source_label=source_split[1];
      source_url=source_split[0];
    }
  }
}
