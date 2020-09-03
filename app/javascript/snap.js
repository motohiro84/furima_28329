function jssnap() {

const jsnap = document.getElementById("jsnap");
if ( jsnap ){
let num = 0;
console.log(jsnap)

const susumu = document.getElementById("susumu");
susumu.addEventListener( "click" , susumujs )
function susumujs(){
  if(num+1 < jsnap.children.length){
  var child = jsnap.children[num+1];
  child.scrollIntoView({
    behavior:"smooth",
    block:"nearest",
    inline:"nearest",
  });
  num++;
  }
  else {
    return;
  }
}

const modoru = document.getElementById("modoru");
modoru.addEventListener( "click" , modorujs )
function modorujs(){
  if(num-1 >= 0){
  var child = jsnap.children[num-1];
  child.scrollIntoView({
    behavior:"smooth",
    block:"nearest",
    inline:"nearest",
  });
  num--;
  }
  else {
    return;
  }
}
}}

window.addEventListener( "load" , jssnap )