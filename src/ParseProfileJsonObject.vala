using Json;

namespace Ruribitaki{
  //プロファイルの解析
  private void parse_profile_json_object(Account account,Json.Object profile_json_object){
    //jsonの解析
    foreach(string member in profile_json_object.get_members()){
      switch(member){
        case "screen_name": account.screen_name=profile_json_object.get_string_member(member);
        break;
        case "id": account.id=profile_json_object.get_int_member(member);
        break;
        case "profile_image_url": account.profile_image_url=profile_json_object.get_string_member(member);
        break;
        case "time_zone":account.time_zone=profile_json_object.get_string_member(member);
        break;
      }
    }
  }
}
