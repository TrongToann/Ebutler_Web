let slideIndex = 0;

showSlides(slideIndex);

function plusSlides(n) {
    showSlides(slideIndex += n);
}

function currentSlide(n) {
    showSlides(slideIndex = n);
}

function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("slider__img");
    let dots = document.getElementsByClassName("dot");
    if (n > slides.length) { slideIndex = 1 }
    if (n < 1) { slideIndex = slides.length }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
}

let slideIndex2 = 1;
function showSlides_Auto() {
    let i;
    let slides = document.getElementsByClassName("slider__img");
    let slides2 = document.getElementsByClassName("slider__img--2");
    let dots = document.getElementsByClassName("dot");

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    for (i = 0; i < slides2.length; i++) {
        slides2[i].style.display = "none";
    }

    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }

    slideIndex++;
    slideIndex2++;

    if (slideIndex > slides.length) { slideIndex = 1 }
    if (slideIndex2 > slides2.length) { slideIndex2 = 1 }

    slides[slideIndex - 1].style.display = "block";
    slides2[slideIndex2 - 1].style.display = "block"; 
    dots[slideIndex - 1].className += " active";
    setTimeout(showSlides_Auto, 2000); 
}

showSlides_Auto();