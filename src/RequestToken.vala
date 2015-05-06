using Rest;

namespace Ruribitaki{
  //token_urlの取得
  public string? request_token(Account account) throws Error{
    try{
      account.api_proxy.request_token(FUNCTION_REQUEST_TOKEN,"oob");
      //OAuth認証用URL
      return OAUTH_URL.printf(account.api_proxy.get_token());
    }catch(Error error){
      throw error;
    }
  }
}
