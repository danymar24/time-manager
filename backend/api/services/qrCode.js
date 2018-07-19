const QRCode = require('qrcode');

module.exports = {

    'generateQR': text => {
        QRCode.toDataURL(text, function(err, url) {
            return url;
        });
    }
}