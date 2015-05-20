using Json;

namespace Ruribitaki{
  private User parse_user(Json.Object user_json_object,User? account=null){
    User user=account??new User();
    foreach(string user_member in user_json_object.get_members()){
      switch(user_member){
        case "name":user.name=user_json_object.get_string_member(user_member);
        break;
        case "id":user.id=user_json_object.get_int_member(user_member);
        break;
        case "id_str":user.id_str=user_json_object.get_string_member(user_member);
        break;
        case "profile_image_url":user.profile_image_url=user_json_object.get_string_member(user_member);
        break;
        case "protected":user.protected=user_json_object.get_boolean_member(user_member);
        break;
        case "screen_name":user.screen_name=user_json_object.get_string_member(user_member);
        break;
      }
    }
    return user;
  }
}

