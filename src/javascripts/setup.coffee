Vue = require 'vue'
# print stack traces for all warnings.
Vue.config.debug = true
# suppress all Vue.js logs and warnings.
Vue.config.silent = not Vue.config.debug
# allow vue-devtools inspection (chrome only)
Vue.config.devtools = Vue.config.debug
# ES6 template string style; useful if working with jinja2 or django templates
Vue.config.delimiters = ['${', '}']
Vue.config.unsafeDelimiters = ['{!!', '!!}']

module.exports = Vue
