namespace Ruribitaki{
  //hashtagの構造体
  public struct hashtag{
    public int[] indices;
    public string text;
  }
  
  //mediumの構造体
  public struct medium{
    public string display_url;
    public string expanded_url;
    public int[] indices;
    public string media_url;
    public string media_url_https;
    public size sizes_large;
    public size sizes_medium;
    public size sizes_small;
    public size sizes_thumb;
    public string type;
    public string url;
  }
  
  //sizeの構造体  
  public struct size{
    public int h;
    public int w;
    public string resize;
  }
    
  //urlの構造体
  public struct url{
    public string display_url;
    public string expanded_url;
    public int[] indices;
    public string url;
  }
  
  //user_mentionsの構造体
  public struct user_mention{
    public int64 id;
    public string id_str;
    public int[] indices;
    public string name;
    public string screen_name;
  }
}
