using Rest;

namespace Ruribitaki{
  //ツイートの取得
  public async Status? statuses_show(Account account,string id_str)throws Error{
    Status status=null;
    Error error=null;
    
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_STATUSES_SHOW);
    proxy_call.set_method(METHOD_GET);
    proxy_call.add_param(PARAM_ID,id_str);
    
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        if(proxy_call.invoke_async.end(res)){
          Json.Parser json_parser=new Json.Parser();
          json_parser.load_from_data(proxy_call.get_payload());
          Json.Node json_node=json_parser.get_root();
          if(json_node!=null){
            status=new Status(json_node.get_object(),account.screen_name);
          }
        }
      }catch(Error e){
        error=e;
      }
      statuses_show.callback();
    });
    
    yield;
    if(error!=null){
      throw error;
    }
    return status;
  }
}
