using Json;
using Rest;

namespace Ruribitaki{
  //アカウント情報の取得
  public bool account_verify_credential(Account account){
    //prox_call
    ProxyCall proxy_call=account.api_proxy.new_call();
    proxy_call.set_function(FUNCTION_ACCOUNT_VERIFY_CREDENTIALS);
    proxy_call.set_method("GET");
    try{
      proxy_call.run();
      Parser parser=new Parser();
      parser.load_from_data(proxy_call.get_payload());
      Json.Node node=parser.get_root();
      Json.Object object=node.get_object();
      parse_profile_json_object(account,object);
      return true;
    }catch(Error e){
      print("Account Verify Error:%s\n",e.message);
      return false;
    }
  }
}
