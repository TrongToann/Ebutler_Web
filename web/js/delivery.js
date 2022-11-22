const overlay = document.querySelector('.overlay')
const popup_close = document.querySelector('.popup-close')
const quick_view = document.querySelector('.quick-view')

const payment_method_containers = document.querySelectorAll('.payment-method-container')
const payment_options = document.querySelectorAll('.payment-option')

const payment_detail_price = document.querySelector('.payment-item-detail-price')
const payment_wallet = document.querySelector('.payment-wallet')
const payment_detail_method = document.querySelector('.payment-item-method')

console.log(payment_options)

popup_close.addEventListener('click', () => overlay.classList.add('hide'))

quick_view.addEventListener('click', () => overlay.classList.remove('hide'))

for(let i = 0; i < payment_options.length; i++) {
    payment_options[i].querySelector('input').addEventListener('click', (e) => {
        payment_detail_price.innerText = e.target.value
    })
}

for(let i = 0; i < payment_method_containers.length; i++) {
    payment_method_containers[i].querySelector('input').addEventListener('click', (e) => {
        payment_wallet.innerText = e.target.value
        payment_detail_method.innerText = e.target.value
    })
}