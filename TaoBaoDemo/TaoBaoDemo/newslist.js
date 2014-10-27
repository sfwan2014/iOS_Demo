
self.onload = function(){
      var spa = document.getElementsByTagName('iframe');

//      alert(spa[0].getAttribute('width'));
    spa[0].width = 320;
//    alert(spa[0].width);
    document.forms[0].submit();
}