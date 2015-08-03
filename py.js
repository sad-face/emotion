/* sad-face 08/01/2015

These functions handle the custom resizing to make %- and px-positioning and sizing compatible.
*/


function refactorLogin(){

}
function refactorIndex(){
    // called in $(document).ready() in header2.tpl
    var sidebar=document.getElementById("sidebar");
    sidebar.style.height=negHeight(4);   
    

    var body=document.getElementsByTagName("body")[0];
    body.style.backgroundImage="url('"+tpl_url+"/images/space.jpg')";
    body.style.backgroundSize=window.innerWidth+"px "+window.innerHeight+"px";
}
function refactorAny(){
    var body=document.getElementsByTagName("body")[0];
    body.style.backgroundImage="url('"+tpl_url+"/images/space.jpg')";
    body.style.backgroundSize=window.innerWidth+"px "+window.innerHeight+"px";
}

function negWidth(w){
    return window.innerWidth-parseInt(w,10)+"px";
}
function negHeight(h){
    return window.innerHeight-parseInt(h,10)+"px";
}


function refactorSwitch(path){
    refactorAny();
    switch(path){
        case "/login2.php":refactorLogin();break;
        case "/index2.php":refactorIndex();break;
        default:console.log(path);
    }
}