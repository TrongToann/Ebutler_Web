const add_item = document.querySelector('.add-item')

const add_modal = document.querySelector('.add-modal')

const close_modal = document.querySelector('.close-modal')

add_item.addEventListener('click', (e) => {
    add_modal.classList.remove('hide')
})

close_modal.addEventListener('click', (e) => {
    add_modal.classList.add('hide')
})