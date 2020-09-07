if (document.URL.match( /new/ )){
function calculator() {
  const figure = document.getElementById("item-price");
  figure.addEventListener("keyup", (e) => {
    let num = document.getElementById("item-price");
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    let money = ( num.value / 10)
    taxPrice.innerHTML = `${ Math.floor(money) }`;
    profit.innerHTML = `${ Math.floor(num.value - money) }`
  })
};

window.addEventListener( "DOMContentLoaded" , calculator )
}