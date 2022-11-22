const overlay = document.querySelectorAll('.overlay')
const popup_close = document.querySelectorAll('.popup-close')
var quick_view = document.querySelectorAll('.quick-view')


for(let i = 0; i < popup_close.length; i++) {
    popup_close[i].addEventListener('click', () => overlay[i].classList.add('hide'))
}

for(let i = 0; i < quick_view.length; i++) {
    quick_view[i].addEventListener('click', function() {
        overlay[i].classList.remove('hide')
    })
}




