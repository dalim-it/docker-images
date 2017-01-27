var fs = require("fs");
var acme = require("./acme.json");

if (!acme.hasOwnProperty("DomainsCertificate") ||
    !acme.DomainsCertificate.hasOwnProperty("Certs")) {
    console.log("Nothing to do");
    process.exit();
}

for (var cert of acme.DomainsCertificate.Certs) {
    let domain = cert.Certificate.Domain;

    var certDump = new Buffer(cert.Certificate.Certificate, 'base64');
    var keyDump = new Buffer(cert.Certificate.PrivateKey, 'base64');

    fs.writeFileSync("./certs/" + domain + ".crt", certDump);
    fs.writeFileSync("./certs/" + domain + ".key", keyDump);
}

console.log("Successfully write all your acme certs & keys");