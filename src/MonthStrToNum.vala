namespace Ruribitaki{
  //月を数字に直す
  private int? month_str_to_num(string month_str){
    int? month=null;
    switch(month_str){
      case "Jan":month=1;
      break;
      case "Feb":month=2;
      break;
      case "Mar":month=3;
      break;
      case "Apr":month=4;
      break;
      case "May":month=5;
      break;
      case "Jun":month=6;
      break;
      case "Jul":month=7;
      break;
      case "Aug":month=8;
      break;
      case "Sep":month=9;
      break;
      case "Oct":month=10;
      break;
      case "Nov":month=11;
      break;
      case "Dec":month=12;
      break;
    }
    return month;
  }
}
