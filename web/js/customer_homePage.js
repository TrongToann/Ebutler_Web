var direct_product_prev = document.querySelector('.direct-product-prev')
var direct_product_next = document.querySelector('.direct-product-next')
var product_cards = document.querySelectorAll('.product-card')

var slider_product = document.querySelector('.slider-product')

var direct_service_prev = document.querySelector('.direct-service-prev')
var direct_service_next = document.querySelector('.direct-service-next')
var service_cards = document.querySelectorAll('.service-card')

var slider_service = document.querySelector('.slider-service')

var slider_card = document.querySelector('.card-detail')

var positionX = 0;
var index_product = 0;

direct_product_prev.addEventListener('click', function() {
    HandleChangeSlide(slider_product, -1)
})

direct_product_next.addEventListener('click', function() {
    HandleChangeSlide(slider_product, 1)
})

direct_service_prev.addEventListener('click', function() {
    HandleChangeSlide(slider_service, -1)
})

direct_service_next.addEventListener('click', function() {
    HandleChangeSlide(slider_service, 1)
})

function HandleChangeSlide(slider, direction) {
    index_product += direction;

    var width = slider_card.offsetWidth;

    index_product = (index_product >= product_cards.length) ? 0 : (index_product < 0) ? product_cards.length - 1 : index_product
    
    positionX = -(slider.offsetWidth * width/slider.offsetWidth * index_product)

    slider.style = `transform: translateX(${positionX}px)`

    console.log(index_product)
}