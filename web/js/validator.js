function Validator(options) {
    console.log("validation")

    const formElement = document.querySelector(options.form)

    var selectorRules = {}

    if (!formElement)
        return

    function validate(inputElement, rule) {
        var messageElement = inputElement.parentElement.querySelector(options.errorSelector)
        var errorMessage;

        var rules = selectorRules[rule.selector];

        for (var i = 0; i < rules.length; i++) {
            errorMessage = rules[i](inputElement.value)
            if (errorMessage)
                break;
        }

        if (errorMessage) {
            messageElement.innerText = errorMessage
            inputElement.classList.add('invalid')
        } else {
            messageElement.innerText = ''
            inputElement.classList.remove('invalid')
        }

        return !errorMessage
    }

    formElement.onsubmit = (e) => {
        e.preventDefault()

        var isFormValid = true;

        options.rules.forEach(rule => {
            var inputElement = formElement.querySelector(rule.selector)
            var isValid = validate(inputElement, rule)

            if (!isValid) {
                isFormValid = false
            }
        })

        if (isFormValid) {
            if (typeof options.onSubmit === 'function') {

                var enableInputs = formElement.querySelectorAll('[name]:not([disabled])');

                var formValues = Array.from(enableInputs).reduce((values, input) => {
                    values[input.name] = input.value
                    return values
                }, {})

                options.onSubmit(formValues)
            } else {
                formElement.submit()
            }
        }
    }

    options.rules.forEach(rule => {
        var inputElement = formElement.querySelector(rule.selector)

        if (Array.isArray(selectorRules[rule.selector])) {
            selectorRules[rule.selector].push(rule.test)
        } else {
            selectorRules[rule.selector] = [rule.test]
        }

        if (!inputElement)
            return

        inputElement.onblur = () => {
            validate(inputElement, rule)
        }

        inputElement.oninput = () => {
            var messageElement = inputElement.parentElement.querySelector(options.errorSelector)
            messageElement.innerText = ''
            inputElement.classList.remove('invalid')
        }

    })

}

Validator.isRequired = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            return value.trim() ? undefined : message || "this space could not be empty"
        }
    }
}

Validator.isName = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            const regex = /^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/
            return regex.test(value) ? undefined : message || 'invalid name'
        }
    }
}

Validator.isUserName = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            const regex = /^[a-zA-Z0-9._@]+$/
            return regex.test(value) ? undefined : message || 'invalid username'
        }
    }
}

Validator.isEmail = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            const regex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            return regex.test(value) ? undefined : message || 'invalid email'
        }
    }
}

Validator.isPhone = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            const regex = /(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})\b/
            return regex.test(value) ? undefined : message || 'invalid phone number'
        }
    }
}

Validator.isMatch = (selector, getCompareValue) => {
    return {
        selector: selector,
        test: function (value) {
            return value === getCompareValue() ? undefined : 'password do not match'
        }
    }
}

Validator.isPassword = (selector, message) => {
    return {
        selector: selector,
        test: function (value) {
            const regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/
            return regex.test(value) ? undefined : message || 'invalid password'
        }
    }
}