using Json;

namespace Ruribitaki{
  public class Status:GLib.Object{
    //メンバ
    public DateTime created_at;
    
    public hashtag[]? entities_hashtags;
    public medium[]? entities_media;
    public medium[]? extended_entities_media;
    public url[]? entities_urls;
    public user_mention[]? entities_user_mentions;
    
    public int64 favorite_count=0;
    public bool favorited=false;
    
    public int64? id;
    public string? id_str;
    
    public string? in_reply_to_screen_name;
    public int64? in_reply_to_status_id;
    public string? in_reply_to_status_id_str;
    public int64? in_reply_to_user_id;
    public string? in_reply_to_user_id_str;
    
    public string? lang;
    
    public int64 retweet_count=-1;
    public bool retweeted=false;
    
    public string? source;
    public string? source_label;
    public string? source_url;
    
    public string? text;
    
    public string timespamp_ms;
    
    public User user;
    
    public bool is_mine=false;
    public bool is_reply=false;
    
    public StatusType status_type=StatusType.NULL;
    
    //eventのメンバ
    public EventType event=EventType.NULL;
    public User? target;
        
    //event,retweet共通
    public Status? target_status=null;
        
    public Status(Json.Object json_obj,string? my_screen_name){
      //jsonを解析
      //deleteだけあまりに構造が特殊なので少し解析方法を変える
      if(json_obj.has_member("delete")){
        status_type=StatusType.DELETE;
        //json_objはdelete.statusから取得
        json_obj=json_obj.get_object_member("delete");
        timespamp_ms=json_obj.get_string_member("timestamp_ms");
        json_obj=json_obj.get_object_member("status");
        user=new User();
      }
      
      foreach(string member in json_obj.get_members()){
        switch(member){
          case "created_at":created_at=parse_created_at(json_obj.get_string_member(member));
          break;
          case "entities":
          //entitiesの解析
          Json.Object entities_obj=json_obj.get_object_member(member);
          foreach(string entities_member in entities_obj.get_members()){
            var json_array=entities_obj.get_array_member(entities_member);
            switch(entities_member){
              case "hashtags":entities_hashtags=parse_hashtags(json_array);
              break;
              case "media":entities_media=parse_media(json_array);
              break;
              case "urls":entities_urls=parse_urls(json_array);
              break;
              case "user_mentions":entities_user_mentions=parse_user_mentions(json_array,my_screen_name);
              break;
            }
          }
          break;
          case "event":
          status_type=StatusType.EVENT;
          switch(json_obj.get_string_member(member)){
            case "access_revoked":event=EventType.ACCESS_REVOKED;
            break;
            case "block":event=EventType.BLOCK;
            break;
            case "favorite":event=EventType.FAVORITE;
            break;
            case "favorited_retweet":event=EventType.FAVORITED_RETWEET;
            break;
            case "follow":event=EventType.FOLLOW;
            break;
            case "list_created":event=EventType.LIST_CREATED;
            break;
            case "list_destroyed":event=EventType.LIST_DESTROYED;
            break;
            case "list_member_added":event=EventType.LIST_MEMBER_ADDED;
            break;
            case "list_member_removed":event=EventType.LIST_MEMBER_REMOVED;
            break;
            case "listuser_subscribed":event=EventType.LIST_USER_SUBSCRIBED;
            break;
            case "listuser_unsubscribed":event=EventType.LIST_USER_UNSUBSCRIBED;
            break;
            case "list_updated":event=EventType.LIST_UPDATED;
            break;
            case "retweeted_retweet":event=EventType.RETWEETED_RETWEET;
            break;
            case "unblock":event=EventType.UNBLOCK;
            break;
            case "unfavorite":event=EventType.UNFAVORITE;
            break;
            case "unfollow":event=EventType.UNFOLLOW;
            break;
            case "user_update":event=EventType.USER_UPDATE;
            break;
            default:
            //print("Event : %s\n",json_obj.get_string_member(event_member));
            break;
          }
          break;
          //extended_entitiesの解析
          case "extended_entities":
          Json.Object extended_entities_obj=json_obj.get_object_member(member);
          foreach(string extended_entities_member in extended_entities_obj.get_members()){
            Json.Array json_array=extended_entities_obj.get_array_member(extended_entities_member);
            switch(extended_entities_member){
              case "media":extended_entities_media=parse_media(json_array);
              break;
            }
          }
          break;
          case "friends":status_type=StatusType.FRIENDS;
          break;
          case "favorited":favorited=json_obj.get_boolean_member(member);
          break;
          case "favorite_count":favorite_count=json_obj.get_int_member(member);
          break;
          case "id":id=get_int_member_from_node(json_obj.get_member(member));
          break;
          case "id_str":id_str=json_obj.get_string_member(member);
          break;
          case "in_reply_to_screen_name":
          in_reply_to_screen_name=json_obj.get_string_member(member);
          //リプライの判定
          is_reply=in_reply_to_screen_name==my_screen_name;
          break;
          case "in_reply_to_status_id":in_reply_to_status_id=get_int_member_from_node(json_obj.get_member(member));
          break;
          case "in_reply_to_status_id_str":in_reply_to_status_id_str=json_obj.get_string_member(member);
          break;
          case "in_reply_to_user_id":in_reply_to_user_id=get_int_member_from_node(json_obj.get_member(member));
          break;
          case "in_reply_to_user_id_str":in_reply_to_user_id_str=json_obj.get_string_member(member);
          break;
          case "lang":lang=json_obj.get_string_member(member);
          break;
          case "retweet_count":retweet_count=json_obj.get_int_member(member);
          break;
          case "retweeted":retweeted=json_obj.get_boolean_member(member);
          break;
          case "retweeted_status":
          status_type=StatusType.RETWEET;
          target_status=new Status(json_obj.get_object_member(member),my_screen_name);
          break;
          //sourceの解析(eventでのsourceはユーザー情報な事に注意)
          case "source":
          Json.Node json_node=json_obj.get_member(member);
          if(json_node.get_node_type()==Json.NodeType.VALUE){
            source=json_node.get_string();
            parse_source(source);
          }else{
            user=parse_user(json_node.get_object());
          }
          break;
          case "target_object":target_status=new Status(json_obj.get_object_member(member),my_screen_name);
          break;
          case "text":
          text=json_obj.get_string_member(member);
          if(status_type==StatusType.NULL){
            status_type=StatusType.TWEET;
          }
          break;
          //userの解析
          case "user":
          user=parse_user(json_obj.get_object_member(member));
          is_mine=user.screen_name==my_screen_name;
          break;
          //多分だけどこれ2つ読み出されるのはDELETEの時だけ
          case "user_id":user.id=json_obj.get_int_member(member);
          break;
          case "user_id_str":user.id_str=json_obj.get_string_member(member);
          break;
        }
      }
      //Twitterのバグかなんかで,user_streamではretweetedが反映されないので強引に上書き
      if(json_obj.has_member("retweeted_status")){
         target_status.retweeted=is_mine; 
      }
    }
    
    //nullかint64を返す
    private int64? get_int_member_from_node(Json.Node json_node){
      if(json_node.get_node_type()!=Json.NodeType.NULL){
        return json_node.get_int();
      }else{
        return null;
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
    private hashtag[] parse_hashtags(Json.Array json_array){
      hashtag[] hashtags=new hashtag[json_array.get_length()];
      for(int i=0;i<json_array.get_length();i++){
        Json.Object json_obj=json_array.get_object_element(i);
        foreach(string member in json_obj.get_members()){
          switch(member){
            case "indices":hashtags[i].indices=parse_indices(json_obj.get_array_member(member));
            break;
            case "text":hashtags[i].text=json_obj.get_string_member(member);
            break;
          }
        }
      }
      return hashtags;
    }
    
    //user_mentionsの解析
    private user_mention[] parse_user_mentions(Json.Array json_array,string? my_screen_name){
      user_mention[] user_mentions=new user_mention[json_array.get_length()];
      for(int i=0;i<json_array.get_length();i++){
        Json.Object json_obj=json_array.get_object_element(i);
        foreach(string member in json_obj.get_members()){
          switch(member){
            case "id":user_mentions[i].id=json_obj.get_int_member(member);
            break;
            case "id_str":user_mentions[i].id_str=json_obj.get_string_member(member);
            break;
            case "indices":user_mentions[i].indices=parse_indices(json_obj.get_array_member(member));
            break;
            case "name":user_mentions[i].name=json_obj.get_string_member(member);
            break;
            case "screen_name":
            user_mentions[i].screen_name=json_obj.get_string_member(member);
            //リプライの判定
            is_reply=user_mentions[i].screen_name==my_screen_name;
            break;
          }
        }
      }
      return user_mentions;
    }
    
    //source(クライアントの解析)
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
      source_label=source_split[1];
      source_url=source_split[0];
    }
  }
}
