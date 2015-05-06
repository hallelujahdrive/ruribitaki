using Rest;

namespace Ruribitaki{
  //ツイートの取得
  public async ParsedJsonObj? statuses_show(Account account,string id_str)throws Error{
    ParsedJsonObj parsed_json_obj=null;
    Error error=null;
    
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_STATUSES_SHOW);
    proxy_call.set_method(METHOD_GET);
    proxy_call.add_param(PARAM_ID,id_str);
    
    proxy_call.invoke_async.begin(null,(obj,res)=>{
      try{
        if(proxy_call.invoke_async.end(res)){
          parsed_json_obj=new ParsedJsonObj.from_string(proxy_call.get_payload(),account.screen_name);
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
    return parsed_json_obj;
  }
}
