//const change_info_btn = document.querySelector('.change_info')
//const info_detail = document.querySelector('.info_detail')
//const close_info = document.querySelector('.close_info')

const change_address_btn = document.querySelector('.change_address')
const address_detail = document.querySelector('.address_detail')
const close_address = document.querySelector('.close_address')

var details = document.querySelectorAll('.detail')

//change_info_btn.addEventListener('click', () => {
//    closeAllDetail();
//    info_detail.classList.remove('hide')
//})
//
//close_info.addEventListener('click', () => {
//    info_detail.classList.add('hide')
//})

change_address_btn.addEventListener('click', () => {
    closeAllDetail();
    address_detail.classList.remove('hide')
})

close_address.addEventListener('click', () => {
    address_detail.classList.add('hide')
})

function closeAllDetail() {
    const length = details.length
    for(var i = 0; i < length; i++) {
        details[i].classList.add('hide')
    }
}