
var script = document.createElement('script');
script.type = 'text/javascript';script.text =

setTimeout(sendMessage,100);
function sendMessage(txt){
    if (txt.length<=0)return;
    var para=document.createElement("p");
    var node=document.createTextNode("OC Send: "+txt);
	para.appendChild(node);
	var element=document.getElementById("div1");
	element.appendChild(para);
}
