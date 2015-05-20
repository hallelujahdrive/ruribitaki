using Json;
using Rest;

namespace Ruribitaki{
  //Userの取得
  public async User users_show(Account account,string? screen_name)throws Error{
    User user=new User();
    Error error=null;
    
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_USERS_SHOW);
    proxy_call.set_method(METHOD_GET);
    proxy_call.add_param(PARAM_SCREEN_NAME,screen_name);
    
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        if(proxy_call.invoke_async.end(res)){
          Parser json_parser=new Parser();
          json_parser.load_from_data(proxy_call.get_payload());
          Json.Node json_node=json_parser.get_root();
          if(json_node!=null){
            user=parse_user(json_node.get_object());
          }
        }
      }catch(Error e){
        error=e;
      }
      users_show.callback();
    });
    
    yield;
    if(error!=null){
      throw error;
    }
    return user;
  }
}
