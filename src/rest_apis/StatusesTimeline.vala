using Json;
using Rest;

namespace Ruribitaki{
  private GLib.Array<Status> statuses_timeline(ProxyCall proxy_call,string screen_name)throws Error{
    //戻り値
    GLib.Array<Status> status_array=new GLib.Array<Status>();
    //取得
    try{
      proxy_call.run();
      string jsons_str=proxy_call.get_payload();
      //debug
      //print("%s\n",jsons_str);
      //json_obj
      Json.Parser json_parser=new Json.Parser();
      json_parser.load_from_data(jsons_str);
      Json.Node json_node=json_parser.get_root();
      if(json_node!=null){
         Json.Array json_array=json_node.get_array();
         for(uint i=0;i<json_array.get_length();i++){
           status_array.append_val(new Status(json_array.get_object_element(i),screen_name));
         }
       }
    }catch(Error error){
      throw error;
    }
    return status_array;
  }
}
