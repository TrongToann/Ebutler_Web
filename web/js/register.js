'use strict'

const provider_role = document.getElementById('PRO')
const customer_role = document.getElementById('CUS')

//const back_register_form = document.querrSelector('.back-register-form')

const auth_form = document.querySelectorAll('.Register-form')

const register_form_customer = document.getElementById('register-form-customer');
const register_form_provider = document.getElementById('register-form-provider');

customer_role.addEventListener('click', openCustomerForm)
provider_role.addEventListener('click', openProviderForm)



function openCustomerForm() {
    hideAllForm()
    register_form_customer.classList.remove('hide')
}

function openProviderForm() {
    hideAllForm()
    register_form_provider.classList.remove('hide')
}

function hideAllForm() {
    for(let i = 0; i < auth_form.length; i++) {
        auth_form[i].classList.add('hide')
    }
}


document.querySelector('.policy-check-pro').addEventListener('click', EnableButton)

document.querySelector('.policy-check-cus').addEventListener('click', EnableButton)

function EnableButton() {
    var btn_login = document.getElementById('btn-register');
    if (this.checked) {
        btn_login.classList.remove("btn--disable");
        btn_login.removeAttribute('disabled');
    } else {
        btn_login.classList.add("btn--disable");
        btn_login.setAttribute('disabled', 'disabled');
    }
}

