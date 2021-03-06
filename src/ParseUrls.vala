using Json;

namespace Ruribitaki{
  //urlの解析
  private url[] parse_urls(Json.Array urls_json_array){
    url[] urls=new url[urls_json_array.get_length()];
    for(int i=0;i<urls_json_array.get_length();i++){
      Json.Object urls_json_obj=urls_json_array.get_object_element(i);
      foreach(string member in urls_json_obj.get_members()){
        switch(member){
          case "display_url":urls[i].display_url=urls_json_obj.get_string_member(member);
          break;
          case "expanded_url":urls[i].expanded_url=urls_json_obj.get_string_member(member);
          break;
          case "indices":urls[i].indices=parse_indices(urls_json_obj.get_array_member(member));
          break;
          case "url":urls[i].url=urls_json_obj.get_string_member(member);
          break;
        }
      }
    }
    return urls;
  }
}
