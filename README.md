  
# AnimatedSearchBar  [![pub package](https://img.shields.io/pub/v/animated_search_bar.svg)](https://pub.dev/packages/animated_search_bar)
A Beautiful and Simple SearchBar widget with animation transition. It can be fully customized with label, labelStyle, searchDecoration, etc. It also maintains onChange state.  
  
## Getting Started  
  
In the `pubspec.yaml` of your flutter project, add the following dependency:  
  
```yaml  
dependencies:  
 ... animated_search_bar: "^1.0.0"
 ```  
  
Import it:  
  
```dart  
import 'package:flutter_search_bar/animated_search_bar.dart';
```  
  
## Usage Examples  
  
```
String searchText="";

AnimatedSearchBar(  
  label: "Search Something Here",  
  onChanged: (value) {  
    print("value on Change");  
    setState(() {  
      searchText = value;  
    });  
  },  
),
```
  
  
## Available Parameters  
| Param | isRequired |  
|--|--|  
| **String** label | No |  
| **Function(String)** onChanged | No |  
| **TextStyle** labelStyle | No |  
| **InputDecoration** searchDecoration | No |  
| **int** animationDuration *in milliseconds* | No |  
| **TextStyle** searchStyle  | No |  
| **Color** cursorColor| No |  
---  
<h3 align="center">Buy me coffee if you love my works ☕️</h3>  
<p align="center">  
  <a href="https://ko-fi.com/ukietux" target="_blank">  
    <img src="https://help.ko-fi.com/system/photos/3604/0095/9793/logo_circle.png" alt="ko-fi" style="vertical-align:top; margin:8px" height="40">  
  </a>&nbsp;&nbsp;&nbsp;&nbsp;  
  <a href="https://www.buymeacoffee.com/ukieTux" target="_blank">  
    <img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" alt="buymeacoffe" style="vertical-align:top; margin:8px" height="40">  
  </a>&nbsp;&nbsp;&nbsp;&nbsp;  
  <a href="https://paypal.me/ukieTux" target="_blank">  
    <img src="https://blog.zoom.us/wp-content/uploads/2019/08/paypal.png" alt="paypal" style="vertical-align:top; margin:8px" height="40">  
  </a>  
</p>  
<br><br>