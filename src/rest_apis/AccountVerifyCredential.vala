using Json;
using Rest;

namespace Ruribitaki{
  //アカウント情報の取得
  public void account_verify_credential(Account account)throws Error{
    //prox_call
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_ACCOUNT_VERIFY_CREDENTIALS);
    proxy_call.set_method(METHOD_GET);
    try{
      proxy_call.run();
      Parser parser=new Parser();
      parser.load_from_data(proxy_call.get_payload());
      Json.Node node=parser.get_root();
      Json.Object object=node.get_object();
      parse_user(object,account);
    }catch(Error error){
      throw error;
    }
  }
}
