var fs = require("fs");
var path = require("path");
var acme = require(__dirname + "/acme/acme.json");

if (typeof(acme) !== 'undefined' && (!acme.hasOwnProperty("DomainsCertificate") ||
    !acme.DomainsCertificate.hasOwnProperty("Certs"))) {
    console.log("Nothing to do");
}
else {
  if(typeof(acme) !== 'undefined'){
    for (var cert of acme.DomainsCertificate.Certs) {
      let domain = cert.Certificate.Domain;

      var certDump = new Buffer(cert.Certificate.Certificate, 'base64');
      var keyDump = new Buffer(cert.Certificate.PrivateKey, 'base64');

      fs.writeFileSync(path.join(__dirname, "certs/" + domain + ".crt"), certDump);
      fs.writeFileSync(path.join(__dirname, "certs/" + domain + ".key"), keyDump);
    }

    console.log("Successfully write all your acme certs & keys");
  }
}
