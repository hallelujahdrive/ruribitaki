using Rest;

namespace Ruribitaki{
  public void oauth_access_token(Account account,string pin_code)throws Error{
    try{
      //token,token_secretの取得
      account.api_proxy.access_token(FUNCTION_ACCESS_TOKEN,pin_code);
      //stream_apiにtokenの設定;
      account.stream_proxy.set_token(account.api_proxy.get_token());
      account.stream_proxy.set_token_secret(account.api_proxy.get_token_secret());      
    }catch(Error error){
      throw error;
    }
  }
}
