using Rest;

namespace Ruribitaki{
  //apiによるjsonの取得(mention)
  public Array<ParsedJsonObj> statuses_mention_timeline(Account account,int count)throws Error{
    ProxyCall proxy_call=account.api_proxy.new_call();
    
    proxy_call.set_function(FUNCTION_STATUSES_MENTIONS_TIMELINE);
    //proxy_callのパラメータ
    proxy_call.set_method(METHOD_GET);
    proxy_call.add_param(PARAM_COUNT,count.to_string());
    
    
    try{
      return statuses_timeline(proxy_call,account.screen_name);
    }catch(Error error){
      throw error;
    }
  }
}
