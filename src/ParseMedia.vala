using Json;

namespace Ruribitaki{
  //urlの解析
  private media[] parse_media(Json.Array media_json_array){
    media[] media=new media[media_json_array.get_length()];
    for(int i=0;i<media_json_array.get_length();i++){
      Json.Object media_json_obj=media_json_array.get_object_element(i);
      foreach(string member in media_json_obj.get_members()){
        switch(member){
          case "display_url":media[i].display_url=media_json_obj.get_string_member(member);
          break;
          case "expanded_url":media[i].expanded_url=media_json_obj.get_string_member(member);
          break;
          case "media_url":media[i].media_url=media_json_obj.get_string_member(member);
          break;
          case "media_url_https":media[i].media_url_https=media_json_obj.get_string_member(member);
          break;
          case "type":media[i].type=media_json_obj.get_string_member(member);
          break;
          case "url":media[i].url=media_json_obj.get_string_member(member);
          break;
          case "indices":
          Json.Array indices_json_array=media_json_obj.get_array_member(member);
          media[i].indices=new int[indices_json_array.get_length()];
          for(int j=0;j<indices_json_array.get_length();j++){
            media[i].indices[j]=(int)indices_json_array.get_int_element(j);
          }
          break;
          case "sizes":
          Json.Object sizes_json_obj=media_json_obj.get_object_member(member);
          foreach(string sizes_member in sizes_json_obj.get_members()){
            Json.Object size_json_obj=sizes_json_obj.get_object_member(sizes_member);
            size size=size();
            foreach(string size_member in size_json_obj.get_members()){
              switch(size_member){
                case "h":size.h=(int)size_json_obj.get_int_member(size_member);
                break;
                case "resize":size.resize=size_json_obj.get_string_member(size_member);
                break;
                case "w":size.h=(int)size_json_obj.get_int_member(size_member);
                break;
              }
            }
            switch(sizes_member){
              case "large":media[i].sizes_large=size;
              break;
              case "medium":media[i].sizes_medium=size;
              break;
              case "small":media[i].sizes_small=size;
              break;
              case "thumb":media[i].sizes_thumb=size;
              break;
            }
          }
          break;
        }
      }
    }
    return media;
  }
}
