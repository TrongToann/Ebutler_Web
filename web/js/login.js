const auth_form = document.querySelectorAll('.auth-form')
const forgot_password_link = document.getElementById('forgot-password-link')

const forgot_password_form = document.getElementById('forgot-password-form')
const login_form = document.getElementById('login-form')

forgot_password_link.addEventListener('click', openForgotPasswordForm)

openLoginForm()

function openLoginForm() {
    hideAllForm()
    login_form.classList.remove('hide')
}

function openForgotPasswordForm() {
    hideAllForm()
    forgot_password_form.classList.remove('hide')
}

function hideAllForm() {
    for(let i = 0; i < auth_form.length; i++) {
        auth_form[i].classList.add('hide')
    }
}