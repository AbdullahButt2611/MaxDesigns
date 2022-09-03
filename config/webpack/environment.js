const { environment } = require('@rails/webpacker')

module.exports = environment

const path = require('path');

const webpack = require('webpack');
environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: path.resolve(path.join(__dirname, '../../node_modules', 'jquery')),
    Popper: ['popper.js', 'default']
}))
 
