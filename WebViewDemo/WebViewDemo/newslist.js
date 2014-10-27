
self.onload = function(listnew){

    var str = listnew + '也能编程';
    var val = document.getElementsByTagName('input');
    for(var i = 0; i < val.length; i++) {
        var tps = val[i].getAttribute('type');
        if(tps == 'search') {
            val[i].value = '呵呵一下';
            alert(2)
        }else if (tps == 'submit') {
            val[i].value = '呵呵一下';
            alert(1)
        }
        if(tps == 'text') {
            alert(tps)
        }
    }
    
//    var str=listnew.split(',');
//    $(function(){
//      
//      var spa = document.getElementsByTagName('span');
//      var count = spa.length - str.length-1;
//      spa[0].innerHTML = '您有<i>'+count+'</i>条未读消息'
//      
//      for(var j = 0; j < str.length; j++) {
//          for(var i = 0; i < spa.length; i++) {
//              var news = spa[i];
//              var newsid =news.getAttribute('newsid');
//                  var v = str[j];
//                  if(v == newsid) {
//                      news.className = 'i03 newslist';
//                  }
//          }
//      }
//    })
}

function getElementsByClassName(className, parentElement){
    var elems = ($(parentElement)||document.body).getElementsByTagName("*");
    var result=[];
    for (i=0; j=elems[i]; i++){
        if ((" "+j.className+" ").indexOf(" "+className+" ")!=-1){
            result.push(j);
        }
    }
    return result;
}

document.getElementsByClassName = function(className,oBox) {
    //适用于获取某个HTML区块内部含有某一特定className的所有HTML元素
    this.d= oBox || document;
    var children = this.d.getElementsByTagName('*') || document.all;
    var elements = new Array();
    for (var ii = 0; ii < children.length; ii++) {
        var child = children[ii];
        var classNames = child.className.split(' ');
        for (var j = 0; j < classNames.length; j++) {
            if (classNames[j] == className) {
                elements.push(child);
                break;
            }
        }
    }
    return elements;
}

document.getElementsByType = function(sTypeValue,oBox) {
    //适用于获取某个HTML区块内部同属于某一特定type的所有HTML元素，如:input,script,link等等
    this.d= oBox || document;
    var children = this.d.getElementsByTagName('*') || document.all;
    var elements = new Array();
    for (var ii = 0; ii < children.length; ii++) {
        if (children[ii].type == sTypeValue) {
            elements.push(children[ii]);
        }
    }
    return elements;
}

function $() {
    var elements = new Array();
    for (var ii = 0; ii < arguments.length; ii++) {
        var element = arguments[ii];
        if (typeof element == 'string')
            element = document.getElementById(element);
        if (arguments.length == 1)
            return element;
        elements.push(element);
    }
    return elements;
}

$Cls = function (s,o){
    return document.getElementsByClassName(s,o);
};

$Type = function (s,o){
    return document.getElementsByType(s,o);
};

$Tag = function (s,o){
    this.d=o || document;
    return this.d.getElementsByTagName(s);
};

$Name = function (s){ //通过name的方式只能针对整个document而言，不能为其限定范围
    return document.getElementsByName(s);
}