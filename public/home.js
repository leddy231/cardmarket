var slideIndex = 0;
carousel("mySlides");
carousel("mySlides2");
carousel("mySlides3");
carousel("mySlides4");

function carousel(string) {
    var i;
    var x = document.getElementsByClassName(string);
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none"; 
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1} 
    x[slideIndex-1].style.display = "block"; 
    setTimeout(function() {
      carousel(string);
    }, Math.random() * 1000 + 2000);
}