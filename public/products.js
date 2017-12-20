
const databaseCards = [];
const cart = [];

const cartDiv = document.getElementById("shoppingCart");
const cartHolder = document.getElementById("cartHolder");
const cartAmount = document.getElementById("shoppingNumber");
const fab = document.getElementById("shoppingFAB");
const totalText = document.getElementById("cartTotal");

firebase.database().ref('/cards').once('value').then(function(snapshot) {
    var cards = snapshot.val();
    if (cards) {
        for (var i = 0; i < cards.length; i++) {
            databaseCards[i] = cards[i];
        }
    }
});

function calculateTotal() {
    var total = 0;
    for (var i = 0; i < cart.length; i++) {
        if (cart[i] > 0) {
            total += databaseCards[i].price * cart[i];
        }
    }
    totalText.innerHTML = "Total: $" + total
}

function getCartSize() {
    var size = 0;
    for (var i = 0; i < cart.length; i++) {
        if (cart[i] > 0) {
            size += 1;
        }
    }
    return size;
}

function updateAmount() {
    calculateTotal();
    var size = getCartSize();
    cartAmount.innerHTML = size;
    if (size > 0) {
        fab.className = "shoppingFAB active";
    } else {
        fab.className = "shoppingFAB";
    }
}


function addToCart(id) {
    if (cart[id] > 0) {
        cart[id] += 1;
        refresh(id);
    } else {
        cart[id] = 1;
        httpGetAsync("/item/" + id, function(html){
            cartDiv.innerHTML += html;
        });
    }
    updateAmount();
}

function increaseCart(id) {
    cart[id] += 1;
    refresh(id);
    calculateTotal();
}

function decreaseCart(id) {
    if (cart[id] > 1) {
        cart[id] -= 1;
        refresh(id);
        calculateTotal();
    }
}

function refresh(id) {
    amount = document.getElementById("cartItemAmount_" + id);
    amount.innerHTML = cart[id] + "x";
}

function deleteCart(id) {
    document.getElementById("cartItem_" + id).outerHTML = "";
    cart[id] = 0;
    hideIfEmpty();
    updateAmount();
}

function showCart() {
    if (getCartSize() > 0) {
        cartHolder.style.visibility = "visible";
    }
}

function hideCart() {
    cartHolder.style.visibility = "hidden";
}

function hideIfEmpty() {
    if (getCartSize() == 0) {
        hideCart();
    }
}

function emptyCart() {
    for (var i = 0; i < cart.length; i++) {
        if (cart[i] > 0) {
            deleteCart(i);
        }
    }
}

function checkout() {
    emptyCart();
}